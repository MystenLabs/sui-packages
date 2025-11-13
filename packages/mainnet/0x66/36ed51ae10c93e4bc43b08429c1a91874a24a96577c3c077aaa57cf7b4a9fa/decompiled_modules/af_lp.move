module 0x6636ed51ae10c93e4bc43b08429c1a91874a24a96577c3c077aaa57cf7b4a9fa::af_lp {
    struct AF_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP, arg1: &mut 0x2::tx_context::TxContext) {
        0x625dc2cd40aee3998a1d6620de8892964c15066e0a285d8b573910ed4c75d50::amm_interface::create_lp_coin<AF_LP>(arg0, 8, arg1);
    }

    // decompiled from Move bytecode v6
}

