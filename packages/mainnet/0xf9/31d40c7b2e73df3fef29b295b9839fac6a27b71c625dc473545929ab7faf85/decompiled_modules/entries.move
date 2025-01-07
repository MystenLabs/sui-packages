module 0xf931d40c7b2e73df3fef29b295b9839fac6a27b71c625dc473545929ab7faf85::entries {
    public entry fun pay<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xf931d40c7b2e73df3fef29b295b9839fac6a27b71c625dc473545929ab7faf85::payment::PaymentPool, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0xf931d40c7b2e73df3fef29b295b9839fac6a27b71c625dc473545929ab7faf85::payment::UserArchieve, arg5: &0xf931d40c7b2e73df3fef29b295b9839fac6a27b71c625dc473545929ab7faf85::version::PaymentVersion, arg6: &mut 0x2::tx_context::TxContext) {
        0xf931d40c7b2e73df3fef29b295b9839fac6a27b71c625dc473545929ab7faf85::payment::pay<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun register(arg0: &mut 0xf931d40c7b2e73df3fef29b295b9839fac6a27b71c625dc473545929ab7faf85::payment::UserReg, arg1: &0xf931d40c7b2e73df3fef29b295b9839fac6a27b71c625dc473545929ab7faf85::version::PaymentVersion, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xf931d40c7b2e73df3fef29b295b9839fac6a27b71c625dc473545929ab7faf85::payment::UserArchieve>(0xf931d40c7b2e73df3fef29b295b9839fac6a27b71c625dc473545929ab7faf85::payment::register(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun update_validator(arg0: &0xf931d40c7b2e73df3fef29b295b9839fac6a27b71c625dc473545929ab7faf85::payment::PaymentAdminCap, arg1: vector<u8>, arg2: &mut 0xf931d40c7b2e73df3fef29b295b9839fac6a27b71c625dc473545929ab7faf85::payment::PaymentPool, arg3: &0xf931d40c7b2e73df3fef29b295b9839fac6a27b71c625dc473545929ab7faf85::version::PaymentVersion) {
        0xf931d40c7b2e73df3fef29b295b9839fac6a27b71c625dc473545929ab7faf85::payment::update_validator(arg0, arg1, arg2, arg3);
    }

    public entry fun withdrawFund<T0>(arg0: &0xf931d40c7b2e73df3fef29b295b9839fac6a27b71c625dc473545929ab7faf85::payment::PaymentTreasureCap, arg1: &mut 0xf931d40c7b2e73df3fef29b295b9839fac6a27b71c625dc473545929ab7faf85::payment::PaymentPool, arg2: &0xf931d40c7b2e73df3fef29b295b9839fac6a27b71c625dc473545929ab7faf85::version::PaymentVersion, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xf931d40c7b2e73df3fef29b295b9839fac6a27b71c625dc473545929ab7faf85::payment::withdrawFund<T0>(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

