{ lib, stdenv, fetchPypi, buildPythonPackage, typed-ast, psutil, isPy3k
, mypy-extensions
, typing-extensions
}:
buildPythonPackage rec {
  pname = "mypy";
  version = "0.910";
  disabled = !isPy3k;

  src = fetchPypi {
    inherit pname version;
    sha256 = "704098302473cb31a218f1775a873b376b30b4c18229421e9e9dc8916fd16150";
  };

  propagatedBuildInputs = [ typed-ast psutil mypy-extensions typing-extensions ];

  # Tests not included in pip package.
  doCheck = false;

  pythonImportsCheck = [
    "mypy"
    "mypy.types"
    "mypy.api"
    "mypy.fastparse"
    "mypy.report"
    "mypyc"
    "mypyc.analysis"
  ];

  # Compile mypy with mypyc, which makes mypy about 4 times faster. The compiled
  # version is also the default in the wheels on Pypi that include binaries.
  # is64bit: unfortunately the build would exhaust all possible memory on i686-linux.
  MYPY_USE_MYPYC = stdenv.buildPlatform.is64bit;

  meta = with lib; {
    description = "Optional static typing for Python";
    homepage    = "http://www.mypy-lang.org";
    license     = licenses.mit;
    maintainers = with maintainers; [ martingms lnl7 ];
  };
}
