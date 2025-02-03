module 0x1a0c65c5850f32caf3b8bc1973837c830e1159b566b3684ace43e37c59868974::staking_pool {
    struct StakingPool<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        amm_pool: 0x2::object::ID,
        balance_meme: 0x2::balance::Balance<T1>,
        balance_lp: 0x2::balance::Balance<T2>,
        balance_x: 0x2::balance::Balance<T0>,
        vesting_config: 0x1a0c65c5850f32caf3b8bc1973837c830e1159b566b3684ace43e37c59868974::vesting::VestingConfig,
        fee_state: 0x1a0c65c5850f32caf3b8bc1973837c830e1159b566b3684ace43e37c59868974::fee_distribution::FeeState<T1, T2>,
        pool_admin: 0x548268236e9cf7ed3ede3a5e0a0d62d50e9a5d0b07389822bb424dae927684e6::pool_admin::PoolAdmin,
        fields: 0x2::object::UID,
    }

    public(friend) fun new<T0, T1, T2>(arg0: 0x2::object::ID, arg1: 0x2::balance::Balance<T1>, arg2: 0x2::balance::Balance<T2>, arg3: 0x1a0c65c5850f32caf3b8bc1973837c830e1159b566b3684ace43e37c59868974::vesting::VestingConfig, arg4: 0x548268236e9cf7ed3ede3a5e0a0d62d50e9a5d0b07389822bb424dae927684e6::pool_admin::PoolAdmin, arg5: 0x2::object::UID, arg6: &mut 0x2::tx_context::TxContext) : StakingPool<T0, T1, T2> {
        StakingPool<T0, T1, T2>{
            id             : 0x2::object::new(arg6),
            amm_pool       : arg0,
            balance_meme   : arg1,
            balance_lp     : arg2,
            balance_x      : 0x2::balance::zero<T0>(),
            vesting_config : arg3,
            fee_state      : 0x1a0c65c5850f32caf3b8bc1973837c830e1159b566b3684ace43e37c59868974::fee_distribution::new<T1, T2>(0x2::balance::value<T2>(&arg2), arg6),
            pool_admin     : arg4,
            fields         : arg5,
        }
    }

    public fun add_fees<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: 0x2::coin::Coin<T2>) {
        0x1a0c65c5850f32caf3b8bc1973837c830e1159b566b3684ace43e37c59868974::fee_distribution::add_fees<T1, T2>(&mut arg0.fee_state, arg1, arg2);
    }

    public fun unstake<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: 0x2::token::Token<T0>, arg2: &0x2::token::TokenPolicy<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        let v0 = 0x2::dynamic_field::borrow_mut<0x1a0c65c5850f32caf3b8bc1973837c830e1159b566b3684ace43e37c59868974::vesting::AccountingDfKey, 0x2::table::Table<address, 0x1a0c65c5850f32caf3b8bc1973837c830e1159b566b3684ace43e37c59868974::vesting::VestingData>>(&mut arg0.fields, 0x1a0c65c5850f32caf3b8bc1973837c830e1159b566b3684ace43e37c59868974::vesting::accounting_key());
        let v1 = 0x2::token::value<T0>(&arg1);
        assert!(v1 <= 0x1a0c65c5850f32caf3b8bc1973837c830e1159b566b3684ace43e37c59868974::vesting::to_release(0x2::table::borrow<address, 0x1a0c65c5850f32caf3b8bc1973837c830e1159b566b3684ace43e37c59868974::vesting::VestingData>(v0, 0x2::tx_context::sender(arg4)), &arg0.vesting_config, 0x2::clock::timestamp_ms(arg3)), 0);
        let v2 = 0x2::table::borrow_mut<address, 0x1a0c65c5850f32caf3b8bc1973837c830e1159b566b3684ace43e37c59868974::vesting::VestingData>(v0, 0x2::tx_context::sender(arg4));
        let (v3, v4) = 0x1a0c65c5850f32caf3b8bc1973837c830e1159b566b3684ace43e37c59868974::fee_distribution::update_stake<T1, T2>(0x1a0c65c5850f32caf3b8bc1973837c830e1159b566b3684ace43e37c59868974::vesting::current_stake(v2), v1, &mut arg0.fee_state, arg4);
        let v5 = v3;
        0x1a0c65c5850f32caf3b8bc1973837c830e1159b566b3684ace43e37c59868974::vesting::release(v2, v1);
        0x2::balance::join<T0>(&mut arg0.balance_x, 0x1a0c65c5850f32caf3b8bc1973837c830e1159b566b3684ace43e37c59868974::token_ir::into_balance<T0>(arg2, arg1, arg4));
        0x2::balance::join<T1>(&mut v5, 0x2::balance::split<T1>(&mut arg0.balance_meme, v1));
        (0x2::coin::from_balance<T1>(v5, arg4), 0x2::coin::from_balance<T2>(v4, arg4))
    }

    public fun withdraw_fees<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        let (v0, v1) = 0x1a0c65c5850f32caf3b8bc1973837c830e1159b566b3684ace43e37c59868974::fee_distribution::withdraw<T1, T2>(&mut arg0.fee_state, 0x1a0c65c5850f32caf3b8bc1973837c830e1159b566b3684ace43e37c59868974::vesting::current_stake(0x2::table::borrow<address, 0x1a0c65c5850f32caf3b8bc1973837c830e1159b566b3684ace43e37c59868974::vesting::VestingData>(0x2::dynamic_field::borrow<0x1a0c65c5850f32caf3b8bc1973837c830e1159b566b3684ace43e37c59868974::vesting::AccountingDfKey, 0x2::table::Table<address, 0x1a0c65c5850f32caf3b8bc1973837c830e1159b566b3684ace43e37c59868974::vesting::VestingData>>(&arg0.fields, 0x1a0c65c5850f32caf3b8bc1973837c830e1159b566b3684ace43e37c59868974::vesting::accounting_key()), 0x2::tx_context::sender(arg1))), arg1);
        (0x2::coin::from_balance<T1>(v0, arg1), 0x2::coin::from_balance<T2>(v1, arg1))
    }

    // decompiled from Move bytecode v6
}

