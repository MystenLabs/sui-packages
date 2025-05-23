module 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::auth {
    struct AuthKey<phantom T0: drop> has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun assert_caller_is_authorized<T0: drop>(arg0: &0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi) {
        assert!(is_caller_authorized<T0>(arg0), 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::errors::ECallerNotAuthorized());
    }

    public(friend) fun authorize_caller<T0: drop>(arg0: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi) {
        let v0 = AuthKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<AuthKey<T0>, bool>(0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::get_id_mut(arg0), v0, true);
    }

    public(friend) fun deauthorize_caller<T0: drop>(arg0: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi) {
        let v0 = AuthKey<T0>{dummy_field: false};
        0x2::dynamic_field::remove<AuthKey<T0>, bool>(0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::get_id_mut(arg0), v0);
    }

    public(friend) fun is_caller_authorized<T0: drop>(arg0: &0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi) : bool {
        let v0 = AuthKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_with_type<AuthKey<T0>, bool>(0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::get_id(arg0), v0)
    }

    // decompiled from Move bytecode v6
}

