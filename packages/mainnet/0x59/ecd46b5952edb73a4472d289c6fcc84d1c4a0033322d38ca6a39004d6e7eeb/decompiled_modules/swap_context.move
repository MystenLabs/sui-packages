module 0x59ecd46b5952edb73a4472d289c6fcc84d1c4a0033322d38ca6a39004d6e7eeb::swap_context {
    struct SwapContext {
        from: 0x1::type_name::TypeName,
        amount_in: u64,
        min_amount_out: u64,
        recipient: address,
        balances: 0x2::bag::Bag,
    }

    public fun amount_in(arg0: &SwapContext) : u64 {
        arg0.amount_in
    }

    public fun begin_swap<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : SwapContext {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 102);
        let v1 = 0x1::type_name::with_original_ids<T0>();
        let v2 = 0x2::bag::new(arg3);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v2, v1, 0x2::coin::into_balance<T0>(arg0));
        SwapContext{
            from           : v1,
            amount_in      : v0,
            min_amount_out : arg1,
            recipient      : arg2,
            balances       : v2,
        }
    }

    public fun confirm_swap<T0>(arg0: SwapContext, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let SwapContext {
            from           : _,
            amount_in      : _,
            min_amount_out : v2,
            recipient      : _,
            balances       : v4,
        } = arg0;
        let v5 = v4;
        let v6 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v5, 0x1::type_name::with_original_ids<T0>());
        assert!(0x2::balance::value<T0>(&v6) >= v2, 100);
        assert!(0x2::bag::is_empty(&v5), 101);
        0x2::bag::destroy_empty(v5);
        0x2::coin::from_balance<T0>(v6, arg1)
    }

    public fun min_amount_out(arg0: &SwapContext) : u64 {
        arg0.min_amount_out
    }

    public fun put_balance<T0>(arg0: &mut SwapContext, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    public fun recipient(arg0: &SwapContext) : address {
        arg0.recipient
    }

    public fun take_balance<T0>(arg0: &mut SwapContext, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        if (0x2::balance::value<T0>(v1) == arg1) {
            0x2::coin::from_balance<T0>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg2)
        } else {
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg1), arg2)
        }
    }

    // decompiled from Move bytecode v7
}

