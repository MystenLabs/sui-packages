module 0x3be082b8e788fa585dc85cf8bcde853fbc9c39dfaf7d569c85aef8a09ec486f4::redeemFee {
    public fun redeem_fee<T0>(arg0: &0x3be082b8e788fa585dc85cf8bcde853fbc9c39dfaf7d569c85aef8a09ec486f4::init::Version, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x3be082b8e788fa585dc85cf8bcde853fbc9c39dfaf7d569c85aef8a09ec486f4::init::check_dexrouter_version(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, arg2, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

