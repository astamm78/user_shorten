$(document).ready(function() {
  $('a.shorty').click(function(){
    var url = $(this).text();
    var click_count_container = $(this).parent().find(".click_count");
    $.post( url, function(data) {
      click_count_container.html(data);
    });
  });
});
