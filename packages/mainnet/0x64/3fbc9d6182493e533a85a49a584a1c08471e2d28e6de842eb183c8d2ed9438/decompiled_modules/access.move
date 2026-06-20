module 0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::access {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ExecutorCap has store, key {
        id: 0x2::object::UID,
    }

    struct AccessRegistry has key {
        id: 0x2::object::UID,
        revoked: 0x2::table::Table<0x2::object::ID, bool>,
        revoked_admins: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct AccessRegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
    }

    struct ExecutorCapMinted has copy, drop {
        cap_id: 0x2::object::ID,
        recipient: address,
    }

    struct AdminCapMinted has copy, drop {
        cap_id: 0x2::object::ID,
        recipient: address,
    }

    struct ExecutorCapRevoked has copy, drop {
        registry_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        revoked_by: address,
        timestamp_ms: u64,
    }

    struct ExecutorCapRestored has copy, drop {
        registry_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        restored_by: address,
        timestamp_ms: u64,
    }

    struct AdminCapRevoked has copy, drop {
        registry_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        revoked_by: address,
        timestamp_ms: u64,
    }

    struct AdminCapRestored has copy, drop {
        registry_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        restored_by: address,
        timestamp_ms: u64,
    }

    public fun assert_admin(arg0: &AccessRegistry, arg1: &AdminCap) {
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg0.revoked_admins, 0x2::object::id<AdminCap>(arg1)), 2);
    }

    public fun assert_executor(arg0: &AccessRegistry, arg1: &ExecutorCap) {
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg0.revoked, 0x2::object::id<ExecutorCap>(arg1)), 1);
    }

    public fun burn_executor_cap(arg0: ExecutorCap) {
        let ExecutorCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = AdminCapMinted{
            cap_id    : 0x2::object::id<AdminCap>(&v1),
            recipient : v0,
        };
        0x2::event::emit<AdminCapMinted>(v2);
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v3 = ExecutorCap{id: 0x2::object::new(arg0)};
        let v4 = ExecutorCapMinted{
            cap_id    : 0x2::object::id<ExecutorCap>(&v3),
            recipient : v0,
        };
        0x2::event::emit<ExecutorCapMinted>(v4);
        0x2::transfer::transfer<ExecutorCap>(v3, v0);
        let v5 = AccessRegistry{
            id             : 0x2::object::new(arg0),
            revoked        : 0x2::table::new<0x2::object::ID, bool>(arg0),
            revoked_admins : 0x2::table::new<0x2::object::ID, bool>(arg0),
        };
        let v6 = AccessRegistryCreated{registry_id: 0x2::object::id<AccessRegistry>(&v5)};
        0x2::event::emit<AccessRegistryCreated>(v6);
        0x2::transfer::share_object<AccessRegistry>(v5);
    }

    public fun is_admin_revoked(arg0: &AccessRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.revoked_admins, arg1)
    }

    public fun is_executor_revoked(arg0: &AccessRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.revoked, arg1)
    }

    public fun new_admin_cap(arg0: &AdminCap, arg1: &AccessRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg1, arg0);
        let v0 = AdminCap{id: 0x2::object::new(arg3)};
        let v1 = AdminCapMinted{
            cap_id    : 0x2::object::id<AdminCap>(&v0),
            recipient : arg2,
        };
        0x2::event::emit<AdminCapMinted>(v1);
        0x2::transfer::transfer<AdminCap>(v0, arg2);
    }

    public fun new_executor_cap(arg0: &AdminCap, arg1: &AccessRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg1, arg0);
        let v0 = ExecutorCap{id: 0x2::object::new(arg3)};
        let v1 = ExecutorCapMinted{
            cap_id    : 0x2::object::id<ExecutorCap>(&v0),
            recipient : arg2,
        };
        0x2::event::emit<ExecutorCapMinted>(v1);
        0x2::transfer::transfer<ExecutorCap>(v0, arg2);
    }

    public fun restore_admin_cap(arg0: &AdminCap, arg1: &mut AccessRegistry, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg0);
        if (0x2::table::contains<0x2::object::ID, bool>(&arg1.revoked_admins, arg2)) {
            0x2::table::remove<0x2::object::ID, bool>(&mut arg1.revoked_admins, arg2);
        };
        let v0 = AdminCapRestored{
            registry_id  : 0x2::object::id<AccessRegistry>(arg1),
            cap_id       : arg2,
            restored_by  : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AdminCapRestored>(v0);
    }

    public fun restore_executor_cap(arg0: &AdminCap, arg1: &mut AccessRegistry, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg0);
        if (0x2::table::contains<0x2::object::ID, bool>(&arg1.revoked, arg2)) {
            0x2::table::remove<0x2::object::ID, bool>(&mut arg1.revoked, arg2);
        };
        let v0 = ExecutorCapRestored{
            registry_id  : 0x2::object::id<AccessRegistry>(arg1),
            cap_id       : arg2,
            restored_by  : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ExecutorCapRestored>(v0);
    }

    public fun revoke_admin_cap(arg0: &AdminCap, arg1: &mut AccessRegistry, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg0);
        if (!0x2::table::contains<0x2::object::ID, bool>(&arg1.revoked_admins, arg2)) {
            0x2::table::add<0x2::object::ID, bool>(&mut arg1.revoked_admins, arg2, true);
        };
        let v0 = AdminCapRevoked{
            registry_id  : 0x2::object::id<AccessRegistry>(arg1),
            cap_id       : arg2,
            revoked_by   : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AdminCapRevoked>(v0);
    }

    public fun revoke_executor_cap(arg0: &AdminCap, arg1: &mut AccessRegistry, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg0);
        if (!0x2::table::contains<0x2::object::ID, bool>(&arg1.revoked, arg2)) {
            0x2::table::add<0x2::object::ID, bool>(&mut arg1.revoked, arg2, true);
        };
        let v0 = ExecutorCapRevoked{
            registry_id  : 0x2::object::id<AccessRegistry>(arg1),
            cap_id       : arg2,
            revoked_by   : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ExecutorCapRevoked>(v0);
    }

    // decompiled from Move bytecode v7
}

