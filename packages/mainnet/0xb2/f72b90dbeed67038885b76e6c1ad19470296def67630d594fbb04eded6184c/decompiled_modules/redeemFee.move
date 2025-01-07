module 0xb2f72b90dbeed67038885b76e6c1ad19470296def67630d594fbb04eded6184c::redeemFee {
    public fun redeem_fee<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

