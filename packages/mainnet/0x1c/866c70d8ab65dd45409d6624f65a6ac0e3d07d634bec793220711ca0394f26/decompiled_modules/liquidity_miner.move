module 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::liquidity_miner {
    struct LiquidityMiner<phantom T0> has store, key {
        id: 0x2::object::UID,
        deposit: 0x2::table::Table<0x1::type_name::TypeName, 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::liquidity_mining_reward_manager::PoolRewardManager>,
        borrow: 0x2::table::Table<0x1::type_name::TypeName, 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::liquidity_mining_reward_manager::PoolRewardManager>,
    }

    public(friend) fun add_reward<T0, T1, T2>(arg0: &mut LiquidityMiner<T0>, arg1: u8, arg2: 0x2::coin::Coin<T2>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::liquidity_mining_reward_manager::add_pool_reward<T2>(get_reward_manager_mut<T0, T1>(arg0, arg1), 0x2::coin::into_balance<T2>(arg2), arg3, arg4, arg5, arg6);
    }

    public(friend) fun cancel_reward<T0, T1, T2>(arg0: &mut LiquidityMiner<T0>, arg1: u8, arg2: u64, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T2> {
        0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::liquidity_mining_reward_manager::cancel_pool_reward<T2>(get_reward_manager_mut<T0, T1>(arg0, arg1), arg2, arg3)
    }

    public(friend) fun claim_rewards<T0, T1, T2>(arg0: &mut LiquidityMiner<T0>, arg1: u8, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: u64) : 0x2::balance::Balance<T2> {
        0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::liquidity_mining_reward_manager::claim_rewards<T2>(get_reward_manager_mut<T0, T1>(arg0, arg1), arg2, arg3, arg4)
    }

    public(friend) fun close_reward<T0, T1, T2>(arg0: &mut LiquidityMiner<T0>, arg1: u8, arg2: u64, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T2> {
        0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::liquidity_mining_reward_manager::close_pool_reward<T2>(get_reward_manager_mut<T0, T1>(arg0, arg1), arg2, arg3)
    }

    public(friend) fun get_borrow_reward_type() : u8 {
        1
    }

    public(friend) fun get_deposit_reward_type() : u8 {
        0
    }

    public fun get_pool_reward_manager<T0, T1>(arg0: &LiquidityMiner<T0>, arg1: u8) : &0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::liquidity_mining_reward_manager::PoolRewardManager {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = get_reward_table<T0>(arg0, arg1);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::liquidity_mining_reward_manager::PoolRewardManager>(v1, v0), 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::error::liquidity_mining_pool_not_initialized());
        0x2::table::borrow<0x1::type_name::TypeName, 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::liquidity_mining_reward_manager::PoolRewardManager>(v1, v0)
    }

    fun get_reward_manager_mut<T0, T1>(arg0: &mut LiquidityMiner<T0>, arg1: u8) : &mut 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::liquidity_mining_reward_manager::PoolRewardManager {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = get_reward_table_mut<T0>(arg0, arg1);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::liquidity_mining_reward_manager::PoolRewardManager>(v1, v0), 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::error::liquidity_mining_pool_not_initialized());
        0x2::table::borrow_mut<0x1::type_name::TypeName, 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::liquidity_mining_reward_manager::PoolRewardManager>(v1, v0)
    }

    fun get_reward_table<T0>(arg0: &LiquidityMiner<T0>, arg1: u8) : &0x2::table::Table<0x1::type_name::TypeName, 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::liquidity_mining_reward_manager::PoolRewardManager> {
        let v0 = &arg1;
        let v1 = 0;
        if (v0 == &v1) {
            &arg0.deposit
        } else {
            let v3 = 1;
            assert!(v0 == &v3, 0);
            &arg0.borrow
        }
    }

    fun get_reward_table_mut<T0>(arg0: &mut LiquidityMiner<T0>, arg1: u8) : &mut 0x2::table::Table<0x1::type_name::TypeName, 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::liquidity_mining_reward_manager::PoolRewardManager> {
        let v0 = &arg1;
        let v1 = 0;
        if (v0 == &v1) {
            &mut arg0.deposit
        } else {
            let v3 = 1;
            assert!(v0 == &v3, 0);
            &mut arg0.borrow
        }
    }

    public fun has_pool_reward_manager<T0, T1>(arg0: &LiquidityMiner<T0>, arg1: u8) : bool {
        0x2::table::contains<0x1::type_name::TypeName, 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::liquidity_mining_reward_manager::PoolRewardManager>(get_reward_table<T0>(arg0, arg1), 0x1::type_name::with_defining_ids<T1>())
    }

    public(friend) fun new_liquidity_miner<T0>(arg0: &mut 0x2::tx_context::TxContext) : LiquidityMiner<T0> {
        LiquidityMiner<T0>{
            id      : 0x2::object::new(arg0),
            deposit : 0x2::table::new<0x1::type_name::TypeName, 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::liquidity_mining_reward_manager::PoolRewardManager>(arg0),
            borrow  : 0x2::table::new<0x1::type_name::TypeName, 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::liquidity_mining_reward_manager::PoolRewardManager>(arg0),
        }
    }

    public(friend) fun support_coin<T0, T1>(arg0: &mut LiquidityMiner<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = 0;
        while (v1 < 2) {
            let v2 = get_reward_table_mut<T0>(arg0, v1);
            assert!(!0x2::table::contains<0x1::type_name::TypeName, 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::liquidity_mining_reward_manager::PoolRewardManager>(v2, v0), 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::error::liquidity_mining_pool_initialized());
            0x2::table::add<0x1::type_name::TypeName, 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::liquidity_mining_reward_manager::PoolRewardManager>(v2, v0, 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::liquidity_mining_reward_manager::new_pool_reward_manager(arg1));
            v1 = v1 + 1;
        };
    }

    public(friend) fun update_obligation_reward_manager<T0, T1>(arg0: &mut LiquidityMiner<T0>, arg1: u8, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = get_reward_manager_mut<T0, T1>(arg0, arg1);
        if (!0x2::table::contains<0x2::object::ID, 0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::liquidity_mining_reward_manager::ObligationRewardManager>(0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::liquidity_mining_reward_manager::borrow_obligation_reward_managers(v0), arg2)) {
            0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::liquidity_mining_reward_manager::new_obligation_reward_manager(v0, arg2, arg4);
        };
        0x1c866c70d8ab65dd45409d6624f65a6ac0e3d07d634bec793220711ca0394f26::liquidity_mining_reward_manager::change_obligation_reward_manager_share(v0, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

