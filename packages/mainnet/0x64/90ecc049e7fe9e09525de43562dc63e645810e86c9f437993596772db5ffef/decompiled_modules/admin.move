module 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::admin {
    struct ADMIN has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct AuthKey<phantom T0: drop> has copy, drop, store {
        dummy_field: bool,
    }

    public entry fun authorize_caller<T0: drop>(arg0: &mut AdminCap, arg1: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::auth::is_caller_authorized<T0>(arg1)) {
            0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::auth::authorize_caller<T0>(arg1);
            if (!0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::has_caller_registry<T0>(arg1)) {
                0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::create_caller_registry<T0>(arg1, arg2);
            };
        };
    }

    public entry fun deauthorize_caller<T0: drop>(arg0: &mut AdminCap, arg1: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::shared::Pi, arg2: &0x2::tx_context::TxContext) {
        if (0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::auth::is_caller_authorized<T0>(arg1)) {
            0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::auth::deauthorize_caller<T0>(arg1);
        };
    }

    fun init(arg0: ADMIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id    : 0x2::object::new(arg1),
            owner : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

