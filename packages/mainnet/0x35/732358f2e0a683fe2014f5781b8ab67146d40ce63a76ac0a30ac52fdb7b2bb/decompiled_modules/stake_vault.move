module 0x330aa337772418f68117556dce74034063f11a8de68f60a99acc9a5ee62f5fb3::stake_vault {
    struct Vault has key {
        id: 0x2::object::UID,
        total_staked: 0x2::balance::Balance<0x2::sui::SUI>,
        pending_yield: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct VaultAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StakeReceipt has store, key {
        id: 0x2::object::UID,
        owner: address,
        principal_mist: u64,
        deposit_ts_ms: u64,
        unlock_ts_ms: 0x1::option::Option<u64>,
    }

    struct StakingVault has key {
        id: 0x2::object::UID,
        total_principal: u64,
        stakes: vector<0x3::staking_pool::StakedSui>,
        pending_rewards: 0x2::balance::Balance<0x2::sui::SUI>,
        liquid_principal: 0x2::balance::Balance<0x2::sui::SUI>,
        pending_unstake_mist: u64,
    }

    struct StakingReceipt has store, key {
        id: 0x2::object::UID,
        owner: address,
        principal_mist: u64,
        deposit_ts_ms: u64,
        unlock_ts_ms: 0x1::option::Option<u64>,
    }

    struct Deposited has copy, drop {
        staker: address,
        amount_mist: u64,
        receipt_id: 0x2::object::ID,
    }

    struct UnstakeRequested has copy, drop {
        staker: address,
        receipt_id: 0x2::object::ID,
        unlock_ts_ms: u64,
    }

    struct Withdrawn has copy, drop {
        staker: address,
        amount_mist: u64,
    }

    struct DepositedV2 has copy, drop {
        staker: address,
        amount_mist: u64,
        receipt_id: 0x2::object::ID,
        referrer: 0x1::option::Option<address>,
    }

    struct PartialUnstakeRequested has copy, drop {
        staker: address,
        original_receipt_id: 0x2::object::ID,
        new_receipt_id: 0x2::object::ID,
        unstake_amount_mist: u64,
        remaining_mist: u64,
        unlock_ts_ms: u64,
    }

    struct Staked has copy, drop {
        staker: address,
        amount_mist: u64,
        receipt_id: 0x2::object::ID,
    }

    struct StakeUnstakeRequested has copy, drop {
        staker: address,
        receipt_id: 0x2::object::ID,
        unlock_ts_ms: u64,
    }

    struct StakeWithdrawn has copy, drop {
        staker: address,
        amount_mist: u64,
    }

    struct Harvested has copy, drop {
        rewards_mist: u64,
        total_principal: u64,
    }

    entry fun add_yield(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pending_yield, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun claim_rewards(arg0: &mut StakingVault, arg1: &VaultAdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pending_rewards, 0x2::balance::value<0x2::sui::SUI>(&arg0.pending_rewards)), arg2)
    }

    entry fun create_staking_vault(arg0: &VaultAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingVault{
            id                   : 0x2::object::new(arg1),
            total_principal      : 0,
            stakes               : 0x1::vector::empty<0x3::staking_pool::StakedSui>(),
            pending_rewards      : 0x2::balance::zero<0x2::sui::SUI>(),
            liquid_principal     : 0x2::balance::zero<0x2::sui::SUI>(),
            pending_unstake_mist : 0,
        };
        0x2::transfer::share_object<StakingVault>(v0);
    }

    entry fun deposit(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= 1000000000, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.total_staked, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = StakeReceipt{
            id             : 0x2::object::new(arg3),
            owner          : 0x2::tx_context::sender(arg3),
            principal_mist : v0,
            deposit_ts_ms  : 0x2::clock::timestamp_ms(arg2),
            unlock_ts_ms   : 0x1::option::none<u64>(),
        };
        let v2 = Deposited{
            staker      : 0x2::tx_context::sender(arg3),
            amount_mist : v0,
            receipt_id  : 0x2::object::id<StakeReceipt>(&v1),
        };
        0x2::event::emit<Deposited>(v2);
        0x2::transfer::transfer<StakeReceipt>(v1, 0x2::tx_context::sender(arg3));
    }

    public fun harvest(arg0: &mut StakingVault, arg1: &VaultAdminCap, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x1::vector::is_empty<0x3::staking_pool::StakedSui>(&arg0.stakes)) {
            return
        };
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        while (!0x1::vector::is_empty<0x3::staking_pool::StakedSui>(&arg0.stakes)) {
            0x2::balance::join<0x2::sui::SUI>(&mut v0, 0x3::sui_system::request_withdraw_stake_non_entry(arg2, 0x1::vector::pop_back<0x3::staking_pool::StakedSui>(&mut arg0.stakes), arg3));
        };
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0) - arg0.total_principal - 0x2::balance::value<0x2::sui::SUI>(&arg0.liquid_principal);
        if (v1 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.pending_rewards, 0x2::balance::split<0x2::sui::SUI>(&mut v0, v1));
        };
        if (arg0.pending_unstake_mist > 0) {
            let v2 = 0x2::balance::value<0x2::sui::SUI>(&v0);
            let v3 = if (arg0.pending_unstake_mist <= v2) {
                arg0.pending_unstake_mist
            } else {
                v2
            };
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.liquid_principal, 0x2::balance::split<0x2::sui::SUI>(&mut v0, v3));
            arg0.pending_unstake_mist = arg0.pending_unstake_mist - v3;
        };
        if (0x2::balance::value<0x2::sui::SUI>(&v0) >= 1000000000) {
            0x1::vector::push_back<0x3::staking_pool::StakedSui>(&mut arg0.stakes, 0x3::sui_system::request_add_stake_non_entry(arg2, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg3), @0xa608b66f7ae2201286f7dd07a8b073cde7955b35056629636a6c9b3f5275f384, arg3));
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.liquid_principal, v0);
        };
        let v4 = Harvested{
            rewards_mist    : v1,
            total_principal : arg0.total_principal,
        };
        0x2::event::emit<Harvested>(v4);
    }

    public fun harvest_yield(arg0: &mut Vault, arg1: &VaultAdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pending_yield, 0x2::balance::value<0x2::sui::SUI>(&arg0.pending_yield)), arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id            : 0x2::object::new(arg0),
            total_staked  : 0x2::balance::zero<0x2::sui::SUI>(),
            pending_yield : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Vault>(v0);
        let v1 = VaultAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<VaultAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun merge_or_push(arg0: &mut StakingVault, arg1: 0x3::staking_pool::StakedSui) {
        let v0 = 0x1::vector::length<0x3::staking_pool::StakedSui>(&arg0.stakes);
        let v1 = v0;
        let v2 = 0;
        while (v2 < v0) {
            if (0x3::staking_pool::is_equal_staking_metadata(0x1::vector::borrow<0x3::staking_pool::StakedSui>(&arg0.stakes, v2), &arg1)) {
                v1 = v2;
                break
            };
            v2 = v2 + 1;
        };
        if (v1 < v0) {
            0x3::staking_pool::join_staked_sui(0x1::vector::borrow_mut<0x3::staking_pool::StakedSui>(&mut arg0.stakes, v1), arg1);
        } else {
            0x1::vector::push_back<0x3::staking_pool::StakedSui>(&mut arg0.stakes, arg1);
        };
    }

    entry fun migrate_from_legacy(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= 1000000000, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.total_staked, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = StakeReceipt{
            id             : 0x2::object::new(arg4),
            owner          : 0x2::tx_context::sender(arg4),
            principal_mist : v0,
            deposit_ts_ms  : arg2,
            unlock_ts_ms   : 0x1::option::none<u64>(),
        };
        let v2 = Deposited{
            staker      : 0x2::tx_context::sender(arg4),
            amount_mist : v0,
            receipt_id  : 0x2::object::id<StakeReceipt>(&v1),
        };
        0x2::event::emit<Deposited>(v2);
        0x2::transfer::transfer<StakeReceipt>(v1, 0x2::tx_context::sender(arg4));
    }

    public fun pending_yield_amount(arg0: &Vault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pending_yield)
    }

    public fun receipt_deposit_ts(arg0: &StakeReceipt) : u64 {
        arg0.deposit_ts_ms
    }

    public fun receipt_is_unstaking(arg0: &StakeReceipt) : bool {
        0x1::option::is_some<u64>(&arg0.unlock_ts_ms)
    }

    public fun receipt_owner(arg0: &StakeReceipt) : address {
        arg0.owner
    }

    public fun receipt_principal(arg0: &StakeReceipt) : u64 {
        arg0.principal_mist
    }

    entry fun request_unstake(arg0: &mut StakeReceipt, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        assert!(0x1::option::is_none<u64>(&arg0.unlock_ts_ms), 3);
        let v0 = 0x2::clock::timestamp_ms(arg1) + 86400000;
        arg0.unlock_ts_ms = 0x1::option::some<u64>(v0);
        let v1 = UnstakeRequested{
            staker       : 0x2::tx_context::sender(arg2),
            receipt_id   : 0x2::object::id<StakeReceipt>(arg0),
            unlock_ts_ms : v0,
        };
        0x2::event::emit<UnstakeRequested>(v1);
    }

    entry fun request_unstake_staked(arg0: &mut StakingVault, arg1: &mut StakingReceipt, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 1);
        assert!(0x1::option::is_none<u64>(&arg1.unlock_ts_ms), 3);
        let v0 = 0x2::clock::timestamp_ms(arg2) + 86400000;
        arg1.unlock_ts_ms = 0x1::option::some<u64>(v0);
        arg0.pending_unstake_mist = arg0.pending_unstake_mist + arg1.principal_mist;
        let v1 = StakeUnstakeRequested{
            staker       : 0x2::tx_context::sender(arg3),
            receipt_id   : 0x2::object::id<StakingReceipt>(arg1),
            unlock_ts_ms : v0,
        };
        0x2::event::emit<StakeUnstakeRequested>(v1);
    }

    entry fun stake(arg0: &mut StakingVault, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 >= 1000000000, 4);
        merge_or_push(arg0, 0x3::sui_system::request_add_stake_non_entry(arg1, arg2, @0xa608b66f7ae2201286f7dd07a8b073cde7955b35056629636a6c9b3f5275f384, arg4));
        arg0.total_principal = arg0.total_principal + v0;
        let v1 = StakingReceipt{
            id             : 0x2::object::new(arg4),
            owner          : 0x2::tx_context::sender(arg4),
            principal_mist : v0,
            deposit_ts_ms  : 0x2::clock::timestamp_ms(arg3),
            unlock_ts_ms   : 0x1::option::none<u64>(),
        };
        let v2 = Staked{
            staker      : 0x2::tx_context::sender(arg4),
            amount_mist : v0,
            receipt_id  : 0x2::object::id<StakingReceipt>(&v1),
        };
        0x2::event::emit<Staked>(v2);
        0x2::transfer::transfer<StakingReceipt>(v1, 0x2::tx_context::sender(arg4));
    }

    public fun staking_liquid_principal(arg0: &StakingVault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.liquid_principal)
    }

    public fun staking_num_stakes(arg0: &StakingVault) : u64 {
        0x1::vector::length<0x3::staking_pool::StakedSui>(&arg0.stakes)
    }

    public fun staking_pending_rewards(arg0: &StakingVault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pending_rewards)
    }

    public fun staking_pending_unstake(arg0: &StakingVault) : u64 {
        arg0.pending_unstake_mist
    }

    public fun staking_receipt_owner(arg0: &StakingReceipt) : address {
        arg0.owner
    }

    public fun staking_receipt_principal(arg0: &StakingReceipt) : u64 {
        arg0.principal_mist
    }

    public fun staking_total_principal(arg0: &StakingVault) : u64 {
        arg0.total_principal
    }

    public fun total_staked(arg0: &Vault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.total_staked)
    }

    entry fun withdraw(arg0: &mut Vault, arg1: StakeReceipt, arg2: &mut 0x330aa337772418f68117556dce74034063f11a8de68f60a99acc9a5ee62f5fb3::loyalty_tracker::LoyaltyRecord, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg4), 1);
        assert!(0x2::clock::timestamp_ms(arg3) >= *0x1::option::borrow<u64>(&arg1.unlock_ts_ms), 2);
        let StakeReceipt {
            id             : v0,
            owner          : _,
            principal_mist : v2,
            deposit_ts_ms  : _,
            unlock_ts_ms   : _,
        } = arg1;
        0x2::object::delete(v0);
        0x330aa337772418f68117556dce74034063f11a8de68f60a99acc9a5ee62f5fb3::loyalty_tracker::reset(arg2, arg3, arg4);
        let v5 = Withdrawn{
            staker      : 0x2::tx_context::sender(arg4),
            amount_mist : v2,
        };
        0x2::event::emit<Withdrawn>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.total_staked, v2), arg4), 0x2::tx_context::sender(arg4));
    }

    entry fun withdraw_staked(arg0: &mut StakingVault, arg1: StakingReceipt, arg2: &mut 0x330aa337772418f68117556dce74034063f11a8de68f60a99acc9a5ee62f5fb3::loyalty_tracker::LoyaltyRecord, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg4), 1);
        assert!(0x2::clock::timestamp_ms(arg3) >= *0x1::option::borrow<u64>(&arg1.unlock_ts_ms), 2);
        let StakingReceipt {
            id             : v0,
            owner          : _,
            principal_mist : v2,
            deposit_ts_ms  : _,
            unlock_ts_ms   : _,
        } = arg1;
        0x2::object::delete(v0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.liquid_principal) >= v2, 5);
        arg0.total_principal = arg0.total_principal - v2;
        0x330aa337772418f68117556dce74034063f11a8de68f60a99acc9a5ee62f5fb3::loyalty_tracker::reset(arg2, arg3, arg4);
        let v5 = StakeWithdrawn{
            staker      : 0x2::tx_context::sender(arg4),
            amount_mist : v2,
        };
        0x2::event::emit<StakeWithdrawn>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.liquid_principal, v2), arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v7
}

