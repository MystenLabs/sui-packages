module 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::utils {
    struct SwapIfZeroEvent has copy, drop {
        vault_id: 0x2::object::ID,
        before_sqrt_price: u128,
        after_sqrt_price: u128,
        is_a: bool,
        amount_in: u64,
        amount_out: u64,
        timestamp_ms: u64,
    }

    struct LpResidualEvent has copy, drop {
        vault_id: 0x2::object::ID,
        lp_coin_a: u64,
        lp_coin_b: u64,
        before_sqrt_price: u128,
        after_sqrt_price: u128,
        is_a: bool,
        swap_amt: u64,
        residual_coin_a: u64,
        residual_coin_b: u64,
        timestamp_ms: u64,
    }

    public fun swap<T0, T1>(arg0: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: bool, arg4: bool, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v3 = v2;
        let (v4, v5) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::swap_receipt_debts(&v3);
        if (arg3) {
            0x2::coin::join<T1>(&mut arg2, 0x2::coin::from_balance<T1>(v1, arg9));
            0x2::balance::destroy_zero<T0>(v0);
            0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg0, v3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v4, arg9)), 0x2::balance::zero<T1>(), arg8, arg9);
        } else {
            0x2::coin::join<T0>(&mut arg1, 0x2::coin::from_balance<T0>(v0, arg9));
            0x2::balance::destroy_zero<T1>(v1);
            0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg0, v3, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v5, arg9)), arg8, arg9);
        };
        (arg1, arg2)
    }

    public fun add_liquidity<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &mut 0x2::balance::Balance<T0>, arg3: &mut 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock, arg5: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::get_position_tick_range<T0, T1, T2, T3>(arg0);
        let v2 = 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::position_borrow_mut<T0, T1, T2, T3>(arg0);
        let (_, v4, v5) = check_is_fix_coin_a(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(v0), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(v1), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg1), 0x2::balance::value<T0>(arg2), 0x2::balance::value<T1>(arg3));
        if (v4 > 0 && v5 > 0) {
            let (v6, v7) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity::add_liquidity<T0, T1>(arg1, v2, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg2, v4), arg6), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(arg3, v5), arg6), 0, 0, arg4, arg5, arg6);
            0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::add_free_balance_a<T0, T1, T2, T3>(arg0, 0x2::coin::into_balance<T0>(v6));
            0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::add_free_balance_b<T0, T1, T2, T3>(arg0, 0x2::coin::into_balance<T1>(v7));
        };
    }

    public fun check_is_fix_coin_a(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: u64) : (bool, u64, u64) {
        let (v0, v1) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity_math::get_amounts_for_liquidity(arg2, arg0, arg1, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity_math::get_liquidity_for_amounts(arg2, arg0, arg1, arg3, arg4), true);
        let v2 = v0 == arg3 || v0 == arg3 + 1 || v0 + 1 == arg3;
        (v2, v0, v1)
    }

    public(friend) fun close_position<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::version::Version, arg4: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity::remove_liquidity<T0, T1>(arg1, 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::position_borrow_mut<T0, T1, T2, T3>(arg0), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::liquidity(0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::position_borrow<T0, T1, T2, T3>(arg0)), 0, 0, arg2, arg4, arg5);
        0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::collect::fees<T0, T1, T2, T3>(arg0, arg1, arg3, arg4, arg2, arg5);
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity::close_position(0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::remove_position<T0, T1, T2, T3>(arg0), arg4, arg5);
        (0x2::coin::into_balance<T0>(v0), 0x2::coin::into_balance<T1>(v1))
    }

    public(friend) fun create_position<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::I32, arg3: 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::I32, arg4: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::update_last_rebalance_sqrt_price<T0, T1, T2, T3>(arg0, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg1));
        0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::insert_position<T0, T1, T2, T3>(arg0, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity::open_position<T0, T1>(arg1, arg3, arg2, arg4, arg5));
    }

    public(friend) fun generate_auth_token<T0>(arg0: &T0) : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::get<T0>())
    }

    public fun get_a_to_b_price(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * 1000000000 / (arg1 as u128)) as u64)
    }

    public fun get_b_to_a_price(arg0: u64, arg1: u64) : u64 {
        (((arg1 as u128) * 1000000000 / (arg0 as u128)) as u64)
    }

    public fun get_scalled_position_bounds(arg0: u128, arg1: u128, arg2: u128, arg3: u32) : (0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::I32, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::I32) {
        let v0 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_tick_at_sqrt_price(scale(arg0, arg2));
        let v1 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_tick_at_sqrt_price(scale(arg0, arg1));
        let v2 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::from(arg3);
        (0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::sub(v1, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::mod(v1, v2)), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::sub(v0, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::mod(v0, v2)))
    }

    public fun lp_residual_amount<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: bool, arg4: u64, arg5: &0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::version::Version, arg6: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg7: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<LpResidualEvent>, 0x1::option::Option<LpResidualEvent>) {
        0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::version::assert_supported_version(arg5);
        0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::check_pool_compatibility<T0, T1, T2, T3>(arg0, arg1);
        let v0 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg1);
        let (v1, v2) = 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::get_slippage<T0, T1, T2, T3>(arg0);
        let v3 = 0x1::option::none<LpResidualEvent>();
        let v4 = 0x1::option::none<LpResidualEvent>();
        if (arg3 && (0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::free_balance_a_val<T0, T1, T2, T3>(arg0) > 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::free_threshold_a<T0, T1, T2, T3>(arg0) || arg4 > 0)) {
            let v5 = if (arg4 == 0) {
                let (v6, _) = 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::get_optimal_swap_amount_for_single_sided_liquidity<T0, T1, T2, T3>(arg0, arg1, 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::free_balance_a_val<T0, T1, T2, T3>(arg0), true, 16);
                v6
            } else {
                arg4
            };
            let v8 = 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::get_free_balance_a<T0, T1, T2, T3>(arg0);
            assert!(v5 <= 0x2::balance::value<T0>(&v8), 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::error::insufficient_balance_lp_residual());
            let v9 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v8, v5), arg7);
            let v10 = 0x2::coin::zero<T1>(arg7);
            let (v11, v12) = swap<T0, T1>(arg1, v9, v10, true, true, v5, slippage_adjusted_sqrt_price(true, v1, v2, v0), arg2, arg6, arg7);
            let v13 = v12;
            0x2::coin::destroy_zero<T0>(v11);
            let v14 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg1);
            let (v15, v16) = 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::get_position_tick_range<T0, T1, T2, T3>(arg0);
            let (_, v18, v19) = check_is_fix_coin_a(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(v15), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(v16), v14, 0x2::balance::value<T0>(&v8), 0x2::coin::value<T1>(&v13));
            let (v20, v21) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity::add_liquidity<T0, T1>(arg1, 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::position_borrow_mut<T0, T1, T2, T3>(arg0), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v8, v18), arg7), 0x2::coin::split<T1>(&mut v13, v19, arg7), 0, 0, arg2, arg6, arg7);
            let v22 = v21;
            let v23 = v20;
            0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::add_free_balance_a<T0, T1, T2, T3>(arg0, 0x2::coin::into_balance<T0>(v23));
            0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::add_free_balance_b<T0, T1, T2, T3>(arg0, 0x2::coin::into_balance<T1>(v22));
            0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::add_free_balance_a<T0, T1, T2, T3>(arg0, v8);
            0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::add_free_balance_b<T0, T1, T2, T3>(arg0, 0x2::coin::into_balance<T1>(v13));
            let v24 = LpResidualEvent{
                vault_id          : 0x2::object::id<0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::Vault<T0, T1, T2, T3>>(arg0),
                lp_coin_a         : v18 - 0x2::coin::value<T0>(&v23),
                lp_coin_b         : v19 - 0x2::coin::value<T1>(&v22),
                before_sqrt_price : v0,
                after_sqrt_price  : v14,
                is_a              : arg3,
                swap_amt          : v5,
                residual_coin_a   : 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::free_balance_a_val<T0, T1, T2, T3>(arg0),
                residual_coin_b   : 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::free_balance_b_val<T0, T1, T2, T3>(arg0),
                timestamp_ms      : 0x2::clock::timestamp_ms(arg2),
            };
            0x1::option::fill<LpResidualEvent>(&mut v3, v24);
            0x2::event::emit<LpResidualEvent>(v24);
        };
        if (!arg3 && (0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::free_balance_b_val<T0, T1, T2, T3>(arg0) > 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::free_threshold_b<T0, T1, T2, T3>(arg0) || arg4 > 0)) {
            let v25 = if (arg4 == 0) {
                let (v26, _) = 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::get_optimal_swap_amount_for_single_sided_liquidity<T0, T1, T2, T3>(arg0, arg1, 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::free_balance_b_val<T0, T1, T2, T3>(arg0), false, 16);
                v26
            } else {
                arg4
            };
            let v28 = 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::get_free_balance_b<T0, T1, T2, T3>(arg0);
            assert!(v25 <= 0x2::balance::value<T1>(&v28), 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::error::insufficient_balance_lp_residual());
            let v29 = 0x2::coin::zero<T0>(arg7);
            let v30 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v28, v25), arg7);
            let (v31, v32) = swap<T0, T1>(arg1, v29, v30, false, true, v25, slippage_adjusted_sqrt_price(false, v1, v2, v0), arg2, arg6, arg7);
            let v33 = v31;
            0x2::coin::destroy_zero<T1>(v32);
            let v34 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg1);
            let (v35, v36) = 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::get_position_tick_range<T0, T1, T2, T3>(arg0);
            let (_, v38, v39) = check_is_fix_coin_a(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(v35), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(v36), v34, 0x2::coin::value<T0>(&v33), 0x2::balance::value<T1>(&v28));
            let (v40, v41) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity::add_liquidity<T0, T1>(arg1, 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::position_borrow_mut<T0, T1, T2, T3>(arg0), 0x2::coin::split<T0>(&mut v33, v38, arg7), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v28, v39), arg7), 0, 0, arg2, arg6, arg7);
            let v42 = v41;
            let v43 = v40;
            0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::add_free_balance_b<T0, T1, T2, T3>(arg0, 0x2::coin::into_balance<T1>(v42));
            0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::add_free_balance_a<T0, T1, T2, T3>(arg0, 0x2::coin::into_balance<T0>(v43));
            0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::add_free_balance_b<T0, T1, T2, T3>(arg0, v28);
            0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::add_free_balance_a<T0, T1, T2, T3>(arg0, 0x2::coin::into_balance<T0>(v33));
            let v44 = LpResidualEvent{
                vault_id          : 0x2::object::id<0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::Vault<T0, T1, T2, T3>>(arg0),
                lp_coin_a         : v38 - 0x2::coin::value<T0>(&v43),
                lp_coin_b         : v39 - 0x2::coin::value<T1>(&v42),
                before_sqrt_price : v0,
                after_sqrt_price  : v34,
                is_a              : arg3,
                swap_amt          : v25,
                residual_coin_a   : 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::free_balance_a_val<T0, T1, T2, T3>(arg0),
                residual_coin_b   : 0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::free_balance_b_val<T0, T1, T2, T3>(arg0),
                timestamp_ms      : 0x2::clock::timestamp_ms(arg2),
            };
            0x1::option::fill<LpResidualEvent>(&mut v4, v44);
            0x2::event::emit<LpResidualEvent>(v44);
        };
        (v3, v4)
    }

    public fun oracle_price_to_sqrt_price(arg0: u64, arg1: u8, arg2: u8) : u128 {
        let v0 = (arg0 as u128) * 100000000;
        let v1 = v0;
        let v2 = 1000000000;
        let v3 = v2;
        if (arg2 >= arg1) {
            v1 = (((v0 as u256) * (0x1::u128::pow(10, arg2 - arg1) as u256)) as u128);
        } else {
            v3 = (((v2 as u256) * (0x1::u128::pow(10, arg1 - arg2) as u256)) as u128);
        };
        ((((0x1::u128::sqrt(v1) / 0x1::u128::sqrt(v3)) as u256) * 18446744073709551616 / 10000) as u128)
    }

    public fun scale(arg0: u128, arg1: u128) : u128 {
        (((arg0 as u256) * (arg1 as u256) / (0x1fd529c7d651fe13b35c7c83a1a7442c0b56237e881fa4bcfabdca61eea500f3::vault::scalling_factor() as u256)) as u128)
    }

    public fun slippage_adjusted_sqrt_price(arg0: bool, arg1: u128, arg2: u128, arg3: u128) : u128 {
        if (arg1 == 0 && arg2 == 0) {
            if (arg0) {
                4295048017
            } else {
                79226673515401279992447579054
            }
        } else if (arg0) {
            scale(arg3, arg2)
        } else {
            scale(arg3, arg1)
        }
    }

    public fun swap_if_zero<T0, T1>(arg0: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg1: &mut 0x2::balance::Balance<T0>, arg2: &mut 0x2::balance::Balance<T1>, arg3: u128, arg4: u128, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg0);
        if (0x2::balance::value<T0>(arg1) == 0 && 0x2::balance::value<T1>(arg2) / 2 > 0) {
            let v1 = 0x2::balance::value<T1>(arg2) / 2;
            let v2 = 0x2::coin::zero<T0>(arg8);
            let v3 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(arg2, v1), arg8);
            let (v4, v5) = swap<T0, T1>(arg0, v2, v3, false, true, v1, slippage_adjusted_sqrt_price(false, arg3, arg4, v0), arg6, arg7, arg8);
            let v6 = v4;
            0x2::coin::destroy_zero<T1>(v5);
            let v7 = SwapIfZeroEvent{
                vault_id          : arg5,
                before_sqrt_price : v0,
                after_sqrt_price  : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg0),
                is_a              : false,
                amount_in         : v1,
                amount_out        : 0x2::coin::value<T0>(&v6),
                timestamp_ms      : 0x2::clock::timestamp_ms(arg6),
            };
            0x2::event::emit<SwapIfZeroEvent>(v7);
            0x2::balance::join<T0>(arg1, 0x2::coin::into_balance<T0>(v6));
        };
        if (0x2::balance::value<T1>(arg2) == 0 && 0x2::balance::value<T0>(arg1) / 2 > 0) {
            let v8 = 0x2::balance::value<T0>(arg1) / 2;
            let v9 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg1, v8), arg8);
            let v10 = 0x2::coin::zero<T1>(arg8);
            let (v11, v12) = swap<T0, T1>(arg0, v9, v10, true, true, v8, slippage_adjusted_sqrt_price(true, arg3, arg4, v0), arg6, arg7, arg8);
            let v13 = v12;
            0x2::coin::destroy_zero<T0>(v11);
            let v14 = SwapIfZeroEvent{
                vault_id          : arg5,
                before_sqrt_price : v0,
                after_sqrt_price  : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg0),
                is_a              : true,
                amount_in         : v8,
                amount_out        : 0x2::coin::value<T1>(&v13),
                timestamp_ms      : 0x2::clock::timestamp_ms(arg6),
            };
            0x2::event::emit<SwapIfZeroEvent>(v14);
            0x2::balance::join<T1>(arg2, 0x2::coin::into_balance<T1>(v13));
        };
    }

    // decompiled from Move bytecode v6
}

