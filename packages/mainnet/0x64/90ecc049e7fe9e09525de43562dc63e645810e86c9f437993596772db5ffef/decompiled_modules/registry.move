module 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry {
    struct REGISTRY has drop {
        dummy_field: bool,
    }

    struct Registry has store, key {
        id: 0x2::object::UID,
    }

    struct RegistryKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct CallerKey<phantom T0: drop> has copy, drop, store {
        dummy_field: bool,
    }

    struct SubCallerKey<phantom T0: drop, phantom T1: drop> has copy, drop, store {
        dummy_field: bool,
    }

    public fun borrow<T0: store>(arg0: &Registry) : &T0 {
        let v0 = RegistryKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<RegistryKey<T0>, T0>(&arg0.id, v0)
    }

    public fun borrow_mut<T0: store>(arg0: &mut Registry) : &mut T0 {
        let v0 = RegistryKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<RegistryKey<T0>, T0>(&mut arg0.id, v0)
    }

    public fun add<T0: store>(arg0: &mut Registry, arg1: T0) {
        let v0 = RegistryKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<RegistryKey<T0>, T0>(&mut arg0.id, v0, arg1);
    }

    public fun assert_friend_caller_is_authorized<T0: drop, T1: drop>(arg0: &0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi, arg1: &T0, arg2: &T1) {
        assert!(is_friend_caller_authorized<T0, T1>(arg0), 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::errors::EFriendCallerNotAuthorized());
    }

    public fun authorize_friend_caller<T0: drop, T1: drop>(arg0: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi, arg1: &T0) {
        0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::auth::assert_caller_is_authorized<T0>(arg0);
        let v0 = SubCallerKey<T0, T1>{dummy_field: false};
        0x2::dynamic_field::add<SubCallerKey<T0, T1>, bool>(0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::get_id_mut(arg0), v0, true);
    }

    public fun borrow_caller_registry<T0: drop>(arg0: &0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi) : &Registry {
        let v0 = CallerKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<CallerKey<T0>, Registry>(0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::get_id(arg0), v0)
    }

    public fun borrow_caller_registry_mut<T0: drop>(arg0: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi, arg1: &T0) : &mut Registry {
        0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::auth::assert_caller_is_authorized<T0>(arg0);
        let v0 = CallerKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<CallerKey<T0>, Registry>(0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::get_id_mut(arg0), v0)
    }

    public fun create_caller_registry<T0: drop>(arg0: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi, arg1: &mut 0x2::tx_context::TxContext) {
        0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::auth::assert_caller_is_authorized<T0>(arg0);
        let v0 = CallerKey<T0>{dummy_field: false};
        let v1 = Registry{id: 0x2::object::new(arg1)};
        0x2::dynamic_field::add<CallerKey<T0>, Registry>(0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::get_id_mut(arg0), v0, v1);
    }

    public fun deauthorize_friend_caller<T0: drop, T1: drop>(arg0: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi, arg1: &T0) {
        0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::auth::assert_caller_is_authorized<T0>(arg0);
        let v0 = SubCallerKey<T0, T1>{dummy_field: false};
        0x2::dynamic_field::remove<SubCallerKey<T0, T1>, bool>(0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::get_id_mut(arg0), v0);
    }

    public fun has_caller_registry<T0: drop>(arg0: &0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi) : bool {
        let v0 = CallerKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_with_type<CallerKey<T0>, Registry>(0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::get_id(arg0), v0)
    }

    public fun is_friend_caller_authorized<T0: drop, T1: drop>(arg0: &0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi) : bool {
        0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::auth::assert_caller_is_authorized<T0>(arg0);
        let v0 = SubCallerKey<T0, T1>{dummy_field: false};
        0x2::dynamic_field::exists_with_type<SubCallerKey<T0, T1>, bool>(0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::get_id(arg0), v0)
    }

    // decompiled from Move bytecode v6
}

