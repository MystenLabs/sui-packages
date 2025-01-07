module 0x66283072137b1fd3e74269fbe91ca4364e6b67ce3028dac209a28729fc3a4c23::redeemFee {
    public fun redeem_fee<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

