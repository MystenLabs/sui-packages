module 0x33fc214ef8751a9dac189755e608c663f8bf23fbeb0a2b9dae7d5494d252a3a1::utils {
    public fun check_coin_threshold<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
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

    public fun transfer_or_destroy_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

