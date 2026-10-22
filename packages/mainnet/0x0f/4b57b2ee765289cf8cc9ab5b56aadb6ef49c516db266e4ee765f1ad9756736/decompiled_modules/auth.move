module 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::auth {
    struct AdminRole has drop, store {
        dummy_field: bool,
    }

    struct RebalancerRole has drop, store {
        dummy_field: bool,
    }

    struct MigrateRole has drop, store {
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
        timelock_cap: 0x1::option::Option<0x2::object::ID>,
    }

    public(friend) fun add_admin(arg0: &mut Auth, arg1: address) {
        let v0 = AdminRoleKey{owner: arg1};
        assert!(!0x2::bag::contains<AdminRoleKey>(&arg0.roles, v0), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::role_already_assigned());
        let v1 = AdminRoleKey{owner: arg1};
        let v2 = AdminRole{dummy_field: false};
        0x2::bag::add<AdminRoleKey, AdminRole>(&mut arg0.roles, v1, v2);
        arg0.admin_count = arg0.admin_count + 1;
    }

    public(friend) fun assert_admin(arg0: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::LendingRegistry, arg1: &Auth, arg2: 0x1::option::Option<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::timelock_cap::TimelockTicket>, arg3: &0x2::tx_context::TxContext) {
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::assert_version(arg0);
        assert_is_admin_direct(arg1, arg3);
        assert_ticket(arg1, arg2);
    }

    public fun timelock_cap(arg0: &Auth) : 0x1::option::Option<0x2::object::ID> {
        arg0.timelock_cap
    }

    public(friend) fun assert_has_role<T0: drop + store>(arg0: &Auth, arg1: &0x2::tx_context::TxContext) {
        assert!(has_role<T0>(arg0, 0x2::tx_context::sender(arg1)), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::f_token_unauthorized());
    }

    public(friend) fun assert_is_admin_direct(arg0: &Auth, arg1: &0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg1)), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::f_token_unauthorized());
    }

    public(friend) fun assert_is_migrator(arg0: &Auth, arg1: &0x2::tx_context::TxContext) {
        assert!(is_migrator(arg0, 0x2::tx_context::sender(arg1)), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::f_token_unauthorized());
    }

    public(friend) fun assert_role<T0: drop + store>(arg0: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::LendingRegistry, arg1: &Auth, arg2: &0x2::tx_context::TxContext) {
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::assert_version(arg0);
        assert_has_role<T0>(arg1, arg2);
    }

    fun assert_ticket(arg0: &Auth, arg1: 0x1::option::Option<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::timelock_cap::TimelockTicket>) {
        if (0x1::option::is_some<0x2::object::ID>(&arg0.timelock_cap)) {
            assert!(0x1::option::is_some<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::timelock_cap::TimelockTicket>(&arg1), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::timelock_ticket_required());
            assert!(0x1::option::some<0x2::object::ID>(0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::timelock_cap::cap_id(0x1::option::borrow<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::timelock_cap::TimelockTicket>(&arg1))) == arg0.timelock_cap, 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::wrong_timelock_cap());
        };
    }

    public(friend) fun disable_timelock(arg0: &mut Auth, arg1: 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::timelock_cap::TimelockCap) {
        assert!(arg0.timelock_cap == 0x1::option::some<0x2::object::ID>(0x2::object::id<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::timelock_cap::TimelockCap>(&arg1)), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::wrong_timelock_cap());
        arg0.timelock_cap = 0x1::option::none<0x2::object::ID>();
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::timelock_cap::delete(arg1);
    }

    public(friend) fun enable_timelock(arg0: &mut Auth, arg1: &mut 0x2::tx_context::TxContext) : 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::timelock_cap::TimelockCap {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.timelock_cap), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::timelock_already_enabled());
        let v0 = 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::timelock_cap::new(arg1);
        arg0.timelock_cap = 0x1::option::some<0x2::object::ID>(0x2::object::id<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::timelock_cap::TimelockCap>(&v0));
        v0
    }

    public(friend) fun grant_operator_role<T0: drop + store>(arg0: &mut Auth, arg1: address) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(v0 != 0x1::type_name::with_defining_ids<AdminRole>(), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::f_token_invalid_params());
        let v1 = RoleKey<T0>{owner: arg1};
        assert!(!0x2::bag::contains<RoleKey<T0>>(&arg0.roles, v1), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::role_already_assigned());
        if (v0 == 0x1::type_name::with_defining_ids<RebalancerRole>()) {
            let v2 = RoleKey<T0>{owner: arg1};
            let v3 = RebalancerRole{dummy_field: false};
            0x2::bag::add<RoleKey<T0>, RebalancerRole>(&mut arg0.roles, v2, v3);
        } else {
            assert!(v0 == 0x1::type_name::with_defining_ids<MigrateRole>(), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::f_token_invalid_params());
            let v4 = RoleKey<T0>{owner: arg1};
            let v5 = MigrateRole{dummy_field: false};
            0x2::bag::add<RoleKey<T0>, MigrateRole>(&mut arg0.roles, v4, v5);
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
            id           : 0x2::object::new(arg0),
            admin_count  : 1,
            roles        : v0,
            timelock_cap : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::share_object<Auth>(v3);
    }

    public fun is_admin(arg0: &Auth, arg1: address) : bool {
        let v0 = AdminRoleKey{owner: arg1};
        0x2::bag::contains<AdminRoleKey>(&arg0.roles, v0)
    }

    public fun is_migrator(arg0: &Auth, arg1: address) : bool {
        has_role<MigrateRole>(arg0, arg1) || is_admin(arg0, arg1)
    }

    public fun is_timelock_enabled(arg0: &Auth) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.timelock_cap)
    }

    public(friend) fun remove_admin(arg0: &mut Auth, arg1: address) {
        let v0 = AdminRoleKey{owner: arg1};
        assert!(0x2::bag::contains<AdminRoleKey>(&arg0.roles, v0), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::role_not_assigned());
        assert!(arg0.admin_count > 1, 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::last_admin_not_removable());
        let v1 = AdminRoleKey{owner: arg1};
        let AdminRole {  } = 0x2::bag::remove<AdminRoleKey, AdminRole>(&mut arg0.roles, v1);
        arg0.admin_count = arg0.admin_count - 1;
    }

    public(friend) fun revoke_operator_role<T0: drop + store>(arg0: &mut Auth, arg1: address) {
        let v0 = RoleKey<T0>{owner: arg1};
        assert!(0x2::bag::contains<RoleKey<T0>>(&arg0.roles, v0), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::role_not_assigned());
        let v1 = RoleKey<T0>{owner: arg1};
        0x2::bag::remove<RoleKey<T0>, T0>(&mut arg0.roles, v1);
    }

    public fun timelock_ticket(arg0: &Auth, arg1: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::timelock_cap::TimelockCap) : 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::timelock_cap::TimelockTicket {
        assert!(arg0.timelock_cap == 0x1::option::some<0x2::object::ID>(0x2::object::id<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::timelock_cap::TimelockCap>(arg1)), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::wrong_timelock_cap());
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::timelock_cap::new_ticket(arg1)
    }

    // decompiled from Move bytecode v7
}

