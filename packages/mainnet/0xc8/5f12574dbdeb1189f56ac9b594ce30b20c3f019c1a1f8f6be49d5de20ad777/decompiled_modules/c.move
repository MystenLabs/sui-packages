module 0x526e85f862de2ef134eb569b42248412e106da03519225ab4ea5e0a993eae37a::c {
    struct Bank<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        owner: address,
    }

    struct AccessList has store, key {
        id: 0x2::object::UID,
        admin: address,
        trader: address,
        wl: vector<0x2::object::ID>,
        positions: 0x2::table::Table<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>,
    }

    struct AccessList2 has store, key {
        id: 0x2::object::UID,
        admin: address,
        trader: address,
        wl: vector<0x2::object::ID>,
        positions: 0x2::table::Table<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>,
        cetus_positions: 0x2::table::Table<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
    }

    public fun close_position<T0, T1, T2, T3>(arg0: &mut AccessList, arg1: &0x2::clock::Clock, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: 0x2::object::ID, arg5: &mut Bank<T0>, arg6: &mut Bank<T1>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg0, arg7), 1);
        let v0 = 0x2::table::remove<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.positions, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg1, arg3, arg2, &mut v0), arg7), arg0.admin);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T3>(arg1, arg3, arg2, &mut v0), arg7), arg0.admin);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v0);
        let (v2, v3) = if (v1 > 0) {
            let (_, _, v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg3, arg2, &mut v0, v1, arg1);
            (v6, v7)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v8 = v3;
        let v9 = v2;
        let (_, _, v12, v13) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg1, arg3, arg2, &mut v0);
        0x2::balance::join<T0>(&mut v9, v12);
        0x2::balance::join<T1>(&mut v8, v13);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg1, arg3, arg2, v0);
        deposit<T0>(arg5, 0x2::coin::from_balance<T0>(v9, arg7), 0);
        deposit<T1>(arg6, 0x2::coin::from_balance<T1>(v8, arg7), 0);
    }

    fun remove_liquidity<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut Bank<T0>, arg6: &mut Bank<T1>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg0, arg1, arg2, false);
        0x2::balance::join<T0>(&mut v3, v4);
        0x2::balance::join<T1>(&mut v2, v5);
        deposit<T0>(arg5, 0x2::coin::from_balance<T0>(v3, arg7), 0);
        deposit<T1>(arg6, 0x2::coin::from_balance<T1>(v2, arg7), 0);
    }

    fun repay_add_liquidity<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::AddLiquidityReceipt<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: &mut Bank<T0>, arg8: &mut Bank<T1>, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&arg2);
        assert!(v0 <= arg5, 0);
        assert!(v1 <= arg6, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v0, arg9)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, v1, arg9)), arg2);
        deposit<T0>(arg7, arg3, 0);
        deposit<T1>(arg8, arg4, 0);
    }

    public fun add_liquidity<T0, T1>(arg0: &mut AccessList, arg1: &0x2::clock::Clock, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: &mut Bank<T0>, arg9: &mut Bank<T1>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg0, arg10), 1);
        assert!(is_pool_wl(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2)), 2);
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg2));
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg3, arg2, v0, v0 + 1, arg10);
        let (_, _, v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg1, arg3, arg2, &mut v1, 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut arg8.balance, arg5, arg10)), 0x2::coin::into_balance<T1>(0x2::coin::take<T1>(&mut arg9.balance, arg6, arg10)), arg4, arg7);
        deposit<T0>(arg8, 0x2::coin::from_balance<T0>(v4, arg10), 0);
        deposit<T1>(arg9, 0x2::coin::from_balance<T1>(v5, arg10), 0);
        0x2::table::add<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.positions, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v1), v1);
    }

    public fun add_liquidity_bluefin<T0, T1>(arg0: &mut AccessList2, arg1: &0x2::clock::Clock, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: &mut Bank<T0>, arg9: &mut Bank<T1>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader2(arg0, arg10), 1);
        assert!(is_pool_wl2(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2)), 2);
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg2));
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg3, arg2, v0, v0 + 1, arg10);
        let (_, _, v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg1, arg3, arg2, &mut v1, 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut arg8.balance, arg5, arg10)), 0x2::coin::into_balance<T1>(0x2::coin::take<T1>(&mut arg9.balance, arg6, arg10)), arg4, arg7);
        deposit<T0>(arg8, 0x2::coin::from_balance<T0>(v4, arg10), 0);
        deposit<T1>(arg9, 0x2::coin::from_balance<T1>(v5, arg10), 0);
        0x2::table::add<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.positions, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v1), v1);
    }

    public fun add_liquidity_cetus<T0, T1>(arg0: &mut AccessList2, arg1: &0x2::clock::Clock, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: u64, arg5: u64, arg6: bool, arg7: &mut Bank<T0>, arg8: &mut Bank<T1>, arg9: u32, arg10: u32, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader2(arg0, arg11), 1);
        assert!(is_pool_wl2(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2)), 2);
        let v0 = 0x2::coin::take<T0>(&mut arg7.balance, arg4, arg11);
        let v1 = 0x2::coin::take<T1>(&mut arg8.balance, arg5, arg11);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg3, arg2, arg9, arg10, arg11);
        let v3 = if (arg6) {
            arg4
        } else {
            arg5
        };
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg3, arg2, &mut v2, v3, arg6, arg1);
        repay_add_liquidity<T0, T1>(arg3, arg2, v4, v0, v1, arg4, arg5, arg7, arg8, arg11);
        0x2::table::add<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.cetus_positions, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v2), v2);
    }

    public fun add_wl(arg0: &mut AccessList, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, arg2), 1);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg0.wl, &arg1), 2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.wl, arg1);
    }

    public fun add_wl2(arg0: &mut AccessList2, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin2(arg0, arg2), 1);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg0.wl, &arg1), 2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.wl, arg1);
    }

    public fun bluefin_a2b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut AccessList, arg4: &mut Bank<T0>, arg5: &mut Bank<T1>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg3, arg8), 1);
        assert!(is_pool_wl(arg3, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1)), 2);
        deposit<T1>(arg5, 0x2::coin::from_balance<T1>(0x526e85f862de2ef134eb569b42248412e106da03519225ab4ea5e0a993eae37a::d::bluefin_a2b<T0, T1>(arg2, arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut arg4.balance, arg6, arg8)), arg8), arg8), arg7);
    }

    public fun bluefin_b2a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut AccessList, arg4: &mut Bank<T1>, arg5: &mut Bank<T0>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg3, arg8), 1);
        assert!(is_pool_wl(arg3, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1)), 2);
        deposit<T0>(arg5, 0x2::coin::from_balance<T0>(0x526e85f862de2ef134eb569b42248412e106da03519225ab4ea5e0a993eae37a::d::bluefin_b2a<T0, T1>(arg2, arg0, arg1, 0x2::coin::into_balance<T1>(0x2::coin::take<T1>(&mut arg4.balance, arg6, arg8)), arg8), arg8), arg7);
    }

    public fun cetus_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut AccessList, arg4: &mut Bank<T0>, arg5: &mut Bank<T1>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg3, arg8), 1);
        is_pool_wl(arg3, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1));
        deposit<T1>(arg5, 0x2::coin::from_balance<T1>(0x526e85f862de2ef134eb569b42248412e106da03519225ab4ea5e0a993eae37a::d::cetus_a2b<T0, T1>(arg2, arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut arg4.balance, arg6, arg8)), arg8), arg8), arg7);
    }

    public fun cetus_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut AccessList, arg4: &mut Bank<T1>, arg5: &mut Bank<T0>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg3, arg8), 1);
        assert!(is_pool_wl(arg3, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1)), 2);
        deposit<T0>(arg5, 0x2::coin::from_balance<T0>(0x526e85f862de2ef134eb569b42248412e106da03519225ab4ea5e0a993eae37a::d::cetus_b2a<T0, T1>(arg2, arg0, arg1, 0x2::coin::into_balance<T1>(0x2::coin::take<T1>(&mut arg4.balance, arg6, arg8)), arg8), arg8), arg7);
    }

    public fun close_position_bluefin<T0, T1, T2, T3, T4, T5>(arg0: &mut AccessList2, arg1: &0x2::clock::Clock, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: 0x2::object::ID, arg5: &mut Bank<T0>, arg6: &mut Bank<T1>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader2(arg0, arg7), 1);
        let v0 = 0x2::table::remove<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.positions, arg4);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg1, arg3, arg2, &mut v0);
        if (0x2::balance::value<T2>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v1, arg7), arg0.admin);
        } else {
            0x2::balance::destroy_zero<T2>(v1);
        };
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T3>(arg1, arg3, arg2, &mut v0);
        if (0x2::balance::value<T3>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v2, arg7), arg0.admin);
        } else {
            0x2::balance::destroy_zero<T3>(v2);
        };
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T4>(arg1, arg3, arg2, &mut v0);
        if (0x2::balance::value<T4>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(0x2::coin::from_balance<T4>(v3, arg7), arg0.admin);
        } else {
            0x2::balance::destroy_zero<T4>(v3);
        };
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T5>(arg1, arg3, arg2, &mut v0);
        if (0x2::balance::value<T5>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T5>>(0x2::coin::from_balance<T5>(v4, arg7), arg0.admin);
        } else {
            0x2::balance::destroy_zero<T5>(v4);
        };
        let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v0);
        let (v6, v7) = if (v5 > 0) {
            let (_, _, v10, v11) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg3, arg2, &mut v0, v5, arg1);
            (v10, v11)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v12 = v7;
        let v13 = v6;
        let (_, _, v16, v17) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg1, arg3, arg2, &mut v0);
        0x2::balance::join<T0>(&mut v13, v16);
        0x2::balance::join<T1>(&mut v12, v17);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg1, arg3, arg2, v0);
        deposit<T0>(arg5, 0x2::coin::from_balance<T0>(v13, arg7), 0);
        deposit<T1>(arg6, 0x2::coin::from_balance<T1>(v12, arg7), 0);
    }

    public fun close_position_cetus<T0, T1, T2, T3, T4, T5>(arg0: &mut AccessList2, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg2: &0x2::clock::Clock, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: 0x2::object::ID, arg6: &mut Bank<T0>, arg7: &mut Bank<T1>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader2(arg0, arg8), 1);
        let v0 = 0x2::table::remove<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.cetus_positions, arg5);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg4, arg3, &v0, arg1, true, arg2);
        if (0x2::balance::value<T2>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v1, arg8), arg0.admin);
        } else {
            0x2::balance::destroy_zero<T2>(v1);
        };
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T3>(arg4, arg3, &v0, arg1, true, arg2);
        if (0x2::balance::value<T3>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v2, arg8), arg0.admin);
        } else {
            0x2::balance::destroy_zero<T3>(v2);
        };
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T4>(arg4, arg3, &v0, arg1, true, arg2);
        if (0x2::balance::value<T4>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(0x2::coin::from_balance<T4>(v3, arg8), arg0.admin);
        } else {
            0x2::balance::destroy_zero<T4>(v3);
        };
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T5>(arg4, arg3, &v0, arg1, true, arg2);
        if (0x2::balance::value<T5>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T5>>(0x2::coin::from_balance<T5>(v4, arg8), arg0.admin);
        } else {
            0x2::balance::destroy_zero<T5>(v4);
        };
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v0);
        if (v5 > 0) {
            let v6 = &mut v0;
            remove_liquidity<T0, T1>(arg4, arg3, v6, v5, arg2, arg6, arg7, arg8);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg4, arg3, v0);
    }

    public fun deposit<T0>(arg0: &mut Bank<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64) {
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 2);
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
    }

    fun is_admin(arg0: &AccessList, arg1: &0x2::tx_context::TxContext) : bool {
        arg0.admin == 0x2::tx_context::sender(arg1)
    }

    fun is_admin2(arg0: &AccessList2, arg1: &0x2::tx_context::TxContext) : bool {
        arg0.admin == 0x2::tx_context::sender(arg1)
    }

    fun is_pool_wl(arg0: &AccessList, arg1: 0x2::object::ID) : bool {
        0x1::vector::contains<0x2::object::ID>(&arg0.wl, &arg1)
    }

    fun is_pool_wl2(arg0: &AccessList2, arg1: 0x2::object::ID) : bool {
        0x1::vector::contains<0x2::object::ID>(&arg0.wl, &arg1)
    }

    fun is_trader(arg0: &AccessList, arg1: &0x2::tx_context::TxContext) : bool {
        arg0.trader == 0x2::tx_context::sender(arg1)
    }

    fun is_trader2(arg0: &AccessList2, arg1: &0x2::tx_context::TxContext) : bool {
        arg0.trader == 0x2::tx_context::sender(arg1)
    }

    public fun momentum_a2b<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut AccessList, arg4: &mut Bank<T0>, arg5: &mut Bank<T1>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg3, arg8), 1);
        assert!(is_pool_wl(arg3, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1)), 2);
        deposit<T1>(arg5, 0x2::coin::from_balance<T1>(0x526e85f862de2ef134eb569b42248412e106da03519225ab4ea5e0a993eae37a::d::momentum_a2b<T0, T1>(arg2, arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut arg4.balance, arg6, arg8)), arg8), arg8), arg7);
    }

    public fun momentum_b2a<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut AccessList, arg4: &mut Bank<T1>, arg5: &mut Bank<T0>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg3, arg8), 1);
        assert!(is_pool_wl(arg3, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1)), 2);
        deposit<T0>(arg5, 0x2::coin::from_balance<T0>(0x526e85f862de2ef134eb569b42248412e106da03519225ab4ea5e0a993eae37a::d::momentum_b2a<T0, T1>(arg2, arg0, arg1, 0x2::coin::into_balance<T1>(0x2::coin::take<T1>(&mut arg4.balance, arg6, arg8)), arg8), arg8), arg7);
    }

    public fun new_access_list(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x559eeb498fa8006d3db9c4265135ff0be1c3f4ef2e2dfa93b5a0522aa1f28bf5, 1);
        let v0 = AccessList{
            id        : 0x2::object::new(arg0),
            admin     : 0x2::tx_context::sender(arg0),
            trader    : @0x559eeb498fa8006d3db9c4265135ff0be1c3f4ef2e2dfa93b5a0522aa1f28bf5,
            wl        : 0x1::vector::empty<0x2::object::ID>(),
            positions : 0x2::table::new<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0),
        };
        0x2::transfer::share_object<AccessList>(v0);
    }

    public fun new_access_list2(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x559eeb498fa8006d3db9c4265135ff0be1c3f4ef2e2dfa93b5a0522aa1f28bf5, 1);
        let v0 = AccessList2{
            id              : 0x2::object::new(arg0),
            admin           : 0x2::tx_context::sender(arg0),
            trader          : @0x559eeb498fa8006d3db9c4265135ff0be1c3f4ef2e2dfa93b5a0522aa1f28bf5,
            wl              : 0x1::vector::empty<0x2::object::ID>(),
            positions       : 0x2::table::new<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0),
            cetus_positions : 0x2::table::new<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0),
        };
        0x2::transfer::share_object<AccessList2>(v0);
    }

    public fun new_b<T0>(arg0: &mut AccessList, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, arg2), 1);
        let v0 = Bank<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::coin::into_balance<T0>(arg1),
            owner   : 0x2::tx_context::sender(arg2),
        };
        0x2::transfer::share_object<Bank<T0>>(v0);
    }

    public fun obric_x2y<T0, T1>(arg0: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg1: &mut AccessList, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut Bank<T0>, arg7: &mut Bank<T1>, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg1, arg10), 1);
        assert!(is_pool_wl(arg1, 0x2::object::id<0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>>(arg0)), 2);
        deposit<T1>(arg7, 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::swap_x_to_y<T0, T1>(arg0, arg2, arg3, arg4, arg5, 0x2::coin::take<T0>(&mut arg6.balance, arg8, arg10), arg10), arg9);
    }

    public fun obric_y2x<T0, T1>(arg0: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg1: &mut AccessList, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut Bank<T1>, arg7: &mut Bank<T0>, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg1, arg10), 1);
        assert!(is_pool_wl(arg1, 0x2::object::id<0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>>(arg0)), 2);
        deposit<T0>(arg7, 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::swap_y_to_x<T0, T1>(arg0, arg2, arg3, arg4, arg5, 0x2::coin::take<T1>(&mut arg6.balance, arg8, arg10), arg10), arg9);
    }

    public fun turbos_a2b<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x2::clock::Clock, arg3: &mut AccessList, arg4: &mut Bank<T0>, arg5: &mut Bank<T1>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg3, arg8), 1);
        assert!(is_pool_wl(arg3, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1)), 2);
        deposit<T1>(arg5, 0x2::coin::from_balance<T1>(0x526e85f862de2ef134eb569b42248412e106da03519225ab4ea5e0a993eae37a::d::turbos_a2b<T0, T1, T2>(arg1, 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut arg4.balance, arg6, arg8)), arg2, arg0, arg8), arg8), arg7);
    }

    public fun turbos_b2a<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x2::clock::Clock, arg3: &mut AccessList, arg4: &mut Bank<T1>, arg5: &mut Bank<T0>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg3, arg8), 1);
        assert!(is_pool_wl(arg3, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1)), 2);
        deposit<T0>(arg5, 0x2::coin::from_balance<T0>(0x526e85f862de2ef134eb569b42248412e106da03519225ab4ea5e0a993eae37a::d::turbos_b2a<T0, T1, T2>(arg1, 0x2::coin::into_balance<T1>(0x2::coin::take<T1>(&mut arg4.balance, arg6, arg8)), arg2, arg0, arg8), arg8), arg7);
    }

    public fun withdraw_admin<T0>(arg0: &mut AccessList, arg1: &mut Bank<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, arg3), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, arg2, arg3), @0x86b81e99e521d147db478ec3ee615209ab5bcfa9e006ee924a98477a8dc8fca6);
    }

    // decompiled from Move bytecode v6
}

