module 0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::cetus {
    public fun add_liquidity<T0, T1>(arg0: &mut 0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::LiquidityManager, arg1: &0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::ManagerCap, arg2: 0x2::object::ID, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::assert_admin(arg0, arg1);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg3, arg4, 0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::get_cetus_position(arg0, arg2), arg7, arg8);
        repay_add_liquidity<T0, T1>(arg0, arg1, arg3, arg4, v0, arg5, arg6, arg9);
    }

    public fun collect_fee<T0, T1>(arg0: &mut 0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::LiquidityManager, arg1: &0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::ManagerCap, arg2: 0x2::object::ID, arg3: address, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: &mut 0x2::tx_context::TxContext) {
        0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::assert_admin(arg0, arg1);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg4, arg5, 0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::get_cetus_position(arg0, arg2), true);
        0x2::coin::join<T0>(&mut arg6, 0x2::coin::from_balance<T0>(v0, arg8));
        0x2::coin::join<T1>(&mut arg7, 0x2::coin::from_balance<T1>(v1, arg8));
        0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::utils::send_coin<T0>(arg6, arg3);
        0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::utils::send_coin<T1>(arg7, arg3);
    }

    public fun collect_reward<T0, T1, T2>(arg0: &mut 0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::LiquidityManager, arg1: &0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::ManagerCap, arg2: 0x2::object::ID, arg3: address, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg7: 0x2::coin::Coin<T2>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::assert_admin(arg0, arg1);
        0x2::coin::join<T2>(&mut arg7, 0x2::coin::from_balance<T2>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg4, arg5, 0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::get_cetus_position(arg0, arg2), arg6, true, arg8), arg9));
        0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::utils::send_coin<T2>(arg7, arg3);
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut 0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::LiquidityManager, arg1: &0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::ManagerCap, arg2: 0x2::object::ID, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: u128, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::assert_admin(arg0, arg1);
        let v0 = 0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::get_cetus_position(arg0, arg2);
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg3, arg4, v0, arg5, arg8);
        let v3 = v2;
        let v4 = v1;
        assert!(0x2::balance::value<T0>(&v4) >= arg6, 1);
        assert!(0x2::balance::value<T1>(&v3) >= arg7, 1);
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg3, arg4, v0, false);
        0x2::balance::join<T0>(&mut v4, v5);
        0x2::balance::join<T1>(&mut v3, v6);
        0x2::balance::join<T0>(0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::get_balance_mut<T0>(arg0), v4);
        0x2::balance::join<T1>(0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::get_balance_mut<T1>(arg0), v3);
    }

    fun repay_add_liquidity<T0, T1>(arg0: &mut 0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::LiquidityManager, arg1: &0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::ManagerCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::AddLiquidityReceipt<T0, T1>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::assert_admin(arg0, arg1);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&arg4);
        assert!(v0 <= arg5, 0);
        assert!(v1 <= arg6, 0);
        let v2 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::get_balance_mut<T0>(arg0), v0), arg7);
        let v3 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::get_balance_mut<T1>(arg0), v1), arg7);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v2, v0, arg7)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v3, v1, arg7)), arg4);
        0x2::balance::join<T0>(0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::get_balance_mut<T0>(arg0), 0x2::coin::into_balance<T0>(v2));
        0x2::balance::join<T1>(0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::get_balance_mut<T1>(arg0), 0x2::coin::into_balance<T1>(v3));
    }

    public fun add_liquidity_by_fix_coin<T0, T1>(arg0: &mut 0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::LiquidityManager, arg1: &0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::ManagerCap, arg2: 0x2::object::ID, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: u64, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::assert_admin(arg0, arg1);
        let v0 = if (arg7) {
            arg5
        } else {
            arg6
        };
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg3, arg4, 0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::get_cetus_position(arg0, arg2), v0, arg7, arg8);
        repay_add_liquidity<T0, T1>(arg0, arg1, arg3, arg4, v1, arg5, arg6, arg9);
    }

    public fun open_position_with_liquidity<T0, T1>(arg0: &mut 0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::LiquidityManager, arg1: &0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::ManagerCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u32, arg5: u32, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::assert_admin(arg0, arg1);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg2, arg3, arg4, arg5, arg10);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg2, arg3, &mut v0, arg8, arg9);
        repay_add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, v1, arg6, arg7, arg10);
        let v2 = 0x1::vector::empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>();
        0x1::vector::push_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut v2, v0);
        0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::add_cetus_positions(arg0, arg1, v2, arg10);
    }

    public fun open_position_with_liquidity_by_fix_coin<T0, T1>(arg0: &mut 0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::LiquidityManager, arg1: &0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::ManagerCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u32, arg5: u32, arg6: u64, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::assert_admin(arg0, arg1);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg2, arg3, arg4, arg5, arg10);
        let v1 = if (arg8) {
            arg6
        } else {
            arg7
        };
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg2, arg3, &mut v0, v1, arg8, arg9);
        repay_add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, v2, arg6, arg7, arg10);
        let v3 = 0x1::vector::empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>();
        0x1::vector::push_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut v3, v0);
        0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::add_cetus_positions(arg0, arg1, v3, arg10);
    }

    // decompiled from Move bytecode v6
}

