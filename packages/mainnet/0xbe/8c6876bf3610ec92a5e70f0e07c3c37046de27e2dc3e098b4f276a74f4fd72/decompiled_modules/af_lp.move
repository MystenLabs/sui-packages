module 0xbe8c6876bf3610ec92a5e70f0e07c3c37046de27e2dc3e098b4f276a74f4fd72::af_lp {
    struct AF_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP, arg1: &mut 0x2::tx_context::TxContext) {
        0x625dc2cd40aee3998a1d6620de8892964c15066e0a285d8b573910ed4c75d50::amm_interface::create_lp_coin<AF_LP>(arg0, 6, arg1);
    }

    // decompiled from Move bytecode v6
}

