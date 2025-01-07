module 0x96e972f5dae0ac056bbd0d106a7cda8a88efb571426921955d520230f2adbc2f::hello_world {
    public entry fun merge<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<0x2::coin::Coin<T0>>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x2::coin::Coin<T0>>(&arg1);
        assert!(v0 > 0, 0);
        let v1 = 0;
        while (v1 < v0) {
            0x2::coin::join<T0>(arg0, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg1));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg1);
    }

    // decompiled from Move bytecode v6
}

