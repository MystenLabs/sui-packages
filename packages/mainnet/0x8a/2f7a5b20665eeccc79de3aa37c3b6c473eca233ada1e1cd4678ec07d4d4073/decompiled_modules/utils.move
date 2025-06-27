module 0x43811be4677f5a5de7bf2dac740c10abddfaa524aee6b18e910eeadda8a2f6ae::utils {
    public fun check_coin_threshold<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
    }

    public fun check_coin_threshold_v1<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= (arg2 as u64), 1);
    }

    public fun check_coin_threshold_v2<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg3 > 0) {
            if (arg4 != @0x0) {
                arg3 <= 10000
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            let v1 = (((0x2::coin::value<T0>(arg0) as u128) * (arg3 as u128) / (1000000 as u128)) as u64);
            if (v1 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, v1, arg5), arg4);
            };
        };
        assert!(0x2::coin::value<T0>(arg0) >= (arg2 as u64), 1);
    }

    public fun check_coins_threshold<T0>(arg0: &vector<0x2::coin::Coin<T0>>, arg1: u64) {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<0x2::coin::Coin<T0>>(arg0)) {
            v1 = v1 + 0x2::coin::value<T0>(0x1::vector::borrow<0x2::coin::Coin<T0>>(arg0, v0));
            v0 = v0 + 1;
        };
        assert!(v1 >= arg1, 1);
    }

    public fun max_sqrt_price() : u128 {
        79226673515401279992447579055
    }

    public fun min_sqrt_price() : u128 {
        4295048016
    }

    public fun transfer_or_destroy_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

