module 0xd237f50b0d5662ae70e526f25ef59a7d48772556f7fff852f65c90a9719d03b1::utils {
    public fun check_coin_threshold<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 13835058093936869377);
    }

    // decompiled from Move bytecode v6
}

