module 0xec0d2da82ff3c998acd430306e169169ece49e4afa0e6da42fbccc366f945a74::internal_rewards {
    struct RewardProportions has store, key {
        id: 0x2::object::UID,
        staking_pool_rewards_bps: u64,
        external_partner_rewards_bps: u64,
        insurance_fund_bps: u64,
        team_bps: u64,
    }

    struct RewardDestinations has store, key {
        id: 0x2::object::UID,
        external_partner_rewards_addr: address,
        insurance_fund_addr: address,
        team_addr: address,
    }

    struct InternalSuiVault has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        depositor: address,
    }

    struct EmergencyWithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    struct DistributeSuiRewardsEvent has copy, drop {
        vault_id: 0x2::object::ID,
        staking_pool_amount: u64,
        external_partner_amount: u64,
        insurance_fund_amount: u64,
        team_amount: u64,
        external_partner_addr: address,
        insurance_fund_addr: address,
        team_addr: address,
        setter: address,
    }

    struct ProportionsUpdatedEvent has copy, drop {
        proportions_id: 0x2::object::ID,
        old_staking_bps: u64,
        old_external_bps: u64,
        old_insurance_bps: u64,
        new_staking_bps: u64,
        new_external_bps: u64,
        new_insurance_bps: u64,
        setter: address,
    }

    struct DestinationsUpdatedEvent has copy, drop {
        destinations_id: 0x2::object::ID,
        old_external_partner_addr: address,
        old_insurance_fund_addr: address,
        old_team_addr: address,
        new_external_partner_addr: address,
        new_insurance_fund_addr: address,
        new_team_addr: address,
        setter: address,
    }

    public entry fun deposit_sui(arg0: &mut InternalSuiVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = DepositEvent{
            vault_id  : 0x2::object::id<InternalSuiVault>(arg0),
            coin_type : 0x1::type_name::with_defining_ids<0x2::sui::SUI>(),
            amount    : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            depositor : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public entry fun distribute_sui_rewards_by_admin(arg0: &0xec0d2da82ff3c998acd430306e169169ece49e4afa0e6da42fbccc366f945a74::admin::AdminCap, arg1: &mut InternalSuiVault, arg2: &RewardProportions, arg3: &RewardDestinations, arg4: &mut 0xec0d2da82ff3c998acd430306e169169ece49e4afa0e6da42fbccc366f945a74::staking_pool_rewards::RewardPool<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        distribute_sui_rewards_internal(arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun distribute_sui_rewards_by_keeper(arg0: &0xec0d2da82ff3c998acd430306e169169ece49e4afa0e6da42fbccc366f945a74::admin::KeeperCap, arg1: &mut InternalSuiVault, arg2: &RewardProportions, arg3: &RewardDestinations, arg4: &mut 0xec0d2da82ff3c998acd430306e169169ece49e4afa0e6da42fbccc366f945a74::staking_pool_rewards::RewardPool<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        distribute_sui_rewards_internal(arg1, arg2, arg3, arg4, arg5);
    }

    fun distribute_sui_rewards_internal(arg0: &mut InternalSuiVault, arg1: &RewardProportions, arg2: &RewardDestinations, arg3: &mut 0xec0d2da82ff3c998acd430306e169169ece49e4afa0e6da42fbccc366f945a74::staking_pool_rewards::RewardPool<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        assert!(v0 > 0, 1);
        let v1 = 10000;
        let v2 = v0 * arg1.staking_pool_rewards_bps / v1;
        let v3 = v0 * arg1.external_partner_rewards_bps / v1;
        let v4 = v0 * arg1.insurance_fund_bps / v1;
        let v5 = v0 * arg1.team_bps / v1;
        let v6 = DistributeSuiRewardsEvent{
            vault_id                : 0x2::object::id<InternalSuiVault>(arg0),
            staking_pool_amount     : v2,
            external_partner_amount : v3,
            insurance_fund_amount   : v4,
            team_amount             : v5,
            external_partner_addr   : arg2.external_partner_rewards_addr,
            insurance_fund_addr     : arg2.insurance_fund_addr,
            team_addr               : arg2.team_addr,
            setter                  : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<DistributeSuiRewardsEvent>(v6);
        if (v2 > 0) {
            0xec0d2da82ff3c998acd430306e169169ece49e4afa0e6da42fbccc366f945a74::staking_pool_rewards::deposit_reward_funds<0x2::sui::SUI>(arg3, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v2), arg4), arg4);
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v3), arg4), arg2.external_partner_rewards_addr);
        };
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v4), arg4), arg2.insurance_fund_addr);
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v5), arg4), arg2.team_addr);
        };
    }

    public fun emergency_withdraw_sui(arg0: &0xec0d2da82ff3c998acd430306e169169ece49e4afa0e6da42fbccc366f945a74::admin::AdminCap, arg1: &mut InternalSuiVault, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance);
        if (v0 > 0) {
            let v1 = EmergencyWithdrawEvent{
                vault_id  : 0x2::object::id<InternalSuiVault>(arg1),
                coin_type : 0x1::type_name::with_defining_ids<0x2::sui::SUI>(),
                amount    : v0,
                recipient : 0x2::tx_context::sender(arg2),
            };
            0x2::event::emit<EmergencyWithdrawEvent>(v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v0), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    public fun get_destinations(arg0: &RewardDestinations) : (address, address, address) {
        (arg0.external_partner_rewards_addr, arg0.insurance_fund_addr, arg0.team_addr)
    }

    public fun get_proportions(arg0: &RewardProportions) : (u64, u64, u64, u64) {
        (arg0.staking_pool_rewards_bps, arg0.external_partner_rewards_bps, arg0.insurance_fund_bps, arg0.team_bps)
    }

    public fun get_sui_vault_balance(arg0: &InternalSuiVault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardProportions{
            id                           : 0x2::object::new(arg0),
            staking_pool_rewards_bps     : 3500,
            external_partner_rewards_bps : 3500,
            insurance_fund_bps           : 1500,
            team_bps                     : 1500,
        };
        0x2::transfer::share_object<RewardProportions>(v0);
        let v1 = RewardDestinations{
            id                            : 0x2::object::new(arg0),
            external_partner_rewards_addr : @0x0,
            insurance_fund_addr           : @0x0,
            team_addr                     : @0x0,
        };
        0x2::transfer::share_object<RewardDestinations>(v1);
        let v2 = InternalSuiVault{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<InternalSuiVault>(v2);
    }

    public fun update_destinations(arg0: &0xec0d2da82ff3c998acd430306e169169ece49e4afa0e6da42fbccc366f945a74::admin::AdminCap, arg1: &mut RewardDestinations, arg2: address, arg3: address, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        arg1.external_partner_rewards_addr = arg2;
        arg1.insurance_fund_addr = arg3;
        arg1.team_addr = arg4;
        let v0 = DestinationsUpdatedEvent{
            destinations_id           : 0x2::object::id<RewardDestinations>(arg1),
            old_external_partner_addr : arg1.external_partner_rewards_addr,
            old_insurance_fund_addr   : arg1.insurance_fund_addr,
            old_team_addr             : arg1.team_addr,
            new_external_partner_addr : arg2,
            new_insurance_fund_addr   : arg3,
            new_team_addr             : arg4,
            setter                    : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<DestinationsUpdatedEvent>(v0);
    }

    public fun update_proportions(arg0: &0xec0d2da82ff3c998acd430306e169169ece49e4afa0e6da42fbccc366f945a74::admin::AdminCap, arg1: &mut RewardProportions, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 + arg3 + arg4 == 8500, 2);
        arg1.staking_pool_rewards_bps = arg2;
        arg1.external_partner_rewards_bps = arg3;
        arg1.insurance_fund_bps = arg4;
        let v0 = ProportionsUpdatedEvent{
            proportions_id    : 0x2::object::id<RewardProportions>(arg1),
            old_staking_bps   : arg1.staking_pool_rewards_bps,
            old_external_bps  : arg1.external_partner_rewards_bps,
            old_insurance_bps : arg1.insurance_fund_bps,
            new_staking_bps   : arg2,
            new_external_bps  : arg3,
            new_insurance_bps : arg4,
            setter            : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<ProportionsUpdatedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

