module 0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::authority {
    struct PACKAGE has copy, drop, store {
        dummy_field: bool,
    }

    struct ADMIN has copy, drop, store {
        dummy_field: bool,
    }

    struct ASSISTANT has copy, drop, store {
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
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 13835058325865103361);
        let v0 = AuthorityCapKey<PACKAGE, ADMIN>{dummy_field: false};
        assert!(!0x2::derived_object::exists<AuthorityCapKey<PACKAGE, ADMIN>>(arg1, v0), 13835058338750005249);
        let v1 = AuthorityCap<PACKAGE, ADMIN>{
            id  : 0x2::derived_object::claim<AuthorityCapKey<PACKAGE, ADMIN>>(arg1, v0),
            for : this_package(),
        };
        0x2::transfer::transfer<AuthorityCap<PACKAGE, ADMIN>>(v1, 0x2::tx_context::sender(arg2));
    }

    public(friend) fun create_package_assistant_cap_and_keep<T0: drop>(arg0: &T0, arg1: &mut 0x2::object::UID, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 13835058424649351169);
        let v0 = AuthorityCapKey<PACKAGE, ASSISTANT>{dummy_field: false};
        assert!(!0x2::derived_object::exists<AuthorityCapKey<PACKAGE, ASSISTANT>>(arg1, v0), 13835058437534253057);
        let v1 = AuthorityCap<PACKAGE, ASSISTANT>{
            id  : 0x2::derived_object::claim<AuthorityCapKey<PACKAGE, ASSISTANT>>(arg1, v0),
            for : this_package(),
        };
        0x2::transfer::transfer<AuthorityCap<PACKAGE, ASSISTANT>>(v1, 0x2::tx_context::sender(arg2));
    }

    fun this_package() : 0x2::object::ID {
        let v0 = 0x1::type_name::with_defining_ids<ADMIN>();
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v0));
        0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v1))
    }

    // decompiled from Move bytecode v6
}

