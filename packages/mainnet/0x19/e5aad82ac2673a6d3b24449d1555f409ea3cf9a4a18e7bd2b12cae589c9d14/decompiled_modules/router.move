module 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router {
    struct SwapContext {
        quote_id: 0x1::string::String,
        from: 0x1::type_name::TypeName,
        target: 0x1::type_name::TypeName,
        amount_in: u64,
        expect_amount_out: u64,
        amount_out_limit: u64,
        fee_rate: u32,
        fee_recipient: address,
        balances: 0x2::bag::Bag,
    }

    struct QuoteGuardV3 has drop, store {
        quote_amount_in: u64,
        quote_amount_out: u64,
        slippage: u64,
    }

    struct QuoteGuardKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ConfirmSwapEvent has copy, drop {
        quote_id: 0x1::string::String,
        from: 0x1::type_name::TypeName,
        target: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        fee_rate: u32,
        fee_recipient: address,
        expect_amount_out: u64,
        amount_out_limit: u64,
    }

    struct ConfirmSwapEventV3 has copy, drop {
        quote_id: 0x1::string::String,
        from: 0x1::type_name::TypeName,
        target: 0x1::type_name::TypeName,
        quote_amount_in: u64,
        quote_amount_out: u64,
        slippage: u64,
        amount_in: u64,
        amount_out: u64,
        amount_out_limit: u64,
        fee_amount: u64,
        fee_rate: u32,
        fee_recipient: address,
    }

    struct SwapEvent has copy, drop {
        quote_id: 0x1::string::String,
        pool_id: 0x2::object::ID,
        dex: 0x1::string::String,
        from: 0x1::type_name::TypeName,
        target: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
        amount_in_remaining: u64,
    }

    fun collect_fee<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u32, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg1 == 0 || arg2 == @0x0) {
            return 0
        };
        let v0 = mul_div(0x2::balance::value<T0>(arg0), (arg1 as u64), (1000000 as u64));
        transfer_balance<T0>(0x2::balance::split<T0>(arg0, v0), arg2, arg3);
        v0
    }

    public fun confirm_swap<T0>(arg0: SwapContext, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let SwapContext {
            quote_id          : v0,
            from              : v1,
            target            : v2,
            amount_in         : v3,
            expect_amount_out : v4,
            amount_out_limit  : v5,
            fee_rate          : v6,
            fee_recipient     : v7,
            balances          : v8,
        } = arg0;
        let v9 = v8;
        let v10 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v9, v2);
        let v11 = &mut v10;
        let v12 = collect_fee<T0>(v11, v6, v7, arg1);
        assert!(0x2::balance::value<T0>(&v10) >= v5, 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::errors::err_amount_out_slippage_check_failed());
        assert!(0x2::bag::is_empty(&v9), 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::errors::err_remains_balance());
        0x2::bag::destroy_empty(v9);
        let v13 = ConfirmSwapEvent{
            quote_id          : v0,
            from              : v1,
            target            : v2,
            amount_in         : v3,
            amount_out        : 0x2::balance::value<T0>(&v10),
            fee_amount        : v12,
            fee_rate          : v6,
            fee_recipient     : v7,
            expect_amount_out : v4,
            amount_out_limit  : v5,
        };
        0x2::event::emit<ConfirmSwapEvent>(v13);
        0x2::coin::from_balance<T0>(v10, arg1)
    }

    public fun confirm_swap_v3<T0>(arg0: SwapContext, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = QuoteGuardKey{dummy_field: false};
        assert!(0x2::bag::contains_with_type<QuoteGuardKey, QuoteGuardV3>(&arg0.balances, v0), 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::errors::err_missing_quote_guard());
        let SwapContext {
            quote_id          : v1,
            from              : v2,
            target            : v3,
            amount_in         : v4,
            expect_amount_out : _,
            amount_out_limit  : _,
            fee_rate          : v7,
            fee_recipient     : v8,
            balances          : v9,
        } = arg0;
        let v10 = v9;
        let v11 = QuoteGuardKey{dummy_field: false};
        let QuoteGuardV3 {
            quote_amount_in  : v12,
            quote_amount_out : v13,
            slippage         : v14,
        } = 0x2::bag::remove<QuoteGuardKey, QuoteGuardV3>(&mut v10, v11);
        let v15 = mul_div(mul_div(v4, v13, v12), 1000000 - v14, 1000000);
        assert!(v15 > 0, 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::errors::err_amount_out_limit_is_zero());
        let v16 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v10, v3);
        let v17 = &mut v16;
        let v18 = collect_fee<T0>(v17, v7, v8, arg1);
        assert!(0x2::balance::value<T0>(&v16) >= v15, 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::errors::err_amount_out_slippage_check_failed());
        assert!(0x2::bag::is_empty(&v10), 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::errors::err_remains_balance());
        0x2::bag::destroy_empty(v10);
        let v19 = ConfirmSwapEventV3{
            quote_id         : v1,
            from             : v2,
            target           : v3,
            quote_amount_in  : v12,
            quote_amount_out : v13,
            slippage         : v14,
            amount_in        : v4,
            amount_out       : 0x2::balance::value<T0>(&v16),
            amount_out_limit : v15,
            fee_amount       : v18,
            fee_rate         : v7,
            fee_recipient    : v8,
        };
        0x2::event::emit<ConfirmSwapEventV3>(v19);
        0x2::coin::from_balance<T0>(v16, arg1)
    }

    public fun emit_swap_event<T0, T1>(arg0: &SwapContext, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = SwapEvent{
            quote_id            : arg0.quote_id,
            pool_id             : arg2,
            dex                 : 0x1::string::utf8(arg1),
            from                : 0x1::type_name::get<T0>(),
            target              : 0x1::type_name::get<T1>(),
            amount_in           : arg3,
            amount_out          : arg4,
            amount_in_remaining : arg5,
        };
        0x2::event::emit<SwapEvent>(v0);
    }

    public fun max_amount_in() : u64 {
        18446744073709551615
    }

    public fun merge_balance<T0>(arg0: &mut SwapContext, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
        };
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= (18446744073709551615 as u128), 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::errors::err_expect_amount_out_overflow());
        (v0 as u64)
    }

    public fun new_swap_context<T0, T1>(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: u32, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : SwapContext {
        assert!(0x2::coin::value<T0>(&arg3) > 0, 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::errors::err_amount_in_is_zero());
        if (arg4 > 0) {
            assert!(arg5 != @0x0, 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::errors::err_invalid_fee_recipient());
        };
        assert!(arg4 <= 100000, 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::errors::err_too_large_fee_rate());
        let v0 = 0x2::bag::new(arg6);
        let v1 = 0x1::type_name::get<T0>();
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0, v1, 0x2::coin::into_balance<T0>(arg3));
        SwapContext{
            quote_id          : arg0,
            from              : v1,
            target            : 0x1::type_name::get<T1>(),
            amount_in         : 0x2::coin::value<T0>(&arg3),
            expect_amount_out : arg1,
            amount_out_limit  : arg2,
            fee_rate          : arg4,
            fee_recipient     : arg5,
            balances          : v0,
        }
    }

    public fun new_swap_context_v2<T0, T1>(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: u32, arg6: address, arg7: &mut 0x2::tx_context::TxContext) : SwapContext {
        assert!(0x2::coin::value<T0>(&arg4) <= arg1, 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::errors::err_exceed_max_amount_in());
        new_swap_context<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun new_swap_context_v3<T0, T1>(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: u32, arg7: address, arg8: &mut 0x2::tx_context::TxContext) : SwapContext {
        assert!(0x2::coin::value<T0>(&arg5) <= arg1, 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::errors::err_exceed_max_amount_in());
        assert!(arg2 > 0, 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::errors::err_amount_in_is_zero());
        assert!(arg3 > 0, 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::errors::err_amount_out_is_zero());
        assert!(arg4 < 1000000, 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::errors::err_invalid_slippage());
        let v0 = new_swap_context<T0, T1>(arg0, 0, 0, arg5, arg6, arg7, arg8);
        let v1 = QuoteGuardKey{dummy_field: false};
        let v2 = QuoteGuardV3{
            quote_amount_in  : arg2,
            quote_amount_out : arg3,
            slippage         : arg4,
        };
        0x2::bag::add<QuoteGuardKey, QuoteGuardV3>(&mut v0.balances, v1, v2);
        v0
    }

    public fun take_balance<T0>(arg0: &mut SwapContext, arg1: u64) : 0x2::balance::Balance<T0> {
        if (arg1 == 0) {
            return 0x2::balance::zero<T0>()
        };
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            return 0x2::balance::zero<T0>()
        };
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        if (0x2::balance::value<T0>(v1) <= arg1) {
            0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0)
        } else {
            0x2::balance::split<T0>(v1, arg1)
        }
    }

    public fun transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    public fun transfer_or_destroy_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v7
}

