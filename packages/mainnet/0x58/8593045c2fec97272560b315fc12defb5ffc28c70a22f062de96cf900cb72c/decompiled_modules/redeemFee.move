module 0x588593045c2fec97272560b315fc12defb5ffc28c70a22f062de96cf900cb72c::redeemFee {
    public fun redeem_fee<T0>(arg0: &0x588593045c2fec97272560b315fc12defb5ffc28c70a22f062de96cf900cb72c::init::Version, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x588593045c2fec97272560b315fc12defb5ffc28c70a22f062de96cf900cb72c::init::check_dexrouter_version(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, arg2, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

