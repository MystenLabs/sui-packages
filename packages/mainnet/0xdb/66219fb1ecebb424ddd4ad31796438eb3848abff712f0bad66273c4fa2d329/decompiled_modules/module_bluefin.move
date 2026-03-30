module 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::module_bluefin {
    public(friend) fun add_liquidity<T0, T1>(arg0: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::account::TraderAccount, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T0>, arg4: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T1>, arg5: 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::type_params::OpenParams, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::type_params::open_fixed_amount(&arg5);
        let v1 = 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::type_params::open_deduction(&arg5);
        let v2 = 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::type_params::open_is_fixed_a(&arg5);
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg1);
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg1);
        let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v4, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(v4, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v3)));
        let v6 = 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::balance_value<T0>(arg3);
        let v7 = 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::balance_value<T1>(arg4);
        let (v8, v9) = if (v2) {
            let v10 = if (v0 > 0) {
                v0
            } else {
                assert!(v6 > v1, 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::error::insufficient_vault_balance());
                v6 - v1
            };
            assert!(v6 >= v10, 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::error::insufficient_vault_balance());
            (v10, v7)
        } else {
            let v11 = if (v0 > 0) {
                v0
            } else {
                assert!(v7 > v1, 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::error::insufficient_vault_balance());
                v7 - v1
            };
            assert!(v7 >= v11, 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::error::insufficient_vault_balance());
            (v6, v11)
        };
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg2, arg1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v5, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::type_params::open_lower_mult(&arg5) * v3))), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v5, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::type_params::open_upper_mult(&arg5) * v3))), arg7);
        let v13 = if (v2) {
            v8
        } else {
            v9
        };
        let (_, _, v16, v17) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg6, arg2, arg1, &mut v12, 0x2::balance::split<T0>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T0>(arg3), v8), 0x2::balance::split<T1>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T1>(arg4), v9), v13, v2);
        0x2::balance::join<T0>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T0>(arg3), v16);
        0x2::balance::join<T1>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T1>(arg4), v17);
        0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::account::add_position<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, v12, arg7);
    }

    public(friend) fun burn_position<T0, T1>(arg0: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T0>, arg4: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T1>, arg5: &0x2::clock::Clock) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&arg0);
        let (v1, v2) = if (v0 > 0) {
            let (_, _, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg2, arg1, &mut arg0, v0, arg5);
            (v5, v6)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v7 = v2;
        let v8 = v1;
        let (_, _, v11, v12) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg5, arg2, arg1, &mut arg0);
        0x2::balance::join<T0>(&mut v8, v11);
        0x2::balance::join<T1>(&mut v7, v12);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg5, arg2, arg1, arg0);
        0x2::balance::join<T0>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T0>(arg3), v8);
        0x2::balance::join<T1>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T1>(arg4), v7);
    }

    public(friend) fun claimed_fees_rewards(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) : vector<u8> {
        let v0 = 0x1::vector::empty<0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::type_reward::RewardAmount>();
        let v1 = 0;
        while (v1 < 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::reward_infos_length(arg0)) {
            0x1::vector::push_back<0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::type_reward::RewardAmount>(&mut v0, 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::type_reward::new_reward_amount(v1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::coins_owed_reward(arg0, v1)));
            v1 = v1 + 1;
        };
        let (v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::get_accrued_fee(arg0);
        let v4 = 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::type_reward::new_all_rewards_data(v2, v3, v0);
        0x2::bcs::to_bytes<0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::type_reward::AllRewardsData>(&v4)
    }

    public(friend) fun collect_reward_account<T0, T1, T2>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::account::TraderAccount, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg4, arg2, arg1, arg0);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg5), 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::account::profit_address(arg3));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
    }

    public(friend) fun collect_reward_vault<T0, T1, T2>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T2>, arg4: &0x2::clock::Clock) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg4, arg2, arg1, arg0);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::balance::join<T2>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T2>(arg3), v0);
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
    }

    // decompiled from Move bytecode v6
}

