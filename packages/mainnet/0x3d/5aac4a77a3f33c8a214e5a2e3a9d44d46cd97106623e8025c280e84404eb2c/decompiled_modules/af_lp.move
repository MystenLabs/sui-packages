module 0x3d5aac4a77a3f33c8a214e5a2e3a9d44d46cd97106623e8025c280e84404eb2c::af_lp {
    struct AF_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP, arg1: &mut 0x2::tx_context::TxContext) {
        0x625dc2cd40aee3998a1d6620de8892964c15066e0a285d8b573910ed4c75d50::amm_interface::create_lp_coin<AF_LP>(arg0, 13, arg1);
    }

    // decompiled from Move bytecode v6
}

