module 0x11bc720363a37ce25293c8e249ccee505bc3ab5881d2c0c3af7786b63460c360::coordinator_registry {
    struct CoordinatorRegistry has key {
        id: 0x2::object::UID,
        operator: address,
        coordinator: address,
        proposed_coordinator: 0x1::option::Option<address>,
        proposed_at_ms: u64,
        frozen: bool,
        version: u64,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct RegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        operator: address,
        coordinator: address,
    }

    struct CoordinatorProposed has copy, drop {
        registry_id: 0x2::object::ID,
        proposer: address,
        proposed: address,
        proposed_at_ms: u64,
    }

    struct CoordinatorAccepted has copy, drop {
        registry_id: 0x2::object::ID,
        old: address,
        new: address,
        version: u64,
        accepted_at_ms: u64,
    }

    struct CoordinatorProposalCancelled has copy, drop {
        registry_id: 0x2::object::ID,
        cancelled_by: address,
    }

    struct EmergencyFreezeChanged has copy, drop {
        registry_id: 0x2::object::ID,
        frozen: bool,
    }

    public fun accept_coordinator(arg0: &mut CoordinatorRegistry, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<address>(&arg0.proposed_coordinator), 701);
        let v0 = *0x1::option::borrow<address>(&arg0.proposed_coordinator);
        assert!(0x2::tx_context::sender(arg2) == v0, 702);
        arg0.coordinator = v0;
        arg0.proposed_coordinator = 0x1::option::none<address>();
        arg0.version = arg0.version + 1;
        let v1 = CoordinatorAccepted{
            registry_id    : 0x2::object::id<CoordinatorRegistry>(arg0),
            old            : arg0.coordinator,
            new            : v0,
            version        : arg0.version,
            accepted_at_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<CoordinatorAccepted>(v1);
    }

    public fun assert_coordinator(arg0: &CoordinatorRegistry, arg1: &0x2::tx_context::TxContext) {
        assert!(!arg0.frozen, 703);
        assert!(arg0.coordinator == 0x2::tx_context::sender(arg1), 704);
    }

    public fun assert_operator(arg0: &CoordinatorRegistry, arg1: &OperatorCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.registry_id == 0x2::object::id<CoordinatorRegistry>(arg0), 700);
        assert!(arg0.operator == 0x2::tx_context::sender(arg2), 700);
    }

    public fun cancel_proposal(arg0: &mut CoordinatorRegistry, arg1: &OperatorCap, arg2: &0x2::tx_context::TxContext) {
        assert_operator(arg0, arg1, arg2);
        arg0.proposed_coordinator = 0x1::option::none<address>();
        let v0 = CoordinatorProposalCancelled{
            registry_id  : 0x2::object::id<CoordinatorRegistry>(arg0),
            cancelled_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<CoordinatorProposalCancelled>(v0);
    }

    public fun coordinator(arg0: &CoordinatorRegistry) : address {
        arg0.coordinator
    }

    public fun create_registry(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : OperatorCap {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = CoordinatorRegistry{
            id                   : 0x2::object::new(arg1),
            operator             : v0,
            coordinator          : arg0,
            proposed_coordinator : 0x1::option::none<address>(),
            proposed_at_ms       : 0,
            frozen               : false,
            version              : 0,
        };
        let v2 = 0x2::object::id<CoordinatorRegistry>(&v1);
        let v3 = RegistryCreated{
            registry_id : v2,
            operator    : v0,
            coordinator : arg0,
        };
        0x2::event::emit<RegistryCreated>(v3);
        let v4 = OperatorCap{
            id          : 0x2::object::new(arg1),
            registry_id : v2,
        };
        0x2::transfer::share_object<CoordinatorRegistry>(v1);
        v4
    }

    public fun is_frozen(arg0: &CoordinatorRegistry) : bool {
        arg0.frozen
    }

    public fun operator(arg0: &CoordinatorRegistry) : address {
        arg0.operator
    }

    public fun propose_coordinator(arg0: &mut CoordinatorRegistry, arg1: &OperatorCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_operator(arg0, arg1, arg4);
        assert!(arg2 != arg0.coordinator, 705);
        arg0.proposed_coordinator = 0x1::option::some<address>(arg2);
        arg0.proposed_at_ms = 0x2::clock::timestamp_ms(arg3);
        let v0 = CoordinatorProposed{
            registry_id    : 0x2::object::id<CoordinatorRegistry>(arg0),
            proposer       : 0x2::tx_context::sender(arg4),
            proposed       : arg2,
            proposed_at_ms : arg0.proposed_at_ms,
        };
        0x2::event::emit<CoordinatorProposed>(v0);
    }

    public fun proposed(arg0: &CoordinatorRegistry) : &0x1::option::Option<address> {
        &arg0.proposed_coordinator
    }

    public fun set_frozen(arg0: &mut CoordinatorRegistry, arg1: &OperatorCap, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_operator(arg0, arg1, arg3);
        arg0.frozen = arg2;
        let v0 = EmergencyFreezeChanged{
            registry_id : 0x2::object::id<CoordinatorRegistry>(arg0),
            frozen      : arg2,
        };
        0x2::event::emit<EmergencyFreezeChanged>(v0);
    }

    public fun version(arg0: &CoordinatorRegistry) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

