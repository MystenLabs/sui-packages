module 0xd8646fb1f9d1d0fe75db886ac7e6d581db33cbc63916dfa6d1f7536b61bb28c2::authority {
    struct PACKAGE {
        dummy_field: bool,
    }

    struct VAULT {
        dummy_field: bool,
    }

    struct ADMIN {
        dummy_field: bool,
    }

    struct ASSISTANT {
        dummy_field: bool,
    }

    struct AuthorityCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    public(friend) fun create_package_admin_cap_and_keep<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 13835058471893991425);
        let v0 = AuthorityCap<PACKAGE, ADMIN>{
            id  : 0x2::object::new(arg1),
            for : this_package(),
        };
        0x2::transfer::transfer<AuthorityCap<PACKAGE, ADMIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun create_package_assistant_cap(arg0: &mut 0x2::tx_context::TxContext) : AuthorityCap<PACKAGE, ASSISTANT> {
        AuthorityCap<PACKAGE, ASSISTANT>{
            id  : 0x2::object::new(arg0),
            for : this_package(),
        }
    }

    public fun is_admin(arg0: 0x1::type_name::TypeName) : bool {
        is_role<ADMIN>(arg0)
    }

    public fun is_assistant(arg0: 0x1::type_name::TypeName) : bool {
        is_role<ASSISTANT>(arg0)
    }

    public fun is_role<T0>(arg0: 0x1::type_name::TypeName) : bool {
        arg0 == 0x1::type_name::with_defining_ids<T0>()
    }

    fun this_package() : 0x2::object::ID {
        let v0 = 0x1::type_name::with_defining_ids<ADMIN>();
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v0));
        0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v1))
    }

    // decompiled from Move bytecode v6
}

