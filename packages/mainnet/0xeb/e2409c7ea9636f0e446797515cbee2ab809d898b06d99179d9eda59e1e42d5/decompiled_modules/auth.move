module 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::auth {
    struct Auth has key {
        id: 0x2::object::UID,
        roles: 0x2::bag::Bag,
        owner_count: u64,
    }

    struct RoleKey<phantom T0> has copy, drop, store {
        owner: address,
    }

    struct OwnerRole has drop, store {
        dummy_field: bool,
    }

    struct ConfigRole has drop, store {
        dummy_field: bool,
    }

    public fun assert_has<T0>(arg0: &Auth, arg1: address) {
        assert!(has<T0>(arg0, arg1), 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::errors::auth_no_auth());
    }

    public fun grant<T0>(arg0: &mut Auth, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_has<OwnerRole>(arg0, 0x2::tx_context::sender(arg2));
        if (!has<T0>(arg0, arg1)) {
            0x2::bag::add<RoleKey<T0>, bool>(&mut arg0.roles, role_key<T0>(arg1), true);
            if (is_owner_role<T0>()) {
                arg0.owner_count = arg0.owner_count + 1;
            };
        };
    }

    public fun has<T0>(arg0: &Auth, arg1: address) : bool {
        0x2::bag::contains<RoleKey<T0>>(&arg0.roles, role_key<T0>(arg1))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Auth{
            id          : 0x2::object::new(arg0),
            roles       : 0x2::bag::new(arg0),
            owner_count : 1,
        };
        0x2::bag::add<RoleKey<OwnerRole>, bool>(&mut v0.roles, role_key<OwnerRole>(0x2::tx_context::sender(arg0)), true);
        0x2::bag::add<RoleKey<ConfigRole>, bool>(&mut v0.roles, role_key<ConfigRole>(0x2::tx_context::sender(arg0)), true);
        0x2::transfer::share_object<Auth>(v0);
    }

    fun is_owner_role<T0>() : bool {
        0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<OwnerRole>()
    }

    public fun revoke<T0>(arg0: &mut Auth, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_has<OwnerRole>(arg0, 0x2::tx_context::sender(arg2));
        if (has<T0>(arg0, arg1)) {
            if (is_owner_role<T0>()) {
                assert!(arg0.owner_count > 1, 0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::errors::auth_last_owner());
                arg0.owner_count = arg0.owner_count - 1;
            };
            0x2::bag::remove<RoleKey<T0>, bool>(&mut arg0.roles, role_key<T0>(arg1));
        };
    }

    fun role_key<T0>(arg0: address) : RoleKey<T0> {
        RoleKey<T0>{owner: arg0}
    }

    // decompiled from Move bytecode v7
}

