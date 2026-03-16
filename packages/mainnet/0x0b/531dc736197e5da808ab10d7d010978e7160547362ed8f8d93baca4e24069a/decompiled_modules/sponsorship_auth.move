module 0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::sponsorship_auth {
    struct SponsorshipAuthorizedPackageAdded has copy, drop {
        package_addr: address,
    }

    struct SponsorshipAuthorizedPackageRemoved has copy, drop {
        package_addr: address,
    }

    struct SponsorshipRegistry has key {
        id: 0x2::object::UID,
        authorized_packages: 0x2::vec_set::VecSet<address>,
    }

    struct SponsorshipAdminCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct SponsorshipAuth has drop {
        target_id: 0x2::object::ID,
    }

    public fun add_authorized_package(arg0: &mut SponsorshipRegistry, arg1: &SponsorshipAdminCap, arg2: address) {
        assert!(0x2::object::id<SponsorshipRegistry>(arg0) == arg1.registry_id, 3);
        assert!(!0x2::vec_set::contains<address>(&arg0.authorized_packages, &arg2), 1);
        0x2::vec_set::insert<address>(&mut arg0.authorized_packages, arg2);
        let v0 = SponsorshipAuthorizedPackageAdded{package_addr: arg2};
        0x2::event::emit<SponsorshipAuthorizedPackageAdded>(v0);
    }

    fun assert_authorized_witness<T0: drop>(arg0: &SponsorshipRegistry) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x1::type_name::is_primitive(&v0), 0);
        let v1 = 0x1::type_name::address_string(&v0);
        assert!(is_authorized_package(arg0, 0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1))), 0);
        assert!(is_allowed_witness_type(&v0), 0);
    }

    public fun create<T0: drop>(arg0: &SponsorshipRegistry, arg1: T0, arg2: 0x2::object::ID) : SponsorshipAuth {
        assert_authorized_witness<T0>(arg0);
        SponsorshipAuth{target_id: arg2}
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = SponsorshipAdminCap{
            id          : 0x2::object::new(arg0),
            registry_id : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::transfer<SponsorshipAdminCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = SponsorshipRegistry{
            id                  : v0,
            authorized_packages : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<SponsorshipRegistry>(v2);
    }

    fun is_allowed_witness_module(arg0: &0x1::ascii::String) : bool {
        let v0 = b"proposal_sponsorship";
        0x1::ascii::as_bytes(arg0) == &v0
    }

    fun is_allowed_witness_type(arg0: &0x1::type_name::TypeName) : bool {
        let v0 = 0x1::type_name::module_string(arg0);
        if (!is_allowed_witness_module(&v0)) {
            return false
        };
        let v1 = struct_name_bytes(arg0);
        let v2 = b"Witness";
        &v1 == &v2
    }

    public fun is_authorized_package(arg0: &SponsorshipRegistry, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.authorized_packages, &arg1)
    }

    public fun remove_authorized_package(arg0: &mut SponsorshipRegistry, arg1: &SponsorshipAdminCap, arg2: address) {
        assert!(0x2::object::id<SponsorshipRegistry>(arg0) == arg1.registry_id, 3);
        assert!(0x2::vec_set::contains<address>(&arg0.authorized_packages, &arg2), 2);
        0x2::vec_set::remove<address>(&mut arg0.authorized_packages, &arg2);
        let v0 = SponsorshipAuthorizedPackageRemoved{package_addr: arg2};
        0x2::event::emit<SponsorshipAuthorizedPackageRemoved>(v0);
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

    public fun target_id(arg0: &SponsorshipAuth) : 0x2::object::ID {
        arg0.target_id
    }

    // decompiled from Move bytecode v6
}

