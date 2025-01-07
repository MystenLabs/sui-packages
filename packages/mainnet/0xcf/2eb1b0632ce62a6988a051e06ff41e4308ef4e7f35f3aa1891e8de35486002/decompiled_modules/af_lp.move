module 0xcf2eb1b0632ce62a6988a051e06ff41e4308ef4e7f35f3aa1891e8de35486002::af_lp {
    struct AF_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP, arg1: &mut 0x2::tx_context::TxContext) {
        0x625dc2cd40aee3998a1d6620de8892964c15066e0a285d8b573910ed4c75d50::amm_interface::create_lp_coin<AF_LP>(arg0, 2, arg1);
    }

    // decompiled from Move bytecode v6
}

