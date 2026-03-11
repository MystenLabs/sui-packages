module 0x1afdb98c6e1ac322ca5fd3a4b26a700f0ce161625828cf50344b101ad9835bcf::arb_executor {
    public fun assert_min_output<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 4);
    }

    public fun assert_profit<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64, arg2: u64) {
        let v0 = 0x2::coin::value<T0>(arg0);
        assert!(v0 > 0, 3);
        assert!(arg1 > 0, 2);
        assert!(v0 >= arg1 + arg2, 1);
    }

    public fun calculate_profit(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    public fun is_profitable(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg0 >= arg1 + arg2
    }

    public fun merge_and_check_profit<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64) {
        0x2::coin::join<T0>(arg0, arg1);
        assert!(0x2::coin::value<T0>(arg0) >= arg2 + arg3, 1);
    }

    public fun split_exact<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0, 2);
        0x2::coin::split<T0>(arg0, arg1, arg2)
    }

    public fun transfer_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

