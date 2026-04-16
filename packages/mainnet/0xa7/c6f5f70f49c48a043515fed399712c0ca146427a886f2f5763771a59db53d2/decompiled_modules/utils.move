module 0xa7c6f5f70f49c48a043515fed399712c0ca146427a886f2f5763771a59db53d2::utils {
    public fun check_coin_threshold<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 13835058093936869377);
    }

    // decompiled from Move bytecode v6
}

