module 0xa9cd5022d794ac4f174578fdf030aa1a85c91983f87dd1d07c11ba1e6f644bf7::dsw {
    public fun d3a<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(0x2::coin::from_balance<T0>(arg0, arg1))
    }

    // decompiled from Move bytecode v6
}

