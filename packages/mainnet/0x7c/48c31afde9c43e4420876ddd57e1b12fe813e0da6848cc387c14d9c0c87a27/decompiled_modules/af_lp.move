module 0x7c48c31afde9c43e4420876ddd57e1b12fe813e0da6848cc387c14d9c0c87a27::af_lp {
    struct AF_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP, arg1: &mut 0x2::tx_context::TxContext) {
        0x625dc2cd40aee3998a1d6620de8892964c15066e0a285d8b573910ed4c75d50::amm_interface::create_lp_coin<AF_LP>(arg0, 10, arg1);
    }

    // decompiled from Move bytecode v6
}

