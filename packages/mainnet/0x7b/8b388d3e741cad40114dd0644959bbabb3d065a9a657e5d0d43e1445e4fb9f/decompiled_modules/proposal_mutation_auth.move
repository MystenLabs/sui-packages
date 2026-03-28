module 0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::proposal_mutation_auth {
    struct ProposalMutationAuthorizedPackageAdded has copy, drop {
        package_addr: address,
    }

    struct ProposalMutationAuthorizedPackageRemoved has copy, drop {
        package_addr: address,
    }

    struct ProposalMutationRegistry has key {
        id: 0x2::object::UID,
        authorized_packages: 0x2::vec_set::VecSet<address>,
    }

    struct ProposalMutationAdminCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct ProposalMutationAuth has drop {
        target_id: 0x2::object::ID,
    }

    public fun add_authorized_package(arg0: &mut ProposalMutationRegistry, arg1: &ProposalMutationAdminCap, arg2: address) {
        assert!(0x2::object::id<ProposalMutationRegistry>(arg0) == arg1.registry_id, 3);
        assert!(!0x2::vec_set::contains<address>(&arg0.authorized_packages, &arg2), 1);
        0x2::vec_set::insert<address>(&mut arg0.authorized_packages, arg2);
        let v0 = ProposalMutationAuthorizedPackageAdded{package_addr: arg2};
        0x2::event::emit<ProposalMutationAuthorizedPackageAdded>(v0);
    }

    fun assert_authorized_witness<T0: drop>(arg0: &ProposalMutationRegistry) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x1::type_name::is_primitive(&v0), 0);
        let v1 = 0x1::type_name::address_string(&v0);
        assert!(is_authorized_package(arg0, 0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1))), 0);
        assert!(is_allowed_witness_type(&v0), 0);
    }

    public fun create<T0: drop>(arg0: &ProposalMutationRegistry, arg1: T0, arg2: 0x2::object::ID) : ProposalMutationAuth {
        assert_authorized_witness<T0>(arg0);
        ProposalMutationAuth{target_id: arg2}
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = ProposalMutationAdminCap{
            id          : 0x2::object::new(arg0),
            registry_id : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::transfer<ProposalMutationAdminCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = ProposalMutationRegistry{
            id                  : v0,
            authorized_packages : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<ProposalMutationRegistry>(v2);
    }

    fun is_allowed_witness_type(arg0: &0x1::type_name::TypeName) : bool {
        let v0 = 0x1::type_name::module_string(arg0);
        let v1 = struct_name_bytes(arg0);
        let v2 = 0x1::ascii::as_bytes(&v0);
        let v3 = b"governance_intents";
        if (v2 == &v3) {
            let v4 = b"GovernanceWitness";
            return &v1 == &v4
        };
        let v5 = b"ptb_executor";
        let v6 = if (v2 == &v5) {
            true
        } else {
            let v7 = b"proposal_lifecycle";
            v2 == &v7
        };
        if (v6) {
            let v9 = b"ProposalMutationWitness";
            &v1 == &v9
        } else {
            false
        }
    }

    public fun is_authorized_package(arg0: &ProposalMutationRegistry, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.authorized_packages, &arg1)
    }

    public fun remove_authorized_package(arg0: &mut ProposalMutationRegistry, arg1: &ProposalMutationAdminCap, arg2: address) {
        assert!(0x2::object::id<ProposalMutationRegistry>(arg0) == arg1.registry_id, 3);
        assert!(0x2::vec_set::contains<address>(&arg0.authorized_packages, &arg2), 2);
        0x2::vec_set::remove<address>(&mut arg0.authorized_packages, &arg2);
        let v0 = ProposalMutationAuthorizedPackageRemoved{package_addr: arg2};
        0x2::event::emit<ProposalMutationAuthorizedPackageRemoved>(v0);
    }

    fun struct_name_bytes(arg0: &0x1::type_name::TypeName) : vector<u8> {
        let v0 = 0x1::ascii::as_bytes(0x1::type_name::as_string(arg0));
        let v1 = 0x1::type_name::address_string(arg0);
        let v2 = 0x1::type_name::module_string(arg0);
        let v3 = 0x1::vector::length<u8>(0x1::ascii::as_bytes(&v1)) + 2 + 0x1::vector::length<u8>(0x1::ascii::as_bytes(&v2)) + 2;
        if (v3 >= 0x1::vector::length<u8>(v0)) {
            return b""
        };
        let v4 = b"";
        while (v3 < 0x1::vector::length<u8>(v0)) {
            let v5 = *0x1::vector::borrow<u8>(v0, v3);
            if (v5 == 60) {
                break
            };
            0x1::vector::push_back<u8>(&mut v4, v5);
            v3 = v3 + 1;
        };
        v4
    }

    public fun target_id(arg0: &ProposalMutationAuth) : 0x2::object::ID {
        arg0.target_id
    }

    // decompiled from Move bytecode v6
}

