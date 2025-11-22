module 0xb428bbdc8a292a279bf2e4a58c8be834232b90385da135c4c422de3e2b499922::vault {
    struct VaultAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VaultRegistry has key {
        id: 0x2::object::UID,
        total_vaults: u64,
        total_staked: u64,
        total_yield_distributed: u64,
        is_accepting_stakes: bool,
    }

    struct StakePosition has drop, store {
        amount: u64,
        start_time: u64,
        last_yield_claim: u64,
        accumulated_yield: u64,
        locked_until: u64,
        is_from_hometovault: bool,
        hometovault_vault_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct HedgeSwapVault has store, key {
        id: 0x2::object::UID,
        total_staked: 0x2::balance::Balance<0x2::sui::SUI>,
        stakes: 0x2::table::Table<address, StakePosition>,
        total_stakers: u64,
        accumulated_yield: 0x2::balance::Balance<0x2::sui::SUI>,
        strategy_name: vector<u8>,
        apy_basis_points: u64,
        risk_level: u8,
        min_lockup_seconds: u64,
        is_active: bool,
        is_frozen: bool,
        is_locked: bool,
    }

    struct StrategyMetadata has copy, drop {
        strategy_name: vector<u8>,
        apy_basis_points: u64,
        risk_level: u8,
        min_lockup_seconds: u64,
        total_staked: u64,
        total_stakers: u64,
        is_active: bool,
    }

    struct VaultCreated has copy, drop {
        vault_id: address,
        strategy_name: vector<u8>,
        apy_basis_points: u64,
        timestamp: u64,
    }

    struct Staked has copy, drop {
        vault_id: address,
        staker: address,
        amount: u64,
        lockup_end: u64,
        is_from_hometovault: bool,
        timestamp: u64,
    }

    struct Unstaked has copy, drop {
        vault_id: address,
        staker: address,
        amount: u64,
        yield_claimed: u64,
        timestamp: u64,
    }

    struct YieldClaimed has copy, drop {
        vault_id: address,
        staker: address,
        yield_amount: u64,
        timestamp: u64,
    }

    struct YieldDeposited has copy, drop {
        vault_id: address,
        amount: u64,
        timestamp: u64,
    }

    public fun calculate_claimable_yield(arg0: &HedgeSwapVault, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        if (!0x2::table::contains<address, StakePosition>(&arg0.stakes, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, StakePosition>(&arg0.stakes, arg1);
        calculate_yield(v0.amount, 0x2::clock::timestamp_ms(arg2) - v0.last_yield_claim, arg0.apy_basis_points)
    }

    fun calculate_yield(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        arg0 * arg2 * arg1 / 1000 / 10000 * 31536000
    }

    public entry fun claim_yield(arg0: &mut HedgeSwapVault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_frozen, 2057);
        assert!(!arg0.is_locked, 2052);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, StakePosition>(&arg0.stakes, v0), 2056);
        let v1 = 0x2::table::borrow_mut<address, StakePosition>(&mut arg0.stakes, v0);
        let v2 = 0x2::clock::timestamp_ms(arg1);
        let v3 = calculate_yield(v1.amount, v2 - v1.last_yield_claim, arg0.apy_basis_points);
        assert!(v3 > 0, 2050);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.accumulated_yield) >= v3, 2051);
        v1.last_yield_claim = v2;
        v1.accumulated_yield = v1.accumulated_yield + v3;
        let v4 = YieldClaimed{
            vault_id     : 0x2::object::uid_to_address(&arg0.id),
            staker       : v0,
            yield_amount : v3,
            timestamp    : v2,
        };
        0x2::event::emit<YieldClaimed>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.accumulated_yield, v3), arg2), v0);
    }

    public entry fun create_vault(arg0: &mut VaultRegistry, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = HedgeSwapVault{
            id                 : 0x2::object::new(arg3),
            total_staked       : 0x2::balance::zero<0x2::sui::SUI>(),
            stakes             : 0x2::table::new<address, StakePosition>(arg3),
            total_stakers      : 0,
            accumulated_yield  : 0x2::balance::zero<0x2::sui::SUI>(),
            strategy_name      : arg1,
            apy_basis_points   : 800,
            risk_level         : 2,
            min_lockup_seconds : 2592000,
            is_active          : true,
            is_frozen          : false,
            is_locked          : false,
        };
        arg0.total_vaults = arg0.total_vaults + 1;
        let v1 = VaultCreated{
            vault_id         : 0x2::object::uid_to_address(&v0.id),
            strategy_name    : arg1,
            apy_basis_points : 800,
            timestamp        : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<VaultCreated>(v1);
        0x2::transfer::share_object<HedgeSwapVault>(v0);
    }

    public entry fun deposit_yield(arg0: &VaultAdminCap, arg1: &mut HedgeSwapVault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 2050);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.accumulated_yield, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v1 = YieldDeposited{
            vault_id  : 0x2::object::uid_to_address(&arg1.id),
            amount    : v0,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<YieldDeposited>(v1);
    }

    public entry fun freeze_vault(arg0: &VaultAdminCap, arg1: &mut HedgeSwapVault, arg2: bool) {
        arg1.is_frozen = arg2;
    }

    public fun get_stake_balance(arg0: &HedgeSwapVault, arg1: address) : (u64, u64, u64, bool) {
        if (!0x2::table::contains<address, StakePosition>(&arg0.stakes, arg1)) {
            return (0, 0, 0, false)
        };
        let v0 = 0x2::table::borrow<address, StakePosition>(&arg0.stakes, arg1);
        (v0.amount, v0.accumulated_yield, v0.locked_until, v0.is_from_hometovault)
    }

    public fun get_strategy_metadata(arg0: &HedgeSwapVault) : StrategyMetadata {
        StrategyMetadata{
            strategy_name      : arg0.strategy_name,
            apy_basis_points   : arg0.apy_basis_points,
            risk_level         : arg0.risk_level,
            min_lockup_seconds : arg0.min_lockup_seconds,
            total_staked       : 0x2::balance::value<0x2::sui::SUI>(&arg0.total_staked),
            total_stakers      : arg0.total_stakers,
            is_active          : arg0.is_active,
        }
    }

    public fun get_vault_stats(arg0: &HedgeSwapVault) : (u64, u64, u64, bool) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.total_staked), arg0.total_stakers, 0x2::balance::value<0x2::sui::SUI>(&arg0.accumulated_yield), arg0.is_active)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultAdminCap{id: 0x2::object::new(arg0)};
        let v1 = VaultRegistry{
            id                      : 0x2::object::new(arg0),
            total_vaults            : 0,
            total_staked            : 0,
            total_yield_distributed : 0,
            is_accepting_stakes     : true,
        };
        0x2::transfer::transfer<VaultAdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<VaultRegistry>(v1);
    }

    public entry fun set_vault_active(arg0: &VaultAdminCap, arg1: &mut HedgeSwapVault, arg2: bool) {
        arg1.is_active = arg2;
    }

    public entry fun stake(arg0: &mut HedgeSwapVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_frozen, 2057);
        assert!(!arg0.is_locked, 2052);
        assert!(arg0.is_active, 2054);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 2050);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = v2 + arg0.min_lockup_seconds * 1000;
        assert!(!0x2::table::contains<address, StakePosition>(&arg0.stakes, v1), 2055);
        let v4 = StakePosition{
            amount               : v0,
            start_time           : v2,
            last_yield_claim     : v2,
            accumulated_yield    : 0,
            locked_until         : v3,
            is_from_hometovault  : false,
            hometovault_vault_id : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.total_staked, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        0x2::table::add<address, StakePosition>(&mut arg0.stakes, v1, v4);
        arg0.total_stakers = arg0.total_stakers + 1;
        let v5 = Staked{
            vault_id            : 0x2::object::uid_to_address(&arg0.id),
            staker              : v1,
            amount              : v0,
            lockup_end          : v3,
            is_from_hometovault : false,
            timestamp           : v2,
        };
        0x2::event::emit<Staked>(v5);
    }

    public entry fun stake_from_hometovault(arg0: &mut HedgeSwapVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_frozen, 2057);
        assert!(!arg0.is_locked, 2052);
        assert!(arg0.is_active, 2054);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 2050);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = v2 + arg0.min_lockup_seconds * 1000;
        assert!(!0x2::table::contains<address, StakePosition>(&arg0.stakes, v1), 2055);
        let v4 = StakePosition{
            amount               : v0,
            start_time           : v2,
            last_yield_claim     : v2,
            accumulated_yield    : 0,
            locked_until         : v3,
            is_from_hometovault  : true,
            hometovault_vault_id : 0x1::option::some<0x2::object::ID>(arg2),
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.total_staked, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        0x2::table::add<address, StakePosition>(&mut arg0.stakes, v1, v4);
        arg0.total_stakers = arg0.total_stakers + 1;
        let v5 = Staked{
            vault_id            : 0x2::object::uid_to_address(&arg0.id),
            staker              : v1,
            amount              : v0,
            lockup_end          : v3,
            is_from_hometovault : true,
            timestamp           : v2,
        };
        0x2::event::emit<Staked>(v5);
    }

    public entry fun unstake(arg0: &mut HedgeSwapVault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_frozen, 2057);
        assert!(!arg0.is_locked, 2052);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, StakePosition>(&arg0.stakes, v0), 2056);
        let v1 = 0x2::table::remove<address, StakePosition>(&mut arg0.stakes, v0);
        let v2 = 0x2::clock::timestamp_ms(arg1);
        assert!(!v1.is_from_hometovault, 2049);
        assert!(v2 >= v1.locked_until, 2053);
        let v3 = calculate_yield(v1.amount, v2 - v1.last_yield_claim, arg0.apy_basis_points);
        let v4 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.total_staked, v1.amount);
        if (v3 > 0 && 0x2::balance::value<0x2::sui::SUI>(&arg0.accumulated_yield) >= v3) {
            0x2::balance::join<0x2::sui::SUI>(&mut v4, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.accumulated_yield, v3));
        };
        arg0.total_stakers = arg0.total_stakers - 1;
        let v5 = Unstaked{
            vault_id      : 0x2::object::uid_to_address(&arg0.id),
            staker        : v0,
            amount        : v1.amount,
            yield_claimed : v3,
            timestamp     : v2,
        };
        0x2::event::emit<Unstaked>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v4, arg2), v0);
    }

    public fun unstake_for_borrower(arg0: &mut HedgeSwapVault, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg3) == @0x0, 2049);
        assert!(!arg0.is_frozen, 2057);
        assert!(!arg0.is_locked, 2052);
        assert!(0x2::table::contains<address, StakePosition>(&arg0.stakes, arg1), 2056);
        let v0 = 0x2::table::remove<address, StakePosition>(&mut arg0.stakes, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = calculate_yield(v0.amount, v1 - v0.last_yield_claim, arg0.apy_basis_points);
        let v3 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.total_staked, v0.amount);
        if (v2 > 0 && 0x2::balance::value<0x2::sui::SUI>(&arg0.accumulated_yield) >= v2) {
            0x2::balance::join<0x2::sui::SUI>(&mut v3, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.accumulated_yield, v2));
        };
        arg0.total_stakers = arg0.total_stakers - 1;
        let v4 = Unstaked{
            vault_id      : 0x2::object::uid_to_address(&arg0.id),
            staker        : arg1,
            amount        : v0.amount,
            yield_claimed : v2,
            timestamp     : v1,
        };
        0x2::event::emit<Unstaked>(v4);
        0x2::coin::from_balance<0x2::sui::SUI>(v3, arg3)
    }

    public fun update_hometovault_address(arg0: &VaultAdminCap, arg1: address) {
        abort 2049
    }

    // decompiled from Move bytecode v6
}

