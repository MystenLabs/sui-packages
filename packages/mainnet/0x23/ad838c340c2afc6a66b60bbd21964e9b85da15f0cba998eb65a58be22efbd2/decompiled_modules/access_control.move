module 0x23ad838c340c2afc6a66b60bbd21964e9b85da15f0cba998eb65a58be22efbd2::access_control {
    struct AdminKey has store, key {
        id: 0x2::object::UID,
        tenant_admins: 0x2::table::Table<vector<u8>, 0x2::table::Table<address, bool>>,
    }

    struct Executor has store, key {
        id: 0x2::object::UID,
        executor_admin: 0x2::table::Table<address, bool>,
    }

    public fun add_executor(arg0: &mut Executor, arg1: address) {
        if (0x2::table::contains<address, bool>(&arg0.executor_admin, arg1)) {
            abort 2
        };
        0x2::table::add<address, bool>(&mut arg0.executor_admin, arg1, true);
    }

    public fun add_tenant_admin(arg0: &mut AdminKey, arg1: vector<u8>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x2::table::contains<vector<u8>, 0x2::table::Table<address, bool>>(&arg0.tenant_admins, arg1)) {
            0x2::table::borrow_mut<vector<u8>, 0x2::table::Table<address, bool>>(&mut arg0.tenant_admins, arg1)
        } else {
            0x2::table::add<vector<u8>, 0x2::table::Table<address, bool>>(&mut arg0.tenant_admins, arg1, 0x2::table::new<address, bool>(arg3));
            0x2::table::borrow_mut<vector<u8>, 0x2::table::Table<address, bool>>(&mut arg0.tenant_admins, arg1)
        };
        if (0x2::table::contains<address, bool>(v0, arg2)) {
            abort 2
        };
        0x2::table::add<address, bool>(v0, arg2, true);
    }

    public fun assert_admin(arg0: address, arg1: vector<u8>, arg2: &AdminKey) : bool {
        let v0 = 0x2::table::borrow<vector<u8>, 0x2::table::Table<address, bool>>(&arg2.tenant_admins, arg1);
        0x2::table::contains<address, bool>(v0, arg0) && *0x2::table::borrow<address, bool>(v0, arg0)
    }

    public fun assert_executor(arg0: address, arg1: &Executor) : bool {
        0x2::table::contains<address, bool>(&arg1.executor_admin, arg0) && *0x2::table::borrow<address, bool>(&arg1.executor_admin, arg0)
    }

    public fun delete_executor(arg0: &mut Executor, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_executor(0x2::tx_context::sender(arg2), arg0);
        if (0x2::table::contains<address, bool>(&arg0.executor_admin, arg1)) {
            0x2::table::remove<address, bool>(&mut arg0.executor_admin, arg1);
        };
    }

    public fun delete_tenant_admin(arg0: &mut AdminKey, arg1: vector<u8>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(0x2::tx_context::sender(arg3), arg1, arg0);
        let v0 = 0x2::table::borrow_mut<vector<u8>, 0x2::table::Table<address, bool>>(&mut arg0.tenant_admins, arg1);
        if (0x2::table::contains<address, bool>(v0, arg2)) {
            0x2::table::remove<address, bool>(v0, arg2);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminKey{
            id            : 0x2::object::new(arg0),
            tenant_admins : 0x2::table::new<vector<u8>, 0x2::table::Table<address, bool>>(arg0),
        };
        let v1 = Executor{
            id             : 0x2::object::new(arg0),
            executor_admin : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::public_transfer<AdminKey>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_transfer<Executor>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminKey{
            id            : 0x2::object::new(arg0),
            tenant_admins : 0x2::table::new<vector<u8>, 0x2::table::Table<address, bool>>(arg0),
        };
        0x2::transfer::public_transfer<AdminKey>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

