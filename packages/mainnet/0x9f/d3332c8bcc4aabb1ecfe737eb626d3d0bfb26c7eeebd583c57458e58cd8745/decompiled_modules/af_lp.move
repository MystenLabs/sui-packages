module 0x9fd3332c8bcc4aabb1ecfe737eb626d3d0bfb26c7eeebd583c57458e58cd8745::af_lp {
    struct AF_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP, arg1: &mut 0x2::tx_context::TxContext) {
        0x625dc2cd40aee3998a1d6620de8892964c15066e0a285d8b573910ed4c75d50::amm_interface::create_lp_coin<AF_LP>(arg0, 2, arg1);
    }

    // decompiled from Move bytecode v6
}

