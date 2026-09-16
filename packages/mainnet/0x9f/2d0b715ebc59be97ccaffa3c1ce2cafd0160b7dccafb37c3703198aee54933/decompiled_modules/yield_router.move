module 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router {
    struct YieldRouter has key {
        id: 0x2::object::UID,
        auto_yield_default_off: bool,
        protocol_yield_skim_bps: u64,
        paused: bool,
    }

    struct RouterFeeConfig has key {
        id: 0x2::object::UID,
        owner: address,
        profit_fee_bps: u64,
        profit_fee_cap_usd_micros: u64,
        profit_fee_enabled: bool,
        treasury: address,
    }

    struct FeeConfigCreatorCap has key {
        id: 0x2::object::UID,
    }

    struct RouterAdminAnchorKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RouterAdminAnchor has copy, drop, store {
        admin_cap_id: 0x2::object::ID,
        governance: address,
    }

    struct RouterAdminCap has key {
        id: 0x2::object::UID,
        router_id: 0x2::object::ID,
    }

    struct DepositPlanned has copy, drop {
        owner: address,
        adapter_id: vector<u8>,
        amount_micros: u64,
        fee_micros: u64,
    }

    struct WithdrawPlanned has copy, drop {
        owner: address,
        adapter_id: vector<u8>,
        amount_micros: u64,
        fee_micros: u64,
    }

    struct HarvestSkimmed has copy, drop {
        owner: address,
        adapter_id: vector<u8>,
        gross_yield_micros: u64,
        protocol_skim_micros: u64,
        net_yield_micros: u64,
        fee_bps: u64,
    }

    struct DepositPlannedV2 has copy, drop {
        version: u64,
        owner: address,
        adapter_id: vector<u8>,
        amount_micros: u64,
        fee_micros: u64,
    }

    struct WithdrawPlannedV2 has copy, drop {
        version: u64,
        owner: address,
        adapter_id: vector<u8>,
        amount_micros: u64,
        fee_micros: u64,
    }

    struct HarvestSkimmedV2 has copy, drop {
        version: u64,
        owner: address,
        adapter_id: vector<u8>,
        gross_yield_micros: u64,
        protocol_skim_micros: u64,
        net_yield_micros: u64,
        fee_bps: u64,
    }

    struct RouterAdminCreated has copy, drop {
        router_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        governance: address,
    }

    struct RouterPauseChanged has copy, drop {
        router_id: 0x2::object::ID,
        paused: bool,
    }

    struct ProfitFeeConfigured has copy, drop {
        owner: address,
        profit_fee_bps: u64,
        profit_fee_cap_usd_micros: u64,
        profit_fee_enabled: bool,
        treasury: address,
    }

    struct ForwardExecuted has copy, drop {
        owner: address,
        adapter_id: vector<u8>,
        amount: u64,
        fee: u64,
    }

    fun assert_governance_recipient(arg0: address) {
        assert!(arg0 != @0x0, 16);
        assert!(arg0 != @0xc7166e26852d600068350ca65b6252880a3e17b540e2080e683f796303e1d491, 16);
    }

    fun assert_router_admin(arg0: &RouterAdminCap, arg1: &YieldRouter) {
        assert!(arg0.router_id == 0x2::object::id<YieldRouter>(arg1), 14);
        let v0 = RouterAdminAnchorKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<RouterAdminAnchorKey>(&arg1.id, v0), 14);
        let v1 = RouterAdminAnchorKey{dummy_field: false};
        assert!(0x2::dynamic_field::borrow<RouterAdminAnchorKey, RouterAdminAnchor>(&arg1.id, v1).admin_cap_id == 0x2::object::id<RouterAdminCap>(arg0), 14);
    }

    public fun auto_yield_default_off(arg0: &YieldRouter) : bool {
        arg0.auto_yield_default_off
    }

    public fun bootstrap_router_admin(arg0: &mut YieldRouter, arg1: &0x2::package::UpgradeCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id_address<0x2::package::UpgradeCap>(arg1) == @0xfb7a7925da9332ab039cd7296828f5ebaef5ff7246f1bfa051d0a409fa15eb2d, 13);
        assert!(0x2::object::id_address<YieldRouter>(arg0) == @0xa0722a3dd74837d9daa4a82c2ffd7ed4c1b6013d57a362a42cb5a6c9c004db6f, 14);
        assert_governance_recipient(arg2);
        0x2::transfer::transfer<RouterAdminCap>(bootstrap_router_admin_internal(arg0, arg2, arg3), arg2);
    }

    fun bootstrap_router_admin_internal(arg0: &mut YieldRouter, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : RouterAdminCap {
        let v0 = RouterAdminAnchorKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<RouterAdminAnchorKey>(&arg0.id, v0), 15);
        let v1 = 0x2::object::id<YieldRouter>(arg0);
        let v2 = RouterAdminCap{
            id        : 0x2::object::new(arg2),
            router_id : v1,
        };
        let v3 = 0x2::object::id<RouterAdminCap>(&v2);
        let v4 = RouterAdminAnchorKey{dummy_field: false};
        let v5 = RouterAdminAnchor{
            admin_cap_id : v3,
            governance   : arg1,
        };
        0x2::dynamic_field::add<RouterAdminAnchorKey, RouterAdminAnchor>(&mut arg0.id, v4, v5);
        let v6 = RouterAdminCreated{
            router_id    : v1,
            admin_cap_id : v3,
            governance   : arg1,
        };
        0x2::event::emit<RouterAdminCreated>(v6);
        v2
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = YieldRouter{
            id                      : 0x2::object::new(arg0),
            auto_yield_default_off  : true,
            protocol_yield_skim_bps : 500,
            paused                  : false,
        };
        0x2::transfer::share_object<YieldRouter>(v0);
    }

    public fun create_fee_config(arg0: FeeConfigCreatorCap, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0xc7166e26852d600068350ca65b6252880a3e17b540e2080e683f796303e1d491, 6);
        let FeeConfigCreatorCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = RouterFeeConfig{
            id                        : 0x2::object::new(arg1),
            owner                     : @0xc7166e26852d600068350ca65b6252880a3e17b540e2080e683f796303e1d491,
            profit_fee_bps            : 100,
            profit_fee_cap_usd_micros : 10000000,
            profit_fee_enabled        : false,
            treasury                  : @0xc7166e26852d600068350ca65b6252880a3e17b540e2080e683f796303e1d491,
        };
        0x2::transfer::share_object<RouterFeeConfig>(v1);
    }

    public entry fun forward_deposit<T0>(arg0: &YieldRouter, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistry, arg2: vector<u8>, arg3: 0x2::coin::Coin<T0>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        assert!(0x2::coin::value<T0>(&arg3) > 0, 2);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::assert_active(arg1, arg2);
        abort 5
    }

    public entry fun forward_deposit_v2<T0>(arg0: &YieldRouter, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg2: vector<u8>, arg3: 0x2::coin::Coin<T0>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        assert!(0x2::coin::value<T0>(&arg3) > 0, 2);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::assert_active_v2(arg1, arg2);
        abort 5
    }

    public entry fun forward_withdraw<T0>(arg0: &YieldRouter, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistry, arg2: &RouterFeeConfig, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::assert_active(arg1, arg3);
        abort 5
    }

    public entry fun forward_withdraw_v2<T0>(arg0: &YieldRouter, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg2: &RouterFeeConfig, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::assert_active_v2(arg1, arg3);
        abort 5
    }

    public fun is_paused(arg0: &YieldRouter) : bool {
        arg0.paused
    }

    public entry fun mint_fee_config_creator_cap(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0xc7166e26852d600068350ca65b6252880a3e17b540e2080e683f796303e1d491, 6);
        let v0 = FeeConfigCreatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<FeeConfigCreatorCap>(v0, @0xc7166e26852d600068350ca65b6252880a3e17b540e2080e683f796303e1d491);
    }

    public fun owner(arg0: &RouterFeeConfig) : address {
        arg0.owner
    }

    public fun plan_deposit(arg0: &YieldRouter, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistry, arg2: vector<u8>, arg3: u64, arg4: address, arg5: bool) {
        abort 11
    }

    public fun plan_deposit_v2(arg0: &YieldRouter, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg2: vector<u8>, arg3: u64, arg4: address, arg5: bool, arg6: &0x2::tx_context::TxContext) {
        assert!(arg4 == 0x2::tx_context::sender(arg6), 3);
        assert!(!arg0.paused, 1);
        assert!(arg3 > 0, 2);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::assert_active_v2(arg1, arg2);
        let v0 = DepositPlannedV2{
            version       : 2,
            owner         : arg4,
            adapter_id    : arg2,
            amount_micros : arg3,
            fee_micros    : 0,
        };
        0x2::event::emit<DepositPlannedV2>(v0);
    }

    public fun plan_harvest_skim(arg0: &YieldRouter, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistry, arg2: vector<u8>, arg3: u64, arg4: address) {
        abort 11
    }

    public fun plan_harvest_skim_v2(arg0: &YieldRouter, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg2: vector<u8>, arg3: u64, arg4: address) {
        abort 11
    }

    public fun plan_withdraw(arg0: &YieldRouter, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistry, arg2: vector<u8>, arg3: u64, arg4: address) {
        abort 11
    }

    public fun plan_withdraw_authenticated(arg0: &YieldRouter, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistry, arg2: vector<u8>, arg3: u64, arg4: address, arg5: &0x2::tx_context::TxContext) {
        abort 11
    }

    public fun plan_withdraw_authenticated_v2(arg0: &YieldRouter, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg2: vector<u8>, arg3: u64, arg4: address, arg5: &0x2::tx_context::TxContext) {
        assert!(arg4 == 0x2::tx_context::sender(arg5), 3);
        assert!(arg3 > 0, 2);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::assert_active_v2(arg1, arg2);
        let v0 = WithdrawPlannedV2{
            version       : 2,
            owner         : arg4,
            adapter_id    : arg2,
            amount_micros : arg3,
            fee_micros    : 0,
        };
        0x2::event::emit<WithdrawPlannedV2>(v0);
    }

    public fun profit_fee_bps(arg0: &RouterFeeConfig) : u64 {
        arg0.profit_fee_bps
    }

    public fun profit_fee_cap_usd_micros(arg0: &RouterFeeConfig) : u64 {
        arg0.profit_fee_cap_usd_micros
    }

    public fun profit_fee_enabled(arg0: &RouterFeeConfig) : bool {
        arg0.profit_fee_enabled
    }

    public fun protocol_yield_skim_bps(arg0: &YieldRouter) : u64 {
        arg0.protocol_yield_skim_bps
    }

    public fun quote_profit_fee(arg0: &RouterFeeConfig, arg1: u64) : u64 {
        let v0 = if (!arg0.profit_fee_enabled) {
            true
        } else if (arg0.profit_fee_bps == 0) {
            true
        } else {
            arg1 == 0
        };
        if (v0) {
            return 0
        };
        let v1 = (((arg1 as u128) * (arg0.profit_fee_bps as u128) / (10000 as u128)) as u64);
        if (arg0.profit_fee_cap_usd_micros != 0 && v1 > arg0.profit_fee_cap_usd_micros) {
            arg0.profit_fee_cap_usd_micros
        } else {
            v1
        }
    }

    public(friend) fun record_harvest_skim_v2_for_position(arg0: &YieldRouter, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::Position, arg3: vector<u8>, arg4: u64) {
        abort 11
    }

    public fun router_admin_cap_id(arg0: &YieldRouter) : 0x1::option::Option<0x2::object::ID> {
        let v0 = RouterAdminAnchorKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<RouterAdminAnchorKey>(&arg0.id, v0)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        let v1 = RouterAdminAnchorKey{dummy_field: false};
        0x1::option::some<0x2::object::ID>(0x2::dynamic_field::borrow<RouterAdminAnchorKey, RouterAdminAnchor>(&arg0.id, v1).admin_cap_id)
    }

    public fun router_admin_governance(arg0: &YieldRouter) : 0x1::option::Option<address> {
        let v0 = RouterAdminAnchorKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<RouterAdminAnchorKey>(&arg0.id, v0)) {
            return 0x1::option::none<address>()
        };
        let v1 = RouterAdminAnchorKey{dummy_field: false};
        0x1::option::some<address>(0x2::dynamic_field::borrow<RouterAdminAnchorKey, RouterAdminAnchor>(&arg0.id, v1).governance)
    }

    public fun set_paused(arg0: &RouterAdminCap, arg1: &mut YieldRouter, arg2: bool) {
        assert_router_admin(arg0, arg1);
        arg1.paused = arg2;
        let v0 = RouterPauseChanged{
            router_id : 0x2::object::id<YieldRouter>(arg1),
            paused    : arg2,
        };
        0x2::event::emit<RouterPauseChanged>(v0);
    }

    public entry fun set_profit_fee(arg0: &mut RouterFeeConfig, arg1: u64, arg2: u64, arg3: bool, arg4: address, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 3);
        assert!(arg1 <= 200, 4);
        assert!(arg4 != @0x0, 10);
        arg0.profit_fee_bps = arg1;
        arg0.profit_fee_cap_usd_micros = arg2;
        arg0.profit_fee_enabled = arg3;
        arg0.treasury = arg4;
        let v0 = ProfitFeeConfigured{
            owner                     : arg0.owner,
            profit_fee_bps            : arg1,
            profit_fee_cap_usd_micros : arg2,
            profit_fee_enabled        : arg3,
            treasury                  : arg4,
        };
        0x2::event::emit<ProfitFeeConfigured>(v0);
    }

    public entry fun set_treasury(arg0: &mut RouterFeeConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 3);
        assert!(arg1 != @0x0, 10);
        arg0.treasury = arg1;
        let v0 = ProfitFeeConfigured{
            owner                     : arg0.owner,
            profit_fee_bps            : arg0.profit_fee_bps,
            profit_fee_cap_usd_micros : arg0.profit_fee_cap_usd_micros,
            profit_fee_enabled        : arg0.profit_fee_enabled,
            treasury                  : arg1,
        };
        0x2::event::emit<ProfitFeeConfigured>(v0);
    }

    public(friend) fun settle_position_owner_exit<T0>(arg0: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg1: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::Position, arg2: u128, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::settle_owner_exit<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public(friend) fun split_and_forward_fee<T0>(arg0: &RouterFeeConfig, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        abort 12
    }

    public fun treasury(arg0: &RouterFeeConfig) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v7
}

