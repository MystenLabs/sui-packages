module 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day {
    struct ProtocolConfig has key {
        id: 0x2::object::UID,
        protocol_yield_skim_bps: u64,
        auto_yield_default_off: bool,
    }

    struct StrategyRegistryAnchorKey has copy, drop, store {
        dummy_field: bool,
    }

    struct StrategyRegistryAnchor has copy, drop, store {
        registry_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        governance: address,
    }

    struct HubStateAnchorKey has copy, drop, store {
        dummy_field: bool,
    }

    struct HubStateAnchor has copy, drop, store {
        hub_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
    }

    struct AdapterRegistryV2AnchorKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AdapterRegistryV2Anchor has copy, drop, store {
        registry_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        governance: address,
    }

    struct YieldHarvested has copy, drop {
        gross_yield_micros: u64,
        protocol_skim_micros: u64,
        net_yield_micros: u64,
        fee_bps: u64,
    }

    struct SurvivalUnstake has copy, drop {
        unstake_micros: u64,
        storage_bill_micros: u64,
        reason: vector<u8>,
    }

    struct TopUpRecorded has copy, drop {
        amount_micros: u64,
        fee_micros: u64,
    }

    public(friend) fun adapter_registry_v2_bootstrapped(arg0: &ProtocolConfig) : bool {
        let v0 = AdapterRegistryV2AnchorKey{dummy_field: false};
        0x2::dynamic_field::exists<AdapterRegistryV2AnchorKey>(&arg0.id, v0)
    }

    public(friend) fun anchor_adapter_registry_v2(arg0: &mut ProtocolConfig, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address) {
        let v0 = AdapterRegistryV2AnchorKey{dummy_field: false};
        let v1 = AdapterRegistryV2Anchor{
            registry_id  : arg1,
            admin_cap_id : arg2,
            governance   : arg3,
        };
        0x2::dynamic_field::add<AdapterRegistryV2AnchorKey, AdapterRegistryV2Anchor>(&mut arg0.id, v0, v1);
    }

    public(friend) fun anchor_hub_state(arg0: &mut ProtocolConfig, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        assert!(!hub_state_bootstrapped(arg0), 5);
        let v0 = HubStateAnchorKey{dummy_field: false};
        let v1 = HubStateAnchor{
            hub_id      : arg1,
            registry_id : arg2,
        };
        0x2::dynamic_field::add<HubStateAnchorKey, HubStateAnchor>(&mut arg0.id, v0, v1);
    }

    public(friend) fun anchor_strategy_registry(arg0: &mut ProtocolConfig, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address) {
        let v0 = StrategyRegistryAnchorKey{dummy_field: false};
        let v1 = StrategyRegistryAnchor{
            registry_id  : arg1,
            admin_cap_id : arg2,
            governance   : arg3,
        };
        0x2::dynamic_field::add<StrategyRegistryAnchorKey, StrategyRegistryAnchor>(&mut arg0.id, v0, v1);
    }

    public(friend) fun assert_canonical_hub_state_binding(arg0: &ProtocolConfig, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        assert!(hub_state_bootstrapped(arg0), 6);
        let v0 = HubStateAnchorKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<HubStateAnchorKey, HubStateAnchor>(&arg0.id, v0);
        assert!(v1.hub_id == arg1, 6);
        assert!(v1.registry_id == arg2, 6);
    }

    public(friend) fun assert_canonical_strategy_registry_binding(arg0: &ProtocolConfig, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address) {
        assert!(strategy_registry_bootstrapped(arg0), 3);
        let v0 = StrategyRegistryAnchorKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<StrategyRegistryAnchorKey, StrategyRegistryAnchor>(&arg0.id, v0);
        assert!(v1.registry_id == arg1, 4);
        assert!(v1.admin_cap_id == arg2, 4);
        assert!(v1.governance == arg3, 4);
    }

    public fun canonical_adapter_registry_v2_id(arg0: &ProtocolConfig) : 0x1::option::Option<0x2::object::ID> {
        if (!adapter_registry_v2_bootstrapped(arg0)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        let v0 = AdapterRegistryV2AnchorKey{dummy_field: false};
        0x1::option::some<0x2::object::ID>(0x2::dynamic_field::borrow<AdapterRegistryV2AnchorKey, AdapterRegistryV2Anchor>(&arg0.id, v0).registry_id)
    }

    public fun canonical_hub_state_id(arg0: &ProtocolConfig) : 0x1::option::Option<0x2::object::ID> {
        if (!hub_state_bootstrapped(arg0)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        let v0 = HubStateAnchorKey{dummy_field: false};
        0x1::option::some<0x2::object::ID>(0x2::dynamic_field::borrow<HubStateAnchorKey, HubStateAnchor>(&arg0.id, v0).hub_id)
    }

    public fun canonical_hub_state_registry_id(arg0: &ProtocolConfig) : 0x1::option::Option<0x2::object::ID> {
        if (!hub_state_bootstrapped(arg0)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        let v0 = HubStateAnchorKey{dummy_field: false};
        0x1::option::some<0x2::object::ID>(0x2::dynamic_field::borrow<HubStateAnchorKey, HubStateAnchor>(&arg0.id, v0).registry_id)
    }

    public fun canonical_strategy_registry_admin_cap_id(arg0: &ProtocolConfig) : 0x1::option::Option<0x2::object::ID> {
        if (!strategy_registry_bootstrapped(arg0)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        let v0 = StrategyRegistryAnchorKey{dummy_field: false};
        0x1::option::some<0x2::object::ID>(0x2::dynamic_field::borrow<StrategyRegistryAnchorKey, StrategyRegistryAnchor>(&arg0.id, v0).admin_cap_id)
    }

    public fun canonical_strategy_registry_governance(arg0: &ProtocolConfig) : 0x1::option::Option<address> {
        if (!strategy_registry_bootstrapped(arg0)) {
            return 0x1::option::none<address>()
        };
        let v0 = StrategyRegistryAnchorKey{dummy_field: false};
        0x1::option::some<address>(0x2::dynamic_field::borrow<StrategyRegistryAnchorKey, StrategyRegistryAnchor>(&arg0.id, v0).governance)
    }

    public fun canonical_strategy_registry_id(arg0: &ProtocolConfig) : 0x1::option::Option<0x2::object::ID> {
        if (!strategy_registry_bootstrapped(arg0)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        let v0 = StrategyRegistryAnchorKey{dummy_field: false};
        0x1::option::some<0x2::object::ID>(0x2::dynamic_field::borrow<StrategyRegistryAnchorKey, StrategyRegistryAnchor>(&arg0.id, v0).registry_id)
    }

    public fun default_skim_bps() : u64 {
        500
    }

    public fun emit_survival_unstake(arg0: u64, arg1: u64) {
        let v0 = SurvivalUnstake{
            unstake_micros      : arg0,
            storage_bill_micros : arg1,
            reason              : b"survival_storage",
        };
        0x2::event::emit<SurvivalUnstake>(v0);
    }

    public fun get_skim_bps(arg0: &ProtocolConfig) : u64 {
        arg0.protocol_yield_skim_bps
    }

    public(friend) fun hub_state_bootstrapped(arg0: &ProtocolConfig) : bool {
        let v0 = HubStateAnchorKey{dummy_field: false};
        0x2::dynamic_field::exists<HubStateAnchorKey>(&arg0.id, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolConfig{
            id                      : 0x2::object::new(arg0),
            protocol_yield_skim_bps : 500,
            auto_yield_default_off  : true,
        };
        0x2::transfer::share_object<ProtocolConfig>(v0);
    }

    public fun is_auto_yield_default_off(arg0: &ProtocolConfig) : bool {
        arg0.auto_yield_default_off
    }

    public fun mul_bps(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 10000, 2);
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun record_harvest(arg0: &ProtocolConfig, arg1: u64, arg2: u64) {
        let (v0, v1) = skim_yield(arg1, arg0.protocol_yield_skim_bps);
        if (arg2 > 0 && v1 > 0) {
            assert!(arg2 <= v1, 1);
        };
        let v2 = YieldHarvested{
            gross_yield_micros   : arg1,
            protocol_skim_micros : v0,
            net_yield_micros     : v1,
            fee_bps              : arg0.protocol_yield_skim_bps,
        };
        0x2::event::emit<YieldHarvested>(v2);
    }

    public fun record_top_up(arg0: u64) {
        let v0 = TopUpRecorded{
            amount_micros : arg0,
            fee_micros    : 0,
        };
        0x2::event::emit<TopUpRecorded>(v0);
    }

    public fun skim_yield(arg0: u64, arg1: u64) : (u64, u64) {
        let v0 = mul_bps(arg0, arg1);
        (v0, arg0 - v0)
    }

    public(friend) fun strategy_registry_bootstrapped(arg0: &ProtocolConfig) : bool {
        let v0 = StrategyRegistryAnchorKey{dummy_field: false};
        0x2::dynamic_field::exists<StrategyRegistryAnchorKey>(&arg0.id, v0)
    }

    // decompiled from Move bytecode v7
}

