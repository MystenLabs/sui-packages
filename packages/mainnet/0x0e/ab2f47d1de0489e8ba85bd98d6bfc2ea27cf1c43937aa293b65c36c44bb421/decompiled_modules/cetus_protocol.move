module 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_protocol {
    struct SwapResult has copy, drop, store {
        fee_amount: u64,
        before_sqrt_price: u128,
        after_sqrt_price: u128,
    }

    struct SwapEvent has copy, drop, store {
        owner: address,
        account_name: 0x1::ascii::String,
        pool_id: 0x2::object::ID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        a2b: bool,
        amount_in: u64,
        amount_out: u64,
        result: 0x1::option::Option<SwapResult>,
    }

    struct CollectRewardEvent has copy, drop, store {
        owner: address,
        account_name: 0x1::ascii::String,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct CollectFeeEvent has copy, drop, store {
        owner: address,
        account_name: 0x1::ascii::String,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        amount_a: u64,
        amount_b: u64,
    }

    struct RemoveLiquidityEvent has copy, drop, store {
        owner: address,
        account_name: 0x1::ascii::String,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        amount_a: u64,
        amount_b: u64,
    }

    struct ClosePositionEvent has copy, drop, store {
        owner: address,
        account_name: 0x1::ascii::String,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        amount_a: u64,
        amount_b: u64,
    }

    struct OpenPositionEvent has copy, drop, store {
        owner: address,
        account_name: 0x1::ascii::String,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        amount_a: u64,
        amount_b: u64,
    }

    struct AddLiquidityEvent has copy, drop, store {
        owner: address,
        account_name: 0x1::ascii::String,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        amount_a: u64,
        amount_b: u64,
    }

    public(friend) fun swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg3: address, arg4: 0x1::ascii::String, arg5: bool, arg6: bool, arg7: u64, arg8: u128, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg5, arg6, arg7, arg8, arg10);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        let v7 = if (arg5) {
            0x2::balance::value<T1>(&v4)
        } else {
            0x2::balance::value<T0>(&v5)
        };
        let v8 = 0x1::option::none<SwapResult>();
        if (arg9) {
            let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, arg5, arg6, arg7);
            let v10 = SwapResult{
                fee_amount        : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v9),
                before_sqrt_price : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1),
                after_sqrt_price  : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_after_sqrt_price(&v9),
            };
            v8 = 0x1::option::some<SwapResult>(v10);
        };
        let (v11, v12) = if (arg5) {
            (0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::withdraw<T0>(arg2, arg3, arg4, 0x1::option::some<u64>(v6)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::withdraw<T1>(arg2, arg3, arg4, 0x1::option::some<u64>(v6)))
        };
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::deposit<T1>(arg2, arg3, arg4, v4, arg11);
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::deposit<T0>(arg2, arg3, arg4, v5, arg11);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v11, v12, v3);
        let v13 = SwapEvent{
            owner        : arg3,
            account_name : arg4,
            pool_id      : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            coin_type_a  : 0x1::type_name::get<T0>(),
            coin_type_b  : 0x1::type_name::get<T1>(),
            a2b          : arg5,
            amount_in    : v6,
            amount_out   : v7,
            result       : v8,
        };
        0x2::event::emit<SwapEvent>(v13);
    }

    public(friend) fun add_liquidity<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg2: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::CetusPortfolio, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: address, arg5: 0x1::ascii::String, arg6: 0x2::object::ID, arg7: u128, arg8: &0x2::clock::Clock) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg0, arg3, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::borrow_position_mut(arg2, arg4, arg5, arg6), arg7, arg8);
        let (v1, v2) = repay_add_liquidity<T0, T1>(arg0, arg3, arg1, arg4, arg5, v0);
        let v3 = AddLiquidityEvent{
            owner        : arg4,
            account_name : arg5,
            pool_id      : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3),
            position_id  : arg6,
            coin_type_a  : 0x1::type_name::get<T0>(),
            coin_type_b  : 0x1::type_name::get<T1>(),
            amount_a     : v1,
            amount_b     : v2,
        };
        0x2::event::emit<AddLiquidityEvent>(v3);
    }

    public(friend) fun add_liquidity_by_max_amount<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg2: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::CetusPortfolio, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: address, arg5: 0x1::ascii::String, arg6: 0x2::object::ID, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>, arg9: &0x2::clock::Clock) {
        let v0 = 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::borrow_position_mut(arg2, arg4, arg5, arg6);
        let (v1, v2) = get_free_amounts<T0, T1>(arg1, arg4, arg5, arg7, arg8);
        let v3 = get_liquidity_from_amounts<T0, T1>(arg3, v0, v1, v2);
        assert!(v3 > 0, 2);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg0, arg3, v0, v3, arg9);
        let (v5, v6) = repay_add_liquidity<T0, T1>(arg0, arg3, arg1, arg4, arg5, v4);
        let v7 = AddLiquidityEvent{
            owner        : arg4,
            account_name : arg5,
            pool_id      : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3),
            position_id  : arg6,
            coin_type_a  : 0x1::type_name::get<T0>(),
            coin_type_b  : 0x1::type_name::get<T1>(),
            amount_a     : v5,
            amount_b     : v6,
        };
        0x2::event::emit<AddLiquidityEvent>(v7);
    }

    public(friend) fun add_liquidity_fix_coin<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg2: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::CetusPortfolio, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: address, arg5: 0x1::ascii::String, arg6: 0x2::object::ID, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg3, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::borrow_position_mut(arg2, arg4, arg5, arg6), arg7, arg8, arg9);
        let (v1, v2) = repay_add_liquidity<T0, T1>(arg0, arg3, arg1, arg4, arg5, v0);
        let v3 = AddLiquidityEvent{
            owner        : arg4,
            account_name : arg5,
            pool_id      : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3),
            position_id  : arg6,
            coin_type_a  : 0x1::type_name::get<T0>(),
            coin_type_b  : 0x1::type_name::get<T1>(),
            amount_a     : v1,
            amount_b     : v2,
        };
        0x2::event::emit<AddLiquidityEvent>(v3);
    }

    public(friend) fun close_position<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg2: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::CetusPortfolio, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: address, arg5: 0x1::ascii::String, arg6: 0x2::object::ID, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<u64>, arg10: 0x1::option::Option<u64>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::withdraw_position(arg2, arg4, arg5, arg6);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v0);
        let v2 = 0;
        let v3 = 0;
        if (v1 > 0) {
            let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg0, arg3, &mut v0, v1, arg11);
            let v6 = v5;
            let v7 = v4;
            let v8 = 0x2::balance::value<T0>(&v7);
            v2 = v8;
            let v9 = 0x2::balance::value<T1>(&v6);
            v3 = v9;
            assert!(0x1::option::is_none<u64>(&arg7) || v8 >= *0x1::option::borrow<u64>(&arg7), 0);
            assert!(0x1::option::is_none<u64>(&arg8) || v9 >= *0x1::option::borrow<u64>(&arg8), 0);
            assert!(0x1::option::is_none<u64>(&arg9) || v8 <= *0x1::option::borrow<u64>(&arg9), 1);
            assert!(0x1::option::is_none<u64>(&arg10) || v9 <= *0x1::option::borrow<u64>(&arg10), 1);
            0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::deposit<T0>(arg1, arg4, arg5, v7, arg12);
            0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::deposit<T1>(arg1, arg4, arg5, v6, arg12);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg0, arg3, v0);
        let v10 = ClosePositionEvent{
            owner        : arg4,
            account_name : arg5,
            pool_id      : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3),
            position_id  : arg6,
            coin_type_a  : 0x1::type_name::get<T0>(),
            coin_type_b  : 0x1::type_name::get<T1>(),
            amount_a     : v2,
            amount_b     : v3,
        };
        0x2::event::emit<ClosePositionEvent>(v10);
    }

    public(friend) fun collect_fee<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg2: &0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::CetusPortfolio, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: address, arg5: 0x1::ascii::String, arg6: 0x2::object::ID, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg0, arg3, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::borrow_position(arg2, arg4, arg5, arg6), arg7);
        let v2 = v1;
        let v3 = v0;
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::deposit_fee<T0>(arg1, arg4, arg5, v3, arg8);
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::deposit_fee<T1>(arg1, arg4, arg5, v2, arg8);
        let v4 = CollectFeeEvent{
            owner        : arg4,
            account_name : arg5,
            pool_id      : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3),
            position_id  : arg6,
            coin_type_a  : 0x1::type_name::get<T0>(),
            coin_type_b  : 0x1::type_name::get<T1>(),
            amount_a     : 0x2::balance::value<T0>(&v3),
            amount_b     : 0x2::balance::value<T1>(&v2),
        };
        0x2::event::emit<CollectFeeEvent>(v4);
    }

    public(friend) fun collect_reward<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg2: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg3: &0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::CetusPortfolio, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: address, arg6: 0x1::ascii::String, arg7: 0x2::object::ID, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg0, arg4, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::borrow_position(arg3, arg5, arg6, arg7), arg1, arg8, arg9);
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::deposit_reward<T2>(arg2, arg5, arg6, v0, arg10);
        let v1 = CollectRewardEvent{
            owner        : arg5,
            account_name : arg6,
            pool_id      : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4),
            position_id  : arg7,
            coin_type    : 0x1::type_name::get<T2>(),
            amount       : 0x2::balance::value<T2>(&v0),
        };
        0x2::event::emit<CollectRewardEvent>(v1);
    }

    fun get_free_amounts<T0, T1>(arg0: &0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg1: address, arg2: 0x1::ascii::String, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>) : (u64, u64) {
        let (v0, v1) = 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::get_pool_amounts<T0, T1>(arg0, arg1, arg2);
        let v2 = if (0x1::option::is_some<u64>(&arg3) && *0x1::option::borrow<u64>(&arg3) < v0) {
            *0x1::option::borrow<u64>(&arg3)
        } else {
            v0
        };
        let v3 = if (0x1::option::is_some<u64>(&arg3) && *0x1::option::borrow<u64>(&arg4) < v1) {
            *0x1::option::borrow<u64>(&arg4)
        } else {
            v1
        };
        (v2, v3)
    }

    fun get_liquidity_from_amounts<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: u64, arg3: u64) : u128 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(arg1);
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v0, v2)) {
            return 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_a(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v3), arg2, false)
        };
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v0, v3)) {
            return 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_a(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v3), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v2), arg3, false)
        };
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_a(v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v3), arg2, false);
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_a(v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v2), arg3, false);
        if (v4 < v5) {
            v4
        } else {
            v5
        }
    }

    public(friend) fun open_position_by_max_amount<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg2: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::CetusPortfolio, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: address, arg5: 0x1::ascii::String, arg6: u32, arg7: u32, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<u64>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg0, arg3, arg6, arg7, arg11);
        let (v1, v2) = get_free_amounts<T0, T1>(arg1, arg4, arg5, arg8, arg9);
        let v3 = get_liquidity_from_amounts<T0, T1>(arg3, &v0, v1, v2);
        assert!(v3 > 0, 2);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg0, arg3, &mut v0, v3, arg10);
        let (v5, v6) = repay_add_liquidity<T0, T1>(arg0, arg3, arg1, arg4, arg5, v4);
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::deposit_position(arg2, arg4, arg5, v0, arg11);
        let v7 = OpenPositionEvent{
            owner        : arg4,
            account_name : arg5,
            pool_id      : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3),
            position_id  : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0),
            coin_type_a  : 0x1::type_name::get<T0>(),
            coin_type_b  : 0x1::type_name::get<T1>(),
            amount_a     : v5,
            amount_b     : v6,
        };
        0x2::event::emit<OpenPositionEvent>(v7);
    }

    public(friend) fun open_position_fix_coin<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg2: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::CetusPortfolio, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: address, arg5: 0x1::ascii::String, arg6: u32, arg7: u32, arg8: u64, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg0, arg3, arg6, arg7, arg11);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg3, &mut v0, arg8, arg9, arg10);
        let (v2, v3) = repay_add_liquidity<T0, T1>(arg0, arg3, arg1, arg4, arg5, v1);
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::deposit_position(arg2, arg4, arg5, v0, arg11);
        let v4 = OpenPositionEvent{
            owner        : arg4,
            account_name : arg5,
            pool_id      : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3),
            position_id  : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0),
            coin_type_a  : 0x1::type_name::get<T0>(),
            coin_type_b  : 0x1::type_name::get<T1>(),
            amount_a     : v2,
            amount_b     : v3,
        };
        0x2::event::emit<OpenPositionEvent>(v4);
    }

    public(friend) fun open_position_with_liquidity<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg2: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::CetusPortfolio, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: address, arg5: 0x1::ascii::String, arg6: u32, arg7: u32, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg0, arg3, arg6, arg7, arg10);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg0, arg3, &mut v0, arg8, arg9);
        let (v2, v3) = repay_add_liquidity<T0, T1>(arg0, arg3, arg1, arg4, arg5, v1);
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::deposit_position(arg2, arg4, arg5, v0, arg10);
        let v4 = OpenPositionEvent{
            owner        : arg4,
            account_name : arg5,
            pool_id      : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3),
            position_id  : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0),
            coin_type_a  : 0x1::type_name::get<T0>(),
            coin_type_b  : 0x1::type_name::get<T1>(),
            amount_a     : v2,
            amount_b     : v3,
        };
        0x2::event::emit<OpenPositionEvent>(v4);
    }

    public(friend) fun remove_liquidity<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg2: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::CetusPortfolio, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: address, arg5: 0x1::ascii::String, arg6: 0x2::object::ID, arg7: u128, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<u64>, arg10: 0x1::option::Option<u64>, arg11: 0x1::option::Option<u64>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg0, arg3, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::borrow_position_mut(arg2, arg4, arg5, arg6), arg7, arg12);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::balance::value<T0>(&v3);
        let v5 = 0x2::balance::value<T1>(&v2);
        assert!(0x1::option::is_none<u64>(&arg8) || v4 >= *0x1::option::borrow<u64>(&arg8), 0);
        assert!(0x1::option::is_none<u64>(&arg9) || v5 >= *0x1::option::borrow<u64>(&arg9), 0);
        assert!(0x1::option::is_none<u64>(&arg10) || v4 <= *0x1::option::borrow<u64>(&arg10), 1);
        assert!(0x1::option::is_none<u64>(&arg11) || v5 <= *0x1::option::borrow<u64>(&arg11), 1);
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::deposit<T0>(arg1, arg4, arg5, v3, arg13);
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::deposit<T1>(arg1, arg4, arg5, v2, arg13);
        let v6 = RemoveLiquidityEvent{
            owner        : arg4,
            account_name : arg5,
            pool_id      : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3),
            position_id  : arg6,
            coin_type_a  : 0x1::type_name::get<T0>(),
            coin_type_b  : 0x1::type_name::get<T1>(),
            amount_a     : v4,
            amount_b     : v5,
        };
        0x2::event::emit<RemoveLiquidityEvent>(v6);
    }

    fun repay_add_liquidity<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg3: address, arg4: 0x1::ascii::String, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::AddLiquidityReceipt<T0, T1>) : (u64, u64) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&arg5);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg0, arg1, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::withdraw<T0>(arg2, arg3, arg4, 0x1::option::some<u64>(v0)), 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::withdraw<T1>(arg2, arg3, arg4, 0x1::option::some<u64>(v1)), arg5);
        (v0, v1)
    }

    // decompiled from Move bytecode v6
}

