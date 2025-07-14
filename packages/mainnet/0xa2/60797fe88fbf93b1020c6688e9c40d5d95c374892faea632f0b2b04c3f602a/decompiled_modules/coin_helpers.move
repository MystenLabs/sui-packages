module 0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::coin_helpers {
    public fun balance_to_coin<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(arg0, arg1)
    }

    public fun calculate_total_value<T0>(arg0: &vector<0x2::coin::Coin<T0>>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::coin::Coin<T0>>(arg0)) {
            v0 = v0 + 0x2::coin::value<T0>(0x1::vector::borrow<0x2::coin::Coin<T0>>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun coin_to_balance<T0>(arg0: 0x2::coin::Coin<T0>) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(arg0)
    }

    public fun consolidate_small_coins<T0>(arg0: &mut vector<0x2::coin::Coin<T0>>, arg1: u64) {
        if (0x1::vector::length<0x2::coin::Coin<T0>>(arg0) <= 1) {
            return
        };
        let v0 = 0x1::vector::swap_remove<0x2::coin::Coin<T0>>(arg0, find_largest_coin<T0>(arg0));
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::coin::Coin<T0>>(arg0)) {
            if (0x2::coin::value<T0>(0x1::vector::borrow<0x2::coin::Coin<T0>>(arg0, v1)) < arg1) {
                0x2::coin::join<T0>(&mut v0, 0x1::vector::swap_remove<0x2::coin::Coin<T0>>(arg0, v1));
                continue
            };
            v1 = v1 + 1;
        };
        0x1::vector::push_back<0x2::coin::Coin<T0>>(arg0, v0);
    }

    public fun create_coin_vector_from_splits<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<T0>> {
        assert!(validate_arbitrage_amounts<T0>(arg0, arg1), 1);
        split_coin_multiple<T0>(arg0, arg1, arg2)
    }

    public fun create_zero_coin<T0>(arg0: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::zero<T0>(arg0)
    }

    public fun destroy_empty_coin<T0>(arg0: 0x2::coin::Coin<T0>) {
        0x2::coin::destroy_zero<T0>(arg0);
    }

    public fun find_largest_coin<T0>(arg0: &vector<0x2::coin::Coin<T0>>) : u64 {
        let v0 = 0x1::vector::length<0x2::coin::Coin<T0>>(arg0);
        assert!(v0 > 0, 3);
        let v1 = 0;
        while (v1 < v0) {
            v1 = v1 + 1;
        };
        0
    }

    public fun get_balance_value<T0>(arg0: &0x2::balance::Balance<T0>) : u64 {
        0x2::balance::value<T0>(arg0)
    }

    public fun get_coin_balance<T0>(arg0: &0x2::coin::Coin<T0>) : u64 {
        0x2::coin::value<T0>(arg0)
    }

    public fun handle_dust_coins<T0>(arg0: &mut vector<0x2::coin::Coin<T0>>, arg1: u64) {
        if (0x1::vector::length<0x2::coin::Coin<T0>>(arg0) <= 1) {
            return
        };
        let v0 = 0x1::vector::swap_remove<0x2::coin::Coin<T0>>(arg0, find_largest_coin<T0>(arg0));
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::coin::Coin<T0>>(arg0)) {
            if (0x2::coin::value<T0>(0x1::vector::borrow<0x2::coin::Coin<T0>>(arg0, v1)) < arg1) {
                0x2::coin::join<T0>(&mut v0, 0x1::vector::swap_remove<0x2::coin::Coin<T0>>(arg0, v1));
                continue
            };
            v1 = v1 + 1;
        };
        0x1::vector::push_back<0x2::coin::Coin<T0>>(arg0, v0);
    }

    public fun has_sufficient_balance<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) : bool {
        0x2::coin::value<T0>(arg0) >= arg1
    }

    public fun is_dust_coin<T0>(arg0: &0x2::coin::Coin<T0>) : bool {
        0x2::coin::value<T0>(arg0) < 1000
    }

    public fun is_empty_coin<T0>(arg0: &0x2::coin::Coin<T0>) : bool {
        0x2::coin::value<T0>(arg0) == 0
    }

    public fun join_balances<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(arg0, arg1);
    }

    public fun merge_arbitrage_outputs<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg0) > 0, 3);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
        let v1 = &mut v0;
        merge_coins<T0>(v1, arg0);
        v0
    }

    public fun merge_coins<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<0x2::coin::Coin<T0>>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::coin::Coin<T0>>(&arg1)) {
            0x2::coin::join<T0>(arg0, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg1));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg1);
    }

    public fun prepare_multi_hop_coins<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<T0>> {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1)) {
            v0 = v0 + *0x1::vector::borrow<u64>(&arg1, v1);
            v1 = v1 + 1;
        };
        assert!(0x2::coin::value<T0>(arg0) >= v0, 1);
        split_coin_multiple<T0>(arg0, arg1, arg2)
    }

    public fun split_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 1);
        0x2::balance::split<T0>(arg0, arg1)
    }

    public fun split_coin_equal<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<T0>> {
        assert!(arg1 > 0, 2);
        assert!(arg1 <= 256, 6);
        let v0 = 0x2::coin::value<T0>(arg0);
        assert!(v0 >= arg1, 1);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        let v2 = 0;
        while (v2 < arg1) {
            let v3 = if (v2 == 0) {
                v0 / arg1 + v0 % arg1
            } else {
                v0 / arg1
            };
            if (v3 > 0) {
                0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v1, 0x2::coin::split<T0>(arg0, v3, arg2));
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun split_coin_multiple<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<T0>> {
        let v0 = 0x1::vector::length<u64>(&arg1);
        assert!(v0 > 0, 2);
        assert!(v0 <= 256, 6);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u64>(&arg1, v2);
            assert!(v3 > 0, 5);
            assert!(0x2::coin::value<T0>(arg0) >= v3, 1);
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v1, 0x2::coin::split<T0>(arg0, v3, arg2));
            v2 = v2 + 1;
        };
        v1
    }

    public fun split_coin_safe<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0, 5);
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
        0x2::coin::split<T0>(arg0, arg1, arg2)
    }

    public fun split_for_arbitrage<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = arg1 + arg2;
        assert!(0x2::coin::value<T0>(arg0) >= v0, 1);
        0x2::coin::split<T0>(arg0, v0, arg3)
    }

    public fun transfer_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    public fun try_split_coin<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (arg1 == 0 || 0x2::coin::value<T0>(arg0) < arg1) {
            0x1::option::none<0x2::coin::Coin<T0>>()
        } else {
            0x1::option::some<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, arg1, arg2))
        }
    }

    public fun validate_arbitrage_amounts<T0>(arg0: &0x2::coin::Coin<T0>, arg1: vector<u64>) : bool {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1)) {
            let v2 = *0x1::vector::borrow<u64>(&arg1, v1);
            if (v2 == 0) {
                return false
            };
            v0 = v0 + v2;
            v1 = v1 + 1;
        };
        0x2::coin::value<T0>(arg0) >= v0
    }

    // decompiled from Move bytecode v6
}

