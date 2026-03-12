$colors=@('black','white','new hope gray','blue','heaven blue','neon green','green','racing green','light cyan','orange','caution yellow','passion red','cherry blossom pink','purple','light violet','matcha green','scarlet red')
$out=@()
foreach($c in $colors){
  $q=[uri]::EscapeDataString("ps5 decorative trim shell $c")
  $u="https://www.extremerate.com/search/suggest.json?q=$q&resources[type]=product&resources[limit]=30"
  try{
    $j=(Invoke-WebRequest -Uri $u -UseBasicParsing).Content|ConvertFrom-Json
    $items=$j.resources.results.products | Where-Object { $_.handle -like '*decorative-trim-shell*ps5-controller*' }
    $pick=$items | Select-Object -First 1
    if($pick){
      $img=''
      if($pick.images.Count -ge 2){ $img=$pick.images[1].url }
      elseif($pick.featured_image.url){ $img=$pick.featured_image.url }
      if($img -and $img.StartsWith('//')){ $img='https:'+$img }
      $out += [pscustomobject]@{query=$c; title=$pick.title; handle=$pick.handle; image=$img}
    } else {
      $out += [pscustomobject]@{query=$c; title=''; handle=''; image=''}
    }
  }catch{ $out += [pscustomobject]@{query=$c; title='ERR'; handle=''; image=''} }
}
$out | ConvertTo-Json -Depth 6
