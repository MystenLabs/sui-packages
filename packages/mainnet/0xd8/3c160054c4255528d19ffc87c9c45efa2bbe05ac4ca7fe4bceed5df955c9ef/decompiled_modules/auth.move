module 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::auth {
    struct AdminRole has drop, store {
        dummy_field: bool,
    }

    struct AuthorizeRole has drop, store {
        dummy_field: bool,
    }

    struct GuardianRole has drop, store {
        dummy_field: bool,
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
        let v0 = RoleKey<AdminRole>{owner: arg1};
        assert!(!0x2::bag::contains<RoleKey<AdminRole>>(&arg0.roles, v0), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::auth_role_already_assigned());
        let v1 = RoleKey<AdminRole>{owner: arg1};
        let v2 = AdminRole{dummy_field: false};
        0x2::bag::add<RoleKey<AdminRole>, AdminRole>(&mut arg0.roles, v1, v2);
        arg0.admin_count = arg0.admin_count + 1;
        0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::events::emit_log_add_admin(arg1);
    }

    public(friend) fun assert_auth(arg0: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::registry::Registry, arg1: &Auth, arg2: &0x2::tx_context::TxContext) {
        0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::registry::assert_version(arg0);
        assert_is_auth(arg1, 0x2::tx_context::sender(arg2));
    }

    public(friend) fun assert_governance(arg0: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::registry::Registry, arg1: &Auth, arg2: &0x2::tx_context::TxContext) {
        0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::registry::assert_version(arg0);
        assert_is_governance(arg1, 0x2::tx_context::sender(arg2));
    }

    public(friend) fun assert_guardian(arg0: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::registry::Registry, arg1: &Auth, arg2: &0x2::tx_context::TxContext) {
        0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::registry::assert_version(arg0);
        assert_is_guardian(arg1, 0x2::tx_context::sender(arg2));
    }

    public(friend) fun assert_is_auth(arg0: &Auth, arg1: address) {
        assert!(get_is_auth(arg0, arg1), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::admin_module_only_auths());
    }

    public(friend) fun assert_is_governance(arg0: &Auth, arg1: address) {
        assert!(get_is_governance(arg0, arg1), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::admin_module_only_governance());
    }

    public(friend) fun assert_is_guardian(arg0: &Auth, arg1: address) {
        assert!(get_is_guardian(arg0, arg1), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::admin_module_only_guardians());
    }

    public fun get_admin_count(arg0: &Auth) : u64 {
        arg0.admin_count
    }

    public fun get_is_auth(arg0: &Auth, arg1: address) : bool {
        let v0 = RoleKey<AuthorizeRole>{owner: arg1};
        0x2::bag::contains<RoleKey<AuthorizeRole>>(&arg0.roles, v0) || get_is_governance(arg0, arg1)
    }

    public fun get_is_auth_record(arg0: &Auth, arg1: address) : bool {
        let v0 = RoleKey<AuthorizeRole>{owner: arg1};
        0x2::bag::contains<RoleKey<AuthorizeRole>>(&arg0.roles, v0)
    }

    public fun get_is_governance(arg0: &Auth, arg1: address) : bool {
        let v0 = RoleKey<AdminRole>{owner: arg1};
        0x2::bag::contains<RoleKey<AdminRole>>(&arg0.roles, v0)
    }

    public fun get_is_guardian(arg0: &Auth, arg1: address) : bool {
        let v0 = RoleKey<GuardianRole>{owner: arg1};
        0x2::bag::contains<RoleKey<GuardianRole>>(&arg0.roles, v0) || get_is_governance(arg0, arg1)
    }

    public fun get_is_guardian_record(arg0: &Auth, arg1: address) : bool {
        let v0 = RoleKey<GuardianRole>{owner: arg1};
        0x2::bag::contains<RoleKey<GuardianRole>>(&arg0.roles, v0)
    }

    public(friend) fun grant_auth_or_guardian_role<T0: drop + store>(arg0: &mut Auth, arg1: address) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(v0 != 0x1::type_name::with_defining_ids<AdminRole>(), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::auth_use_add_admin());
        assert!(v0 == 0x1::type_name::with_defining_ids<AuthorizeRole>() || v0 == 0x1::type_name::with_defining_ids<GuardianRole>(), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::admin_module_invalid_params());
        let v1 = RoleKey<T0>{owner: arg1};
        assert!(!0x2::bag::contains<RoleKey<T0>>(&arg0.roles, v1), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::auth_role_already_assigned());
        if (v0 == 0x1::type_name::with_defining_ids<AuthorizeRole>()) {
            let v2 = RoleKey<T0>{owner: arg1};
            let v3 = AuthorizeRole{dummy_field: false};
            0x2::bag::add<RoleKey<T0>, AuthorizeRole>(&mut arg0.roles, v2, v3);
        } else {
            let v4 = RoleKey<T0>{owner: arg1};
            let v5 = GuardianRole{dummy_field: false};
            0x2::bag::add<RoleKey<T0>, GuardianRole>(&mut arg0.roles, v4, v5);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bag::new(arg0);
        let v1 = RoleKey<AdminRole>{owner: 0x2::tx_context::sender(arg0)};
        let v2 = AdminRole{dummy_field: false};
        0x2::bag::add<RoleKey<AdminRole>, AdminRole>(&mut v0, v1, v2);
        let v3 = Auth{
            id          : 0x2::object::new(arg0),
            admin_count : 1,
            roles       : v0,
        };
        0x2::transfer::share_object<Auth>(v3);
    }

    public(friend) fun remove_admin(arg0: &mut Auth, arg1: address) {
        let v0 = RoleKey<AdminRole>{owner: arg1};
        assert!(0x2::bag::contains<RoleKey<AdminRole>>(&arg0.roles, v0), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::auth_role_not_assigned());
        assert!(arg0.admin_count > 1, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::auth_last_admin_not_removable());
        let v1 = RoleKey<AdminRole>{owner: arg1};
        let AdminRole {  } = 0x2::bag::remove<RoleKey<AdminRole>, AdminRole>(&mut arg0.roles, v1);
        arg0.admin_count = arg0.admin_count - 1;
        0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::events::emit_log_remove_admin(arg1);
    }

    public(friend) fun revoke_auth_or_guardian_role<T0: drop + store>(arg0: &mut Auth, arg1: address) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(v0 != 0x1::type_name::with_defining_ids<AdminRole>(), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::auth_use_add_admin());
        assert!(v0 == 0x1::type_name::with_defining_ids<AuthorizeRole>() || v0 == 0x1::type_name::with_defining_ids<GuardianRole>(), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::admin_module_invalid_params());
        let v1 = RoleKey<T0>{owner: arg1};
        assert!(0x2::bag::contains<RoleKey<T0>>(&arg0.roles, v1), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::auth_role_not_assigned());
        let v2 = RoleKey<T0>{owner: arg1};
        0x2::bag::remove<RoleKey<T0>, T0>(&mut arg0.roles, v2);
    }

    // decompiled from Move bytecode v7
}

