module 0xf69748e85278ea477cad1e3d1e89aa2370cec9c4de14a9204e443bcb6e0b33b2::math_helper {
    public fun ageb_u128(arg0: u128, arg1: u128) {
        assert!(arg0 >= arg1, 2);
    }

    public fun ageb_u256(arg0: u256, arg1: u256) {
        assert!(arg0 >= arg1, 3);
    }

    public fun ageb_u64(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 1);
    }

    public fun ageb_u64_coin_in_with_div<T0>(arg0: u64, arg1: &0x2::coin::Coin<T0>, arg2: u64, arg3: u64) {
        assert!(arg0 >= 0x2::coin::value<T0>(arg1) * arg2 / arg3, 1);
    }

    public fun ageb_u64_with_div(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg0 >= arg1 * arg2 / arg3, 1);
    }

    // decompiled from Move bytecode v6
}

