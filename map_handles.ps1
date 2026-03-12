$handles=@{
  'Black'='extremerate-replacement-front-housing-shell-with-touchpad-compatible-with-ps5-controller-bdm-010-020-030-040-black'
  'White'='extremerate-replacement-front-housing-shell-with-touchpad-compatible-with-ps5-controller-bdm-010-020-030-040-white'
  'New Hope Gray'='extremerate-replacement-front-housing-shell-with-touchpad-compatible-with-ps5-controller-bdm-010-020-030-040-new-hope-gray'
  'Blue'='extremerate-replacement-front-housing-shell-with-touchpad-compatible-with-ps5-controller-bdm-010-020-030-040-blue'
  'Racing Green'='extremerate-replacement-front-housing-shell-with-touchpad-compatible-with-ps5-controller-bdm-010-020-030-040-racing-green'
  'Matcha Green'='extremerate-replacement-front-housing-shell-with-touchpad-compatible-with-ps5-controller-bdm-010-020-030-040-matcha-green'
  'Passion Red'='extremerate-replacement-front-housing-shell-with-touchpad-compatible-with-ps5-controller-bdm-010-020-030-040-passion-red'
  'Cherry Blossom Pink'='extremerate-replacement-front-housing-shell-with-touchpad-compatible-with-ps5-controller-bdm-010-020-030-040-cherry-blossoms-pink'
  'Caution Yellow'='extremerate-replacement-front-housing-shell-with-touchpad-compatible-with-ps5-controller-bdm-010-020-030-040-caution-yellow'
  'Purple'='extremerate-replacement-front-housing-shell-with-touchpad-compatible-with-ps5-controller-bdm-010-020-030-040-purple'
  'Chrome Gold'='extremerate-replacement-front-housing-shell-with-touchpad-compatible-with-ps5-controller-bdm-010-020-030-040-chrome-gold'
  'Chrome Silver'='extremerate-replacement-front-housing-shell-with-touchpad-compatible-with-ps5-controller-bdm-010-020-030-040-chrome-silver'
}
$out=@()
foreach($k in $handles.Keys){
  $h=$handles[$k]
  $url="https://www.extremerate.com/products/$h.js"
  try{
    $p=(Invoke-WebRequest -Uri $url -UseBasicParsing).Content | ConvertFrom-Json
    $img=$p.images[0]
    if($img -and $img.StartsWith('//')){ $img='https:'+$img }
    $out += [pscustomobject]@{name=$k; image=$img; title=$p.title}
  }catch{
    $out += [pscustomobject]@{name=$k; image=''; title='ERR'}
  }
}
$out | Sort-Object name | ConvertTo-Json -Depth 4
