module 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access {
    struct Auth has drop {
        witness: 0x1::option::Option<0x1::type_name::TypeName>,
        exchange: 0x1::option::Option<0x2::object::ID>,
        refund_only: bool,
        primary: bool,
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

    struct ExtensionRefundEventV1 has copy, drop {
        registry_id: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
        retained: bool,
    }

    struct ExtensionVersionEventV1 has copy, drop {
        registry_id: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
        min_version: u64,
    }

    struct WitnessKey has copy, drop, store {
        name: 0x1::type_name::TypeName,
    }

    struct RefundOnlyKey has copy, drop, store {
        name: 0x1::type_name::TypeName,
    }

    struct MinVersionKey has copy, drop, store {
        name: 0x1::type_name::TypeName,
    }

    struct SealKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ProposalKey has copy, drop, store {
        name: 0x1::type_name::TypeName,
    }

    struct PrimaryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PrimaryWitnessKey has copy, drop, store {
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
        drop_refund_uid<T0>(arg0);
    }

    public(friend) fun assert_bound(arg0: &Auth, arg1: 0x2::object::ID) {
        if (0x1::option::is_some<0x1::type_name::TypeName>(&arg0.witness)) {
            assert!(!arg0.refund_only && arg0.exchange == 0x1::option::some<0x2::object::ID>(arg1), 13836747536503406605);
        };
    }

    public(friend) fun assert_bound_any(arg0: &Auth) {
        if (0x1::option::is_some<0x1::type_name::TypeName>(&arg0.witness)) {
            assert!(!arg0.refund_only && 0x1::option::is_some<0x2::object::ID>(&arg0.exchange), 13836747613812817933);
        };
    }

    public(friend) fun assert_bound_refund(arg0: &Auth, arg1: 0x2::object::ID) {
        if (0x1::option::is_some<0x1::type_name::TypeName>(&arg0.witness)) {
            assert!(arg0.exchange == 0x1::option::some<0x2::object::ID>(arg1), 13836747570863144973);
        };
    }

    public(friend) fun assert_on_exchange(arg0: &Auth, arg1: &0x2::object::UID) {
        assert_registered_on(arg0, arg1);
        if (0x1::option::is_some<0x2::object::ID>(&arg0.exchange)) {
            assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.exchange) == 0x2::object::uid_to_inner(arg1), 13836747704007131149);
        };
    }

    public(friend) fun assert_primary(arg0: &Auth, arg1: &0x2::object::UID) {
        if (0x1::option::is_some<0x1::type_name::TypeName>(&arg0.witness)) {
            assert!(!arg0.refund_only, 13836747751251771405);
            let v0 = PrimaryWitnessKey{name: *0x1::option::borrow<0x1::type_name::TypeName>(&arg0.witness)};
            assert!(0x2::dynamic_field::exists<PrimaryWitnessKey>(arg1, v0), 13837029230523580431);
        };
    }

    public(friend) fun assert_primary_bound(arg0: &Auth) {
        if (0x1::option::is_some<0x1::type_name::TypeName>(&arg0.witness)) {
            assert!(arg0.primary, 13837029269178286095);
        };
    }

    public(friend) fun assert_registered_on(arg0: &Auth, arg1: &0x2::object::UID) {
        if (0x1::option::is_some<0x1::type_name::TypeName>(&arg0.witness)) {
            let v0 = WitnessKey{name: *0x1::option::borrow<0x1::type_name::TypeName>(&arg0.witness)};
            assert!(0x2::dynamic_field::exists<WitnessKey>(arg1, v0), 13835058806901440513);
            assert!(!arg0.refund_only, 13836747661057458189);
        };
    }

    public fun assert_version_live<T0>(arg0: &0x2::object::UID, arg1: u64) {
        let v0 = MinVersionKey{name: 0x1::type_name::with_defining_ids<T0>()};
        if (0x2::dynamic_field::exists<MinVersionKey>(arg0, v0)) {
            assert!(arg1 >= *0x2::dynamic_field::borrow<MinVersionKey, u64>(arg0, v0), 13837311315385778193);
        };
    }

    public(friend) fun cancel_uid<T0>(arg0: &mut 0x2::object::UID) {
        remove_proposal_uid<T0>(arg0, false);
    }

    public(friend) fun drop_refund_uid<T0>(arg0: &mut 0x2::object::UID) {
        let v0 = RefundOnlyKey{name: 0x1::type_name::with_defining_ids<T0>()};
        if (0x2::dynamic_field::exists<RefundOnlyKey>(arg0, v0)) {
            0x2::dynamic_field::remove<RefundOnlyKey, bool>(arg0, v0);
            let v1 = ExtensionRefundEventV1{
                registry_id : 0x2::object::uid_to_inner(arg0),
                witness     : v0.name,
                retained    : false,
            };
            0x2::event::emit<ExtensionRefundEventV1>(v1);
        };
    }

    public fun extension_witness(arg0: &Auth) : 0x1::option::Option<0x1::type_name::TypeName> {
        if (arg0.refund_only || 0x1::option::is_none<0x1::type_name::TypeName>(&arg0.witness)) {
            0x1::option::none<0x1::type_name::TypeName>()
        } else {
            0x1::option::some<0x1::type_name::TypeName>(*0x1::option::borrow<0x1::type_name::TypeName>(&arg0.witness))
        }
    }

    public fun is_refund_retained<T0>(arg0: &0x2::object::UID) : bool {
        let v0 = RefundOnlyKey{name: 0x1::type_name::with_defining_ids<T0>()};
        0x2::dynamic_field::exists<RefundOnlyKey>(arg0, v0)
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
        assert!(0x2::dynamic_field::exists<WitnessKey>(arg1, v1), 13835058532023533569);
        Auth{
            witness     : 0x1::option::some<0x1::type_name::TypeName>(v0),
            exchange    : 0x1::option::none<0x2::object::ID>(),
            refund_only : false,
            primary     : false,
        }
    }

    public(friend) fun issue_bound<T0: drop>(arg0: T0, arg1: &0x2::object::UID, arg2: &0x2::object::UID) : Auth {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = WitnessKey{name: v0};
        assert!(0x2::dynamic_field::exists<WitnessKey>(arg1, v1), 13835058579268173825);
        let v2 = WitnessKey{name: v0};
        assert!(0x2::dynamic_field::exists<WitnessKey>(arg2, v2), 13835058583563141121);
        let v3 = PrimaryWitnessKey{name: v0};
        Auth{
            witness     : 0x1::option::some<0x1::type_name::TypeName>(v0),
            exchange    : 0x1::option::some<0x2::object::ID>(0x2::object::uid_to_inner(arg2)),
            refund_only : false,
            primary     : 0x2::dynamic_field::exists<PrimaryWitnessKey>(arg2, v3),
        }
    }

    public(friend) fun issue_refund<T0: drop>(arg0: T0, arg1: &0x2::object::UID, arg2: 0x2::object::ID) : Auth {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = WitnessKey{name: v0};
        let v2 = if (0x2::dynamic_field::exists<WitnessKey>(arg1, v1)) {
            true
        } else {
            let v3 = RefundOnlyKey{name: v0};
            0x2::dynamic_field::exists<RefundOnlyKey>(arg1, v3)
        };
        assert!(v2, 13835058647987650561);
        Auth{
            witness     : 0x1::option::some<0x1::type_name::TypeName>(v0),
            exchange    : 0x1::option::some<0x2::object::ID>(arg2),
            refund_only : true,
            primary     : false,
        }
    }

    public fun min_version<T0>(arg0: &0x2::object::UID) : u64 {
        let v0 = MinVersionKey{name: 0x1::type_name::with_defining_ids<T0>()};
        if (0x2::dynamic_field::exists<MinVersionKey>(arg0, v0)) {
            *0x2::dynamic_field::borrow<MinVersionKey, u64>(arg0, v0)
        } else {
            0
        }
    }

    public(friend) fun new() : Auth {
        Auth{
            witness     : 0x1::option::none<0x1::type_name::TypeName>(),
            exchange    : 0x1::option::none<0x2::object::ID>(),
            refund_only : false,
            primary     : false,
        }
    }

    public fun primary(arg0: &0x2::object::UID) : 0x1::option::Option<0x1::type_name::TypeName> {
        let v0 = PrimaryKey{dummy_field: false};
        if (0x2::dynamic_field::exists<PrimaryKey>(arg0, v0)) {
            let v2 = PrimaryKey{dummy_field: false};
            0x1::option::some<0x1::type_name::TypeName>(*0x2::dynamic_field::borrow<PrimaryKey, 0x1::type_name::TypeName>(arg0, v2))
        } else {
            0x1::option::none<0x1::type_name::TypeName>()
        }
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
        assert!(!is_registered<T0>(arg0), 13836466473843425291);
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
        assert!(is_registered<T0>(arg1), 13836184934442074121);
        add_uid<T0>(arg0);
        if (primary(arg1) == 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T0>())) {
            set_primary_if_absent<T0>(arg0);
        };
    }

    public(friend) fun register_proposed_uid<T0>(arg0: &mut 0x2::object::UID, arg1: u64) {
        let v0 = ProposalKey{name: 0x1::type_name::with_defining_ids<T0>()};
        assert!(0x2::dynamic_field::exists<ProposalKey>(arg0, v0), 13835622126222311429);
        assert!(arg1 >= *0x2::dynamic_field::borrow<ProposalKey, u64>(arg0, v0), 13835903605494120455);
        remove_proposal_uid<T0>(arg0, true);
        add_uid<T0>(arg0);
    }

    public(friend) fun register_uid<T0>(arg0: &mut 0x2::object::UID) {
        if (is_registered<T0>(arg0)) {
            return
        };
        assert!(!is_sealed(arg0), 13835340462266908675);
        add_uid<T0>(arg0);
        let v0 = SealKey{dummy_field: false};
        0x2::dynamic_field::add<SealKey, bool>(arg0, v0, true);
        set_primary_if_absent<T0>(arg0);
        let v1 = proposal_eta<T0>(arg0);
        if (0x1::option::is_some<u64>(&v1)) {
            cancel_uid<T0>(arg0);
        };
    }

    fun remove_proposal_uid<T0>(arg0: &mut 0x2::object::UID, arg1: bool) {
        let v0 = ProposalKey{name: 0x1::type_name::with_defining_ids<T0>()};
        assert!(0x2::dynamic_field::exists<ProposalKey>(arg0, v0), 13835622164877017093);
        let v1 = ExtensionProposalEventV1{
            registry_id : 0x2::object::uid_to_inner(arg0),
            witness     : v0.name,
            eta_ms      : 0x2::dynamic_field::remove<ProposalKey, u64>(arg0, v0),
            active      : false,
            consumed    : arg1,
        };
        0x2::event::emit<ExtensionProposalEventV1>(v1);
    }

    public(friend) fun revoke_keep_refund_uid<T0>(arg0: &mut 0x2::object::UID) {
        let v0 = is_registered<T0>(arg0);
        unregister_uid<T0>(arg0);
        let v1 = RefundOnlyKey{name: 0x1::type_name::with_defining_ids<T0>()};
        if (v0 && !0x2::dynamic_field::exists<RefundOnlyKey>(arg0, v1)) {
            0x2::dynamic_field::add<RefundOnlyKey, bool>(arg0, v1, true);
            let v2 = ExtensionRefundEventV1{
                registry_id : 0x2::object::uid_to_inner(arg0),
                witness     : v1.name,
                retained    : true,
            };
            0x2::event::emit<ExtensionRefundEventV1>(v2);
        };
    }

    public(friend) fun set_min_version_uid<T0: drop>(arg0: T0, arg1: &mut 0x2::object::UID, arg2: u64) {
        let v0 = MinVersionKey{name: 0x1::type_name::with_defining_ids<T0>()};
        let v1 = min_version<T0>(arg1);
        assert!(arg2 >= v1, 13837592721643143187);
        if (arg2 == v1) {
            return
        };
        if (0x2::dynamic_field::exists<MinVersionKey>(arg1, v0)) {
            *0x2::dynamic_field::borrow_mut<MinVersionKey, u64>(arg1, v0) = arg2;
        } else {
            0x2::dynamic_field::add<MinVersionKey, u64>(arg1, v0, arg2);
        };
        let v2 = ExtensionVersionEventV1{
            registry_id : 0x2::object::uid_to_inner(arg1),
            witness     : v0.name,
            min_version : arg2,
        };
        0x2::event::emit<ExtensionVersionEventV1>(v2);
    }

    fun set_primary_if_absent<T0>(arg0: &mut 0x2::object::UID) {
        let v0 = PrimaryKey{dummy_field: false};
        if (0x2::dynamic_field::exists<PrimaryKey>(arg0, v0)) {
            return
        };
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = PrimaryKey{dummy_field: false};
        0x2::dynamic_field::add<PrimaryKey, 0x1::type_name::TypeName>(arg0, v2, v1);
        let v3 = PrimaryWitnessKey{name: v1};
        0x2::dynamic_field::add<PrimaryWitnessKey, bool>(arg0, v3, true);
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

