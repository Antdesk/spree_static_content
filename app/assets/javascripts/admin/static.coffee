jQuery ->
  alert('sse')
  CKEDITOR.stylesSet.add('my_style', [
    { name: 'Pytanie', element: 'div', attributes: { 'class': 'faq_block_q' } },
    { name: 'Odpowiedz', element: 'div', attributes: { 'class': 'faq_block_a' } },
    { name: 'Tekst'}
  ])
  CKEDITOR.config.stylesSet = 'my_style'
