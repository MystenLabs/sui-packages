module 0x75399c2601f4f0f6c2d26ade1a02ba763dc9a9e92fcc7a93abbb51cfd16ac819::cetus {
    public fun close_position<T0, T1, T2>(arg0: &mut 0x75399c2601f4f0f6c2d26ade1a02ba763dc9a9e92fcc7a93abbb51cfd16ac819::portfolio::PositionManager, arg1: &0x75399c2601f4f0f6c2d26ade1a02ba763dc9a9e92fcc7a93abbb51cfd16ac819::portfolio::ManagerCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: u32, arg6: u32, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(0x75399c2601f4f0f6c2d26ade1a02ba763dc9a9e92fcc7a93abbb51cfd16ac819::portfolio::verify_manager_cap(arg0, arg1), 0);
        assert!(0x75399c2601f4f0f6c2d26ade1a02ba763dc9a9e92fcc7a93abbb51cfd16ac819::portfolio::position_exists<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), arg5, arg6), 1);
        0x75399c2601f4f0f6c2d26ade1a02ba763dc9a9e92fcc7a93abbb51cfd16ac819::portfolio::remove_df_position<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), arg5, arg6);
        let v0 = 0x75399c2601f4f0f6c2d26ade1a02ba763dc9a9e92fcc7a93abbb51cfd16ac819::portfolio::remove_dof_position<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg2, arg3, v0);
        0x2::coin::from_balance<T2>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg2, arg3, &v0, arg4, false, arg7), arg8)
    }

    public fun create_and_open_position<T0, T1>(arg0: &mut 0x75399c2601f4f0f6c2d26ade1a02ba763dc9a9e92fcc7a93abbb51cfd16ac819::portfolio::PositionManager, arg1: &0x75399c2601f4f0f6c2d26ade1a02ba763dc9a9e92fcc7a93abbb51cfd16ac819::portfolio::OwnerCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u32, arg5: u32, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x75399c2601f4f0f6c2d26ade1a02ba763dc9a9e92fcc7a93abbb51cfd16ac819::portfolio::open_position<T0, T1>(arg0, arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), arg4, arg5, arg12);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg2, arg3, arg4, arg5, arg12);
        let v1 = if (arg10) {
            arg8
        } else {
            arg9
        };
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg2, arg3, &mut v0, v1, arg10, arg11);
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg6, v3, arg12)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg7, v4, arg12)), v2);
        0x75399c2601f4f0f6c2d26ade1a02ba763dc9a9e92fcc7a93abbb51cfd16ac819::portfolio::add_dof_manager<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0), v0);
        (arg6, arg7)
    }

    // decompiled from Move bytecode v6
}

