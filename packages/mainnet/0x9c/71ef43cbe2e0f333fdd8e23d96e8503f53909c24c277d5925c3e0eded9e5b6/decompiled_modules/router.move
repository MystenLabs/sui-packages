module 0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::router {
    struct SwapContext {
        quote_id: 0x1::string::String,
        from: 0x1::type_name::TypeName,
        target: 0x1::type_name::TypeName,
        amount_in: u64,
        quote_amount_in: u64,
        quote_amount_out: u64,
        slippage: u64,
        fee_rate: u32,
        fee_recipient: address,
        balances: 0x2::bag::Bag,
    }

    struct ConfirmSwapEvent has copy, drop {
        quote_id: 0x1::string::String,
        from: 0x1::type_name::TypeName,
        target: 0x1::type_name::TypeName,
        vault_id: 0x2::object::ID,
        quote_amount_in: u64,
        quote_amount_out: u64,
        slippage: u64,
        amount_in: u64,
        amount_out: u64,
        amount_out_limit: u64,
        protocol_fee_amount: u64,
        integrator_fee_amount: u64,
        surplus_amount: u64,
        surplus_share: u64,
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

    public fun confirm_swap<T0>(arg0: SwapContext, arg1: &0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::versioned::Versioned, arg2: &mut 0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::protocol_fee::ProtocolFeeVault, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::versioned::check_version(arg1);
        let SwapContext {
            quote_id         : v0,
            from             : v1,
            target           : v2,
            amount_in        : v3,
            quote_amount_in  : v4,
            quote_amount_out : v5,
            slippage         : v6,
            fee_rate         : v7,
            fee_recipient    : v8,
            balances         : v9,
        } = arg0;
        let v10 = v9;
        let v11 = mul_div(v3, v5, v4);
        let v12 = mul_div(v11, 1000000 - v6, 1000000);
        assert!(v12 > 0, 0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::errors::err_amount_out_limit_is_zero());
        let v13 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v10, v2);
        let v14 = 0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::protocol_fee::rate_denominator();
        let v15 = 0;
        let v16 = 0;
        if (v7 > 0 && v8 != @0x0) {
            let v17 = mul_div(0x2::balance::value<T0>(&v13), (v7 as u64), (1000000 as u64));
            let v18 = mul_div(v17, 0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::protocol_fee::protocol_cut_rate(arg2), v14);
            v15 = v18;
            let v19 = v17 - v18;
            v16 = v19;
            0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::protocol_fee::deposit_overlay_fee<T0>(arg2, 0x2::balance::split<T0>(&mut v13, v18));
            transfer_balance<T0>(0x2::balance::split<T0>(&mut v13, v19), v8, arg3);
        };
        assert!(0x2::balance::value<T0>(&v13) >= v12, 0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::errors::err_amount_out_slippage_check_failed());
        assert!(0x2::bag::is_empty(&v10), 0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::errors::err_remains_balance());
        0x2::bag::destroy_empty(v10);
        let v20 = 0;
        let v21 = 0;
        if (0x2::balance::value<T0>(&v13) > v11) {
            let v22 = 0x2::balance::value<T0>(&v13) - v11;
            v20 = v22;
            let v23 = mul_div(v22, 0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::protocol_fee::capture_rate(arg2), v14);
            v21 = v23;
            let v24 = mul_div(0x2::balance::value<T0>(&v13), 0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::protocol_fee::volume_cap_rate(arg2), v14);
            if (v23 > v24) {
                v21 = v24;
            };
            0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::protocol_fee::deposit_surplus_revenue<T0>(arg2, 0x2::balance::split<T0>(&mut v13, v21));
        };
        let v25 = ConfirmSwapEvent{
            quote_id              : v0,
            from                  : v1,
            target                : v2,
            vault_id              : 0x2::object::id<0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::protocol_fee::ProtocolFeeVault>(arg2),
            quote_amount_in       : v4,
            quote_amount_out      : v5,
            slippage              : v6,
            amount_in             : v3,
            amount_out            : 0x2::balance::value<T0>(&v13),
            amount_out_limit      : v12,
            protocol_fee_amount   : v15,
            integrator_fee_amount : v16,
            surplus_amount        : v20,
            surplus_share         : v21,
            fee_rate              : v7,
            fee_recipient         : v8,
        };
        0x2::event::emit<ConfirmSwapEvent>(v25);
        0x2::coin::from_balance<T0>(v13, arg3)
    }

    public fun emit_swap_event<T0, T1>(arg0: &SwapContext, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = SwapEvent{
            quote_id            : arg0.quote_id,
            pool_id             : arg2,
            dex                 : 0x1::string::utf8(arg1),
            from                : 0x1::type_name::with_defining_ids<T0>(),
            target              : 0x1::type_name::with_defining_ids<T1>(),
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
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
        };
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= (18446744073709551615 as u128), 0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::errors::err_expect_amount_out_overflow());
        (v0 as u64)
    }

    public fun new_swap_context<T0, T1>(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: u32, arg7: address, arg8: &mut 0x2::tx_context::TxContext) : SwapContext {
        assert!(0x2::coin::value<T0>(&arg5) > 0, 0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::errors::err_amount_in_is_zero());
        assert!(0x2::coin::value<T0>(&arg5) <= arg1, 0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::errors::err_exceed_max_amount_in());
        assert!(arg2 > 0, 0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::errors::err_amount_out_is_zero());
        assert!(arg3 > 0, 0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::errors::err_amount_out_is_zero());
        assert!(arg4 < 1000000, 0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::errors::err_invalid_slippage());
        if (arg6 > 0) {
            assert!(arg7 != @0x0, 0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::errors::err_invalid_fee_recipient());
        };
        assert!(arg6 <= 100000, 0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::errors::err_too_large_fee_rate());
        let v0 = 0x2::bag::new(arg8);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0, v1, 0x2::coin::into_balance<T0>(arg5));
        SwapContext{
            quote_id         : arg0,
            from             : v1,
            target           : 0x1::type_name::with_defining_ids<T1>(),
            amount_in        : 0x2::coin::value<T0>(&arg5),
            quote_amount_in  : arg2,
            quote_amount_out : arg3,
            slippage         : arg4,
            fee_rate         : arg6,
            fee_recipient    : arg7,
            balances         : v0,
        }
    }

    public fun take_balance<T0>(arg0: &mut SwapContext, arg1: u64) : 0x2::balance::Balance<T0> {
        if (arg1 == 0) {
            return 0x2::balance::zero<T0>()
        };
        let v0 = 0x1::type_name::with_defining_ids<T0>();
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

