{ lib
, fetchPypi
, buildPythonPackage
, pythonOlder
, multidict
, pytest-runner
, pytest
, typing-extensions
, idna
}:

buildPythonPackage rec {
  pname = "yarl";
  version = "1.7.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "8e7ebaf62e19c2feb097ffb7c94deb0f0c9fab52590784c8cd679d30ab009162";
  };

  checkInputs = [ pytest pytest-runner ];
  propagatedBuildInputs = [ multidict idna ]
    ++ lib.optionals (pythonOlder "3.8") [
      typing-extensions
    ];

  meta = with lib; {
    description = "Yet another URL library";
    homepage = "https://github.com/aio-libs/yarl/";
    license = licenses.asl20;
    maintainers = with maintainers; [ dotlambda ];
  };
}
