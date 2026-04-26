module 0xf70afe2ef72270fbe1b87456a204a8ae90553872eb5dbdcd4193cd6b46f42d7a::guard {
    public fun assert_min_output_and_return<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 0);
        arg0
    }

    // decompiled from Move bytecode v7
}

