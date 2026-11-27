module 0x79ad7ba2d2cbf6dbaab7bb4fd5c74de5bb14e4248a988ab334279307c20e6d41::fee_helper {
    public fun e_bps_too_high() : u64 {
        1
    }

    public fun split_bps<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 10000, 1);
        let v0 = (((0x2::coin::value<T0>(arg0) as u128) * (arg1 as u128) / 10000) as u64);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, v0, arg3), arg2);
        };
    }

    public fun split_bps_take<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = &mut arg0;
        split_bps<T0>(v0, arg1, arg2, arg3);
        arg0
    }

    // decompiled from Move bytecode v7
}

