module 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access {
    struct Auth has drop {
        witness: 0x1::option::Option<0x1::type_name::TypeName>,
    }

    struct ExtensionRegistryEventV1 has copy, drop {
        registry_id: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
        registered: bool,
    }

    struct ExtensionProposalEventV1 has copy, drop {
        registry_id: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
        eta_ms: u64,
        active: bool,
        consumed: bool,
    }

    struct WitnessKey has copy, drop, store {
        name: 0x1::type_name::TypeName,
    }

    struct SealKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ProposalKey has copy, drop, store {
        name: 0x1::type_name::TypeName,
    }

    fun add_uid<T0>(arg0: &mut 0x2::object::UID) {
        let v0 = WitnessKey{name: 0x1::type_name::with_defining_ids<T0>()};
        if (!0x2::dynamic_field::exists<WitnessKey>(arg0, v0)) {
            0x2::dynamic_field::add<WitnessKey, bool>(arg0, v0, true);
            let v1 = ExtensionRegistryEventV1{
                registry_id : 0x2::object::uid_to_inner(arg0),
                witness     : v0.name,
                registered  : true,
            };
            0x2::event::emit<ExtensionRegistryEventV1>(v1);
        };
    }

    public(friend) fun assert_registered_on(arg0: &Auth, arg1: &0x2::object::UID) {
        if (0x1::option::is_some<0x1::type_name::TypeName>(&arg0.witness)) {
            let v0 = WitnessKey{name: *0x1::option::borrow<0x1::type_name::TypeName>(&arg0.witness)};
            assert!(0x2::dynamic_field::exists<WitnessKey>(arg1, v0), 13835058355929874433);
        };
    }

    public(friend) fun cancel_uid<T0>(arg0: &mut 0x2::object::UID) {
        remove_proposal_uid<T0>(arg0, false);
    }

    public fun is_registered<T0>(arg0: &0x2::object::UID) : bool {
        let v0 = WitnessKey{name: 0x1::type_name::with_defining_ids<T0>()};
        0x2::dynamic_field::exists<WitnessKey>(arg0, v0)
    }

    public fun is_sealed(arg0: &0x2::object::UID) : bool {
        let v0 = SealKey{dummy_field: false};
        0x2::dynamic_field::exists<SealKey>(arg0, v0)
    }

    public fun issue<T0: drop>(arg0: T0, arg1: &0x2::object::UID) : Auth {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = WitnessKey{name: v0};
        assert!(0x2::dynamic_field::exists<WitnessKey>(arg1, v1), 13835058312980201473);
        Auth{witness: 0x1::option::some<0x1::type_name::TypeName>(v0)}
    }

    public(friend) fun new() : Auth {
        Auth{witness: 0x1::option::none<0x1::type_name::TypeName>()}
    }

    public fun proposal_eta<T0>(arg0: &0x2::object::UID) : 0x1::option::Option<u64> {
        let v0 = ProposalKey{name: 0x1::type_name::with_defining_ids<T0>()};
        if (0x2::dynamic_field::exists<ProposalKey>(arg0, v0)) {
            0x1::option::some<u64>(*0x2::dynamic_field::borrow<ProposalKey, u64>(arg0, v0))
        } else {
            0x1::option::none<u64>()
        }
    }

    public(friend) fun propose_uid<T0>(arg0: &mut 0x2::object::UID, arg1: u64) {
        assert!(!is_registered<T0>(arg0), 13836465842483232779);
        let v0 = ProposalKey{name: 0x1::type_name::with_defining_ids<T0>()};
        if (0x2::dynamic_field::exists<ProposalKey>(arg0, v0)) {
            0x2::dynamic_field::remove<ProposalKey, u64>(arg0, v0);
        };
        0x2::dynamic_field::add<ProposalKey, u64>(arg0, v0, arg1);
        let v1 = ExtensionProposalEventV1{
            registry_id : 0x2::object::uid_to_inner(arg0),
            witness     : v0.name,
            eta_ms      : arg1,
            active      : true,
            consumed    : false,
        };
        0x2::event::emit<ExtensionProposalEventV1>(v1);
    }

    public(friend) fun register_mirror_uid<T0>(arg0: &mut 0x2::object::UID, arg1: &0x2::object::UID) {
        assert!(is_registered<T0>(arg1), 13836184337441619977);
        add_uid<T0>(arg0);
    }

    public(friend) fun register_proposed_uid<T0>(arg0: &mut 0x2::object::UID, arg1: u64) {
        let v0 = ProposalKey{name: 0x1::type_name::with_defining_ids<T0>()};
        assert!(0x2::dynamic_field::exists<ProposalKey>(arg0, v0), 13835621494862118917);
        assert!(arg1 >= *0x2::dynamic_field::borrow<ProposalKey, u64>(arg0, v0), 13835902974133927943);
        remove_proposal_uid<T0>(arg0, true);
        add_uid<T0>(arg0);
    }

    public(friend) fun register_uid<T0>(arg0: &mut 0x2::object::UID) {
        if (is_registered<T0>(arg0)) {
            return
        };
        assert!(!is_sealed(arg0), 13835339873856389123);
        add_uid<T0>(arg0);
        let v0 = SealKey{dummy_field: false};
        0x2::dynamic_field::add<SealKey, bool>(arg0, v0, true);
        let v1 = proposal_eta<T0>(arg0);
        if (0x1::option::is_some<u64>(&v1)) {
            cancel_uid<T0>(arg0);
        };
    }

    fun remove_proposal_uid<T0>(arg0: &mut 0x2::object::UID, arg1: bool) {
        let v0 = ProposalKey{name: 0x1::type_name::with_defining_ids<T0>()};
        assert!(0x2::dynamic_field::exists<ProposalKey>(arg0, v0), 13835621533516824581);
        let v1 = ExtensionProposalEventV1{
            registry_id : 0x2::object::uid_to_inner(arg0),
            witness     : v0.name,
            eta_ms      : 0x2::dynamic_field::remove<ProposalKey, u64>(arg0, v0),
            active      : false,
            consumed    : arg1,
        };
        0x2::event::emit<ExtensionProposalEventV1>(v1);
    }

    public(friend) fun unregister_uid<T0>(arg0: &mut 0x2::object::UID) {
        let v0 = WitnessKey{name: 0x1::type_name::with_defining_ids<T0>()};
        if (0x2::dynamic_field::exists<WitnessKey>(arg0, v0)) {
            0x2::dynamic_field::remove<WitnessKey, bool>(arg0, v0);
            let v1 = ExtensionRegistryEventV1{
                registry_id : 0x2::object::uid_to_inner(arg0),
                witness     : v0.name,
                registered  : false,
            };
            0x2::event::emit<ExtensionRegistryEventV1>(v1);
        };
        let v2 = proposal_eta<T0>(arg0);
        if (0x1::option::is_some<u64>(&v2)) {
            cancel_uid<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v7
}

