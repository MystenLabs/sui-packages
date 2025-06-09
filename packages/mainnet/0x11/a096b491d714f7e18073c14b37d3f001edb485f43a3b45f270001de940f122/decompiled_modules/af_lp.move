module 0x11a096b491d714f7e18073c14b37d3f001edb485f43a3b45f270001de940f122::af_lp {
    struct AF_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP, arg1: &mut 0x2::tx_context::TxContext) {
        0x625dc2cd40aee3998a1d6620de8892964c15066e0a285d8b573910ed4c75d50::amm_interface::create_lp_coin<AF_LP>(arg0, 7, arg1);
    }

    // decompiled from Move bytecode v6
}

