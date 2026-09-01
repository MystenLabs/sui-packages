module 0x59b4ffcd0d3d3563cafa66f54f8de2f481d5186e1505bd44aff195fd72995d64::hikida {
    public fun receive_balance<T0>(arg0: &mut 0x2::object::UID, arg1: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>) : 0x2::balance::Balance<T0> {
        receive_balance_impl<T0>(arg0, arg1)
    }

    fun receive_balance_impl<T0>(arg0: &mut 0x2::object::UID, arg1: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>) : 0x2::balance::Balance<T0> {
        assert!(!0x1::vector::is_empty<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&arg1), 0);
        let v0 = 0x2::coin::into_balance<T0>(0x2::transfer::public_receive<0x2::coin::Coin<T0>>(arg0, 0x1::vector::pop_back<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&mut arg1)));
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&arg1)) {
            0x2::balance::join<T0>(&mut v0, 0x2::coin::into_balance<T0>(0x2::transfer::public_receive<0x2::coin::Coin<T0>>(arg0, 0x1::vector::pop_back<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&mut arg1))));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(arg1);
        v0
    }

    public fun receive_coin<T0>(arg0: &mut 0x2::object::UID, arg1: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(receive_balance_impl<T0>(arg0, arg1), arg2)
    }

    public fun redeem_balance<T0>(arg0: &mut 0x2::object::UID, arg1: u64) : 0x2::balance::Balance<T0> {
        redeem_balance_impl<T0>(arg0, arg1)
    }

    fun redeem_balance_impl<T0>(arg0: &mut 0x2::object::UID, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(arg1 > 0, 1);
        0x2::balance::redeem_funds<T0>(0x2::balance::withdraw_funds_from_object<T0>(arg0, arg1))
    }

    public fun redeem_coin<T0>(arg0: &mut 0x2::object::UID, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(redeem_balance_impl<T0>(arg0, arg1), arg2)
    }

    // decompiled from Move bytecode v7
}

