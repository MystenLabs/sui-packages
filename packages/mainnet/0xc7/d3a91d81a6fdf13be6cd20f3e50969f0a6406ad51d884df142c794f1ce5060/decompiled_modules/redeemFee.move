module 0xc7d3a91d81a6fdf13be6cd20f3e50969f0a6406ad51d884df142c794f1ce5060::redeemFee {
    public fun redeem_fee<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

