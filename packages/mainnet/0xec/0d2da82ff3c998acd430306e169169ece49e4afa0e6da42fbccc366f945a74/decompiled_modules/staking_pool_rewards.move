module 0xec0d2da82ff3c998acd430306e169169ece49e4afa0e6da42fbccc366f945a74::staking_pool_rewards {
    struct RewardPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault: 0x2::balance::Balance<T0>,
        rewards: 0x2::table::Table<address, 0x2::balance::Balance<T0>>,
    }

    struct DepositRewardFundsEvent has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        depositor: address,
    }

    struct ClaimRewardEvent has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    struct EmergencyWithdrawEvent has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    struct SetRewardsEvent has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        recipients: vector<address>,
        amounts: vector<u64>,
        setter: address,
    }

    public fun add_reward_token<T0>(arg0: &0xec0d2da82ff3c998acd430306e169169ece49e4afa0e6da42fbccc366f945a74::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardPool<T0>{
            id      : 0x2::object::new(arg1),
            vault   : 0x2::balance::zero<T0>(),
            rewards : 0x2::table::new<address, 0x2::balance::Balance<T0>>(arg1),
        };
        0x2::transfer::share_object<RewardPool<T0>>(v0);
    }

    public entry fun claim_reward<T0>(arg0: &mut RewardPool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, 0x2::balance::Balance<T0>>(&arg0.rewards, v0), 1);
        let v1 = 0x2::table::remove<address, 0x2::balance::Balance<T0>>(&mut arg0.rewards, v0);
        let v2 = 0x2::balance::value<T0>(&v1);
        assert!(v2 > 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg1), v0);
        let v3 = ClaimRewardEvent{
            pool_id   : 0x2::object::id<RewardPool<T0>>(arg0),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : v2,
            recipient : v0,
        };
        0x2::event::emit<ClaimRewardEvent>(v3);
    }

    public entry fun deposit_reward_funds<T0>(arg0: &mut RewardPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg1));
        let v0 = DepositRewardFundsEvent{
            pool_id   : 0x2::object::id<RewardPool<T0>>(arg0),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : 0x2::coin::value<T0>(&arg1),
            depositor : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<DepositRewardFundsEvent>(v0);
    }

    public fun emergency_withdraw<T0>(arg0: &0xec0d2da82ff3c998acd430306e169169ece49e4afa0e6da42fbccc366f945a74::admin::AdminCap, arg1: &mut RewardPool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg1.vault);
        if (v0 > 0) {
            let v1 = EmergencyWithdrawEvent{
                pool_id   : 0x2::object::id<RewardPool<T0>>(arg1),
                coin_type : 0x1::type_name::with_defining_ids<T0>(),
                amount    : v0,
                recipient : 0x2::tx_context::sender(arg2),
            };
            0x2::event::emit<EmergencyWithdrawEvent>(v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.vault, v0), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    public fun get_pending_reward<T0>(arg0: &RewardPool<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, 0x2::balance::Balance<T0>>(&arg0.rewards, arg1)) {
            0x2::balance::value<T0>(0x2::table::borrow<address, 0x2::balance::Balance<T0>>(&arg0.rewards, arg1))
        } else {
            0
        }
    }

    public fun get_vault_balance<T0>(arg0: &RewardPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.vault)
    }

    public entry fun set_rewards_by_admin<T0>(arg0: &0xec0d2da82ff3c998acd430306e169169ece49e4afa0e6da42fbccc366f945a74::admin::AdminCap, arg1: &mut RewardPool<T0>, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        set_rewards_internal<T0>(arg1, arg2, arg3, arg4);
    }

    public entry fun set_rewards_by_keeper<T0>(arg0: &0xec0d2da82ff3c998acd430306e169169ece49e4afa0e6da42fbccc366f945a74::admin::KeeperCap, arg1: &mut RewardPool<T0>, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        set_rewards_internal<T0>(arg1, arg2, arg3, arg4);
    }

    fun set_rewards_internal<T0>(arg0: &mut RewardPool<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            let v2 = *0x1::vector::borrow<u64>(&arg2, v0);
            assert!(0x2::balance::value<T0>(&arg0.vault) >= v2, 3);
            if (0x2::table::contains<address, 0x2::balance::Balance<T0>>(&arg0.rewards, v1)) {
                0x2::balance::join<T0>(0x2::table::borrow_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.rewards, v1), 0x2::balance::split<T0>(&mut arg0.vault, v2));
            } else {
                0x2::table::add<address, 0x2::balance::Balance<T0>>(&mut arg0.rewards, v1, 0x2::balance::split<T0>(&mut arg0.vault, v2));
            };
            v0 = v0 + 1;
        };
        let v3 = SetRewardsEvent{
            pool_id    : 0x2::object::id<RewardPool<T0>>(arg0),
            coin_type  : 0x1::type_name::with_defining_ids<T0>(),
            recipients : arg1,
            amounts    : arg2,
            setter     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SetRewardsEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

