module 0x7b3bc19275df073b47e5705adf0ef87a840231120a8c86c5ff43d9c40b40ac04::swap_context {
    struct SwapContext {
        from: 0x1::type_name::TypeName,
        balances: 0x2::bag::Bag,
    }

    public fun confirm_swap<T0>(arg0: SwapContext, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let SwapContext {
            from     : _,
            balances : v1,
        } = arg0;
        let v2 = v1;
        assert!(0x2::bag::is_empty(&v2), 0x7b3bc19275df073b47e5705adf0ef87a840231120a8c86c5ff43d9c40b40ac04::errors::err_remains_balance());
        0x2::bag::destroy_empty(v2);
        0x2::coin::from_balance<T0>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v2, 0x1::type_name::with_defining_ids<T0>()), arg1)
    }

    public fun merge_balance<T0>(arg0: &mut SwapContext, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
        };
    }

    public fun merge_coin_balance<T0>(arg0: &mut SwapContext, arg1: 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
            return
        };
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    public fun new_swap_context<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : SwapContext {
        assert!(0x2::coin::value<T0>(&arg0) > 0, 0x7b3bc19275df073b47e5705adf0ef87a840231120a8c86c5ff43d9c40b40ac04::errors::err_amount_in_is_zero());
        let v0 = 0x2::bag::new(arg1);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0, v1, 0x2::coin::into_balance<T0>(arg0));
        SwapContext{
            from     : v1,
            balances : v0,
        }
    }

    public fun take_balance<T0>(arg0: &mut SwapContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            return 0x2::balance::zero<T0>()
        };
        0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0)
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

