module 0x2::pay {
    public entry fun join<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::join<T0>(arg0, arg1);
    }

    public entry fun split<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        keep<T0>(0x2::coin::split<T0>(arg0, arg1, arg2), arg2);
    }

    public entry fun divide_and_keep<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::divide_into_n<T0>(arg0, arg1, arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::coin::Coin<T0>>(&v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut v0), 0x2::tx_context::sender(arg2));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(v0);
    }

    public entry fun join_vec<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<0x2::coin::Coin<T0>>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::coin::Coin<T0>>(&arg1)) {
            0x2::coin::join<T0>(arg0, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg1));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg1);
    }

    public entry fun join_vec_and_transfer<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: address) {
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg0) > 0, 0);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
        let v1 = &mut v0;
        join_vec<T0>(v1, arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg1);
    }

    public fun keep<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
    }

    public entry fun split_and_transfer<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, arg1, arg3), arg2);
    }

    public entry fun split_vec<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            split<T0>(arg0, *0x1::vector::borrow<u64>(&arg1, v0), arg2);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

