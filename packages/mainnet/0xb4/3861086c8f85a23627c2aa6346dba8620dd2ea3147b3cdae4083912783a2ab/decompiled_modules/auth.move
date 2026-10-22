module 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::auth {
    struct AdminRole has drop, store {
        dummy_field: bool,
    }

    struct AuthorizeRole has drop, store {
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
        roles: 0x2::bag::Bag,
        admin_count: u64,
        timelock_cap: 0x1::option::Option<0x2::object::ID>,
    }

    public fun admin_count(arg0: &Auth) : u64 {
        arg0.admin_count
    }

    public fun assert_has<T0: drop + store>(arg0: &Auth, arg1: 0x1::option::Option<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::timelock_cap::TimelockTicket>, arg2: &0x2::tx_context::TxContext) {
        assert_has_direct<T0>(arg0, arg2);
        assert_ticket(arg0, arg1);
    }

    public fun timelock_cap(arg0: &Auth) : 0x1::option::Option<0x2::object::ID> {
        arg0.timelock_cap
    }

    public fun assert_has_direct<T0: drop + store>(arg0: &Auth, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = is_authorize_role<T0>() && has<AdminRole>(arg0, v0) || is_migrate_role<T0>() && (has<AuthorizeRole>(arg0, v0) || has<AdminRole>(arg0, v0));
        assert!(has<T0>(arg0, v0) || v1, 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::errors::auth_no_auth());
    }

    fun assert_ticket(arg0: &Auth, arg1: 0x1::option::Option<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::timelock_cap::TimelockTicket>) {
        if (0x1::option::is_some<0x2::object::ID>(&arg0.timelock_cap)) {
            assert!(0x1::option::is_some<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::timelock_cap::TimelockTicket>(&arg1), 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::errors::auth_timelock_ticket_required());
            assert!(0x1::option::some<0x2::object::ID>(0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::timelock_cap::cap_id(0x1::option::borrow<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::timelock_cap::TimelockTicket>(&arg1))) == arg0.timelock_cap, 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::errors::auth_wrong_timelock_cap());
        };
    }

    public(friend) fun disable_timelock(arg0: &mut Auth, arg1: 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::timelock_cap::TimelockCap) {
        assert!(arg0.timelock_cap == 0x1::option::some<0x2::object::ID>(0x2::object::id<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::timelock_cap::TimelockCap>(&arg1)), 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::errors::auth_wrong_timelock_cap());
        arg0.timelock_cap = 0x1::option::none<0x2::object::ID>();
        0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::timelock_cap::delete(arg1);
    }

    public(friend) fun enable_timelock(arg0: &mut Auth, arg1: &mut 0x2::tx_context::TxContext) : 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::timelock_cap::TimelockCap {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.timelock_cap), 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::errors::auth_timelock_already_enabled());
        let v0 = 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::timelock_cap::new(arg1);
        arg0.timelock_cap = 0x1::option::some<0x2::object::ID>(0x2::object::id<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::timelock_cap::TimelockCap>(&v0));
        v0
    }

    public(friend) fun grant<T0: drop + store>(arg0: &mut Auth, arg1: 0x1::option::Option<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::timelock_cap::TimelockTicket>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_has<AdminRole>(arg0, arg1, arg3);
        assert!(arg2 != @0x0, 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::errors::auth_zero_address());
        let v0 = RoleKey<T0>{owner: arg2};
        assert!(!0x2::bag::contains<RoleKey<T0>>(&arg0.roles, v0), 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::errors::auth_role_already_assigned());
        let v1 = RoleKey<T0>{owner: arg2};
        0x2::bag::add<RoleKey<T0>, bool>(&mut arg0.roles, v1, true);
        if (is_admin_role<T0>()) {
            arg0.admin_count = arg0.admin_count + 1;
        };
        0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::events::emit_log_role_updated(0x1::type_name::with_defining_ids<T0>(), arg2, true);
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
            id           : 0x2::object::new(arg0),
            roles        : v0,
            admin_count  : 1,
            timelock_cap : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::share_object<Auth>(v2);
    }

    fun is_admin_role<T0>() : bool {
        0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<AdminRole>()
    }

    fun is_authorize_role<T0>() : bool {
        0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<AuthorizeRole>()
    }

    fun is_migrate_role<T0>() : bool {
        0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<MigrateRole>()
    }

    public fun is_timelock_enabled(arg0: &Auth) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.timelock_cap)
    }

    public(friend) fun revoke<T0: drop + store>(arg0: &mut Auth, arg1: 0x1::option::Option<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::timelock_cap::TimelockTicket>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_has<AdminRole>(arg0, arg1, arg3);
        let v0 = RoleKey<T0>{owner: arg2};
        assert!(0x2::bag::contains<RoleKey<T0>>(&arg0.roles, v0), 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::errors::auth_role_not_assigned());
        if (is_admin_role<T0>()) {
            assert!(arg0.admin_count > 1, 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::errors::auth_last_admin());
            arg0.admin_count = arg0.admin_count - 1;
        };
        let v1 = RoleKey<T0>{owner: arg2};
        0x2::bag::remove<RoleKey<T0>, bool>(&mut arg0.roles, v1);
        0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::events::emit_log_role_updated(0x1::type_name::with_defining_ids<T0>(), arg2, false);
    }

    public fun timelock_ticket(arg0: &Auth, arg1: &0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::timelock_cap::TimelockCap) : 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::timelock_cap::TimelockTicket {
        assert!(arg0.timelock_cap == 0x1::option::some<0x2::object::ID>(0x2::object::id<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::timelock_cap::TimelockCap>(arg1)), 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::errors::auth_wrong_timelock_cap());
        0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::timelock_cap::new_ticket(arg1)
    }

    // decompiled from Move bytecode v7
}

