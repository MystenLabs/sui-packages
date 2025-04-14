module 0x6ee5c66cc34dd2a86a5a30357d91526aae05eb0b784ecc16d4938d8df3cdcc83::redeemFee {
    public fun redeem_fee<T0>(arg0: &0x6ee5c66cc34dd2a86a5a30357d91526aae05eb0b784ecc16d4938d8df3cdcc83::init::Version, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x6ee5c66cc34dd2a86a5a30357d91526aae05eb0b784ecc16d4938d8df3cdcc83::init::check_xbridge_version(arg0);
        assert!(arg2 > 0 && arg3 != @0x0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, arg2, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

