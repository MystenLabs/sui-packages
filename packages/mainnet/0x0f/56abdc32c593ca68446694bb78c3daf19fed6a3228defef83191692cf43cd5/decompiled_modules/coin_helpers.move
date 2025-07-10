module 0xf56abdc32c593ca68446694bb78c3daf19fed6a3228defef83191692cf43cd5::coin_helpers {
    public fun calculate_total_value<T0>(arg0: &vector<0x2::coin::Coin<T0>>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::coin::Coin<T0>>(arg0)) {
            v0 = v0 + 0x2::coin::value<T0>(0x1::vector::borrow<0x2::coin::Coin<T0>>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_coin_value<T0>(arg0: &0x2::coin::Coin<T0>) : u64 {
        0x2::coin::value<T0>(arg0)
    }

    public fun is_zero_coin<T0>(arg0: &0x2::coin::Coin<T0>) : bool {
        0x2::coin::value<T0>(arg0) == 0
    }

    public fun merge_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>) : 0x2::coin::Coin<T0> {
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg0) > 0, 3);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x2::coin::join<T0>(&mut v0, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
        v0
    }

    public fun split_exact_amount<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0, 4);
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
        0x2::coin::split<T0>(arg0, arg1, arg2)
    }

    public fun split_for_gas_efficiency<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<T0>> {
        let v0 = 0x2::coin::value<T0>(arg0);
        assert!(v0 >= arg1, 1);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        if (v0 > arg1) {
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v1, 0x2::coin::split<T0>(arg0, arg1, arg2));
        };
        v1
    }

    public fun validate_coin_type<T0>() : bool {
        true
    }

    public fun validate_minimum_amount<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) : bool {
        0x2::coin::value<T0>(arg0) >= arg1
    }

    // decompiled from Move bytecode v6
}

