module 0xbccf81dc362fac2423d13ec4f90a9e7d9878a8cc84529de43426bacc8fd66ab0::fromSwap {
    struct OrderRecord has copy, drop {
        order_id: u64,
        decimal: u8,
        out_amount: u64,
    }

    public fun dex_finalize_with_return<T0>(arg0: &0xbccf81dc362fac2423d13ec4f90a9e7d9878a8cc84529de43426bacc8fd66ab0::init::Version, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xbccf81dc362fac2423d13ec4f90a9e7d9878a8cc84529de43426bacc8fd66ab0::init::check_xbridge_version(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        if (v0 < arg2) {
            abort 3
        };
        let v1 = OrderRecord{
            order_id   : arg3,
            decimal    : arg4,
            out_amount : v0,
        };
        0x2::event::emit<OrderRecord>(v1);
        arg1
    }

    // decompiled from Move bytecode v6
}

