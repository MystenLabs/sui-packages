module 0x5d46ec8c0db952054a7b5a3961501881f1f0fe1f9311134af682442b4209cb4c::access_control {
    struct TenantAdmin has copy, drop, store {
        tenant_id: vector<u8>,
        admin: address,
    }

    struct AdminKey has store, key {
        id: 0x2::object::UID,
        tenant_admins: 0x2::bag::Bag,
    }

    struct ExecutorAdmin has copy, drop, store {
        admin: address,
    }

    struct Executor has store, key {
        id: 0x2::object::UID,
        executor_admins: 0x2::bag::Bag,
    }

    public fun add_executor(arg0: &mut Executor, arg1: address) {
        let v0 = ExecutorAdmin{admin: arg1};
        if (0x2::bag::contains<ExecutorAdmin>(&arg0.executor_admins, v0)) {
            abort 2
        };
        0x2::bag::add<ExecutorAdmin, bool>(&mut arg0.executor_admins, v0, true);
    }

    public fun add_tenant_admin(arg0: &mut AdminKey, arg1: vector<u8>, arg2: address) {
        let v0 = TenantAdmin{
            tenant_id : arg1,
            admin     : arg2,
        };
        if (0x2::bag::contains<TenantAdmin>(&arg0.tenant_admins, v0)) {
            abort 2
        };
        0x2::bag::add<TenantAdmin, bool>(&mut arg0.tenant_admins, v0, true);
    }

    public fun assert_admin(arg0: address, arg1: vector<u8>, arg2: &AdminKey) : bool {
        let v0 = TenantAdmin{
            tenant_id : arg1,
            admin     : arg0,
        };
        0x2::bag::contains<TenantAdmin>(&arg2.tenant_admins, v0)
    }

    public fun assert_executor(arg0: address, arg1: &Executor) : bool {
        let v0 = ExecutorAdmin{admin: arg0};
        0x2::bag::contains<ExecutorAdmin>(&arg1.executor_admins, v0)
    }

    public fun delete_executor(arg0: &mut Executor, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_executor(0x2::tx_context::sender(arg2), arg0);
        let v0 = ExecutorAdmin{admin: arg1};
        if (0x2::bag::contains<ExecutorAdmin>(&arg0.executor_admins, v0)) {
            0x2::bag::remove<ExecutorAdmin, bool>(&mut arg0.executor_admins, v0);
        };
    }

    public fun delete_tenant_admin(arg0: &mut AdminKey, arg1: vector<u8>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(0x2::tx_context::sender(arg3), arg1, arg0);
        let v0 = TenantAdmin{
            tenant_id : arg1,
            admin     : arg2,
        };
        if (0x2::bag::contains<TenantAdmin>(&arg0.tenant_admins, v0)) {
            0x2::bag::remove<TenantAdmin, bool>(&mut arg0.tenant_admins, v0);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminKey{
            id            : 0x2::object::new(arg0),
            tenant_admins : 0x2::bag::new(arg0),
        };
        let v1 = Executor{
            id              : 0x2::object::new(arg0),
            executor_admins : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<AdminKey>(v0);
        0x2::transfer::share_object<Executor>(v1);
    }

    public fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminKey{
            id            : 0x2::object::new(arg0),
            tenant_admins : 0x2::bag::new(arg0),
        };
        let v1 = Executor{
            id              : 0x2::object::new(arg0),
            executor_admins : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<AdminKey>(v0);
        0x2::transfer::share_object<Executor>(v1);
    }

    // decompiled from Move bytecode v6
}

