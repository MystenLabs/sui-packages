module 0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router {
    struct SwapContext {
        quote_id: 0x1::string::String,
        from: 0x1::type_name::TypeName,
        target: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out_limit: u64,
        balances: 0x2::bag::Bag,
    }

    struct ConfirmSwapEvent has copy, drop {
        quote_id: 0x1::string::String,
        from: 0x1::type_name::TypeName,
        target: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
        amount_out_limit: u64,
    }

    public fun arb_swap<T0, T1>(arg0: 0x1::string::String, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : SwapContext {
        assert!(0x2::coin::value<T0>(&arg2) > 0, 1);
        let v0 = 0x2::bag::new(arg3);
        let v1 = 0x1::type_name::get<T0>();
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0, v1, 0x2::coin::into_balance<T0>(arg2));
        SwapContext{
            quote_id         : arg0,
            from             : v1,
            target           : 0x1::type_name::get<T1>(),
            amount_in        : 0x2::coin::value<T0>(&arg2),
            amount_out_limit : arg1,
            balances         : v0,
        }
    }

    public fun arb_swap_cetus_a2b<T0, T1, T2>(arg0: 0x1::string::String, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : SwapContext {
        let v0 = arb_swap<T0, T2>(arg0, arg1, arg2, arg6);
        let v1 = &mut v0;
        let v2 = take_balance<T0>(v1, 18446744073709551615);
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg3, arg4, true, true, 0x2::balance::value<T0>(&v2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg5);
        let v6 = v5;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg3, arg4, 0x2::balance::split<T0>(&mut v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v6)), 0x2::balance::zero<T1>(), v6);
        0x2::balance::destroy_zero<T0>(v3);
        let v7 = 0x2::tx_context::sender(arg6);
        transfer_balance<T0>(v2, v7, arg6);
        let v8 = &mut v0;
        merge_balance<T1>(v8, v4);
        v0
    }

    public fun arb_swap_cetus_a2b_limit<T0, T1, T2>(arg0: 0x1::string::String, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : SwapContext {
        let v0 = if (arg5 == 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price()
        } else {
            arg5
        };
        let v1 = arb_swap<T0, T2>(arg0, arg1, arg2, arg7);
        let v2 = &mut v1;
        let v3 = take_balance<T0>(v2, 18446744073709551615);
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg3, arg4, true, true, 0x2::balance::value<T0>(&v3), v0, arg6);
        let v7 = v6;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg3, arg4, 0x2::balance::split<T0>(&mut v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v7)), 0x2::balance::zero<T1>(), v7);
        0x2::balance::destroy_zero<T0>(v4);
        let v8 = 0x2::tx_context::sender(arg7);
        transfer_balance<T0>(v3, v8, arg7);
        let v9 = &mut v1;
        merge_balance<T1>(v9, v5);
        v1
    }

    public fun arb_swap_cetus_b2a<T0, T1, T2>(arg0: 0x1::string::String, arg1: u64, arg2: 0x2::coin::Coin<T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : SwapContext {
        let v0 = arb_swap<T1, T2>(arg0, arg1, arg2, arg6);
        let v1 = &mut v0;
        let v2 = take_balance<T1>(v1, 18446744073709551615);
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg3, arg4, false, true, 0x2::balance::value<T1>(&v2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg5);
        let v6 = v5;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg3, arg4, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v6)), v6);
        0x2::balance::destroy_zero<T1>(v4);
        let v7 = 0x2::tx_context::sender(arg6);
        transfer_balance<T1>(v2, v7, arg6);
        let v8 = &mut v0;
        merge_balance<T0>(v8, v3);
        v0
    }

    public fun arb_swap_cetus_b2a_limit<T0, T1, T2>(arg0: 0x1::string::String, arg1: u64, arg2: 0x2::coin::Coin<T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : SwapContext {
        let v0 = if (arg5 == 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price()
        } else {
            arg5
        };
        let v1 = arb_swap<T1, T2>(arg0, arg1, arg2, arg7);
        let v2 = &mut v1;
        let v3 = take_balance<T1>(v2, 18446744073709551615);
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg3, arg4, false, true, 0x2::balance::value<T1>(&v3), v0, arg6);
        let v7 = v6;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg3, arg4, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v7)), v7);
        0x2::balance::destroy_zero<T1>(v5);
        let v8 = 0x2::tx_context::sender(arg7);
        transfer_balance<T1>(v3, v8, arg7);
        let v9 = &mut v1;
        merge_balance<T0>(v9, v4);
        v1
    }

    public fun confirm_swap<T0>(arg0: SwapContext, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let SwapContext {
            quote_id         : v0,
            from             : v1,
            target           : v2,
            amount_in        : v3,
            amount_out_limit : v4,
            balances         : v5,
        } = arg0;
        let v6 = v5;
        let v7 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v6, v2);
        assert!(0x2::balance::value<T0>(&v7) >= v4, 2);
        assert!(0x2::bag::is_empty(&v6), 3);
        0x2::bag::destroy_empty(v6);
        let v8 = ConfirmSwapEvent{
            quote_id         : v0,
            from             : v1,
            target           : v2,
            amount_in        : v3,
            amount_out       : 0x2::balance::value<T0>(&v7),
            amount_out_limit : v4,
        };
        0x2::event::emit<ConfirmSwapEvent>(v8);
        0x2::coin::from_balance<T0>(v7, arg1)
    }

    public fun emit_swap_event<T0, T1>(arg0: &SwapContext, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64) {
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

    public fun new_swap_context<T0, T1>(arg0: 0x1::string::String, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : SwapContext {
        arb_swap<T0, T1>(arg0, arg1, arg2, arg3)
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

