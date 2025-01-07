module 0xc2af7da805b0fe32293dcabab95f952a18b6c6cc3e2d41cc2f030735c6f2f517::af_lp {
    struct AF_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP, arg1: &mut 0x2::tx_context::TxContext) {
        0x625dc2cd40aee3998a1d6620de8892964c15066e0a285d8b573910ed4c75d50::amm_interface::create_lp_coin<AF_LP>(arg0, 0, arg1);
    }

    // decompiled from Move bytecode v6
}

