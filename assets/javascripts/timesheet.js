function targetField(label_element) {
  return  $('#' + label_element.attributes.for.value).get(0);
}

function selectAllOptions(element) {
  for (var i = 0; i < element.options.length; i++) {
    element.options[i].selected = true;
  }
}

$(function() { 
    $('label.select_all').each(function(element) {
      $(this).click(function (e) { selectAllOptions(targetField(this)); });
    });
  });
