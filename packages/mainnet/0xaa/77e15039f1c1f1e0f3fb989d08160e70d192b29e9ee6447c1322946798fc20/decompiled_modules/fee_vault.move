module 0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::fee_vault {
    struct FeeVault<phantom T0> has key {
        id: 0x2::object::UID,
        stake_pool_id: address,
        reward_balance: 0x2::balance::Balance<T0>,
        emission_rate_per_second: u256,
        global_reward_index: u256,
        last_update_ms: u64,
        total_registered_weight: u256,
        position_weights: 0x2::table::Table<address, u256>,
        position_reward_indexes: 0x2::table::Table<address, u256>,
        pending_debts: 0x2::table::Table<address, u256>,
    }

    struct VaultAdminCap has key {
        id: 0x2::object::UID,
        vault_id: address,
    }

    struct RewardsDeposited has copy, drop {
        amount: u256,
        balance_after: u256,
    }

    struct PositionRegistered has copy, drop {
        user: address,
        position_id: address,
        fixed_weight: u256,
        initial_index: u256,
    }

    struct PositionUnregistered has copy, drop {
        updater: address,
        position_id: address,
        removed_weight: u256,
    }

    struct RewardsClaimed has copy, drop {
        user: address,
        position_id: address,
        elapsed_ms: u64,
        vtaco_shares: u256,
        reward: u256,
    }

    struct RewardConfigUpdated has copy, drop {
        emission_rate_per_second: u256,
    }

    struct FeeVaultCreated has copy, drop {
        vault_id: address,
        stake_pool_id: address,
        admin: address,
    }

    fun assert_cap<T0>(arg0: &FeeVault<T0>, arg1: &VaultAdminCap) {
        assert!(0x2::object::id_address<FeeVault<T0>>(arg0) == arg1.vault_id, 12001);
    }

    public fun claim_rewards<T0>(arg0: &mut FeeVault<T0>, arg1: &0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco_staking::StakePool, arg2: &0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco_staking::StakePosition, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(claim_rewards_ptb<T0>(arg0, arg1, arg2, arg3, arg4), v0);
    }

    public fun claim_rewards_ptb<T0>(arg0: &mut FeeVault<T0>, arg1: &0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco_staking::StakePool, arg2: &0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco_staking::StakePosition, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::object::id_address<0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco_staking::StakePool>(arg1) == arg0.stake_pool_id, 12003);
        0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco_staking::assert_position_owner(arg2, 0x2::tx_context::sender(arg4));
        0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco_staking::assert_position_in_pool(arg1, arg2);
        update_global_index<T0>(arg0, arg3);
        let v0 = 0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco_staking::position_id(arg2);
        if (0x2::table::contains<address, u256>(&arg0.position_reward_indexes, v0) && 0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco_staking::is_position_unlocked_or_missing(arg1, v0, arg3)) {
            unregister_registered_position<T0>(arg0, v0, 0x2::tx_context::sender(arg4));
        };
        let v1 = 0x2::table::contains<address, u256>(&arg0.position_reward_indexes, v0);
        let v2 = pending_debt_or_zero<T0>(arg0, v0);
        if (!v1 && v2 == 0) {
            abort 12005
        };
        let v3 = 0;
        let v4 = 0;
        if (v1) {
            let v5 = *0x2::table::borrow<address, u256>(&arg0.position_reward_indexes, v0);
            let v6 = if (arg0.global_reward_index > v5) {
                arg0.global_reward_index - v5
            } else {
                0
            };
            let v7 = *0x2::table::borrow<address, u256>(&arg0.position_weights, v0);
            v3 = v7;
            let v8 = if (v6 == 0 || v7 == 0) {
                0
            } else {
                v7 * v6 / 1000000000000000000
            };
            v4 = v8;
        };
        let v9 = v4 + v2;
        let v10 = (0x2::balance::value<T0>(&arg0.reward_balance) as u256);
        let v11 = if (v9 > v10) {
            v10
        } else {
            v9
        };
        let v12 = to_u64(v11);
        if (v1) {
            *0x2::table::borrow_mut<address, u256>(&mut arg0.position_reward_indexes, v0) = arg0.global_reward_index;
        };
        set_pending_debt<T0>(arg0, v0, v9 - v11);
        let v13 = if (v12 == 0) {
            0x2::balance::zero<T0>()
        } else {
            0x2::balance::split<T0>(&mut arg0.reward_balance, v12)
        };
        let v14 = RewardsClaimed{
            user         : 0x2::tx_context::sender(arg4),
            position_id  : v0,
            elapsed_ms   : 0,
            vtaco_shares : v3,
            reward       : v11,
        };
        0x2::event::emit<RewardsClaimed>(v14);
        0x2::coin::from_balance<T0>(v13, arg4)
    }

    public fun create_fee_vault<T0>(arg0: &0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco_staking::StakePool, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_fee_vault_internal<T0>(arg0, 0, arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        let v4 = FeeVaultCreated{
            vault_id      : 0x2::object::id_address<FeeVault<T0>>(&v2),
            stake_pool_id : 0x2::object::id_address<0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco_staking::StakePool>(arg0),
            admin         : v3,
        };
        0x2::event::emit<FeeVaultCreated>(v4);
        0x2::transfer::transfer<VaultAdminCap>(v1, v3);
        0x2::transfer::share_object<FeeVault<T0>>(v2);
    }

    fun create_fee_vault_internal<T0>(arg0: &0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco_staking::StakePool, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) : (FeeVault<T0>, VaultAdminCap) {
        let v0 = FeeVault<T0>{
            id                       : 0x2::object::new(arg2),
            stake_pool_id            : 0x2::object::id_address<0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco_staking::StakePool>(arg0),
            reward_balance           : 0x2::balance::zero<T0>(),
            emission_rate_per_second : arg1,
            global_reward_index      : 0,
            last_update_ms           : 0,
            total_registered_weight  : 0,
            position_weights         : 0x2::table::new<address, u256>(arg2),
            position_reward_indexes  : 0x2::table::new<address, u256>(arg2),
            pending_debts            : 0x2::table::new<address, u256>(arg2),
        };
        let v1 = VaultAdminCap{
            id       : 0x2::object::new(arg2),
            vault_id : 0x2::object::id_address<FeeVault<T0>>(&v0),
        };
        (v0, v1)
    }

    public fun deposit_rewards<T0>(arg0: &mut FeeVault<T0>, arg1: 0x2::coin::Coin<T0>) {
        deposit_rewards_balance<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    public(friend) fun deposit_rewards_balance<T0>(arg0: &mut FeeVault<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.reward_balance, arg1);
        let v0 = RewardsDeposited{
            amount        : (0x2::balance::value<T0>(&arg1) as u256),
            balance_after : (0x2::balance::value<T0>(&arg0.reward_balance) as u256),
        };
        0x2::event::emit<RewardsDeposited>(v0);
    }

    public(friend) fun emission_rate_per_second<T0>(arg0: &FeeVault<T0>) : u256 {
        arg0.emission_rate_per_second
    }

    fun pending_debt_or_zero<T0>(arg0: &FeeVault<T0>, arg1: address) : u256 {
        if (!0x2::table::contains<address, u256>(&arg0.pending_debts, arg1)) {
            return 0
        };
        *0x2::table::borrow<address, u256>(&arg0.pending_debts, arg1)
    }

    public fun register_position<T0>(arg0: &mut FeeVault<T0>, arg1: &0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco_staking::StakePool, arg2: &0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco_staking::StakePosition, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        register_position_ptb<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun register_position_ptb<T0>(arg0: &mut FeeVault<T0>, arg1: &0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco_staking::StakePool, arg2: &0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco_staking::StakePosition, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id_address<0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco_staking::StakePool>(arg1) == arg0.stake_pool_id, 12003);
        0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco_staking::assert_position_owner(arg2, 0x2::tx_context::sender(arg4));
        0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco_staking::assert_position_in_pool(arg1, arg2);
        update_global_index<T0>(arg0, arg3);
        let v0 = 0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco_staking::position_id(arg2);
        assert!(!0x2::table::contains<address, u256>(&arg0.position_reward_indexes, v0), 12004);
        let v1 = 0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco_staking::position_initial_v_shares(arg2);
        let v2 = arg0.global_reward_index;
        arg0.total_registered_weight = arg0.total_registered_weight + v1;
        0x2::table::add<address, u256>(&mut arg0.position_weights, v0, v1);
        0x2::table::add<address, u256>(&mut arg0.position_reward_indexes, v0, v2);
        let v3 = PositionRegistered{
            user          : 0x2::tx_context::sender(arg4),
            position_id   : v0,
            fixed_weight  : v1,
            initial_index : v2,
        };
        0x2::event::emit<PositionRegistered>(v3);
    }

    public(friend) fun reward_balance<T0>(arg0: &FeeVault<T0>) : u256 {
        (0x2::balance::value<T0>(&arg0.reward_balance) as u256)
    }

    public fun set_emission_rate_per_second<T0>(arg0: &mut FeeVault<T0>, arg1: &VaultAdminCap, arg2: &0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco_staking::StakePool, arg3: u256, arg4: &0x2::clock::Clock) {
        assert_cap<T0>(arg0, arg1);
        assert!(0x2::object::id_address<0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco_staking::StakePool>(arg2) == arg0.stake_pool_id, 12003);
        assert!(arg3 <= 18446744073709551615, 12002);
        update_global_index<T0>(arg0, arg4);
        arg0.emission_rate_per_second = arg3;
        let v0 = RewardConfigUpdated{emission_rate_per_second: arg3};
        0x2::event::emit<RewardConfigUpdated>(v0);
    }

    fun set_pending_debt<T0>(arg0: &mut FeeVault<T0>, arg1: address, arg2: u256) {
        if (arg2 == 0) {
            if (0x2::table::contains<address, u256>(&arg0.pending_debts, arg1)) {
                0x2::table::remove<address, u256>(&mut arg0.pending_debts, arg1);
            };
            return
        };
        if (0x2::table::contains<address, u256>(&arg0.pending_debts, arg1)) {
            *0x2::table::borrow_mut<address, u256>(&mut arg0.pending_debts, arg1) = arg2;
        } else {
            0x2::table::add<address, u256>(&mut arg0.pending_debts, arg1, arg2);
        };
    }

    fun to_u64(arg0: u256) : u64 {
        if (arg0 > 18446744073709551615) {
            abort 12002
        };
        (arg0 as u64)
    }

    fun unregister_registered_position<T0>(arg0: &mut FeeVault<T0>, arg1: address, arg2: address) {
        assert!(0x2::table::contains<address, u256>(&arg0.position_reward_indexes, arg1), 12005);
        let v0 = *0x2::table::borrow<address, u256>(&arg0.position_reward_indexes, arg1);
        let v1 = if (arg0.global_reward_index > v0) {
            arg0.global_reward_index - v0
        } else {
            0
        };
        let v2 = *0x2::table::borrow<address, u256>(&arg0.position_weights, arg1);
        let v3 = if (v1 == 0 || v2 == 0) {
            0
        } else {
            v2 * v1 / 1000000000000000000
        };
        let v4 = pending_debt_or_zero<T0>(arg0, arg1) + v3;
        set_pending_debt<T0>(arg0, arg1, v4);
        let v5 = 0x2::table::remove<address, u256>(&mut arg0.position_weights, arg1);
        arg0.total_registered_weight = arg0.total_registered_weight - v5;
        0x2::table::remove<address, u256>(&mut arg0.position_reward_indexes, arg1);
        let v6 = PositionUnregistered{
            updater        : arg2,
            position_id    : arg1,
            removed_weight : v5,
        };
        0x2::event::emit<PositionUnregistered>(v6);
    }

    public fun unregister_unlocked_position<T0>(arg0: &mut FeeVault<T0>, arg1: &0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco_staking::StakePool, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        unregister_unlocked_position_ptb<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun unregister_unlocked_position_ptb<T0>(arg0: &mut FeeVault<T0>, arg1: &0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco_staking::StakePool, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id_address<0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco_staking::StakePool>(arg1) == arg0.stake_pool_id, 12003);
        assert!(0x2::table::contains<address, u256>(&arg0.position_reward_indexes, arg2), 12005);
        assert!(0x3163b57b1dc2349877f79a58132b628110b7dd6cd1e9d3d2672c9620b4fe9fbf::taco_staking::is_position_unlocked_or_missing(arg1, arg2, arg3), 12006);
        update_global_index<T0>(arg0, arg3);
        unregister_registered_position<T0>(arg0, arg2, 0x2::tx_context::sender(arg4));
    }

    fun update_global_index<T0>(arg0: &mut FeeVault<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 <= arg0.last_update_ms) {
            return
        };
        let v1 = (v0 - arg0.last_update_ms) / 1000;
        if (v1 == 0) {
            return
        };
        if (arg0.emission_rate_per_second > 0 && arg0.total_registered_weight > 0) {
            arg0.global_reward_index = arg0.global_reward_index + arg0.emission_rate_per_second * 1000000000000000000 / arg0.total_registered_weight * (v1 as u256);
        };
        arg0.last_update_ms = arg0.last_update_ms + v1 * 1000;
    }

    // decompiled from Move bytecode v6
}

