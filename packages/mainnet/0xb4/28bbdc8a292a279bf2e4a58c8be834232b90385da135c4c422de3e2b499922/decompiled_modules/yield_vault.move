module 0xb428bbdc8a292a279bf2e4a58c8be834232b90385da135c4c422de3e2b499922::yield_vault {
    struct ProtocolWhitelist has key {
        id: 0x2::object::UID,
        approved_protocols: 0x2::table::Table<address, ProtocolMetadata>,
        protocol_count: u64,
        admin: address,
    }

    struct ProtocolMetadata has copy, drop, store {
        protocol_address: address,
        protocol_name: vector<u8>,
        whitelisted_at: u64,
        total_delegated: u64,
        active: bool,
    }

    struct YieldVault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        lp_tokens: 0x2::balance::Balance<0xb428bbdc8a292a279bf2e4a58c8be834232b90385da135c4c422de3e2b499922::dex::LP<T0, T1>>,
        delegations: 0x2::table::Table<address, DelegationRecord>,
        total_delegated: u64,
        total_yield_earned: u64,
        vault_apy_bps: u64,
        risk_tier: u8,
    }

    struct DelegationRecord has copy, drop, store {
        borrower: address,
        protocol: address,
        delegated_amount: u64,
        delegation_timestamp: u64,
        lp_share: u64,
        yield_earned: u64,
        is_active: bool,
    }

    struct VaultAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ProtocolWhitelisted has copy, drop {
        protocol_address: address,
        protocol_name: vector<u8>,
        timestamp: u64,
    }

    struct ProtocolRemoved has copy, drop {
        protocol_address: address,
        reason: vector<u8>,
        timestamp: u64,
    }

    struct CollateralDelegated has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        protocol: address,
        amount: u64,
        lp_tokens_minted: u64,
        timestamp: u64,
    }

    struct CollateralUndelegated has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        protocol: address,
        amount_returned: u64,
        yield_earned: u64,
        timestamp: u64,
    }

    struct YieldHarvested has copy, drop {
        vault_id: 0x2::object::ID,
        borrower: address,
        yield_amount: u64,
        timestamp: u64,
    }

    public fun create_yield_vault<T0, T1>(arg0: &VaultAdminCap, arg1: 0x2::object::ID, arg2: u64, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = YieldVault<T0, T1>{
            id                 : 0x2::object::new(arg4),
            pool_id            : arg1,
            lp_tokens          : 0x2::balance::zero<0xb428bbdc8a292a279bf2e4a58c8be834232b90385da135c4c422de3e2b499922::dex::LP<T0, T1>>(),
            delegations        : 0x2::table::new<address, DelegationRecord>(arg4),
            total_delegated    : 0,
            total_yield_earned : 0,
            vault_apy_bps      : arg2,
            risk_tier          : arg3,
        };
        0x2::transfer::share_object<YieldVault<T0, T1>>(v0);
    }

    public fun get_delegation_info<T0, T1>(arg0: &YieldVault<T0, T1>, arg1: address) : (address, u64, u64, u64, u64, bool) {
        if (0x2::table::contains<address, DelegationRecord>(&arg0.delegations, arg1)) {
            let v6 = 0x2::table::borrow<address, DelegationRecord>(&arg0.delegations, arg1);
            (v6.protocol, v6.delegated_amount, v6.delegation_timestamp, v6.lp_share, v6.yield_earned, v6.is_active)
        } else {
            (@0x0, 0, 0, 0, 0, false)
        }
    }

    public fun get_stake_balance<T0, T1>(arg0: &YieldVault<T0, T1>, arg1: &0xb428bbdc8a292a279bf2e4a58c8be834232b90385da135c4c422de3e2b499922::dex::Pool<T0, T1>, arg2: address) : u64 {
        if (0x2::table::contains<address, DelegationRecord>(&arg0.delegations, arg2)) {
            let v1 = 0x2::table::borrow<address, DelegationRecord>(&arg0.delegations, arg2);
            if (v1.is_active) {
                let (v2, _) = 0xb428bbdc8a292a279bf2e4a58c8be834232b90385da135c4c422de3e2b499922::dex::get_reserves<T0, T1>(arg1);
                v1.lp_share * v2 / 0xb428bbdc8a292a279bf2e4a58c8be834232b90385da135c4c422de3e2b499922::dex::get_lp_supply<T0, T1>(arg1)
            } else {
                0
            }
        } else {
            0
        }
    }

    public fun get_strategy_metadata<T0, T1>(arg0: &YieldVault<T0, T1>) : (u64, u8, u64, u64) {
        (arg0.vault_apy_bps, arg0.risk_tier, arg0.total_delegated, arg0.total_yield_earned)
    }

    public fun get_total_delegated<T0, T1>(arg0: &YieldVault<T0, T1>) : u64 {
        arg0.total_delegated
    }

    public fun get_vault_apy<T0, T1>(arg0: &YieldVault<T0, T1>) : u64 {
        arg0.vault_apy_bps
    }

    public entry fun harvest_yield<T0, T1>(arg0: &mut YieldVault<T0, T1>, arg1: &0xb428bbdc8a292a279bf2e4a58c8be834232b90385da135c4c422de3e2b499922::dex::Pool<T0, T1>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, DelegationRecord>(&arg0.delegations, arg2), 6);
        let v0 = 0x2::table::borrow_mut<address, DelegationRecord>(&mut arg0.delegations, arg2);
        assert!(v0.is_active, 6);
        assert!(v0.protocol == 0x2::tx_context::sender(arg4), 1);
        let (v1, _) = 0xb428bbdc8a292a279bf2e4a58c8be834232b90385da135c4c422de3e2b499922::dex::get_reserves<T0, T1>(arg1);
        let v3 = v0.lp_share * v1 / 0xb428bbdc8a292a279bf2e4a58c8be834232b90385da135c4c422de3e2b499922::dex::get_lp_supply<T0, T1>(arg1);
        let v4 = if (v3 > v0.delegated_amount) {
            v3 - v0.delegated_amount
        } else {
            0
        };
        v0.yield_earned = v4;
        let v5 = YieldHarvested{
            vault_id     : 0x2::object::id<YieldVault<T0, T1>>(arg0),
            borrower     : arg2,
            yield_amount : v4,
            timestamp    : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<YieldHarvested>(v5);
    }

    public fun has_active_delegation<T0, T1>(arg0: &YieldVault<T0, T1>, arg1: address) : bool {
        0x2::table::contains<address, DelegationRecord>(&arg0.delegations, arg1) && 0x2::table::borrow<address, DelegationRecord>(&arg0.delegations, arg1).is_active
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolWhitelist{
            id                 : 0x2::object::new(arg0),
            approved_protocols : 0x2::table::new<address, ProtocolMetadata>(arg0),
            protocol_count     : 0,
            admin              : 0x2::tx_context::sender(arg0),
        };
        let v1 = VaultAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<VaultAdminCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<ProtocolWhitelist>(v0);
    }

    public fun is_protocol_whitelisted(arg0: &ProtocolWhitelist, arg1: address) : bool {
        0x2::table::contains<address, ProtocolMetadata>(&arg0.approved_protocols, arg1) && 0x2::table::borrow<address, ProtocolMetadata>(&arg0.approved_protocols, arg1).active
    }

    public entry fun remove_protocol(arg0: &mut ProtocolWhitelist, arg1: address, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 1);
        assert!(0x2::table::contains<address, ProtocolMetadata>(&arg0.approved_protocols, arg1), 2);
        0x2::table::borrow_mut<address, ProtocolMetadata>(&mut arg0.approved_protocols, arg1).active = false;
        let v0 = ProtocolRemoved{
            protocol_address : arg1,
            reason           : arg2,
            timestamp        : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<ProtocolRemoved>(v0);
    }

    public fun stake_delegated_collateral<T0, T1>(arg0: &mut YieldVault<T0, T1>, arg1: &mut ProtocolWhitelist, arg2: &mut 0xb428bbdc8a292a279bf2e4a58c8be834232b90385da135c4c422de3e2b499922::dex::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(is_protocol_whitelisted(arg1, v0), 2);
        let v1 = 0x2::coin::value<T0>(&arg3);
        assert!(v1 >= 1000000000, 5);
        assert!(!0x2::table::contains<address, DelegationRecord>(&arg0.delegations, arg5), 7);
        let v2 = 0xb428bbdc8a292a279bf2e4a58c8be834232b90385da135c4c422de3e2b499922::dex::add_liquidity<T0, T1>(arg2, arg3, arg4, 0, arg7);
        let v3 = 0x2::coin::value<0xb428bbdc8a292a279bf2e4a58c8be834232b90385da135c4c422de3e2b499922::dex::LP<T0, T1>>(&v2);
        0x2::balance::join<0xb428bbdc8a292a279bf2e4a58c8be834232b90385da135c4c422de3e2b499922::dex::LP<T0, T1>>(&mut arg0.lp_tokens, 0x2::coin::into_balance<0xb428bbdc8a292a279bf2e4a58c8be834232b90385da135c4c422de3e2b499922::dex::LP<T0, T1>>(v2));
        let v4 = DelegationRecord{
            borrower             : arg5,
            protocol             : v0,
            delegated_amount     : v1,
            delegation_timestamp : 0x2::clock::timestamp_ms(arg6) / 1000,
            lp_share             : v3,
            yield_earned         : 0,
            is_active            : true,
        };
        0x2::table::add<address, DelegationRecord>(&mut arg0.delegations, arg5, v4);
        arg0.total_delegated = arg0.total_delegated + v1;
        let v5 = 0x2::table::borrow_mut<address, ProtocolMetadata>(&mut arg1.approved_protocols, v0);
        v5.total_delegated = v5.total_delegated + v1;
        let v6 = CollateralDelegated{
            vault_id         : 0x2::object::id<YieldVault<T0, T1>>(arg0),
            borrower         : arg5,
            protocol         : v0,
            amount           : v1,
            lp_tokens_minted : v3,
            timestamp        : 0x2::clock::timestamp_ms(arg6) / 1000,
        };
        0x2::event::emit<CollateralDelegated>(v6);
    }

    public fun unstake_delegated_collateral<T0, T1>(arg0: &mut YieldVault<T0, T1>, arg1: &mut ProtocolWhitelist, arg2: &mut 0xb428bbdc8a292a279bf2e4a58c8be834232b90385da135c4c422de3e2b499922::dex::Pool<T0, T1>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(is_protocol_whitelisted(arg1, v0), 2);
        assert!(0x2::table::contains<address, DelegationRecord>(&arg0.delegations, arg3), 6);
        let v1 = 0x2::table::borrow_mut<address, DelegationRecord>(&mut arg0.delegations, arg3);
        assert!(v1.is_active, 6);
        assert!(v1.protocol == v0, 1);
        let v2 = v1.delegated_amount;
        let (v3, v4) = 0xb428bbdc8a292a279bf2e4a58c8be834232b90385da135c4c422de3e2b499922::dex::remove_liquidity<T0, T1>(arg2, 0x2::coin::from_balance<0xb428bbdc8a292a279bf2e4a58c8be834232b90385da135c4c422de3e2b499922::dex::LP<T0, T1>>(0x2::balance::split<0xb428bbdc8a292a279bf2e4a58c8be834232b90385da135c4c422de3e2b499922::dex::LP<T0, T1>>(&mut arg0.lp_tokens, v1.lp_share), arg5), 0, 0, arg5);
        let v5 = v3;
        let v6 = 0x2::coin::value<T0>(&v5);
        let v7 = if (v6 > v2) {
            v6 - v2
        } else {
            0
        };
        v1.is_active = false;
        v1.yield_earned = v7;
        arg0.total_delegated = arg0.total_delegated - v2;
        arg0.total_yield_earned = arg0.total_yield_earned + v7;
        let v8 = 0x2::table::borrow_mut<address, ProtocolMetadata>(&mut arg1.approved_protocols, v0);
        v8.total_delegated = v8.total_delegated - v2;
        let v9 = CollateralUndelegated{
            vault_id        : 0x2::object::id<YieldVault<T0, T1>>(arg0),
            borrower        : arg3,
            protocol        : v0,
            amount_returned : v6,
            yield_earned    : v7,
            timestamp       : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<CollateralUndelegated>(v9);
        (v5, v4, v7)
    }

    public entry fun whitelist_protocol(arg0: &mut ProtocolWhitelist, arg1: address, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 1);
        let v0 = ProtocolMetadata{
            protocol_address : arg1,
            protocol_name    : arg2,
            whitelisted_at   : 0x2::clock::timestamp_ms(arg3) / 1000,
            total_delegated  : 0,
            active           : true,
        };
        0x2::table::add<address, ProtocolMetadata>(&mut arg0.approved_protocols, arg1, v0);
        arg0.protocol_count = arg0.protocol_count + 1;
        let v1 = ProtocolWhitelisted{
            protocol_address : arg1,
            protocol_name    : arg2,
            timestamp        : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<ProtocolWhitelisted>(v1);
    }

    // decompiled from Move bytecode v6
}

