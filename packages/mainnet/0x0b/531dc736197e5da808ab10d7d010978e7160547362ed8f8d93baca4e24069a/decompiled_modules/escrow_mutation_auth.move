module 0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::escrow_mutation_auth {
    struct EscrowMutationAuthorizedPackageAdded has copy, drop {
        package_addr: address,
    }

    struct EscrowMutationAuthorizedPackageRemoved has copy, drop {
        package_addr: address,
    }

    struct EscrowMutationRegistry has key {
        id: 0x2::object::UID,
        authorized_packages: 0x2::vec_set::VecSet<address>,
    }

    struct EscrowMutationAdminCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct EscrowMutationAuth has drop {
        dummy_field: bool,
    }

    public fun add_authorized_package(arg0: &mut EscrowMutationRegistry, arg1: &EscrowMutationAdminCap, arg2: address) {
        assert!(0x2::object::id<EscrowMutationRegistry>(arg0) == arg1.registry_id, 3);
        assert!(!0x2::vec_set::contains<address>(&arg0.authorized_packages, &arg2), 1);
        0x2::vec_set::insert<address>(&mut arg0.authorized_packages, arg2);
        let v0 = EscrowMutationAuthorizedPackageAdded{package_addr: arg2};
        0x2::event::emit<EscrowMutationAuthorizedPackageAdded>(v0);
    }

    fun assert_authorized_witness<T0: drop>(arg0: &EscrowMutationRegistry) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x1::type_name::is_primitive(&v0), 0);
        let v1 = 0x1::type_name::address_string(&v0);
        assert!(is_authorized_package(arg0, 0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1))), 0);
        assert!(is_allowed_witness_type(&v0), 0);
    }

    public fun create<T0: drop>(arg0: &EscrowMutationRegistry, arg1: T0) : EscrowMutationAuth {
        assert_authorized_witness<T0>(arg0);
        EscrowMutationAuth{dummy_field: false}
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = EscrowMutationAdminCap{
            id          : 0x2::object::new(arg0),
            registry_id : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::transfer<EscrowMutationAdminCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = EscrowMutationRegistry{
            id                  : v0,
            authorized_packages : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<EscrowMutationRegistry>(v2);
    }

    fun is_allowed_witness_module(arg0: &0x1::ascii::String) : bool {
        let v0 = 0x1::ascii::as_bytes(arg0);
        let v1 = b"ptb_executor";
        if (v0 == &v1) {
            true
        } else {
            let v3 = b"liquidity_interact";
            if (v0 == &v3) {
                true
            } else {
                let v4 = b"proposal_lifecycle";
                if (v0 == &v4) {
                    true
                } else {
                    let v5 = b"swap_core";
                    if (v0 == &v5) {
                        true
                    } else {
                        let v6 = b"arbitrage";
                        if (v0 == &v6) {
                            true
                        } else {
                            let v7 = b"quantum_lp_manager";
                            if (v0 == &v7) {
                                true
                            } else {
                                let v8 = b"proposal";
                                if (v0 == &v8) {
                                    true
                                } else {
                                    let v9 = b"liquidity_initialize";
                                    v0 == &v9
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    fun is_allowed_witness_type(arg0: &0x1::type_name::TypeName) : bool {
        let v0 = 0x1::type_name::module_string(arg0);
        if (!is_allowed_witness_module(&v0)) {
            return false
        };
        let v1 = struct_name_bytes(arg0);
        let v2 = b"EscrowMutationWitness";
        &v1 == &v2
    }

    public fun is_authorized_package(arg0: &EscrowMutationRegistry, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.authorized_packages, &arg1)
    }

    public fun registry_id(arg0: &EscrowMutationRegistry) : 0x2::object::ID {
        0x2::object::id<EscrowMutationRegistry>(arg0)
    }

    public fun remove_authorized_package(arg0: &mut EscrowMutationRegistry, arg1: &EscrowMutationAdminCap, arg2: address) {
        assert!(0x2::object::id<EscrowMutationRegistry>(arg0) == arg1.registry_id, 3);
        assert!(0x2::vec_set::contains<address>(&arg0.authorized_packages, &arg2), 2);
        0x2::vec_set::remove<address>(&mut arg0.authorized_packages, &arg2);
        let v0 = EscrowMutationAuthorizedPackageRemoved{package_addr: arg2};
        0x2::event::emit<EscrowMutationAuthorizedPackageRemoved>(v0);
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

    // decompiled from Move bytecode v6
}

