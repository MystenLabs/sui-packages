module 0xa0e9549b50bcb11d22b251593f5409cb51dad06af8599e7ba4732876292592bc::supra_registry {
    struct SupraRegistry has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<0x1::type_name::TypeName, u32>,
    }

    struct SupraRegistryCap has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    public fun assert_supra_pair_id<T0>(arg0: &SupraRegistry, arg1: u32) {
        assert!(arg1 == *0x2::table::borrow<0x1::type_name::TypeName, u32>(&arg0.table, 0x1::type_name::get<T0>()), 70406);
    }

    public entry fun get_supra_pair_id<T0>(arg0: &SupraRegistry) : u32 {
        *0x2::table::borrow<0x1::type_name::TypeName, u32>(&arg0.table, 0x1::type_name::get<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SupraRegistry{
            id    : 0x2::object::new(arg0),
            table : 0x2::table::new<0x1::type_name::TypeName, u32>(arg0),
        };
        let v1 = SupraRegistryCap{
            id  : 0x2::object::new(arg0),
            for : 0x2::object::id<SupraRegistry>(&v0),
        };
        0x2::transfer::share_object<SupraRegistry>(v0);
        0x2::transfer::transfer<SupraRegistryCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun register_supra_pair_id<T0>(arg0: &mut SupraRegistry, arg1: &SupraRegistryCap, arg2: u32) {
        assert!(0x2::object::id<SupraRegistry>(arg0) == arg1.for, 70407);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u32>(&arg0.table, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, u32>(&mut arg0.table, v0);
        };
        0x2::table::add<0x1::type_name::TypeName, u32>(&mut arg0.table, v0, arg2);
    }

    // decompiled from Move bytecode v6
}

