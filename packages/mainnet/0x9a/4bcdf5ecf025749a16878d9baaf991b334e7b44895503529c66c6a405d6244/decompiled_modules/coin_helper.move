module 0x9a4bcdf5ecf025749a16878d9baaf991b334e7b44895503529c66c6a405d6244::coin_helper {
    public fun join_vec<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<0x2::coin::Coin<T0>>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::coin::Coin<T0>>(&arg1)) {
            0x2::coin::join<T0>(arg0, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg1));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg1);
    }

    public fun merge_and_split<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        assert!(0x2::coin::value<T0>(&arg0) > arg1, 0);
        (0x2::coin::split<T0>(&mut arg0, arg1, arg2), arg0)
    }

    public fun merge_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>) : 0x2::coin::Coin<T0> {
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg0) > 0, 0);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
        let v1 = &mut v0;
        join_vec<T0>(v1, arg0);
        v0
    }

    public fun send_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun split_return_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = merge_and_split<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg2));
        v0
    }

    public fun split_return_vec_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<T0>> {
        let (v0, v1) = merge_and_split<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg2));
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, v0);
        v2
    }

    // decompiled from Move bytecode v6
}

