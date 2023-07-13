from functional_tests.base import FunctionalTest
from unittest import skip

class ItemValidationTest(FunctionalTest):
	@skip
	def test_cannot_add_empty_list_items(self):
		# Edith acessa a página inicial e acidentalmente tenta submeter
		# um item vazio na lista. Ela tecla Enter na caixa de entrada vazia

		# A página inicial é atualizada e há uma mensagem de erro informando
		# que itens da lista não podem estar em branco

		# Ela tenta novamente com um texto para o item, e isso agora funciona

		# De forma perversa, ela agora decide submeter um segundo item
		# Branco

		# Ela recebe um aviso semelhante na página da lista

		# E ela pode corrir isso preenchendo o item com um texto
		self.fail('write me!')
