module 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::auth {
    struct AdminRole has drop, store {
        dummy_field: bool,
    }

    struct RateAdminRole has drop, store {
        dummy_field: bool,
    }

    struct RebalancerRole has drop, store {
        dummy_field: bool,
    }

    struct AdminRoleKey has copy, drop, store {
        owner: address,
    }

    struct RoleKey<phantom T0> has copy, drop, store {
        owner: address,
    }

    struct Auth has key {
        id: 0x2::object::UID,
        admin_count: u64,
        roles: 0x2::bag::Bag,
    }

    public(friend) fun add_admin(arg0: &mut Auth, arg1: address) {
        let v0 = AdminRoleKey{owner: arg1};
        assert!(!0x2::bag::contains<AdminRoleKey>(&arg0.roles, v0), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::errors::role_already_assigned());
        let v1 = AdminRoleKey{owner: arg1};
        let v2 = AdminRole{dummy_field: false};
        0x2::bag::add<AdminRoleKey, AdminRole>(&mut arg0.roles, v1, v2);
        arg0.admin_count = arg0.admin_count + 1;
    }

    public(friend) fun assert_admin(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::registry::LendingRegistry, arg1: &Auth, arg2: &0x2::tx_context::TxContext) {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::registry::assert_version(arg0);
        assert_is_admin(arg1, 0x2::tx_context::sender(arg2));
    }

    public(friend) fun assert_has_role<T0: drop + store>(arg0: &Auth, arg1: address) {
        assert!(has_role<T0>(arg0, arg1), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::errors::f_token_unauthorized());
    }

    public(friend) fun assert_is_admin(arg0: &Auth, arg1: address) {
        assert!(is_admin(arg0, arg1), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::errors::f_token_unauthorized());
    }

    public(friend) fun assert_role<T0: drop + store>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::registry::LendingRegistry, arg1: &Auth, arg2: &0x2::tx_context::TxContext) {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::registry::assert_version(arg0);
        assert_has_role<T0>(arg1, 0x2::tx_context::sender(arg2));
    }

    public(friend) fun grant_rate_admin_or_rebalancer_role<T0: drop + store>(arg0: &mut Auth, arg1: address) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(v0 != 0x1::type_name::with_defining_ids<AdminRole>(), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::errors::f_token_invalid_params());
        let v1 = RoleKey<T0>{owner: arg1};
        assert!(!0x2::bag::contains<RoleKey<T0>>(&arg0.roles, v1), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::errors::role_already_assigned());
        if (v0 == 0x1::type_name::with_defining_ids<RateAdminRole>()) {
            let v2 = RoleKey<T0>{owner: arg1};
            let v3 = RateAdminRole{dummy_field: false};
            0x2::bag::add<RoleKey<T0>, RateAdminRole>(&mut arg0.roles, v2, v3);
        } else {
            assert!(v0 == 0x1::type_name::with_defining_ids<RebalancerRole>(), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::errors::f_token_invalid_params());
            let v4 = RoleKey<T0>{owner: arg1};
            let v5 = RebalancerRole{dummy_field: false};
            0x2::bag::add<RoleKey<T0>, RebalancerRole>(&mut arg0.roles, v4, v5);
        };
    }

    public fun has_role<T0: drop + store>(arg0: &Auth, arg1: address) : bool {
        let v0 = RoleKey<T0>{owner: arg1};
        0x2::bag::contains<RoleKey<T0>>(&arg0.roles, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bag::new(arg0);
        let v1 = AdminRoleKey{owner: 0x2::tx_context::sender(arg0)};
        let v2 = AdminRole{dummy_field: false};
        0x2::bag::add<AdminRoleKey, AdminRole>(&mut v0, v1, v2);
        let v3 = Auth{
            id          : 0x2::object::new(arg0),
            admin_count : 1,
            roles       : v0,
        };
        0x2::transfer::share_object<Auth>(v3);
    }

    public fun is_admin(arg0: &Auth, arg1: address) : bool {
        let v0 = AdminRoleKey{owner: arg1};
        0x2::bag::contains<AdminRoleKey>(&arg0.roles, v0)
    }

    public(friend) fun remove_admin(arg0: &mut Auth, arg1: address) {
        let v0 = AdminRoleKey{owner: arg1};
        assert!(0x2::bag::contains<AdminRoleKey>(&arg0.roles, v0), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::errors::role_not_assigned());
        assert!(arg0.admin_count > 1, 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::errors::last_admin_not_removable());
        let v1 = AdminRoleKey{owner: arg1};
        let AdminRole {  } = 0x2::bag::remove<AdminRoleKey, AdminRole>(&mut arg0.roles, v1);
        arg0.admin_count = arg0.admin_count - 1;
    }

    public(friend) fun revoke_rate_admin_or_rebalancer_role<T0: drop + store>(arg0: &mut Auth, arg1: address) {
        let v0 = RoleKey<T0>{owner: arg1};
        assert!(0x2::bag::contains<RoleKey<T0>>(&arg0.roles, v0), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::errors::role_not_assigned());
        let v1 = RoleKey<T0>{owner: arg1};
        0x2::bag::remove<RoleKey<T0>, T0>(&mut arg0.roles, v1);
    }

    // decompiled from Move bytecode v7
}

