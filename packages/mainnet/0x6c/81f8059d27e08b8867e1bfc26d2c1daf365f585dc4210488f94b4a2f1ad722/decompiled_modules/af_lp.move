module 0x6c81f8059d27e08b8867e1bfc26d2c1daf365f585dc4210488f94b4a2f1ad722::af_lp {
    struct AF_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP, arg1: &mut 0x2::tx_context::TxContext) {
        0x625dc2cd40aee3998a1d6620de8892964c15066e0a285d8b573910ed4c75d50::amm_interface::create_lp_coin<AF_LP>(arg0, 2, arg1);
    }

    // decompiled from Move bytecode v6
}

