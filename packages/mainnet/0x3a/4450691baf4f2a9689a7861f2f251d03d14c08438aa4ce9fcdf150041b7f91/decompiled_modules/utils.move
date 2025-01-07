module 0x3a4450691baf4f2a9689a7861f2f251d03d14c08438aa4ce9fcdf150041b7f91::utils {
    public(friend) fun withdraw_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::pay::keep<T0>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(arg0), arg1), arg1);
    }

    // decompiled from Move bytecode v6
}

