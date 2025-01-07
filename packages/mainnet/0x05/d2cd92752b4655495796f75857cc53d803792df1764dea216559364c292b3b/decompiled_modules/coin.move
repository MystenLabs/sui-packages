module 0xc7bab9fcf58f1da2e1f51646468f96ac4f9717f1df99f44a5d67a8e79db4eac8::coin {
    public fun check_coin_threshold<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
    }

    public fun merge_and_split_coin<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
        let v1 = 1;
        while (v1 < 0x1::vector::length<0x2::coin::Coin<T0>>(&arg0)) {
            0x2::coin::join<T0>(&mut v0, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
        assert!(0x2::coin::value<T0>(&v0) > arg1, 0);
        (v0, 0x2::coin::split<T0>(&mut v0, arg1, arg2))
    }

    public fun transfer_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

