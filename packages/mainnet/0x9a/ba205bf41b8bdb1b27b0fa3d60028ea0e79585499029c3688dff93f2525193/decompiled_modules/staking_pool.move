module 0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::staking_pool {
    struct StakingPool<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        amm_pool: 0x2::object::ID,
        balance_meme: 0x2::balance::Balance<T1>,
        balance_lp: 0x2::balance::Balance<T2>,
        vesting_table: 0x2::table::Table<address, 0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::vesting::VestingData>,
        meme_cap: 0x2::coin::TreasuryCap<T1>,
        policy_cap: 0x2::token::TokenPolicyCap<T1>,
        vesting_config: 0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::vesting::VestingConfig,
        fee_state: 0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::fee_distribution::FeeState<T0, T1>,
        pool_admin: 0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::pool_admin::PoolAdmin,
    }

    public(friend) fun new<T0, T1, T2>(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::balance::Balance<T2>, arg3: 0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::vesting::VestingConfig, arg4: 0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::pool_admin::PoolAdmin, arg5: 0x2::coin::TreasuryCap<T1>, arg6: 0x2::token::TokenPolicyCap<T1>, arg7: 0x2::table::Table<address, 0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::vesting::VestingData>, arg8: &mut 0x2::tx_context::TxContext) : StakingPool<T0, T1, T2> {
        StakingPool<T0, T1, T2>{
            id             : 0x2::object::new(arg8),
            amm_pool       : arg0,
            balance_meme   : 0x2::balance::zero<T1>(),
            balance_lp     : arg2,
            vesting_table  : arg7,
            meme_cap       : arg5,
            policy_cap     : arg6,
            vesting_config : arg3,
            fee_state      : 0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::fee_distribution::new<T0, T1>(arg1, arg8),
            pool_admin     : arg4,
        }
    }

    public fun collect_fees<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: &mut 0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::interest_pool::InterestPool<0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::curves::Volatile>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::interest_clamm_volatile::balances_request<T2>(arg1);
        0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::interest_clamm_volatile::read_balance<T0, T2>(arg1, &mut v0);
        0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::interest_clamm_volatile::read_balance<T1, T2>(arg1, &mut v0);
        let (v1, v2) = 0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::interest_clamm_volatile::remove_liquidity_2_pool<T0, T1, T2>(arg1, 0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::interest_clamm_volatile::claim_admin_fees<T2>(arg1, &arg0.pool_admin, arg2, v0, arg3), vector[1, 1], arg3);
        0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::fee_distribution::add_fees<T0, T1>(&mut arg0.fee_state, v2, v1);
    }

    public fun unstake<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: 0x2::token::Token<T1>, arg2: &0x2::token::TokenPolicy<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::token::value<T1>(&arg1);
        assert!(v0 <= 0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::vesting::to_release(0x2::table::borrow<address, 0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::vesting::VestingData>(&arg0.vesting_table, 0x2::tx_context::sender(arg4)), &arg0.vesting_config, 0x2::clock::timestamp_ms(arg3)), 0);
        let v1 = 0x2::table::borrow_mut<address, 0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::vesting::VestingData>(&mut arg0.vesting_table, 0x2::tx_context::sender(arg4));
        let (v2, v3) = 0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::fee_distribution::update_stake<T0, T1>(0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::vesting::current_stake(v1), v0, &mut arg0.fee_state, arg4);
        let v4 = v2;
        0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::vesting::release(v1, v0);
        0x2::coin::burn<T1>(&mut arg0.meme_cap, 0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::token_ir::to_coin<T1>(arg2, arg1, arg4));
        0x2::balance::join<T1>(&mut v4, 0x2::balance::split<T1>(&mut arg0.balance_meme, v0));
        (0x2::coin::from_balance<T1>(v4, arg4), 0x2::coin::from_balance<T0>(v3, arg4))
    }

    public fun withdraw_fees<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        let (v0, v1) = 0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::fee_distribution::withdraw<T0, T1>(&mut arg0.fee_state, 0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::vesting::current_stake(0x2::table::borrow<address, 0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::vesting::VestingData>(&arg0.vesting_table, 0x2::tx_context::sender(arg1))), arg1);
        (0x2::coin::from_balance<T1>(v0, arg1), 0x2::coin::from_balance<T0>(v1, arg1))
    }

    // decompiled from Move bytecode v6
}

