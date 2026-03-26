module 0x856b2a3baae5da810beaefb8d6c8a26d24a884498e4ed4d549232e83a840020::spot_pool_mutation_auth {
    struct SpotPoolMutationAuthorizedPackageAdded has copy, drop {
        package_addr: address,
    }

    struct SpotPoolMutationAuthorizedPackageRemoved has copy, drop {
        package_addr: address,
    }

    struct SpotPoolMutationRegistry has key {
        id: 0x2::object::UID,
        authorized_packages: 0x2::vec_set::VecSet<address>,
    }

    struct SpotPoolMutationAdminCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct SpotPoolMutationAuth has drop {
        target_id: 0x2::object::ID,
    }

    public fun add_authorized_package(arg0: &mut SpotPoolMutationRegistry, arg1: &SpotPoolMutationAdminCap, arg2: address) {
        assert!(0x2::object::id<SpotPoolMutationRegistry>(arg0) == arg1.registry_id, 3);
        assert!(!0x2::vec_set::contains<address>(&arg0.authorized_packages, &arg2), 1);
        0x2::vec_set::insert<address>(&mut arg0.authorized_packages, arg2);
        let v0 = SpotPoolMutationAuthorizedPackageAdded{package_addr: arg2};
        0x2::event::emit<SpotPoolMutationAuthorizedPackageAdded>(v0);
    }

    fun assert_authorized_witness<T0: drop>(arg0: &SpotPoolMutationRegistry) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x1::type_name::is_primitive(&v0), 0);
        let v1 = 0x1::type_name::address_string(&v0);
        assert!(is_authorized_package(arg0, 0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1))), 0);
        assert!(is_allowed_witness_type(&v0), 0);
    }

    public fun create<T0: drop>(arg0: &SpotPoolMutationRegistry, arg1: T0, arg2: 0x2::object::ID) : SpotPoolMutationAuth {
        assert_authorized_witness<T0>(arg0);
        SpotPoolMutationAuth{target_id: arg2}
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = SpotPoolMutationAdminCap{
            id          : 0x2::object::new(arg0),
            registry_id : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::transfer<SpotPoolMutationAdminCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = SpotPoolMutationRegistry{
            id                  : v0,
            authorized_packages : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<SpotPoolMutationRegistry>(v2);
    }

    fun is_allowed_witness_module(arg0: &0x1::ascii::String) : bool {
        let v0 = 0x1::ascii::as_bytes(arg0);
        let v1 = b"proposal_lifecycle";
        if (v0 == &v1) {
            true
        } else {
            let v3 = b"ptb_executor";
            if (v0 == &v3) {
                true
            } else {
                let v4 = b"liquidity_actions";
                if (v0 == &v4) {
                    true
                } else {
                    let v5 = b"liquidity_interact";
                    if (v0 == &v5) {
                        true
                    } else {
                        let v6 = b"proposal";
                        if (v0 == &v6) {
                            true
                        } else {
                            let v7 = b"swap_entry";
                            v0 == &v7
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
        let v2 = b"SpotPoolMutationWitness";
        &v1 == &v2
    }

    public fun is_authorized_package(arg0: &SpotPoolMutationRegistry, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.authorized_packages, &arg1)
    }

    public fun remove_authorized_package(arg0: &mut SpotPoolMutationRegistry, arg1: &SpotPoolMutationAdminCap, arg2: address) {
        assert!(0x2::object::id<SpotPoolMutationRegistry>(arg0) == arg1.registry_id, 3);
        assert!(0x2::vec_set::contains<address>(&arg0.authorized_packages, &arg2), 2);
        0x2::vec_set::remove<address>(&mut arg0.authorized_packages, &arg2);
        let v0 = SpotPoolMutationAuthorizedPackageRemoved{package_addr: arg2};
        0x2::event::emit<SpotPoolMutationAuthorizedPackageRemoved>(v0);
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

    public fun target_id(arg0: &SpotPoolMutationAuth) : 0x2::object::ID {
        arg0.target_id
    }

    // decompiled from Move bytecode v6
}

