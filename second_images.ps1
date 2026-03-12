$handles=@{
  'White'='extremerate-replacement-front-housing-shell-with-touchpad-compatible-with-ps5-controller-bdm-010-020-030-040-white'
  'Black'='extremerate-replacement-front-housing-shell-with-touchpad-compatible-with-ps5-controller-bdm-010-020-030-040-black'
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
foreach($name in $handles.Keys){
  $h=$handles[$name]
  $u="https://www.extremerate.com/products/$h.js"
  $p=(Invoke-WebRequest -Uri $u -UseBasicParsing).Content | ConvertFrom-Json
  $img=''
  if($p.images.Count -ge 2){ $img=$p.images[1] } elseif($p.images.Count -ge 1){ $img=$p.images[0] }
  if($img.StartsWith('//')){ $img='https:'+$img }
  $out += [pscustomobject]@{name=$name; img=$img; count=$p.images.Count}
}
$out | Sort-Object name | ConvertTo-Json -Depth 4
