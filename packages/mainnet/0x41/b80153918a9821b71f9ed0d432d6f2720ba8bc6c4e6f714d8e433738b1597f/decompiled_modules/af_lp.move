module 0x41b80153918a9821b71f9ed0d432d6f2720ba8bc6c4e6f714d8e433738b1597f::af_lp {
    struct AF_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP, arg1: &mut 0x2::tx_context::TxContext) {
        0x625dc2cd40aee3998a1d6620de8892964c15066e0a285d8b573910ed4c75d50::amm_interface::create_lp_coin<AF_LP>(arg0, 0, arg1);
    }

    // decompiled from Move bytecode v6
}

