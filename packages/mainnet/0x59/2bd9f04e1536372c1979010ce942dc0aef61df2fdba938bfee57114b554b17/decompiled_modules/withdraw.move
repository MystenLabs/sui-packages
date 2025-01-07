module 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::withdraw {
    struct WithdrawEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        user: address,
        lp_shares_burned: u64,
        amount_out: u64,
        total_deposited_a: u64,
        total_borrowed_b: u64,
        aum_in_a: u64,
        total_lp_supply: u64,
    }

    fun get_withdraw_flash_swap_amount(arg0: u64, arg1: u64) : u64 {
        (((arg1 as u256) * (((arg0 as u64) - 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::leverage_scaling()) as u256) / (0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::leverage_scaling() as u256)) as u64)
    }

    fun vt_shares_to_underlying_a<T0, T1, T2>(arg0: &0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::Vault<T0, T1, T2>, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg3: &0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle::KriyaOracle, arg4: &0xdf3da4bcc7939caf6486ecc104e1cbd69f97f2025195d270649566301d15eb96::registry::CoinDecimalsRegistry, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: u64, arg7: &0x2::clock::Clock) : u64 {
        let (v0, _, _) = 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::utils::calc_aum<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
        (((arg6 as u256) * (v0 as u256) / (0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::total_vt_supply<T0, T1, T2>(arg0) as u256)) as u64)
    }

    public fun withdraw_a<T0, T1, T2>(arg0: &mut 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle::KriyaOracle, arg9: &0xdf3da4bcc7939caf6486ecc104e1cbd69f97f2025195d270649566301d15eb96::registry::CoinDecimalsRegistry, arg10: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg11: &0x2::clock::Clock, arg12: &0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::version::Version, arg13: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg14: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::version::assert_current_version(arg12);
        assert!(0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::pool_id<T0, T1, T2>(arg0) == 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>>(arg2), 9223372281667911679);
        let v0 = 0x2::coin::value<T2>(&arg1);
        let v1 = vt_shares_to_underlying_a<T0, T1, T2>(arg0, arg4, arg5, arg8, arg9, arg3, v0, arg11);
        let (v2, v3) = 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::slippage<T0, T1, T2>(arg0);
        let (v4, v5, v6) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg2, true, true, get_withdraw_flash_swap_amount(0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::utils::get_cur_leverage<T0, T1, T2>(arg0, arg4, arg5, arg8, arg9, arg3, arg11), v1), 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::utils::get_slippage_adjusted_sqrt_price(true, v2, v3, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg2)), arg11, arg13, arg14);
        let v7 = v6;
        0x2::balance::destroy_zero<T0>(v4);
        let (v8, _) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::swap_receipt_debts(&v7);
        let v10 = 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::withdraw<T0, T1, T2>(arg0, 0x2::coin::from_balance<T1>(v5, arg14), v8 + v1, arg3, arg4, arg5, arg6, arg7, arg10, arg11, arg14);
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg2, v7, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v10, v8, arg14)), 0x2::balance::zero<T1>(), arg13, arg14);
        0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::burn_vt<T0, T1, T2>(arg0, arg1);
        let (v11, v12) = 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::withdrawal_fees<T0, T1, T2>(arg0);
        0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::collect_fees<T0, T1, T2>(arg0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v10, (((0x2::coin::value<T0>(&v10) as u256) * (v11 as u256) / (v12 as u256)) as u64), arg14)));
        let (v13, v14, v15) = 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::utils::calc_aum<T0, T1, T2>(arg0, arg4, arg5, arg8, arg9, arg3, arg11);
        let v16 = WithdrawEvent{
            vault_id          : 0x2::object::id<0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::Vault<T0, T1, T2>>(arg0),
            user              : 0x2::tx_context::sender(arg14),
            lp_shares_burned  : v0,
            amount_out        : 0x2::coin::value<T0>(&v10),
            total_deposited_a : v14,
            total_borrowed_b  : v15,
            aum_in_a          : v13,
            total_lp_supply   : 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::total_vt_supply<T0, T1, T2>(arg0),
        };
        0x2::event::emit<WithdrawEvent>(v16);
        v10
    }

    public fun withdraw_b<T0, T1, T2>(arg0: &mut 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T1, T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle::KriyaOracle, arg9: &0xdf3da4bcc7939caf6486ecc104e1cbd69f97f2025195d270649566301d15eb96::registry::CoinDecimalsRegistry, arg10: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg11: &0x2::clock::Clock, arg12: &0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::version::Version, arg13: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg14: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::version::assert_current_version(arg12);
        assert!(0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::pool_id<T0, T1, T2>(arg0) == 0x2::object::id<0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::Vault<T0, T1, T2>>(arg0), 9223372569430720511);
        let v0 = 0x2::coin::value<T2>(&arg1);
        let v1 = vt_shares_to_underlying_a<T0, T1, T2>(arg0, arg4, arg5, arg8, arg9, arg3, v0, arg11);
        let (v2, v3) = 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::slippage<T0, T1, T2>(arg0);
        let (v4, v5, v6) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T1, T0>(arg2, false, true, get_withdraw_flash_swap_amount(0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::utils::get_cur_leverage<T0, T1, T2>(arg0, arg4, arg5, arg8, arg9, arg3, arg11), v1), 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::utils::get_slippage_adjusted_sqrt_price(false, v2, v3, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T1, T0>(arg2)), arg11, arg13, arg14);
        let v7 = v6;
        0x2::balance::destroy_zero<T0>(v5);
        let (_, v9) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::swap_receipt_debts(&v7);
        let v10 = 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::withdraw<T0, T1, T2>(arg0, 0x2::coin::from_balance<T1>(v4, arg14), v9 + v1, arg3, arg4, arg5, arg6, arg7, arg10, arg11, arg14);
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T1, T0>(arg2, v7, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v10, v9, arg14)), arg13, arg14);
        0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::burn_vt<T0, T1, T2>(arg0, arg1);
        let (v11, v12) = 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::withdrawal_fees<T0, T1, T2>(arg0);
        0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::collect_fees<T0, T1, T2>(arg0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v10, (((0x2::coin::value<T0>(&v10) as u256) * (v11 as u256) / (v12 as u256)) as u64), arg14)));
        let (v13, v14, v15) = 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::utils::calc_aum<T0, T1, T2>(arg0, arg4, arg5, arg8, arg9, arg3, arg11);
        let v16 = WithdrawEvent{
            vault_id          : 0x2::object::id<0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::Vault<T0, T1, T2>>(arg0),
            user              : 0x2::tx_context::sender(arg14),
            lp_shares_burned  : v0,
            amount_out        : 0x2::coin::value<T0>(&v10),
            total_deposited_a : v14,
            total_borrowed_b  : v15,
            aum_in_a          : v13,
            total_lp_supply   : 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::total_vt_supply<T0, T1, T2>(arg0),
        };
        0x2::event::emit<WithdrawEvent>(v16);
        v10
    }

    // decompiled from Move bytecode v6
}

