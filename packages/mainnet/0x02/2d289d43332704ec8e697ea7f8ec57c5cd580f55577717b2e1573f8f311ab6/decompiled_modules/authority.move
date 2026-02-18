module 0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::authority {
    struct PACKAGE {
        dummy_field: bool,
    }

    struct VAULT<phantom T0> {
        dummy_field: bool,
    }

    struct ADMIN {
        dummy_field: bool,
    }

    struct ASSISTANT {
        dummy_field: bool,
    }

    struct PAUSE_GUARDIAN {
        dummy_field: bool,
    }

    struct AuthorityCapKey<phantom T0, phantom T1> has copy, drop, store {
        dummy_field: bool,
    }

    struct AuthorityCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    public fun assert_is_admin_or_assistant<T0>() {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(is_role<ADMIN>(v0) || is_role<ASSISTANT>(v0), 13835621340243296261);
    }

    public(friend) fun create_package_admin_cap_and_keep<T0: drop>(arg0: &T0, arg1: &mut 0x2::object::UID, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 13835058639397715969);
        let v0 = AuthorityCapKey<PACKAGE, ADMIN>{dummy_field: false};
        if (0x2::derived_object::exists<AuthorityCapKey<PACKAGE, ADMIN>>(arg1, v0)) {
            abort 13835058665167519745
        };
        let v1 = AuthorityCap<PACKAGE, ADMIN>{
            id  : 0x2::derived_object::claim<AuthorityCapKey<PACKAGE, ADMIN>>(arg1, v0),
            for : this_package(),
        };
        0x2::transfer::transfer<AuthorityCap<PACKAGE, ADMIN>>(v1, 0x2::tx_context::sender(arg2));
    }

    public(friend) fun create_package_assistant_cap(arg0: &mut 0x2::object::UID) : AuthorityCap<PACKAGE, ASSISTANT> {
        let v0 = AuthorityCapKey<PACKAGE, ASSISTANT>{dummy_field: false};
        if (0x2::derived_object::exists<AuthorityCapKey<PACKAGE, ASSISTANT>>(arg0, v0)) {
            abort 13835058738181963777
        };
        AuthorityCap<PACKAGE, ASSISTANT>{
            id  : 0x2::derived_object::claim<AuthorityCapKey<PACKAGE, ASSISTANT>>(arg0, v0),
            for : this_package(),
        }
    }

    public(friend) fun create_vault_admin_cap<T0>(arg0: &mut 0x2::object::UID) : AuthorityCap<VAULT<T0>, ADMIN> {
        let v0 = AuthorityCapKey<VAULT<T0>, ADMIN>{dummy_field: false};
        if (0x2::derived_object::exists<AuthorityCapKey<VAULT<T0>, ADMIN>>(arg0, v0)) {
            abort 13835340264698413059
        };
        AuthorityCap<VAULT<T0>, ADMIN>{
            id  : 0x2::derived_object::claim<AuthorityCapKey<VAULT<T0>, ADMIN>>(arg0, v0),
            for : 0x2::object::uid_to_inner(arg0),
        }
    }

    public(friend) fun create_vault_assistant_cap<T0>(arg0: &mut 0x2::object::UID) : AuthorityCap<VAULT<T0>, ASSISTANT> {
        let v0 = AuthorityCapKey<VAULT<T0>, ASSISTANT>{dummy_field: false};
        if (0x2::derived_object::exists<AuthorityCapKey<VAULT<T0>, ASSISTANT>>(arg0, v0)) {
            abort 13835340316238020611
        };
        AuthorityCap<VAULT<T0>, ASSISTANT>{
            id  : 0x2::derived_object::claim<AuthorityCapKey<VAULT<T0>, ASSISTANT>>(arg0, v0),
            for : 0x2::object::uid_to_inner(arg0),
        }
    }

    public(friend) fun create_vault_pause_guardian_cap<T0>(arg0: &mut 0x2::object::UID) : AuthorityCap<VAULT<T0>, PAUSE_GUARDIAN> {
        let v0 = AuthorityCapKey<VAULT<T0>, PAUSE_GUARDIAN>{dummy_field: false};
        if (0x2::derived_object::exists<AuthorityCapKey<VAULT<T0>, PAUSE_GUARDIAN>>(arg0, v0)) {
            abort 13835340376367562755
        };
        AuthorityCap<VAULT<T0>, PAUSE_GUARDIAN>{
            id  : 0x2::derived_object::claim<AuthorityCapKey<VAULT<T0>, PAUSE_GUARDIAN>>(arg0, v0),
            for : 0x2::object::uid_to_inner(arg0),
        }
    }

    public(friend) fun destroy_vault_authority_cap<T0, T1>(arg0: AuthorityCap<VAULT<T0>, T1>) {
        let AuthorityCap {
            id  : v0,
            for : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun id<T0, T1>(arg0: &AuthorityCap<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun is_admin(arg0: 0x1::type_name::TypeName) : bool {
        is_role<ADMIN>(arg0)
    }

    public fun is_assistant(arg0: 0x1::type_name::TypeName) : bool {
        is_role<ASSISTANT>(arg0)
    }

    public fun is_pause_guardian(arg0: 0x1::type_name::TypeName) : bool {
        is_role<PAUSE_GUARDIAN>(arg0)
    }

    public fun is_role<T0>(arg0: 0x1::type_name::TypeName) : bool {
        arg0 == 0x1::type_name::with_defining_ids<T0>()
    }

    fun this_package() : 0x2::object::ID {
        let v0 = 0x1::type_name::with_defining_ids<ADMIN>();
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v0));
        0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v1))
    }

    public(friend) fun vault_id<T0, T1>(arg0: &AuthorityCap<VAULT<T0>, T1>) : 0x2::object::ID {
        arg0.for
    }

    // decompiled from Move bytecode v6
}

