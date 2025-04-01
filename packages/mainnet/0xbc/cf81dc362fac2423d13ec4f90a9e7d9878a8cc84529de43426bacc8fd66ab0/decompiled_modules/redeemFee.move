module 0xbccf81dc362fac2423d13ec4f90a9e7d9878a8cc84529de43426bacc8fd66ab0::redeemFee {
    public fun redeem_fee<T0>(arg0: &0xbccf81dc362fac2423d13ec4f90a9e7d9878a8cc84529de43426bacc8fd66ab0::init::Version, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xbccf81dc362fac2423d13ec4f90a9e7d9878a8cc84529de43426bacc8fd66ab0::init::check_xbridge_version(arg0);
        assert!(arg2 > 0 && arg3 != @0x0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, arg2, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

