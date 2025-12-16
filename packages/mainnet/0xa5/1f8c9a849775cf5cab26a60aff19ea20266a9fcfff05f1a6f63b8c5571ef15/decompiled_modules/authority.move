module 0x83e0022e96e0914516fd83fcb19d37efa0ed5aae2a81e9b15723a538fd209128::authority {
    struct PACKAGE {
        dummy_field: bool,
    }

    struct ADMIN {
        dummy_field: bool,
    }

    struct ASSISTANT {
        dummy_field: bool,
    }

    struct AuthorityCapKey<phantom T0, phantom T1> has copy, drop, store {
        dummy_field: bool,
    }

    struct AuthorityCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    public(friend) fun create_package_admin_cap_and_keep<T0: drop>(arg0: &T0, arg1: &mut 0x2::object::UID, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 0);
        let v0 = AuthorityCapKey<PACKAGE, ADMIN>{dummy_field: false};
        assert!(!0x2::derived_object::exists<AuthorityCapKey<PACKAGE, ADMIN>>(arg1, v0), 0);
        let v1 = AuthorityCap<PACKAGE, ADMIN>{
            id  : 0x2::derived_object::claim<AuthorityCapKey<PACKAGE, ADMIN>>(arg1, v0),
            for : this_package(),
        };
        0x2::transfer::transfer<AuthorityCap<PACKAGE, ADMIN>>(v1, 0x2::tx_context::sender(arg2));
    }

    public(friend) fun create_package_assistant_cap(arg0: &mut 0x2::object::UID) : AuthorityCap<PACKAGE, ASSISTANT> {
        let v0 = AuthorityCapKey<PACKAGE, ASSISTANT>{dummy_field: false};
        assert!(!0x2::derived_object::exists<AuthorityCapKey<PACKAGE, ASSISTANT>>(arg0, v0), 0);
        AuthorityCap<PACKAGE, ASSISTANT>{
            id  : 0x2::derived_object::claim<AuthorityCapKey<PACKAGE, ASSISTANT>>(arg0, v0),
            for : this_package(),
        }
    }

    fun this_package() : 0x2::object::ID {
        let v0 = 0x1::type_name::with_defining_ids<ADMIN>();
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v0));
        0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v1))
    }

    // decompiled from Move bytecode v6
}

