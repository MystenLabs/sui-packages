module 0xa8e5f430929ca248759037673374d18f7613a6e686d0675c0a6bfaf6d6eec497::redeemFee {
    public fun redeem_fee<T0>(arg0: &0xa8e5f430929ca248759037673374d18f7613a6e686d0675c0a6bfaf6d6eec497::init::Version, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xa8e5f430929ca248759037673374d18f7613a6e686d0675c0a6bfaf6d6eec497::init::check_dexrouter_version(arg0);
        assert!(arg2 > 0 && arg3 != @0x0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, arg2, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

