module 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::platform_policy {
    struct Policy has copy, drop, store {
        platform_bps: u16,
        platform_address: address,
        enabled: bool,
    }

    struct PolicyRegistry has key {
        id: 0x2::object::UID,
        crowd_walrus_id: 0x2::object::ID,
        policies: 0x2::table::Table<0x1::string::String, Policy>,
    }

    struct PolicyAdded has copy, drop {
        policy_name: 0x1::string::String,
        platform_bps: u16,
        platform_address: address,
        enabled: bool,
        timestamp_ms: u64,
    }

    struct PolicyUpdated has copy, drop {
        policy_name: 0x1::string::String,
        platform_bps: u16,
        platform_address: address,
        enabled: bool,
        timestamp_ms: u64,
    }

    struct PolicyDisabled has copy, drop {
        policy_name: 0x1::string::String,
        platform_bps: u16,
        platform_address: address,
        enabled: bool,
        timestamp_ms: u64,
    }

    public fun contains(arg0: &PolicyRegistry, arg1: &0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, Policy>(&arg0.policies, *arg1)
    }

    public(friend) fun add_policy(arg0: &mut PolicyRegistry, arg1: 0x1::string::String, arg2: u16, arg3: address, arg4: &0x2::clock::Clock) {
        add_policy_with_timestamp(arg0, arg1, arg2, arg3, 0x2::clock::timestamp_ms(arg4));
    }

    public(friend) fun add_policy_bootstrap(arg0: &mut PolicyRegistry, arg1: 0x1::string::String, arg2: u16, arg3: address) {
        add_policy_with_timestamp(arg0, arg1, arg2, arg3, 0);
    }

    fun add_policy_with_timestamp(arg0: &mut PolicyRegistry, arg1: 0x1::string::String, arg2: u16, arg3: address, arg4: u64) {
        assert!(!contains(arg0, &arg1), 1);
        assert!(arg2 <= 10000, 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::campaign::e_invalid_bps());
        assert!(arg3 != @0x0, 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::campaign::e_zero_address());
        let v0 = Policy{
            platform_bps     : arg2,
            platform_address : arg3,
            enabled          : true,
        };
        0x2::table::add<0x1::string::String, Policy>(&mut arg0.policies, arg1, v0);
        emit_added_event_with_timestamp(arg1, arg2, arg3, arg4);
    }

    public fun borrow_policy(arg0: &PolicyRegistry, arg1: &0x1::string::String) : &Policy {
        assert!(contains(arg0, arg1), 2);
        0x2::table::borrow<0x1::string::String, Policy>(&arg0.policies, *arg1)
    }

    public fun borrow_policy_mut(arg0: &mut PolicyRegistry, arg1: &0x1::string::String) : &mut Policy {
        assert!(contains(arg0, arg1), 2);
        0x2::table::borrow_mut<0x1::string::String, Policy>(&mut arg0.policies, *arg1)
    }

    public(friend) fun create_registry(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : PolicyRegistry {
        PolicyRegistry{
            id              : 0x2::object::new(arg1),
            crowd_walrus_id : arg0,
            policies        : 0x2::table::new<0x1::string::String, Policy>(arg1),
        }
    }

    public(friend) fun disable_policy(arg0: &mut PolicyRegistry, arg1: 0x1::string::String, arg2: &0x2::clock::Clock) {
        let v0 = borrow_policy_mut(arg0, &arg1);
        if (!v0.enabled) {
            abort 3
        };
        v0.enabled = false;
        emit_disabled_event(arg1, v0, arg2);
    }

    fun emit_added_event_with_timestamp(arg0: 0x1::string::String, arg1: u16, arg2: address, arg3: u64) {
        let v0 = PolicyAdded{
            policy_name      : arg0,
            platform_bps     : arg1,
            platform_address : arg2,
            enabled          : true,
            timestamp_ms     : arg3,
        };
        0x2::event::emit<PolicyAdded>(v0);
    }

    fun emit_disabled_event(arg0: 0x1::string::String, arg1: &Policy, arg2: &0x2::clock::Clock) {
        let v0 = PolicyDisabled{
            policy_name      : arg0,
            platform_bps     : arg1.platform_bps,
            platform_address : arg1.platform_address,
            enabled          : arg1.enabled,
            timestamp_ms     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PolicyDisabled>(v0);
    }

    fun emit_updated_event(arg0: 0x1::string::String, arg1: &Policy, arg2: &0x2::clock::Clock) {
        let v0 = PolicyUpdated{
            policy_name      : arg0,
            platform_bps     : arg1.platform_bps,
            platform_address : arg1.platform_address,
            enabled          : arg1.enabled,
            timestamp_ms     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PolicyUpdated>(v0);
    }

    public(friend) fun enable_policy(arg0: &mut PolicyRegistry, arg1: 0x1::string::String, arg2: &0x2::clock::Clock) {
        let v0 = borrow_policy_mut(arg0, &arg1);
        if (!v0.enabled) {
            v0.enabled = true;
            emit_updated_event(arg1, v0, arg2);
            return
        };
        emit_updated_event(arg1, v0, arg2);
    }

    public fun policy_copy(arg0: &PolicyRegistry, arg1: &0x1::string::String) : Policy {
        *borrow_policy(arg0, arg1)
    }

    public fun policy_enabled(arg0: &Policy) : bool {
        arg0.enabled
    }

    public fun policy_platform_address(arg0: &Policy) : address {
        arg0.platform_address
    }

    public fun policy_platform_bps(arg0: &Policy) : u16 {
        arg0.platform_bps
    }

    public fun registry_owner_id(arg0: &PolicyRegistry) : 0x2::object::ID {
        arg0.crowd_walrus_id
    }

    public fun require_enabled_policy(arg0: &PolicyRegistry, arg1: &0x1::string::String) : &Policy {
        let v0 = borrow_policy(arg0, arg1);
        assert!(v0.enabled, 3);
        v0
    }

    public(friend) fun share_registry(arg0: PolicyRegistry) {
        0x2::transfer::share_object<PolicyRegistry>(arg0);
    }

    public(friend) fun update_policy(arg0: &mut PolicyRegistry, arg1: 0x1::string::String, arg2: u16, arg3: address, arg4: &0x2::clock::Clock) {
        assert!(arg2 <= 10000, 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::campaign::e_invalid_bps());
        assert!(arg3 != @0x0, 0xa074c5a3c6a5a43f8c6e688a35878f922f4f7e97ec3ae0ee751989dfca8e48b1::campaign::e_zero_address());
        let v0 = borrow_policy_mut(arg0, &arg1);
        v0.platform_bps = arg2;
        v0.platform_address = arg3;
        emit_updated_event(arg1, v0, arg4);
    }

    // decompiled from Move bytecode v6
}

