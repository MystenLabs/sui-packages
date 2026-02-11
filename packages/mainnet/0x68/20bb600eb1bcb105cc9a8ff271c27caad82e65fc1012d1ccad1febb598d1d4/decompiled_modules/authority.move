module 0x6820bb600eb1bcb105cc9a8ff271c27caad82e65fc1012d1ccad1febb598d1d4::authority {
    struct PACKAGE has copy, drop, store {
        dummy_field: bool,
    }

    struct POOL has copy, drop, store {
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
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 13835058343044972545);
        let v0 = AuthorityCapKey<PACKAGE, ADMIN>{dummy_field: false};
        assert!(!0x2::derived_object::exists<AuthorityCapKey<PACKAGE, ADMIN>>(arg1, v0), 13835058355929874433);
        let v1 = AuthorityCap<PACKAGE, ADMIN>{
            id  : 0x2::derived_object::claim<AuthorityCapKey<PACKAGE, ADMIN>>(arg1, v0),
            for : this_package(),
        };
        0x2::transfer::transfer<AuthorityCap<PACKAGE, ADMIN>>(v1, 0x2::tx_context::sender(arg2));
    }

    public(friend) fun create_package_assistant_cap(arg0: &mut 0x2::tx_context::TxContext) : AuthorityCap<PACKAGE, ASSISTANT> {
        AuthorityCap<PACKAGE, ASSISTANT>{
            id  : 0x2::object::new(arg0),
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

