module 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::auth {
    struct AdminRole has drop, store {
        dummy_field: bool,
    }

    struct AuthorizeRole has drop, store {
        dummy_field: bool,
    }

    struct GuardianRole has drop, store {
        dummy_field: bool,
    }

    struct MigrateRole has drop, store {
        dummy_field: bool,
    }

    struct RoleKey<phantom T0> has copy, drop, store {
        owner: address,
    }

    struct Auth has key {
        id: 0x2::object::UID,
        admin_count: u64,
        roles: 0x2::bag::Bag,
        timelock_cap: 0x1::option::Option<0x2::object::ID>,
    }

    public(friend) fun add_admin(arg0: &mut Auth, arg1: address) {
        let v0 = RoleKey<AdminRole>{owner: arg1};
        assert!(!0x2::bag::contains<RoleKey<AdminRole>>(&arg0.roles, v0), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::auth_role_already_assigned());
        let v1 = RoleKey<AdminRole>{owner: arg1};
        let v2 = AdminRole{dummy_field: false};
        0x2::bag::add<RoleKey<AdminRole>, AdminRole>(&mut arg0.roles, v1, v2);
        arg0.admin_count = arg0.admin_count + 1;
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::events::emit_log_add_admin(arg1);
    }

    public(friend) fun assert_auth(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg1: &Auth, arg2: 0x1::option::Option<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockTicket>, arg3: &0x2::tx_context::TxContext) {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::assert_version(arg0);
        assert!(get_is_auth(arg1, 0x2::tx_context::sender(arg3)), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_only_auths());
        assert_ticket(arg1, arg2);
    }

    public fun timelock_cap(arg0: &Auth) : 0x1::option::Option<0x2::object::ID> {
        arg0.timelock_cap
    }

    public(friend) fun assert_governance(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg1: &Auth, arg2: 0x1::option::Option<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockTicket>, arg3: &0x2::tx_context::TxContext) {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::assert_version(arg0);
        assert_is_governance_direct(arg1, arg3);
        assert_ticket(arg1, arg2);
    }

    public(friend) fun assert_guardian(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg1: &Auth, arg2: &0x2::tx_context::TxContext) {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::assert_version(arg0);
        assert_is_guardian(arg1, arg2);
    }

    public(friend) fun assert_is_governance_direct(arg0: &Auth, arg1: &0x2::tx_context::TxContext) {
        assert!(get_is_governance(arg0, 0x2::tx_context::sender(arg1)), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_only_governance());
    }

    public(friend) fun assert_is_guardian(arg0: &Auth, arg1: &0x2::tx_context::TxContext) {
        assert!(get_is_guardian(arg0, 0x2::tx_context::sender(arg1)), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_only_guardians());
    }

    public(friend) fun assert_is_migrator(arg0: &Auth, arg1: &0x2::tx_context::TxContext) {
        assert!(get_is_migrator(arg0, 0x2::tx_context::sender(arg1)), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_only_migrators());
    }

    fun assert_ticket(arg0: &Auth, arg1: 0x1::option::Option<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockTicket>) {
        if (0x1::option::is_some<0x2::object::ID>(&arg0.timelock_cap)) {
            assert!(0x1::option::is_some<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockTicket>(&arg1), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::auth_timelock_ticket_required());
            assert!(0x1::option::some<0x2::object::ID>(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::cap_id(0x1::option::borrow<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockTicket>(&arg1))) == arg0.timelock_cap, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::auth_wrong_timelock_cap());
        };
    }

    public(friend) fun disable_timelock(arg0: &mut Auth, arg1: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockCap) {
        assert!(arg0.timelock_cap == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockCap>(&arg1)), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::auth_wrong_timelock_cap());
        arg0.timelock_cap = 0x1::option::none<0x2::object::ID>();
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::delete(arg1);
    }

    public(friend) fun enable_timelock(arg0: &mut Auth, arg1: &mut 0x2::tx_context::TxContext) : 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockCap {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.timelock_cap), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::auth_timelock_already_enabled());
        let v0 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::new(arg1);
        arg0.timelock_cap = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockCap>(&v0));
        v0
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

    public fun get_is_migrator(arg0: &Auth, arg1: address) : bool {
        let v0 = RoleKey<MigrateRole>{owner: arg1};
        0x2::bag::contains<RoleKey<MigrateRole>>(&arg0.roles, v0) || get_is_auth(arg0, arg1)
    }

    public fun get_is_migrator_record(arg0: &Auth, arg1: address) : bool {
        let v0 = RoleKey<MigrateRole>{owner: arg1};
        0x2::bag::contains<RoleKey<MigrateRole>>(&arg0.roles, v0)
    }

    public(friend) fun grant_role<T0: drop + store>(arg0: &mut Auth, arg1: address) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(v0 != 0x1::type_name::with_defining_ids<AdminRole>(), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::auth_use_add_admin());
        assert!(is_record_role(v0), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_invalid_params());
        let v1 = RoleKey<T0>{owner: arg1};
        assert!(!0x2::bag::contains<RoleKey<T0>>(&arg0.roles, v1), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::auth_role_already_assigned());
        if (v0 == 0x1::type_name::with_defining_ids<AuthorizeRole>()) {
            let v2 = RoleKey<T0>{owner: arg1};
            let v3 = AuthorizeRole{dummy_field: false};
            0x2::bag::add<RoleKey<T0>, AuthorizeRole>(&mut arg0.roles, v2, v3);
        } else if (v0 == 0x1::type_name::with_defining_ids<GuardianRole>()) {
            let v4 = RoleKey<T0>{owner: arg1};
            let v5 = GuardianRole{dummy_field: false};
            0x2::bag::add<RoleKey<T0>, GuardianRole>(&mut arg0.roles, v4, v5);
        } else {
            let v6 = RoleKey<T0>{owner: arg1};
            let v7 = MigrateRole{dummy_field: false};
            0x2::bag::add<RoleKey<T0>, MigrateRole>(&mut arg0.roles, v6, v7);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bag::new(arg0);
        let v1 = RoleKey<AdminRole>{owner: 0x2::tx_context::sender(arg0)};
        let v2 = AdminRole{dummy_field: false};
        0x2::bag::add<RoleKey<AdminRole>, AdminRole>(&mut v0, v1, v2);
        let v3 = Auth{
            id           : 0x2::object::new(arg0),
            admin_count  : 1,
            roles        : v0,
            timelock_cap : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::share_object<Auth>(v3);
    }

    fun is_record_role(arg0: 0x1::type_name::TypeName) : bool {
        if (arg0 == 0x1::type_name::with_defining_ids<AuthorizeRole>()) {
            true
        } else if (arg0 == 0x1::type_name::with_defining_ids<GuardianRole>()) {
            true
        } else {
            arg0 == 0x1::type_name::with_defining_ids<MigrateRole>()
        }
    }

    public fun is_timelock_enabled(arg0: &Auth) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.timelock_cap)
    }

    public(friend) fun remove_admin(arg0: &mut Auth, arg1: address) {
        let v0 = RoleKey<AdminRole>{owner: arg1};
        assert!(0x2::bag::contains<RoleKey<AdminRole>>(&arg0.roles, v0), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::auth_role_not_assigned());
        assert!(arg0.admin_count > 1, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::auth_last_admin_not_removable());
        let v1 = RoleKey<AdminRole>{owner: arg1};
        let AdminRole {  } = 0x2::bag::remove<RoleKey<AdminRole>, AdminRole>(&mut arg0.roles, v1);
        arg0.admin_count = arg0.admin_count - 1;
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::events::emit_log_remove_admin(arg1);
    }

    public(friend) fun revoke_role<T0: drop + store>(arg0: &mut Auth, arg1: address) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(v0 != 0x1::type_name::with_defining_ids<AdminRole>(), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::auth_use_add_admin());
        assert!(is_record_role(v0), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_invalid_params());
        let v1 = RoleKey<T0>{owner: arg1};
        assert!(0x2::bag::contains<RoleKey<T0>>(&arg0.roles, v1), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::auth_role_not_assigned());
        let v2 = RoleKey<T0>{owner: arg1};
        0x2::bag::remove<RoleKey<T0>, T0>(&mut arg0.roles, v2);
    }

    public fun timelock_ticket(arg0: &Auth, arg1: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockCap) : 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockTicket {
        assert!(arg0.timelock_cap == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::TimelockCap>(arg1)), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::auth_wrong_timelock_cap());
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::timelock_cap::new_ticket(arg1)
    }

    // decompiled from Move bytecode v7
}

