module 0x6feddc045ae0921901440af116b79cbab4054c2a519873e4431f71ff492cc45c::entries {
    public entry fun pay<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x6feddc045ae0921901440af116b79cbab4054c2a519873e4431f71ff492cc45c::payment::PaymentPool, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x6feddc045ae0921901440af116b79cbab4054c2a519873e4431f71ff492cc45c::payment::UserArchieve, arg5: &0x6feddc045ae0921901440af116b79cbab4054c2a519873e4431f71ff492cc45c::version::PaymentVersion, arg6: &mut 0x2::tx_context::TxContext) {
        0x6feddc045ae0921901440af116b79cbab4054c2a519873e4431f71ff492cc45c::payment::pay<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun register(arg0: &mut 0x6feddc045ae0921901440af116b79cbab4054c2a519873e4431f71ff492cc45c::payment::UserReg, arg1: &0x6feddc045ae0921901440af116b79cbab4054c2a519873e4431f71ff492cc45c::version::PaymentVersion, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x6feddc045ae0921901440af116b79cbab4054c2a519873e4431f71ff492cc45c::payment::UserArchieve>(0x6feddc045ae0921901440af116b79cbab4054c2a519873e4431f71ff492cc45c::payment::register(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun update_validator(arg0: &0x6feddc045ae0921901440af116b79cbab4054c2a519873e4431f71ff492cc45c::payment::PaymentAdminCap, arg1: vector<u8>, arg2: &mut 0x6feddc045ae0921901440af116b79cbab4054c2a519873e4431f71ff492cc45c::payment::PaymentPool, arg3: &0x6feddc045ae0921901440af116b79cbab4054c2a519873e4431f71ff492cc45c::version::PaymentVersion) {
        0x6feddc045ae0921901440af116b79cbab4054c2a519873e4431f71ff492cc45c::payment::update_validator(arg0, arg1, arg2, arg3);
    }

    public entry fun withdrawFund<T0>(arg0: &0x6feddc045ae0921901440af116b79cbab4054c2a519873e4431f71ff492cc45c::payment::PaymentTreasureCap, arg1: &mut 0x6feddc045ae0921901440af116b79cbab4054c2a519873e4431f71ff492cc45c::payment::PaymentPool, arg2: &0x6feddc045ae0921901440af116b79cbab4054c2a519873e4431f71ff492cc45c::version::PaymentVersion, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x6feddc045ae0921901440af116b79cbab4054c2a519873e4431f71ff492cc45c::payment::withdrawFund<T0>(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

