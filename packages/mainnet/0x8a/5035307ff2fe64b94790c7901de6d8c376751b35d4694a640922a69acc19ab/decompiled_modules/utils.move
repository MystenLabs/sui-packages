module 0x8a5035307ff2fe64b94790c7901de6d8c376751b35d4694a640922a69acc19ab::utils {
    public fun check_amount_sufficient<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 0);
        arg0
    }

    public fun merge_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x1::vector::length<0x2::coin::Coin<T0>>(&arg0) == 0) {
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
            0x2::coin::zero<T0>(arg1)
        } else {
            let v1 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
            0x2::pay::join_vec<T0>(&mut v1, arg0);
            v1
        }
    }

    public fun split_coin_by_weights<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<T0>> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg1)) {
            v1 = v1 + *0x1::vector::borrow<u64>(&arg1, v2);
            v2 = v2 + 1;
        };
        assert!(v1 == 10000, 2);
        let v4 = 0x2::coin::value<T0>(&arg0);
        assert!(v4 > 0, 1);
        while (v3 < 0x1::vector::length<u64>(&arg1)) {
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, 0x2::coin::split<T0>(&mut arg0, 0x8a5035307ff2fe64b94790c7901de6d8c376751b35d4694a640922a69acc19ab::math::divide_and_round_up(v4 * *0x1::vector::borrow<u64>(&arg1, v3), 10000), arg2));
            v3 = v3 + 1;
        };
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
        v0
    }

    // decompiled from Move bytecode v6
}

