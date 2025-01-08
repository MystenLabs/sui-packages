module 0xe3c9743a873b4833e2401e44d2b7d6732fe8341f78866f70e05801b537fc6f8c::af_lp {
    struct AF_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP, arg1: &mut 0x2::tx_context::TxContext) {
        0x625dc2cd40aee3998a1d6620de8892964c15066e0a285d8b573910ed4c75d50::amm_interface::create_lp_coin<AF_LP>(arg0, 4, arg1);
    }

    // decompiled from Move bytecode v6
}

