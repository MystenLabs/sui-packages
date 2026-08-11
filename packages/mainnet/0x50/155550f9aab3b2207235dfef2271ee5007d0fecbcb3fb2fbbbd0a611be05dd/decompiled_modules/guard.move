module 0x50155550f9aab3b2207235dfef2271ee5007d0fecbcb3fb2fbbbd0a611be05dd::guard {
    public fun assert_net<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64, arg2: u64) {
        assert!(arg2 > 0, 3);
        let v0 = 0x2::coin::value<T0>(arg0);
        assert!(v0 >= arg1, 1);
        assert!(v0 - arg1 >= arg2, 2);
    }

    public fun assert_proceeds<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(arg1 > 0, 3);
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
    }

    public fun assert_state_unchanged(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg1 > 0, 3);
        assert!(arg2 < 10000, 3);
        if (arg0 >= arg1) {
            return
        };
        assert!(((arg1 - arg0) as u128) * 10000 <= (arg1 as u128) * (arg2 as u128), 4);
    }

    public fun assert_still_liquidatable(arg0: bool) {
        assert!(arg0, 5);
    }

    public fun net_of<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) : u64 {
        let v0 = 0x2::coin::value<T0>(arg0);
        if (v0 <= arg1) {
            0
        } else {
            v0 - arg1
        }
    }

    // decompiled from Move bytecode v7
}

