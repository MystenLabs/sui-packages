module 0x5063178192fb13a91e469f8549f61df3896c5fdaec46e952b1a47ebe05d0ea12::af_lp {
    struct AF_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP, arg1: &mut 0x2::tx_context::TxContext) {
        0x625dc2cd40aee3998a1d6620de8892964c15066e0a285d8b573910ed4c75d50::amm_interface::create_lp_coin<AF_LP>(arg0, 1, arg1);
    }

    // decompiled from Move bytecode v6
}

