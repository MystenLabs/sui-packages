module 0x3a8311cb46fdbec581a94288b3a4aa6b63d1ceda4e806b3706cabf2296d1e41::router {
    struct SwapContext {
        balances: 0x2::bag::Bag,
        amount_in: u64,
    }

    public fun amount_in(arg0: &SwapContext) : u64 {
        arg0.amount_in
    }

    public fun balance_value<T0>(arg0: &SwapContext) : u64 {
        let v0 = type_key<T0>();
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::ascii::String, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        } else {
            0
        }
    }

    public fun begin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : SwapContext {
        let v0 = 0x2::bag::new(arg1);
        0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0, type_key<T0>(), 0x2::coin::into_balance<T0>(arg0));
        SwapContext{
            balances  : v0,
            amount_in : 0x2::coin::value<T0>(&arg0),
        }
    }

    public fun begin_with_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : SwapContext {
        let v0 = 0x2::bag::new(arg1);
        0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0, type_key<T0>(), arg0);
        SwapContext{
            balances  : v0,
            amount_in : 0x2::balance::value<T0>(&arg0),
        }
    }

    public fun finalize<T0>(arg0: SwapContext, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let SwapContext {
            balances  : v0,
            amount_in : _,
        } = arg0;
        let v2 = v0;
        let v3 = type_key<T0>();
        assert!(0x2::bag::contains<0x1::ascii::String>(&v2, v3), 2);
        let v4 = 0x2::bag::remove<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v2, v3);
        assert!(0x2::balance::value<T0>(&v4) >= arg1, 1);
        assert!(0x2::bag::is_empty(&v2), 3);
        0x2::bag::destroy_empty(v2);
        0x2::coin::from_balance<T0>(v4, arg2)
    }

    public fun finalize_to_balance<T0>(arg0: SwapContext, arg1: u64) : 0x2::balance::Balance<T0> {
        let SwapContext {
            balances  : v0,
            amount_in : _,
        } = arg0;
        let v2 = v0;
        let v3 = type_key<T0>();
        assert!(0x2::bag::contains<0x1::ascii::String>(&v2, v3), 2);
        let v4 = 0x2::bag::remove<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v2, v3);
        assert!(0x2::balance::value<T0>(&v4) >= arg1, 1);
        assert!(0x2::bag::is_empty(&v2), 3);
        0x2::bag::destroy_empty(v2);
        v4
    }

    public fun merge_balance<T0>(arg0: &mut SwapContext, arg1: 0x2::balance::Balance<T0>) {
        let v0 = type_key<T0>();
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
        };
    }

    public fun take_balance<T0>(arg0: &mut SwapContext) : 0x2::balance::Balance<T0> {
        let v0 = type_key<T0>();
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg0.balances, v0), 2);
        0x2::bag::remove<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0)
    }

    public fun take_balance_amount<T0>(arg0: &mut SwapContext, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = type_key<T0>();
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg0.balances, v0), 2);
        0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1)
    }

    fun type_key<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())
    }

    // decompiled from Move bytecode v6
}

