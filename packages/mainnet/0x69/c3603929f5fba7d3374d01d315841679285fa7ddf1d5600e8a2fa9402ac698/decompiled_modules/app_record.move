module 0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::app_record {
    struct AppRecord has store, key {
        id: 0x2::object::UID,
        app_cap_id: 0x2::object::ID,
        package_info_id: 0x1::option::Option<0x2::object::ID>,
        upgrade_cap_id: 0x1::option::Option<0x2::object::ID>,
        networks: 0x2::vec_map::VecMap<0x1::string::String, 0x2::object::ID>,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct AppCap has store, key {
        id: 0x2::object::UID,
        name: 0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::name::Name,
    }

    public(friend) fun new(arg0: 0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::name::Name, arg1: &mut 0x2::tx_context::TxContext) : (AppRecord, AppCap) {
        let v0 = AppCap{
            id   : 0x2::object::new(arg1),
            name : arg0,
        };
        let v1 = AppRecord{
            id              : 0x2::object::new(arg1),
            app_cap_id      : 0x2::object::uid_to_inner(&v0.id),
            package_info_id : 0x1::option::none<0x2::object::ID>(),
            upgrade_cap_id  : 0x1::option::none<0x2::object::ID>(),
            networks        : 0x2::vec_map::empty<0x1::string::String, 0x2::object::ID>(),
            metadata        : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        };
        (v1, v0)
    }

    public(friend) fun assign_package(arg0: &mut AppRecord, arg1: &0x15f29668bc8a8168975f6de8da926ea398619cfff5894bb71d31a777fa7ea18e::package_info::PackageInfo) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.package_info_id), 1);
        arg0.package_info_id = 0x1::option::some<0x2::object::ID>(0x15f29668bc8a8168975f6de8da926ea398619cfff5894bb71d31a777fa7ea18e::package_info::id(arg1));
        arg0.upgrade_cap_id = 0x1::option::some<0x2::object::ID>(0x15f29668bc8a8168975f6de8da926ea398619cfff5894bb71d31a777fa7ea18e::package_info::upgrade_cap_id(arg1));
    }

    public(friend) fun burn(arg0: AppRecord) {
        let AppRecord {
            id              : v0,
            app_cap_id      : _,
            package_info_id : _,
            upgrade_cap_id  : _,
            networks        : _,
            metadata        : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun is_immutable(arg0: &AppRecord) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.package_info_id)
    }

    public(friend) fun is_valid_for(arg0: &AppCap, arg1: &AppRecord) : bool {
        arg1.app_cap_id == 0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun name(arg0: &AppCap) : 0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::name::Name {
        arg0.name
    }

    public(friend) fun set_network(arg0: &mut AppRecord, arg1: 0x1::string::String, arg2: 0x2::object::ID) {
        if (0x2::vec_map::contains<0x1::string::String, 0x2::object::ID>(&arg0.networks, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x2::object::ID>(&mut arg0.networks, &arg1);
        };
        0x2::vec_map::insert<0x1::string::String, 0x2::object::ID>(&mut arg0.networks, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

