import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

// This is a DBank canister
actor DBank {
  stable var currentValue : Float = 100;
  // currentValue := 10;

  stable var startTime = Time.now();
  Debug.print(debug_show (startTime));

  // let id = 468856148743867;

  // Debug.print(debug_show (id));
  // Debug.print(debug_show (currentValue));

  public func topUp(amount : Float) {
    currentValue += amount;
    Debug.print(debug_show (currentValue));
  };

  public func withdraw(amount : Float) {
    let tempValue : Float = currentValue - amount;
    if (tempValue >= 0) {
      currentValue -= amount;
      Debug.print(debug_show (currentValue));
    } else {
      Debug.print(debug_show ("Amount too large, currentValue less then zero."));
    };
  };

  public query func checkBalance() : async Float {
    return currentValue;
  };

  public func compound() {
    let currentTime = Time.now();
    let timeElapsedNS = currentTime - startTime;
    let timeElapsedS = timeElapsedNS / 1000000000;
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedS)); // ** => means squre
    startTime := currentTime;
  };
};
