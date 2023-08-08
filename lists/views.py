from django.core.exceptions import ValidationError
from django.shortcuts import render, redirect
from lists.models import Item, List

# Create your views here.
def home_page(request):
    
    return render(request, 'home.html')

def add_new_item(request, list_, new_list):
    item = Item(text=request.POST['item_text'], list=list_)
    try:
        item.full_clean()
        item.save()
        if not new_list:
            return redirect(list_)
    except ValidationError:
        error = "You can't have an empty list item"
        if new_list:
            list_.delete()
            return render(request, 'home.html', {'error': error})
            
    if new_list:
        return redirect(list_)
    
    return render(request, 'list.html', {'list': list_, 'error': error})

def view_list(request, list_id):
    error = ''
    list_ = List.objects.get(id=list_id)
    if request.method == 'POST':
        return add_new_item(request, list_, False)
        item = Item(text=request.POST['item_text'], list=list_)
        try:
            item.full_clean()
            item.save()
            return redirect(f'/lists/{list_.id}/')
        except ValidationError:
            error = "You can't have an empty list item"
            return render(request, 'list.html', {'list': list_, 'error': error})

    return render(request, 'list.html', {'list': list_, 'error': error})


def new_list(request):
    list_ = List.objects.create()

    return add_new_item(request, list_, True)
    item = Item(text=request.POST['item_text'], list=list_)
    try:
        item.full_clean()
        item.save()
    except ValidationError:
        list_.delete()
        error = "You can't have an empty list item"
        return render(request, 'home.html', {'error': error})
    return redirect('view_list', list_.id)