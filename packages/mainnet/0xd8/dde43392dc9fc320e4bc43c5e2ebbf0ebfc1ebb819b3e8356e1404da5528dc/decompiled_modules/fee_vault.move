module 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::fee_vault {
    struct FeeVault<phantom T0> has key {
        id: 0x2::object::UID,
        stake_pool_id: address,
        reward_balance: 0x2::balance::Balance<T0>,
        reward_weight_divisor: u256,
        claim_states: vector<ClaimState>,
    }

    struct VaultAdminCap has key {
        id: 0x2::object::UID,
        vault_id: address,
    }

    struct ClaimState has copy, drop, store {
        position_id: address,
        last_claim_ms: u64,
    }

    struct RewardsDeposited has copy, drop {
        amount: u256,
        balance_after: u256,
    }

    struct RewardsClaimed has copy, drop {
        user: address,
        position_id: address,
        elapsed_ms: u64,
        vtaco_shares: u256,
        reward: u256,
    }

    struct RewardConfigUpdated has copy, drop {
        reward_weight_divisor: u256,
    }

    fun assert_cap<T0>(arg0: &FeeVault<T0>, arg1: &VaultAdminCap) {
        assert!(0x2::object::id_address<FeeVault<T0>>(arg0) == arg1.vault_id, 12001);
    }

    public fun claim_rewards<T0>(arg0: &mut FeeVault<T0>, arg1: &0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::taco_staking::StakePool, arg2: &0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::taco_staking::StakePosition, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(claim_rewards_ptb<T0>(arg0, arg1, arg2, arg3, arg4), v0);
    }

    public fun claim_rewards_ptb<T0>(arg0: &mut FeeVault<T0>, arg1: &0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::taco_staking::StakePool, arg2: &0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::taco_staking::StakePosition, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::object::id_address<0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::taco_staking::StakePool>(arg1) == arg0.stake_pool_id, 12003);
        0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::taco_staking::assert_position_owner(arg2, 0x2::tx_context::sender(arg4));
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::taco_staking::position_id(arg2);
        let (v2, _) = find_claim_state(&arg0.claim_states, v1);
        if (!v2) {
            let v4 = 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::taco_staking::position_staked_at_ms(arg2);
            let v5 = if (v0 > v4) {
                v4
            } else {
                v0
            };
            let v6 = ClaimState{
                position_id   : v1,
                last_claim_ms : v5,
            };
            0x1::vector::push_back<ClaimState>(&mut arg0.claim_states, v6);
        };
        let (_, v8) = find_claim_state(&arg0.claim_states, v1);
        let v9 = 0x1::vector::borrow_mut<ClaimState>(&mut arg0.claim_states, v8);
        let v10 = if (v0 > v9.last_claim_ms) {
            v0 - v9.last_claim_ms
        } else {
            0
        };
        let v11 = 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::taco_staking::current_vtaco_shares(arg2, arg3);
        let v12 = if (v10 == 0 || v11 == 0) {
            0
        } else {
            v11 * (v10 as u256) / arg0.reward_weight_divisor
        };
        let v13 = (0x2::balance::value<T0>(&arg0.reward_balance) as u256);
        let v14 = if (v12 > v13) {
            v13
        } else {
            v12
        };
        let v15 = to_u64(v14);
        v9.last_claim_ms = v0;
        let v16 = if (v15 == 0) {
            0x2::balance::zero<T0>()
        } else {
            0x2::balance::split<T0>(&mut arg0.reward_balance, v15)
        };
        let v17 = RewardsClaimed{
            user         : 0x2::tx_context::sender(arg4),
            position_id  : v1,
            elapsed_ms   : v10,
            vtaco_shares : v11,
            reward       : v14,
        };
        0x2::event::emit<RewardsClaimed>(v17);
        0x2::coin::from_balance<T0>(v16, arg4)
    }

    public fun create_fee_vault<T0>(arg0: &0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::taco_staking::StakePool, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_fee_vault_internal<T0>(arg0, 31536000000, arg1);
        0x2::transfer::transfer<VaultAdminCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<FeeVault<T0>>(v0);
    }

    fun create_fee_vault_internal<T0>(arg0: &0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::taco_staking::StakePool, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) : (FeeVault<T0>, VaultAdminCap) {
        assert!(arg1 > 0, 12002);
        let v0 = FeeVault<T0>{
            id                    : 0x2::object::new(arg2),
            stake_pool_id         : 0x2::object::id_address<0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::taco_staking::StakePool>(arg0),
            reward_balance        : 0x2::balance::zero<T0>(),
            reward_weight_divisor : arg1,
            claim_states          : 0x1::vector::empty<ClaimState>(),
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

    fun find_claim_state(arg0: &vector<ClaimState>, arg1: address) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ClaimState>(arg0)) {
            if (0x1::vector::borrow<ClaimState>(arg0, v0).position_id == arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    public(friend) fun reward_balance<T0>(arg0: &FeeVault<T0>) : u256 {
        (0x2::balance::value<T0>(&arg0.reward_balance) as u256)
    }

    public(friend) fun reward_weight_divisor<T0>(arg0: &FeeVault<T0>) : u256 {
        arg0.reward_weight_divisor
    }

    public fun set_reward_weight_divisor<T0>(arg0: &mut FeeVault<T0>, arg1: &VaultAdminCap, arg2: u256) {
        assert_cap<T0>(arg0, arg1);
        assert!(arg2 > 0, 12002);
        arg0.reward_weight_divisor = arg2;
        let v0 = RewardConfigUpdated{reward_weight_divisor: arg2};
        0x2::event::emit<RewardConfigUpdated>(v0);
    }

    fun to_u64(arg0: u256) : u64 {
        if (arg0 > 18446744073709551615) {
            abort 12002
        };
        (arg0 as u64)
    }

    // decompiled from Move bytecode v6
}

