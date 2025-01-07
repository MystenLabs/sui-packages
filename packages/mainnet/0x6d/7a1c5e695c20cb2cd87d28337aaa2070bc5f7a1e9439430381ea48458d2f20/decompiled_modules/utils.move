module 0x6d7a1c5e695c20cb2cd87d28337aaa2070bc5f7a1e9439430381ea48458d2f20::utils {
    public(friend) fun withdraw_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::pay::keep<T0>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(arg0), arg1), arg1);
    }

    // decompiled from Move bytecode v6
}

