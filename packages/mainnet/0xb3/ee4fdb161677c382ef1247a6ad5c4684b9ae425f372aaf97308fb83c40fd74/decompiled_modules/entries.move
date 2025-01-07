module 0xb3ee4fdb161677c382ef1247a6ad5c4684b9ae425f372aaf97308fb83c40fd74::entries {
    public entry fun pay<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xb3ee4fdb161677c382ef1247a6ad5c4684b9ae425f372aaf97308fb83c40fd74::payment::PaymentPool, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0xb3ee4fdb161677c382ef1247a6ad5c4684b9ae425f372aaf97308fb83c40fd74::payment::UserArchieve, arg5: &0xb3ee4fdb161677c382ef1247a6ad5c4684b9ae425f372aaf97308fb83c40fd74::version::PaymentVersion, arg6: &mut 0x2::tx_context::TxContext) {
        0xb3ee4fdb161677c382ef1247a6ad5c4684b9ae425f372aaf97308fb83c40fd74::payment::pay<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun register(arg0: &mut 0xb3ee4fdb161677c382ef1247a6ad5c4684b9ae425f372aaf97308fb83c40fd74::payment::UserReg, arg1: &0xb3ee4fdb161677c382ef1247a6ad5c4684b9ae425f372aaf97308fb83c40fd74::version::PaymentVersion, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xb3ee4fdb161677c382ef1247a6ad5c4684b9ae425f372aaf97308fb83c40fd74::payment::UserArchieve>(0xb3ee4fdb161677c382ef1247a6ad5c4684b9ae425f372aaf97308fb83c40fd74::payment::register(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun update_validator(arg0: &0xb3ee4fdb161677c382ef1247a6ad5c4684b9ae425f372aaf97308fb83c40fd74::payment::PaymentAdminCap, arg1: vector<u8>, arg2: &mut 0xb3ee4fdb161677c382ef1247a6ad5c4684b9ae425f372aaf97308fb83c40fd74::payment::PaymentPool, arg3: &0xb3ee4fdb161677c382ef1247a6ad5c4684b9ae425f372aaf97308fb83c40fd74::version::PaymentVersion) {
        0xb3ee4fdb161677c382ef1247a6ad5c4684b9ae425f372aaf97308fb83c40fd74::payment::update_validator(arg0, arg1, arg2, arg3);
    }

    public entry fun withdrawFund<T0>(arg0: &0xb3ee4fdb161677c382ef1247a6ad5c4684b9ae425f372aaf97308fb83c40fd74::payment::PaymentTreasureCap, arg1: &mut 0xb3ee4fdb161677c382ef1247a6ad5c4684b9ae425f372aaf97308fb83c40fd74::payment::PaymentPool, arg2: &0xb3ee4fdb161677c382ef1247a6ad5c4684b9ae425f372aaf97308fb83c40fd74::version::PaymentVersion, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xb3ee4fdb161677c382ef1247a6ad5c4684b9ae425f372aaf97308fb83c40fd74::payment::withdrawFund<T0>(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

