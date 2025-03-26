module 0x7841e9f469b16b7897450521f2f66e0df13827619503640af7f7adcc1bf76339::af_lp {
    struct AF_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP, arg1: &mut 0x2::tx_context::TxContext) {
        0x625dc2cd40aee3998a1d6620de8892964c15066e0a285d8b573910ed4c75d50::amm_interface::create_lp_coin<AF_LP>(arg0, 4, arg1);
    }

    // decompiled from Move bytecode v6
}

