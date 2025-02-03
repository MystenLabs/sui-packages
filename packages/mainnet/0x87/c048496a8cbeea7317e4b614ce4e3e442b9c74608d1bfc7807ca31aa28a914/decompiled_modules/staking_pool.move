module 0x87c048496a8cbeea7317e4b614ce4e3e442b9c74608d1bfc7807ca31aa28a914::staking_pool {
    struct StakingPool<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        amm_pool: 0x2::object::ID,
        balance_meme: 0x2::balance::Balance<T1>,
        balance_lp: 0x2::balance::Balance<T2>,
        balance_x: 0x2::balance::Balance<T0>,
        vesting_data: 0x2::table::Table<address, 0x87c048496a8cbeea7317e4b614ce4e3e442b9c74608d1bfc7807ca31aa28a914::vesting::VestingData>,
        vesting_config: 0x87c048496a8cbeea7317e4b614ce4e3e442b9c74608d1bfc7807ca31aa28a914::vesting::VestingConfig,
        fee_state: 0x87c048496a8cbeea7317e4b614ce4e3e442b9c74608d1bfc7807ca31aa28a914::fee_distribution::FeeState<T1, T2>,
        pool_admin: 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::pool_admin::PoolAdmin,
        fields: 0x2::object::UID,
    }

    public(friend) fun new<T0, T1, T2>(arg0: 0x2::object::ID, arg1: 0x2::balance::Balance<T1>, arg2: 0x2::balance::Balance<T2>, arg3: 0x87c048496a8cbeea7317e4b614ce4e3e442b9c74608d1bfc7807ca31aa28a914::vesting::VestingConfig, arg4: 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::pool_admin::PoolAdmin, arg5: 0x2::object::UID, arg6: &mut 0x2::tx_context::TxContext) : StakingPool<T0, T1, T2> {
        StakingPool<T0, T1, T2>{
            id             : 0x2::object::new(arg6),
            amm_pool       : arg0,
            balance_meme   : arg1,
            balance_lp     : arg2,
            balance_x      : 0x2::balance::zero<T0>(),
            vesting_data   : 0x2::table::new<address, 0x87c048496a8cbeea7317e4b614ce4e3e442b9c74608d1bfc7807ca31aa28a914::vesting::VestingData>(arg6),
            vesting_config : arg3,
            fee_state      : 0x87c048496a8cbeea7317e4b614ce4e3e442b9c74608d1bfc7807ca31aa28a914::fee_distribution::new<T1, T2>(0x2::balance::value<T2>(&arg2), arg6),
            pool_admin     : arg4,
            fields         : arg5,
        }
    }

    public fun add_fees<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: 0x2::coin::Coin<T2>) {
        0x87c048496a8cbeea7317e4b614ce4e3e442b9c74608d1bfc7807ca31aa28a914::fee_distribution::add_fees<T1, T2>(&mut arg0.fee_state, arg1, arg2);
    }

    public fun unstake<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: 0x2::token::Token<T0>, arg2: &0x2::token::TokenPolicy<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        let v0 = 0x2::token::value<T0>(&arg1);
        assert!(v0 <= 0x87c048496a8cbeea7317e4b614ce4e3e442b9c74608d1bfc7807ca31aa28a914::vesting::to_release(0x2::table::borrow<address, 0x87c048496a8cbeea7317e4b614ce4e3e442b9c74608d1bfc7807ca31aa28a914::vesting::VestingData>(&arg0.vesting_data, 0x2::tx_context::sender(arg4)), &arg0.vesting_config, 0x2::clock::timestamp_ms(arg3)), 0);
        let v1 = 0x2::table::borrow_mut<address, 0x87c048496a8cbeea7317e4b614ce4e3e442b9c74608d1bfc7807ca31aa28a914::vesting::VestingData>(&mut arg0.vesting_data, 0x2::tx_context::sender(arg4));
        let (v2, v3) = 0x87c048496a8cbeea7317e4b614ce4e3e442b9c74608d1bfc7807ca31aa28a914::fee_distribution::update_stake<T1, T2>(0x87c048496a8cbeea7317e4b614ce4e3e442b9c74608d1bfc7807ca31aa28a914::vesting::current_stake(v1), v0, &mut arg0.fee_state, arg4);
        let v4 = v2;
        0x87c048496a8cbeea7317e4b614ce4e3e442b9c74608d1bfc7807ca31aa28a914::vesting::release(v1, v0);
        0x2::balance::join<T0>(&mut arg0.balance_x, 0x87c048496a8cbeea7317e4b614ce4e3e442b9c74608d1bfc7807ca31aa28a914::token_ir::into_balance<T0>(arg2, arg1, arg4));
        0x2::balance::join<T1>(&mut v4, 0x2::balance::split<T1>(&mut arg0.balance_meme, v0));
        (0x2::coin::from_balance<T1>(v4, arg4), 0x2::coin::from_balance<T2>(v3, arg4))
    }

    public fun withdraw_fees<T0, T1, T2>(arg0: &mut StakingPool<T0, T1, T2>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        let (v0, v1) = 0x87c048496a8cbeea7317e4b614ce4e3e442b9c74608d1bfc7807ca31aa28a914::fee_distribution::withdraw<T1, T2>(&mut arg0.fee_state, 0x87c048496a8cbeea7317e4b614ce4e3e442b9c74608d1bfc7807ca31aa28a914::vesting::current_stake(0x2::table::borrow<address, 0x87c048496a8cbeea7317e4b614ce4e3e442b9c74608d1bfc7807ca31aa28a914::vesting::VestingData>(&arg0.vesting_data, 0x2::tx_context::sender(arg1))), arg1);
        (0x2::coin::from_balance<T1>(v0, arg1), 0x2::coin::from_balance<T2>(v1, arg1))
    }

    // decompiled from Move bytecode v6
}

