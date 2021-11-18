remark.macros.box = function (right, top, width) {
  var text = this;
  return '<div class = "box" style = "top: ' + top + '; right: ' + right + '; width: ' + width + ';">' + text + '</div>';
};

remark.macros.label = function (right, top, width) {
  var text = this;
  return '<div class = label-container style = "position: absolute; top: ' + top + '; right: ' + right + '; width: ' + width + ';"><div class = "label"> ' + text + '</div></div>';
};


remark.macros.img = function (x, y, width, attr, caption) {
  var url = this;
  var extra = "";
  if(typeof caption == "undefined") var caption = "";
  if(x == "center" & y != "center") {
    x = "right: 50%";
    extra = " -webkit-transform: translate(50%, 0); ";
  } else if(x != "center" & y == "center") {
    y = "top: 50%";
    extra = " -webkit-transform: translate(0, -50%); ";
  } else if(x == "center" & y == "center") {
    x = "right: 50%";
    y = "top: 50%";
    extra = " -webkit-transform: translate(50%, -50%); ";
  }

  return '<div class = "fig" style = "position: absolute; ' + x + '; ' + y + '; width: ' + width + '; ' + extra + '">' +
            '<div style = "position: relative;">' +
               '<img src="' + url + '" />' +
               '<div class = "attr">' + attr + '</div>' +
            '</div>' +
            '<div class = "caption">' + caption + '</div>' +
         '</div>';
};

remark.macros.hl = function (right, top, width, height, colour){
  var text = this;
  if(typeof colour == "undefined") var colour = "inherited";
  return '<div class = "highlightbox" style = "background-color: ' + colour + '; position: absolute; top: ' + top + '; right: ' + right + '; width: ' + width + '; height: ' + height + '"> ' + text + '</div>';
}

remark.macros.cross = function(pos1, pos2, dim){
  return '<svg width="' + dim + '" style = "position: absolute; ' + pos1 + '; ' + pos2 + ';"><line x1="0" y1="0" x2="100" y2="200" style="stroke:rgb(255,0,0);stroke-width:2"></svg>';
}

remark.macros.spacer = function(padding){
  return '<div style = "padding: ' + padding + '"></div>';
}

remark.macros.here = function(x, y, colour){
  if(typeof colour == "undefined") var colour = "var(--here)";
  var text = this;
  return '<div style = "position: absolute; ' + x + '; ' + y + '; color: ' + colour + ';">' + text + '</div>';
}

remark.macros.note = function(right, bottom, height){
  var text = this;
  return '<div class = "note" style = "display: table; position: absolute; right: ' + right + '; bottom: ' + bottom + '; height: ' + height + '"><div style = "display: table-cell; vertical-align: middle">' + text + '</div></div>';
}

remark.macros.arrow = function(x1, y1, x2, y2, size, colour){
  if(typeof colour == "undefined") var colour = "black";
  var x = x2;
  var y = y2;
  x1 = parseInt(x1);
  x2 = parseInt(x2);
  y1 = parseInt(y1);
  y2 = parseInt(y2);

  if(x2 > x1) {
    x2 = x2 - x1;
    x1 = 0;
  } else if(x1 >= x2) {
    x1 = x1 - x2;
    x2 = 0;
  }
  if(y2 > y1) {
    y2 = y2 - y1;
    y1 = 0;
  } else if(y1 >= y2) {
    y1 = y1 - y2;
    y2 = 0;
  }

  // Add padding
  var p = 35;
  x1 = x1 + p;
  x2 = x2 + p;
  y1 = y1 + p;
  y2 = y2 + p;

  // Adjust placement of svg box
  y = y - y2;
  x = x - x2;

  name = x1 + x2 + y1 + y2 + Math.random();

  var width = Math.max(x1, x2) + 25
  var height = Math.max(y1, y2) + 25
  return '<svg class = centre-arrow; style = "position: absolute; left: ' + x + 'px; top: ' + y + 'px; width: ' + width + 'px; height: ' + height + 'px;" xmlns="http://www.w3.org/2000/svg"><defs><marker id="' + name + '" markerWidth="10" markerHeight="10" refX="0" refY="3" orient="auto-start-reverse" markerUnits="strokeWidth" viewBox="0 0 15 15"><path d="M0,0 L0,6 L9,3 z" fill="' + colour + '" /></marker></defs><line x1="' + x1 + '" y1="' + y1 + '" x2="' + x2 + '" y2="' + y2 + '" marker-end="url(#' + name + ')" stroke = "' + colour + '" stroke-width = "' + size + '"></svg>';
}
