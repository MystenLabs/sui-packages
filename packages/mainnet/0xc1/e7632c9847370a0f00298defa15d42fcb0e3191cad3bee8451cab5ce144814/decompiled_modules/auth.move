module 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::auth {
    struct AdminRole has drop, store {
        dummy_field: bool,
    }

    struct AuthorizeRole has drop, store {
        dummy_field: bool,
    }

    struct RoleKey<phantom T0> has copy, drop, store {
        owner: address,
    }

    struct Auth has key {
        id: 0x2::object::UID,
        roles: 0x2::bag::Bag,
        admin_count: u64,
    }

    public fun assert_has<T0: drop + store>(arg0: &Auth, arg1: address) {
        assert!(has<T0>(arg0, arg1), 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::errors::auth_no_auth());
    }

    public(friend) fun grant<T0: drop + store>(arg0: &mut Auth, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_has<AdminRole>(arg0, 0x2::tx_context::sender(arg2));
        let v0 = RoleKey<T0>{owner: arg1};
        assert!(!0x2::bag::contains<RoleKey<T0>>(&arg0.roles, v0), 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::errors::auth_role_already_assigned());
        let v1 = RoleKey<T0>{owner: arg1};
        0x2::bag::add<RoleKey<T0>, bool>(&mut arg0.roles, v1, true);
        if (is_admin_role<T0>()) {
            arg0.admin_count = arg0.admin_count + 1;
        };
    }

    public fun has<T0: drop + store>(arg0: &Auth, arg1: address) : bool {
        let v0 = RoleKey<T0>{owner: arg1};
        0x2::bag::contains<RoleKey<T0>>(&arg0.roles, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bag::new(arg0);
        let v1 = RoleKey<AdminRole>{owner: 0x2::tx_context::sender(arg0)};
        0x2::bag::add<RoleKey<AdminRole>, bool>(&mut v0, v1, true);
        let v2 = Auth{
            id          : 0x2::object::new(arg0),
            roles       : v0,
            admin_count : 1,
        };
        0x2::transfer::share_object<Auth>(v2);
    }

    fun is_admin_role<T0>() : bool {
        0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<AdminRole>()
    }

    public(friend) fun revoke<T0: drop + store>(arg0: &mut Auth, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_has<AdminRole>(arg0, 0x2::tx_context::sender(arg2));
        let v0 = RoleKey<T0>{owner: arg1};
        assert!(0x2::bag::contains<RoleKey<T0>>(&arg0.roles, v0), 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::errors::auth_role_not_assigned());
        if (is_admin_role<T0>()) {
            assert!(arg0.admin_count > 1, 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::errors::auth_last_admin());
            arg0.admin_count = arg0.admin_count - 1;
        };
        let v1 = RoleKey<T0>{owner: arg1};
        0x2::bag::remove<RoleKey<T0>, bool>(&mut arg0.roles, v1);
    }

    // decompiled from Move bytecode v7
}

