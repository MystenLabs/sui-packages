module 0x2501506bacdee34b3c52fa422b376bc8a70e4c70a5d104776d95591da732bd6::registry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has drop, store {
        price_info_id: 0x2::object::ID,
        price_conf_range: u64,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        version: 0x2501506bacdee34b3c52fa422b376bc8a70e4c70a5d104776d95591da732bd6::version::Version,
        configs: 0x2::table::Table<0x1::type_name::TypeName, Config>,
    }

    public fun assert_pyth_price_info_object<T0>(arg0: &Registry, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let (v0, _) = get_config<T0>(arg0);
        assert!(0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1) == v0, 0);
    }

    public fun get_config<T0>(arg0: &Registry) : (0x2::object::ID, u64) {
        0x2501506bacdee34b3c52fa422b376bc8a70e4c70a5d104776d95591da732bd6::version::assert_current_version(&arg0.version);
        let v0 = 0x2::table::borrow<0x1::type_name::TypeName, Config>(&arg0.configs, 0x1::type_name::get<T0>());
        (v0.price_info_id, v0.price_conf_range)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id      : 0x2::object::new(arg0),
            version : 0x2501506bacdee34b3c52fa422b376bc8a70e4c70a5d104776d95591da732bd6::version::initialize(),
            configs : 0x2::table::new<0x1::type_name::TypeName, Config>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun set_price_config<T0>(arg0: &AdminCap, arg1: &mut Registry, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: u64) {
        0x2501506bacdee34b3c52fa422b376bc8a70e4c70a5d104776d95591da732bd6::version::assert_current_version(&arg1.version);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, Config>(&arg1.configs, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, Config>(&mut arg1.configs, v0);
        };
        let v1 = Config{
            price_info_id    : 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2),
            price_conf_range : arg3,
        };
        0x2::table::add<0x1::type_name::TypeName, Config>(&mut arg1.configs, v0, v1);
    }

    public fun set_price_config_range<T0>(arg0: &AdminCap, arg1: &mut Registry, arg2: u64) {
        0x2501506bacdee34b3c52fa422b376bc8a70e4c70a5d104776d95591da732bd6::version::assert_current_version(&arg1.version);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, Config>(&arg1.configs, v0)) {
            let Config {
                price_info_id    : v1,
                price_conf_range : _,
            } = 0x2::table::remove<0x1::type_name::TypeName, Config>(&mut arg1.configs, v0);
            let v3 = Config{
                price_info_id    : v1,
                price_conf_range : arg2,
            };
            0x2::table::add<0x1::type_name::TypeName, Config>(&mut arg1.configs, v0, v3);
        };
    }

    public fun upgrade_major(arg0: &AdminCap, arg1: &mut Registry) {
        0x2501506bacdee34b3c52fa422b376bc8a70e4c70a5d104776d95591da732bd6::version::upgrade_major(&mut arg1.version);
    }

    public fun upgrade_minor(arg0: &AdminCap, arg1: &mut Registry) {
        0x2501506bacdee34b3c52fa422b376bc8a70e4c70a5d104776d95591da732bd6::version::upgrade_minor(&mut arg1.version);
    }

    public fun version(arg0: &Registry) : &0x2501506bacdee34b3c52fa422b376bc8a70e4c70a5d104776d95591da732bd6::version::Version {
        &arg0.version
    }

    // decompiled from Move bytecode v6
}

