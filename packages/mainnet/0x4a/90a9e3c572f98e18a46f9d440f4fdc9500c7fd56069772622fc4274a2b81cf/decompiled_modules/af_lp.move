module 0x4a90a9e3c572f98e18a46f9d440f4fdc9500c7fd56069772622fc4274a2b81cf::af_lp {
    struct AF_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP, arg1: &mut 0x2::tx_context::TxContext) {
        0x625dc2cd40aee3998a1d6620de8892964c15066e0a285d8b573910ed4c75d50::amm_interface::create_lp_coin<AF_LP>(arg0, 4, arg1);
    }

    // decompiled from Move bytecode v6
}

