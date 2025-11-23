module 0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::collateral_delegation {
    struct DelegationInfo has copy, drop, store {
        strategy_address: address,
        delegated_amount: u64,
        start_timestamp: u64,
        is_active: bool,
        accumulated_yield: u64,
        last_yield_update: u64,
    }

    struct StrategyWhitelist has key {
        id: 0x2::object::UID,
        approved_strategies: 0x2::table::Table<address, StrategyMetadata>,
        strategy_count: u64,
        admin: address,
    }

    struct StrategyMetadata has copy, drop, store {
        strategy_address: address,
        strategy_name: vector<u8>,
        protocol_name: vector<u8>,
        expected_apy_bps: u64,
        risk_tier: u8,
        total_delegated: u64,
        active: bool,
        added_timestamp: u64,
    }

    struct VaultDelegation has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        borrower: address,
        delegation_info: 0x1::option::Option<DelegationInfo>,
        total_collateral: u64,
        delegated_amount: u64,
        passive_amount: u64,
    }

    struct DelegationCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct DelegationStarted has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        strategy_address: address,
        delegated_amount: u64,
        passive_amount: u64,
        timestamp: u64,
    }

    struct DelegationEnded has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        strategy_address: address,
        returned_amount: u64,
        yield_earned: u64,
        timestamp: u64,
    }

    struct YieldHarvested has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        strategy_address: address,
        yield_amount: u64,
        timestamp: u64,
    }

    struct StrategyWhitelisted has copy, drop {
        strategy_address: address,
        strategy_name: vector<u8>,
        protocol_name: vector<u8>,
        timestamp: u64,
    }

    struct StrategyRemoved has copy, drop {
        strategy_address: address,
        reason: vector<u8>,
        timestamp: u64,
    }

    public entry fun add_strategy_to_whitelist(arg0: &mut StrategyWhitelist, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u8, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg0.admin, 1);
        let v0 = StrategyMetadata{
            strategy_address : arg1,
            strategy_name    : arg2,
            protocol_name    : arg3,
            expected_apy_bps : arg4,
            risk_tier        : arg5,
            total_delegated  : 0,
            active           : true,
            added_timestamp  : 0x2::clock::timestamp_ms(arg6) / 1000,
        };
        0x2::table::add<address, StrategyMetadata>(&mut arg0.approved_strategies, arg1, v0);
        arg0.strategy_count = arg0.strategy_count + 1;
        let v1 = StrategyWhitelisted{
            strategy_address : arg1,
            strategy_name    : arg2,
            protocol_name    : arg3,
            timestamp        : 0x2::clock::timestamp_ms(arg6) / 1000,
        };
        0x2::event::emit<StrategyWhitelisted>(v1);
    }

    public entry fun delegate_to_strategy(arg0: &mut VaultDelegation, arg1: &mut StrategyWhitelist, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.borrower, 1);
        assert!(0x1::option::is_none<DelegationInfo>(&arg0.delegation_info), 3);
        assert!(arg3 > 0, 7);
        assert!(is_strategy_whitelisted(arg1, arg2), 6);
        assert!(arg0.passive_amount - arg3 >= arg0.total_collateral * 20 / 100, 9);
        assert!(arg3 <= arg0.passive_amount, 2);
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let v1 = DelegationInfo{
            strategy_address  : arg2,
            delegated_amount  : arg3,
            start_timestamp   : v0,
            is_active         : true,
            accumulated_yield : 0,
            last_yield_update : v0,
        };
        0x1::option::fill<DelegationInfo>(&mut arg0.delegation_info, v1);
        arg0.delegated_amount = arg3;
        arg0.passive_amount = arg0.passive_amount - arg3;
        let v2 = 0x2::table::borrow_mut<address, StrategyMetadata>(&mut arg1.approved_strategies, arg2);
        v2.total_delegated = v2.total_delegated + arg3;
        let v3 = DelegationStarted{
            vault_id         : arg0.vault_id,
            borrower         : arg0.borrower,
            strategy_address : arg2,
            delegated_amount : arg3,
            passive_amount   : arg0.passive_amount,
            timestamp        : v0,
        };
        0x2::event::emit<DelegationStarted>(v3);
    }

    public fun get_delegated_amount(arg0: &VaultDelegation) : u64 {
        arg0.delegated_amount
    }

    public fun get_delegated_info(arg0: &VaultDelegation) : (address, u64, u64, u64, bool) {
        if (0x1::option::is_some<DelegationInfo>(&arg0.delegation_info)) {
            let v5 = 0x1::option::borrow<DelegationInfo>(&arg0.delegation_info);
            (v5.strategy_address, arg0.delegated_amount, arg0.passive_amount, arg0.total_collateral, v5.is_active)
        } else {
            (@0x0, 0, arg0.passive_amount, arg0.total_collateral, false)
        }
    }

    public fun get_delegation_yield_info(arg0: &VaultDelegation) : (u64, u64, u64) {
        if (0x1::option::is_some<DelegationInfo>(&arg0.delegation_info)) {
            let v3 = 0x1::option::borrow<DelegationInfo>(&arg0.delegation_info);
            (v3.accumulated_yield, v3.start_timestamp, v3.last_yield_update)
        } else {
            (0, 0, 0)
        }
    }

    public fun get_passive_amount(arg0: &VaultDelegation) : u64 {
        arg0.passive_amount
    }

    public fun get_strategy_metadata(arg0: &StrategyWhitelist, arg1: address) : (vector<u8>, vector<u8>, u64, u8, u64, bool) {
        assert!(0x2::table::contains<address, StrategyMetadata>(&arg0.approved_strategies, arg1), 6);
        let v0 = 0x2::table::borrow<address, StrategyMetadata>(&arg0.approved_strategies, arg1);
        (v0.strategy_name, v0.protocol_name, v0.expected_apy_bps, v0.risk_tier, v0.total_delegated, v0.active)
    }

    public fun get_total_collateral(arg0: &VaultDelegation) : u64 {
        arg0.total_collateral
    }

    public fun get_whitelist_count(arg0: &StrategyWhitelist) : u64 {
        arg0.strategy_count
    }

    public entry fun harvest_strategy_yield(arg0: &mut VaultDelegation, arg1: &StrategyWhitelist, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.borrower, 1);
        assert!(0x1::option::is_some<DelegationInfo>(&arg0.delegation_info), 4);
        let v0 = 0x1::option::borrow_mut<DelegationInfo>(&mut arg0.delegation_info);
        assert!(v0.is_active, 4);
        let v1 = 0x2::clock::timestamp_ms(arg3) / 1000;
        v0.accumulated_yield = v0.accumulated_yield + arg2;
        v0.last_yield_update = v1;
        let v2 = YieldHarvested{
            vault_id         : arg0.vault_id,
            borrower         : arg0.borrower,
            strategy_address : v0.strategy_address,
            yield_amount     : arg2,
            timestamp        : v1,
        };
        0x2::event::emit<YieldHarvested>(v2);
    }

    public fun has_active_delegation(arg0: &VaultDelegation) : bool {
        0x1::option::is_some<DelegationInfo>(&arg0.delegation_info) && 0x1::option::borrow<DelegationInfo>(&arg0.delegation_info).is_active
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StrategyWhitelist{
            id                  : 0x2::object::new(arg0),
            approved_strategies : 0x2::table::new<address, StrategyMetadata>(arg0),
            strategy_count      : 0,
            admin               : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<StrategyWhitelist>(v0);
    }

    public fun initialize_vault_delegation(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : DelegationCap {
        let v0 = VaultDelegation{
            id               : 0x2::object::new(arg3),
            vault_id         : arg0,
            borrower         : arg1,
            delegation_info  : 0x1::option::none<DelegationInfo>(),
            total_collateral : arg2,
            delegated_amount : 0,
            passive_amount   : arg2,
        };
        let v1 = DelegationCap{
            id       : 0x2::object::new(arg3),
            vault_id : arg0,
        };
        0x2::transfer::share_object<VaultDelegation>(v0);
        v1
    }

    public fun is_strategy_whitelisted(arg0: &StrategyWhitelist, arg1: address) : bool {
        0x2::table::contains<address, StrategyMetadata>(&arg0.approved_strategies, arg1) && 0x2::table::borrow<address, StrategyMetadata>(&arg0.approved_strategies, arg1).active
    }

    public entry fun remove_strategy_from_whitelist(arg0: &mut StrategyWhitelist, arg1: address, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 1);
        assert!(0x2::table::contains<address, StrategyMetadata>(&arg0.approved_strategies, arg1), 6);
        0x2::table::borrow_mut<address, StrategyMetadata>(&mut arg0.approved_strategies, arg1).active = false;
        let v0 = StrategyRemoved{
            strategy_address : arg1,
            reason           : arg2,
            timestamp        : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<StrategyRemoved>(v0);
    }

    public fun transfer_to_strategy(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
    }

    public fun undelegate_from_strategy(arg0: &mut VaultDelegation, arg1: &mut StrategyWhitelist, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : u64 {
        assert!(0x1::option::is_some<DelegationInfo>(&arg0.delegation_info), 4);
        let v0 = 0x1::option::borrow_mut<DelegationInfo>(&mut arg0.delegation_info);
        assert!(v0.is_active, 4);
        let v1 = v0.strategy_address;
        v0.is_active = false;
        v0.accumulated_yield = v0.accumulated_yield + arg3;
        arg0.delegated_amount = 0;
        arg0.passive_amount = arg0.passive_amount + arg2;
        let v2 = 0x2::table::borrow_mut<address, StrategyMetadata>(&mut arg1.approved_strategies, v1);
        v2.total_delegated = v2.total_delegated - v0.delegated_amount;
        let v3 = DelegationEnded{
            vault_id         : arg0.vault_id,
            borrower         : arg0.borrower,
            strategy_address : v1,
            returned_amount  : arg2,
            yield_earned     : arg3,
            timestamp        : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<DelegationEnded>(v3);
        arg2
    }

    // decompiled from Move bytecode v6
}

