module 0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::entries {
    public entry fun pay<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::payment::PaymentPool, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::payment::UserArchieve, arg5: &0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::version::PaymentVersion, arg6: &mut 0x2::tx_context::TxContext) {
        0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::payment::pay<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun register(arg0: &mut 0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::payment::UserReg, arg1: &0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::version::PaymentVersion, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::payment::UserArchieve>(0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::payment::register(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun register2(arg0: &mut 0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::payment::UserReg, arg1: &0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::version::PaymentVersion, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::payment::UserArchieve>(0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::payment::register2(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun update_validator(arg0: &0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::payment::PaymentAdminCap, arg1: vector<u8>, arg2: &mut 0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::payment::PaymentPool, arg3: &0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::version::PaymentVersion) {
        0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::payment::update_validator(arg0, arg1, arg2, arg3);
    }

    public entry fun withdrawFund<T0>(arg0: &0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::payment::PaymentTreasureCap, arg1: &mut 0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::payment::PaymentPool, arg2: &0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::version::PaymentVersion, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::payment::withdrawFund<T0>(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

