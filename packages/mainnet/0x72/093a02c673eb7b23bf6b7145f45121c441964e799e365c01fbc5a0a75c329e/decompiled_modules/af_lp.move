module 0x72093a02c673eb7b23bf6b7145f45121c441964e799e365c01fbc5a0a75c329e::af_lp {
    struct AF_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP, arg1: &mut 0x2::tx_context::TxContext) {
        0x625dc2cd40aee3998a1d6620de8892964c15066e0a285d8b573910ed4c75d50::amm_interface::create_lp_coin<AF_LP>(arg0, 3, arg1);
    }

    // decompiled from Move bytecode v6
}

