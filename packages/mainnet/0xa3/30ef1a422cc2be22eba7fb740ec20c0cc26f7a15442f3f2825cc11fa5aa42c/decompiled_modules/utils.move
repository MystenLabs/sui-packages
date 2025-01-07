module 0xa330ef1a422cc2be22eba7fb740ec20c0cc26f7a15442f3f2825cc11fa5aa42c::utils {
    public fun check_coin_threshold<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        let v0 = 0x2::coin::value<T0>(arg0);
        assert!(v0 >= arg1, v0);
    }

    // decompiled from Move bytecode v6
}

