library(knitr)
username <- Sys.info()['user']
fileName <- "defaultPath.csv"
pathToFile <-
  paste("C:/Users/", username, "/Desktop/pathToCSV/", sep = "")
setwd(pathToFile)
buf0 <-
  read.csv(
    fileName,
    header = F,
    skip = 0,
    stringsAsFactor = F,
    check.names = F,
    na.strings = c(""),
    fileEncoding = "utf-8"
  )

fileName <- "knowledgeVault.csv"
pathToFile <-
  paste("C:/Users/", username, buf0[1,1], sep = "")
setwd(pathToFile)
buf <-
  read.csv(
    fileName,
    header = T,
    skip = 0,
    stringsAsFactor = F,
    check.names = F,
    na.strings = c(""),
    fileEncoding = "utf-8"
  )
buf[, 5] <-
  paste("<a href=\"", buf[, 5], "\" target=\"_blank\">Link</a>", sep = "")

pathToFile <-
  paste("C:/Users/",
        username,
        buf0[2,1],
        sep = "")
setwd(pathToFile)
htmlFile <- "index.html"
alignarg <- c("r","l","l","l","l")
table.argu <-"id=\"amcc_knowledgevault\" width=\"100%\" class=\"display compact\" style=\"font-size:12px;\""

block01<-"
<!DOCTYPE html>
<html lang=\"en\">
<head>
<meta charset=\"utf-8\">
<title>SaECaNet - Knowledge Vault</title>
<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge,chrome=1\" />
<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
<meta name=\"description\" content=\"\">
<meta name=\"author\" content=\"\">

<link href=\"http://fonts.googleapis.com/css?family=Roboto+Condensed\" rel=\"stylesheet\" type=\"text/css\">
<link href=\"components/bootplus.css\" rel=\"stylesheet\">
<style>
body {
  font-family: 'Roboto Condensed', sans-serif;
  font-size: 100%;
  padding-top: 60px;
}
</style>
<script>
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
ga('create', 'UA-3077339-5', 'auto');
ga('send', 'pageview');
</script>
<!-- google analyticsの下に置くこと-->
<link href=\"components/bootplus-responsive.css\" rel=\"stylesheet\">
<link href=\"components/font-awesome-ie7.min.css\" rel=\"stylesheet\">
<!-- google analyticsの下に置くこと-->
<link rel=\"apple-touch-icon-precomposed\" sizes=\"144x144\" href=\"components/apple-touch-icon-144-precomposed.png\">
<link rel=\"apple-touch-icon-precomposed\" sizes=\"114x114\" href=\"components/apple-touch-icon-114-precomposed.png\">
<link rel=\"apple-touch-icon-precomposed\" sizes=\"72x72\"   href=\"components/apple-touch-icon-72-precomposed.png\">
<link rel=\"apple-touch-icon-precomposed\" sizes=\"52x52\"   href=\"components/apple-touch-icon-57-precomposed.png\">
<link rel=\"shortcut icon\" href=\"components/favicon.png\">
</head>
<body>
<div class=\"navbar navbar-fixed-top\">
	<div class=\"navbar-inner\">
		<div class=\"container\">
			<a class=\"brand\" href=\"index.html\">SaECaNet - Knowledge Vault</a>
		</div>
	</div>
