if ((New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  Write-Host "Skript hat bereits Administratorrechte."
}
else {
  # Starte das skript neu, als Administrator.
  Write-Host "Evaluate rights..."
  $process = New-Object System.Diagnostics.ProcessStartInfo "powershell"
  $process.Arguments = $myInvocation.MyCommand.Definition;
  $process.Verb = "runas";
  [System.Diagnostics.Process]::Start($process)
  exit
}

function test-cmd($command) {
  return Get-Command $command -errorAction SilentlyContinue
}

# install choco
if (!(test-cmd "choco")) {
  Write-Host "choco is not installed. Installing now..." -ForegroundColor Yellow
  Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
  (irm https://community.chocolatey.org/install.ps1 | iex) || exit 1
  choco feature enable -n=allowGlobalConfirmation
}

# install git
if (!(test-cmd "git")) {
  Write-Host "git is not installed. Installing now..." -ForegroundColor Yellow
  choco install git || exit 1
}

# install pyhton
if (!(test-cmd "python")) {
  Write-Host "python and pip are not installed. Installing now..." -ForegroundColor Yellow
  choco install python.install
  python -m ensurepip
}

# install make
if (!(test-cmd "make")) {
  Write-Host "make is not installed. Installing now..." -ForegroundColor Yellow
  choco install gnuwin32-coreutils.install
}

# install pdflatex
if (!(test-cmd "pdflatex")) {
  Write-Host "pdflatex not found. Installing MikTex now..." -ForegroundColor Yellow
  choco install miktex.install \ThisUser
  Write-Host "Remember to update MikTex dependencies!" -ForegroundColor Yellow
}

# install pandoc
if (!(test-cmd "pandoc")) {
  Write-Host "pandoc not found. Installing pandoc and extensions now..." -ForegroundColor Yellow
  choco install pandoc pandoc-crossref
  pip install pandoc-include --user

  Write-Host "Installing pandoc-acro now to ~/apps..."
  if (!(test-path ~/apps)) { mkdir -p ~/apps }
  pushd ~/apps || exit
  git clone https://github.com/kprussing/pandoc-acro.git
  pushd pandoc-acro || exit
  python setup.py install
  popd
  popd
}

if (!(choco find --local  pandoc)) {
  Write-Host "libvirt.dll (SVG support) not found. Installing now..." -ForegroundColor Yellow
  choco install rsvg-convert
}