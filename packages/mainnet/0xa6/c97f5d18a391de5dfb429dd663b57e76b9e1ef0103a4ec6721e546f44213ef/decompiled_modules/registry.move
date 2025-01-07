module 0xa6c97f5d18a391de5dfb429dd663b57e76b9e1ef0103a4ec6721e546f44213ef::registry {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        version: 0xa6c97f5d18a391de5dfb429dd663b57e76b9e1ef0103a4ec6721e546f44213ef::version::Version,
        supra_pair_ids: 0x2::table::Table<0x1::type_name::TypeName, u32>,
    }

    public fun get_pair_id<T0>(arg0: &Registry) : u32 {
        0xa6c97f5d18a391de5dfb429dd663b57e76b9e1ef0103a4ec6721e546f44213ef::version::assert_current_version(&arg0.version);
        *0x2::table::borrow<0x1::type_name::TypeName, u32>(&arg0.supra_pair_ids, 0x1::type_name::get<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id             : 0x2::object::new(arg0),
            version        : 0xa6c97f5d18a391de5dfb429dd663b57e76b9e1ef0103a4ec6721e546f44213ef::version::initialize(),
            supra_pair_ids : 0x2::table::new<0x1::type_name::TypeName, u32>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun set_price_pair_id<T0>(arg0: &AdminCap, arg1: &mut Registry, arg2: u32) {
        0xa6c97f5d18a391de5dfb429dd663b57e76b9e1ef0103a4ec6721e546f44213ef::version::assert_current_version(&arg1.version);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u32>(&arg1.supra_pair_ids, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, u32>(&mut arg1.supra_pair_ids, v0);
        };
        0x2::table::add<0x1::type_name::TypeName, u32>(&mut arg1.supra_pair_ids, v0, arg2);
    }

    public fun upgrade_major(arg0: &AdminCap, arg1: &mut Registry) {
        0xa6c97f5d18a391de5dfb429dd663b57e76b9e1ef0103a4ec6721e546f44213ef::version::upgrade_major(&mut arg1.version);
    }

    public fun upgrade_minor(arg0: &AdminCap, arg1: &mut Registry) {
        0xa6c97f5d18a391de5dfb429dd663b57e76b9e1ef0103a4ec6721e546f44213ef::version::upgrade_minor(&mut arg1.version);
    }

    public fun version(arg0: &Registry) : &0xa6c97f5d18a391de5dfb429dd663b57e76b9e1ef0103a4ec6721e546f44213ef::version::Version {
        &arg0.version
    }

    // decompiled from Move bytecode v6
}

