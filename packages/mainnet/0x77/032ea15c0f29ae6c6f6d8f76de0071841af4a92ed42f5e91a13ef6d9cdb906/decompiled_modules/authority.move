module 0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::authority {
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
        let v0 = AuthorityCapKey<PACKAGE, ADMIN>{dummy_field: false};
        assert!(!0x2::derived_object::exists<AuthorityCapKey<PACKAGE, ADMIN>>(arg0, v0), 0);
        AuthorityCap<PACKAGE, ASSISTANT>{
            id  : 0x2::derived_object::claim<AuthorityCapKey<PACKAGE, ADMIN>>(arg0, v0),
            for : this_package(),
        }
    }

    public(friend) fun create_vault_admin_cap(arg0: &mut 0x2::object::UID) : AuthorityCap<VAULT, ADMIN> {
        let v0 = AuthorityCapKey<VAULT, ADMIN>{dummy_field: false};
        assert!(!0x2::derived_object::exists<AuthorityCapKey<VAULT, ADMIN>>(arg0, v0), 1);
        AuthorityCap<VAULT, ADMIN>{
            id  : 0x2::derived_object::claim<AuthorityCapKey<VAULT, ADMIN>>(arg0, v0),
            for : 0x2::object::uid_to_inner(arg0),
        }
    }

    public(friend) fun create_vault_assistant_cap(arg0: &mut 0x2::object::UID) : AuthorityCap<VAULT, ASSISTANT> {
        let v0 = AuthorityCapKey<VAULT, ASSISTANT>{dummy_field: false};
        assert!(!0x2::derived_object::exists<AuthorityCapKey<VAULT, ASSISTANT>>(arg0, v0), 1);
        AuthorityCap<VAULT, ASSISTANT>{
            id  : 0x2::derived_object::claim<AuthorityCapKey<VAULT, ASSISTANT>>(arg0, v0),
            for : 0x2::object::uid_to_inner(arg0),
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
        arg0 == 0x1::type_name::with_defining_ids<T0>()
    }

    fun this_package() : 0x2::object::ID {
        let v0 = 0x1::type_name::with_defining_ids<ADMIN>();
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v0));
        0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v1))
    }

    public(friend) fun vault_id<T0>(arg0: &AuthorityCap<VAULT, T0>) : 0x2::object::ID {
        arg0.for
    }

    // decompiled from Move bytecode v6
}

