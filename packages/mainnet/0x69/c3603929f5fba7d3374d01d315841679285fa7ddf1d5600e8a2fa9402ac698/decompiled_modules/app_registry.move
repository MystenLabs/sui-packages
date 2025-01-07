module 0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::app_registry {
    struct AppRegistry has key {
        id: 0x2::object::UID,
        registry: 0x2::table::Table<0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::name::Name, 0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::app_record::AppRecord>,
    }

    public fun assign_package(arg0: &mut AppRegistry, arg1: &0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::app_record::AppCap, arg2: &0x15f29668bc8a8168975f6de8da926ea398619cfff5894bb71d31a777fa7ea18e::package_info::PackageInfo) {
        assert!(app_exists(arg0, 0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::app_record::name(arg1)), 3);
        let v0 = 0x2::table::borrow_mut<0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::name::Name, 0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::app_record::AppRecord>(&mut arg0.registry, 0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::app_record::name(arg1));
        assert!(0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::app_record::is_valid_for(arg1, v0), 2);
        assert!(!0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::app_record::is_immutable(v0), 1);
        0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::app_record::assign_package(v0, arg2);
    }

    public fun set_network(arg0: &mut AppRegistry, arg1: &0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::app_record::AppCap, arg2: 0x1::string::String, arg3: 0x2::object::ID) {
        assert!(app_exists(arg0, 0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::app_record::name(arg1)), 3);
        let v0 = 0x2::table::borrow_mut<0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::name::Name, 0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::app_record::AppRecord>(&mut arg0.registry, 0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::app_record::name(arg1));
        assert!(0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::app_record::is_valid_for(arg1, v0), 2);
        0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::app_record::set_network(v0, arg2, arg3);
    }

    fun app_exists(arg0: &AppRegistry, arg1: 0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::name::Name) : bool {
        0x2::table::contains<0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::name::Name, 0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::app_record::AppRecord>(&arg0.registry, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AppRegistry{
            id       : 0x2::object::new(arg0),
            registry : 0x2::table::new<0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::name::Name, 0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::app_record::AppRecord>(arg0),
        };
        0x2::transfer::share_object<AppRegistry>(v0);
    }

    public fun register(arg0: &mut AppRegistry, arg1: 0x1::string::String, arg2: &0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::dot_move::DotMove, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::app_record::AppCap {
        let v0 = 0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::name::new(arg1);
        assert!(!0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::dot_move::has_expired(arg2, arg3), 4);
        let v1 = 0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::dot_move::name(arg2);
        assert!(0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::name::is_valid_for(&v1, &v0), 2);
        if (0x2::table::contains<0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::name::Name, 0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::app_record::AppRecord>(&arg0.registry, v0)) {
            let v2 = 0x2::table::remove<0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::name::Name, 0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::app_record::AppRecord>(&mut arg0.registry, v0);
            assert!(!0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::app_record::is_immutable(&v2), 1);
            0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::app_record::burn(v2);
        };
        let (v3, v4) = 0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::app_record::new(v0, arg4);
        0x2::table::add<0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::name::Name, 0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::app_record::AppRecord>(&mut arg0.registry, v0, v3);
        v4
    }

    // decompiled from Move bytecode v6
}

