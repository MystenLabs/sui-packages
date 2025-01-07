module 0xf501f24b9e68daa96dc933acdd78bcf20605ee1587b7a06926a0aeb845f57f41::utils {
    public(friend) fun usdc_decimals() : u8 {
        6
    }

    public(friend) fun withdraw_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::pay::keep<T0>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(arg0), arg1), arg1);
    }

    // decompiled from Move bytecode v6
}

