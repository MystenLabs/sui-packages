module 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority {
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
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 0);
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

    public(friend) fun create_vault_admin_cap(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : AuthorityCap<VAULT, ADMIN> {
        AuthorityCap<VAULT, ADMIN>{
            id  : 0x2::object::new(arg1),
            for : arg0,
        }
    }

    public(friend) fun create_vault_assistant_cap(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : AuthorityCap<VAULT, ASSISTANT> {
        AuthorityCap<VAULT, ASSISTANT>{
            id  : 0x2::object::new(arg1),
            for : arg0,
        }
    }

    public(friend) fun destroy_vault_authority_cap<T0>(arg0: AuthorityCap<VAULT, T0>) {
        let AuthorityCap {
            id  : v0,
            for : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun is_admin(arg0: 0x1::type_name::TypeName) : bool {
        is_role<ADMIN>(arg0)
    }

    public fun is_assistant(arg0: 0x1::type_name::TypeName) : bool {
        is_role<ASSISTANT>(arg0)
    }

    public fun is_role<T0>(arg0: 0x1::type_name::TypeName) : bool {
        arg0 == 0x1::type_name::get<T0>()
    }

    fun this_package() : 0x2::object::ID {
        let v0 = 0x1::type_name::get_with_original_ids<ADMIN>();
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::get_address(&v0));
        0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v1))
    }

    public(friend) fun vault_id<T0>(arg0: &AuthorityCap<VAULT, T0>) : 0x2::object::ID {
        arg0.for
    }

    // decompiled from Move bytecode v6
}

