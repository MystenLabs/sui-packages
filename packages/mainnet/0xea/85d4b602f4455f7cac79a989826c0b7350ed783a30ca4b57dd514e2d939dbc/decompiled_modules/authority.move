module 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::authority {
    struct PACKAGE<phantom T0> has drop {
        dummy_field: bool,
    }

    struct VAULT<phantom T0> has drop {
        dummy_field: bool,
    }

    struct ADMIN has drop {
        dummy_field: bool,
    }

    struct AuthorityCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    public(friend) fun assert_has_authority_over<T0: drop>(arg0: &AuthorityCap<T0>, arg1: 0x2::object::ID) {
        assert!(arg0.for == arg1, 13906834676854685699);
    }

    public(friend) fun create_package_admin_cap_and_keep<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 13906834470696124417);
        let v0 = AuthorityCap<PACKAGE<ADMIN>>{
            id  : 0x2::object::new(arg1),
            for : this_package(),
        };
        0x2::transfer::transfer<AuthorityCap<PACKAGE<ADMIN>>>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun create_vault_admin_cap(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : AuthorityCap<VAULT<ADMIN>> {
        AuthorityCap<VAULT<ADMIN>>{
            id  : 0x2::object::new(arg1),
            for : arg0,
        }
    }

    public(friend) fun destroy_vault_admin_cap(arg0: AuthorityCap<VAULT<ADMIN>>) {
        let AuthorityCap {
            id  : v0,
            for : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun this_package() : 0x2::object::ID {
        let v0 = 0x1::type_name::get<ADMIN>();
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::get_address(&v0));
        0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v1))
    }

    public(friend) fun vault_id<T0: drop>(arg0: &AuthorityCap<T0>) : 0x2::object::ID {
        arg0.for
    }

    // decompiled from Move bytecode v6
}