</div>
<div class=\"container\">
<link href=\"http://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css\" rel=\"stylesheet\">
<script src=\"https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js\"></script>
<script src=\"http://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js\"></script>
<link href=\"http://cdn.datatables.net/plug-ins/1.10.12/features/searchHighlight/dataTables.searchHighlight.css\" rel=\"stylesheet\">
<script src=\"http://cdn.datatables.net/plug-ins/1.10.12/features/searchHighlight/dataTables.searchHighlight.min.js\"></script>
<script src=\"http://bartaz.github.io/sandbox.js/jquery.highlight.js\"></script>
<script type=\"text/javascript\" charset=\"utf-8\">
$(document).ready(function(){
	$('#amcc_knowledgevault').dataTable({
		\"lengthMenu\":[[20,10,-1],[20,10,\"All\"]],
		\"order\":[[0,\"asc\"]],
		\"searching\":true,
		\"columnDefs\":[{\"width\":\"3%\",\"targets\":0},{\"width\":\"20%\",\"targets\":1},{\"width\":\"3%\",\"targets\":4}],
		\"language\":{\"decimal\":\".\",\"thousands\":\",\"},
		\"searchHighlight\": true,
	});
  $('input.global_filter').on( 'keyup click', function () {
    filterGlobal();
  });
  $('input.column_filter').on( 'keyup click', function () {
    filterColumn( $(this).parents('tr').attr('data-column') );
  });
});
</script>
<div id=\"container\" style=\"width:100%\">
<div align=\"center\"><b>正規表現対応フィルターボックス</b></div>  
<table width=\"100%\" cellpadding=\"2\" cellspacing=\"0\">
<thead>
<tr>
<th width=\"15%\" style=\"text-align:right\">Target</th>
<th width=\"75%\" style=\"text-align:center\">Search text</th>
<th style=\"text-align:center\">Regex</th>
</tr>
</thead>
<tbody>"

block02 <- ""
for (rccc in c(2,3,4)) {
  block02 <- paste(
    block02,
    paste("
<tr id=\"filter_col",rccc,"\" data-column=\"",rccc - 1,"\">
<td align=\"right\">",colnames(buf)[rccc],"</td>
<td align=\"right\"><input type=\"text\" class=\"column_filter\" id=\"col",rccc - 1,"_filter\" style=\"width:100%\"></td>
<td align=\"center\"><input type=\"checkbox\" class=\"column_filter\" id=\"col",rccc - 1,"_regex\" checked=\"checked\"></td>
</tr>
    ",sep = "")
  )
}  

block03<-"
</tbody>
</table>
<hr>
<script>
function filterGlobal () {
  $('#amcc_knowledgevault').DataTable().search(
  $('#global_filter').val(),
  $('#global_regex').prop('checked'),
  $('#global_smart').prop('checked')
  ).draw();
}
function filterColumn ( i ) {
  $('#amcc_knowledgevault').DataTable().column( i ).search(
  $('#col'+i+'_filter').val(),
  $('#col'+i+'_regex').prop('checked'),
  $('#col'+i+'_smart').prop('checked')
  ).draw();
}
</script>"

dataSet<-kable(buf,'html',row.names=F,table.attr=table.argu,align=alignarg)
dataSet<-gsub("&lt;","<",dataSet)
dataSet<-gsub("&quot;","\"",dataSet)
dataSet<-gsub("&gt;",">",dataSet)

block04<-paste("
<div style=\"overflow-x:scroll;\">\n",
dataSet,
"\n</div>",sep="")

block05<-"
</div>
<hr>
<div class=\"footer\" align=\"center\">
	<p>SaECaNet - Knowledge Vault</p>
</div>
<div class=\"footer\" align=\"center\">
	<p><a href=\"https://github.com/am-consulting/knowledgeVault/blob/master/README.md\" target=\"_blank\">特記事項</a></p>
	<p><a href=\"http://www.saecanet.com/subfolder/disclaimer.html\" target=\"_blank\">Disclaimer</a></p>
	<p><a href=\"http://am-consulting.co.jp\" target=\"_blank\">Asset Management Consulting Corporation</p>
	<p><a href=\"http://www.saecanet.com\" target=\"_blank\">SaECaNet - Science and Engineering Cafe on the Net</p>
</div>
</div>	
</body>
</html>
"
code0 <- paste(block01, block02, block03, block04, block05)

cat(code0, file = (con <-
                     file(htmlFile, "w", encoding = "UTF-8")), append = T)
close(con)