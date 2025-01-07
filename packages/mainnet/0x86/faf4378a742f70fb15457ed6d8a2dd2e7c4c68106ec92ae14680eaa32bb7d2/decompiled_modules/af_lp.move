module 0x86faf4378a742f70fb15457ed6d8a2dd2e7c4c68106ec92ae14680eaa32bb7d2::af_lp {
    struct AF_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP, arg1: &mut 0x2::tx_context::TxContext) {
        0x625dc2cd40aee3998a1d6620de8892964c15066e0a285d8b573910ed4c75d50::amm_interface::create_lp_coin<AF_LP>(arg0, 5, arg1);
    }

    // decompiled from Move bytecode v6
}

