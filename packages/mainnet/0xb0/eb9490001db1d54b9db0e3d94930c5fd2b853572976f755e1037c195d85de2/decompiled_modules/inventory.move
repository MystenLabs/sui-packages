module 0xb0eb9490001db1d54b9db0e3d94930c5fd2b853572976f755e1037c195d85de2::inventory {
    struct InventoryConfig has key {
        id: 0x2::object::UID,
        blacklist_types: 0x2::table::Table<0x1::type_name::TypeName, bool>,
        version_set: 0x2::vec_set::VecSet<u64>,
    }

    public fun receive<T0: store + key>(arg0: &mut 0xb0eb9490001db1d54b9db0e3d94930c5fd2b853572976f755e1037c195d85de2::doubleup_citizens::DoubleUpCitizen, arg1: 0x2::transfer::Receiving<T0>, arg2: &InventoryConfig) : T0 {
        assert!(is_valid_version(arg2), 1);
        assert!(!0x2::table::contains<0x1::type_name::TypeName, bool>(&arg2.blacklist_types, 0x1::type_name::get<T0>()), 0);
        0xb0eb9490001db1d54b9db0e3d94930c5fd2b853572976f755e1037c195d85de2::doubleup_citizens::receive<T0>(arg0, arg1)
    }

    public fun add_blacklist_type<T0>(arg0: &mut InventoryConfig, arg1: &0xb0eb9490001db1d54b9db0e3d94930c5fd2b853572976f755e1037c195d85de2::admin::AdminCap) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.blacklist_types, v0), 2);
        0x2::table::add<0x1::type_name::TypeName, bool>(&mut arg0.blacklist_types, v0, true);
    }

    public fun add_version(arg0: &mut InventoryConfig, arg1: u64, arg2: &0xb0eb9490001db1d54b9db0e3d94930c5fd2b853572976f755e1037c195d85de2::admin::AdminCap) {
        0x2::vec_set::insert<u64>(&mut arg0.version_set, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InventoryConfig{
            id              : 0x2::object::new(arg0),
            blacklist_types : 0x2::table::new<0x1::type_name::TypeName, bool>(arg0),
            version_set     : 0x2::vec_set::singleton<u64>(0),
        };
        0x2::transfer::share_object<InventoryConfig>(v0);
    }

    fun is_valid_version(arg0: &InventoryConfig) : bool {
        let v0 = 0;
        0x2::vec_set::contains<u64>(&arg0.version_set, &v0)
    }

    public fun remove_blacklist_type<T0>(arg0: &mut InventoryConfig, arg1: &0xb0eb9490001db1d54b9db0e3d94930c5fd2b853572976f755e1037c195d85de2::admin::AdminCap) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.blacklist_types, v0), 3);
        0x2::table::remove<0x1::type_name::TypeName, bool>(&mut arg0.blacklist_types, v0);
    }

    public fun remove_version(arg0: &mut InventoryConfig, arg1: u64, arg2: &0xb0eb9490001db1d54b9db0e3d94930c5fd2b853572976f755e1037c195d85de2::admin::AdminCap) {
        0x2::vec_set::remove<u64>(&mut arg0.version_set, &arg1);
    }

    // decompiled from Move bytecode v6
}

