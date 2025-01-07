module 0xeb0c99b01f4ea7471025ad3e1da9492a9af29180373c8081274684fe9f3690c1::entries {
    public entry fun pay<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xeb0c99b01f4ea7471025ad3e1da9492a9af29180373c8081274684fe9f3690c1::payment::PaymentPool, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0xeb0c99b01f4ea7471025ad3e1da9492a9af29180373c8081274684fe9f3690c1::payment::UserArchieve, arg5: &0xeb0c99b01f4ea7471025ad3e1da9492a9af29180373c8081274684fe9f3690c1::version::PaymentVersion, arg6: &mut 0x2::tx_context::TxContext) {
        0xeb0c99b01f4ea7471025ad3e1da9492a9af29180373c8081274684fe9f3690c1::payment::pay<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun register(arg0: &mut 0xeb0c99b01f4ea7471025ad3e1da9492a9af29180373c8081274684fe9f3690c1::payment::UserReg, arg1: &0xeb0c99b01f4ea7471025ad3e1da9492a9af29180373c8081274684fe9f3690c1::version::PaymentVersion, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xeb0c99b01f4ea7471025ad3e1da9492a9af29180373c8081274684fe9f3690c1::payment::UserArchieve>(0xeb0c99b01f4ea7471025ad3e1da9492a9af29180373c8081274684fe9f3690c1::payment::register(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun update_validator(arg0: &0xeb0c99b01f4ea7471025ad3e1da9492a9af29180373c8081274684fe9f3690c1::payment::PaymentAdminCap, arg1: vector<u8>, arg2: &mut 0xeb0c99b01f4ea7471025ad3e1da9492a9af29180373c8081274684fe9f3690c1::payment::PaymentPool, arg3: &0xeb0c99b01f4ea7471025ad3e1da9492a9af29180373c8081274684fe9f3690c1::version::PaymentVersion) {
        0xeb0c99b01f4ea7471025ad3e1da9492a9af29180373c8081274684fe9f3690c1::payment::update_validator(arg0, arg1, arg2, arg3);
    }

    public entry fun withdrawFund<T0>(arg0: &0xeb0c99b01f4ea7471025ad3e1da9492a9af29180373c8081274684fe9f3690c1::payment::PaymentTreasureCap, arg1: &mut 0xeb0c99b01f4ea7471025ad3e1da9492a9af29180373c8081274684fe9f3690c1::payment::PaymentPool, arg2: &0xeb0c99b01f4ea7471025ad3e1da9492a9af29180373c8081274684fe9f3690c1::version::PaymentVersion, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xeb0c99b01f4ea7471025ad3e1da9492a9af29180373c8081274684fe9f3690c1::payment::withdrawFund<T0>(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

