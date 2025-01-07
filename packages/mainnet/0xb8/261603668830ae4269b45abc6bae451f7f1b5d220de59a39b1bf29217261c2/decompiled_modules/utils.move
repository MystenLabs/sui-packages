module 0xb8261603668830ae4269b45abc6bae451f7f1b5d220de59a39b1bf29217261c2::utils {
    public fun check_amount_sufficient<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 13);
    }

    public fun maybe_split_coin_and_transfer_rest<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x2::coin::value<T0>(&arg0) == arg1) {
            return arg0
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg2);
        0x2::coin::split<T0>(&mut arg0, arg1, arg3)
    }

    public fun maybe_split_coins_and_transfer_rest<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = merge_coins<T0>(arg0, arg3);
        maybe_split_coin_and_transfer_rest<T0>(v0, arg1, arg2, arg3)
    }

    public fun maybe_transfer_or_destroy_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun merge_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg1);
        0x2::pay::join_vec<T0>(&mut v0, arg0);
        v0
    }

    public fun split_coin_by_weights<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<T0>> {
        let v0 = merge_coins<T0>(arg0, arg2);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        let v2 = 0;
        0x1::vector::reverse<u64>(&mut arg1);
        while (!0x1::vector::is_empty<u64>(&arg1)) {
            let v3 = 0x1::vector::pop_back<u64>(&mut arg1);
            assert!(v3 > 0 && v3 < 10000, 12);
            v2 = v2 + v3;
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v1, 0x2::coin::split<T0>(&mut v0, 0x2::coin::value<T0>(&v0) * v3 / 10000, arg2));
        };
        assert!(v2 == 10000, 14);
        maybe_transfer_or_destroy_coin<T0>(v0, arg2);
        v1
    }

    // decompiled from Move bytecode v6
}

