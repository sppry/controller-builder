$base='https://www.extremerate.com'
$colors=@('black','white','new hope gray','blue','racing green','matcha green','passion red','cherry blossom pink','caution yellow','purple','chrome gold','chrome silver')
$results=@()
foreach($c in $colors){
  $q=[uri]::EscapeDataString("ps5 front housing shell $c")
  $url="$base/search/suggest.json?q=$q&resources[type]=product&resources[limit]=20"
  try{
    $json=(Invoke-WebRequest -Uri $url -UseBasicParsing).Content | ConvertFrom-Json
    $items=$json.resources.results.products | Where-Object { $_.handle -like 'extremerate-replacement-front-housing-shell-with-touchpad-compatible-with-ps5-controller*' }
    $pick=$items | Select-Object -First 1
    if($pick){
      $img=$pick.featured_image.url
      if($img -and $img.StartsWith('//')){ $img='https:'+$img }
      $results += [pscustomobject]@{query=$c; title=$pick.title; handle=$pick.handle; image=$img}
    } else {
      $results += [pscustomobject]@{query=$c; title=''; handle=''; image=''}
    }
  } catch {
    $results += [pscustomobject]@{query=$c; title='ERR'; handle=''; image=$_.Exception.Message}
  }
}
$results | ConvertTo-Json -Depth 4
