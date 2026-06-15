module 0x59ecd46b5952edb73a4472d289c6fcc84d1c4a0033322d38ca6a39004d6e7eeb::executor {
    public fun assert_and_keep<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: address) {
        check_profit<T0>(&arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg3);
    }

    public fun assert_profit(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 0);
    }

    public fun check_profit<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64, arg2: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= checked_add(arg1, arg2), 0);
    }

    public fun check_profit_and_return<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64) : 0x2::coin::Coin<T0> {
        check_profit<T0>(&arg0, arg1, arg2);
        arg0
    }

    fun checked_add(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) + (arg1 as u128);
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    public fun min_out_from_bps(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / 10000;
        assert!(v0 <= 18446744073709551615, 1);
        let v1 = (arg0 as u128) + ((v0 as u64) as u128);
        assert!(v1 <= 18446744073709551615, 1);
        (v1 as u64)
    }

    // decompiled from Move bytecode v7
}

