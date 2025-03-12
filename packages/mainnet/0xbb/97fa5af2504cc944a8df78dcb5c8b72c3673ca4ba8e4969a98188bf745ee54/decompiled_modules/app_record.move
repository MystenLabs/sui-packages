module 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record {
    struct AppRecord has store {
        app_cap_id: 0x2::object::ID,
        ns_nft_id: 0x2::object::ID,
        app_info: 0x1::option::Option<0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_info::AppInfo>,
        networks: 0x2::vec_map::VecMap<0x1::string::String, 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_info::AppInfo>,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        storage: 0x2::object::UID,
    }

    struct AppCap has store, key {
        id: 0x2::object::UID,
        name: 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::name::Name,
        is_immutable: bool,
        display: 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_cap_display::AppCapDisplay,
    }

    public(friend) fun new(arg0: 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::name::Name, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : (AppRecord, AppCap) {
        let v0 = AppCap{
            id           : 0x2::object::new(arg2),
            name         : arg0,
            is_immutable : false,
            display      : 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_cap_display::new(arg0, false),
        };
        let v1 = AppRecord{
            app_cap_id : 0x2::object::uid_to_inner(&v0.id),
            ns_nft_id  : arg1,
            app_info   : 0x1::option::none<0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_info::AppInfo>(),
            networks   : 0x2::vec_map::empty<0x1::string::String, 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_info::AppInfo>(),
            metadata   : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            storage    : 0x2::object::new(arg2),
        };
        (v1, v0)
    }

    public(friend) fun app(arg0: &AppCap) : 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::name::Name {
        arg0.name
    }

    public fun name(arg0: &AppCap) : 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::name::Name {
        arg0.name
    }

    public(friend) fun assign_package(arg0: &mut AppRecord, arg1: &mut AppCap, arg2: &0xf6b71233780a3f362137b44ac219290f4fd34eb81e0cb62ddf4bb38d1f9a3a1::package_info::PackageInfo) {
        assert!(0x1::option::is_none<0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_info::AppInfo>(&arg0.app_info), 9223372401926995969);
        arg1.is_immutable = true;
        0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_cap_display::set_link_opacity(&mut arg1.display, true);
        arg0.app_info = 0x1::option::some<0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_info::AppInfo>(0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_info::new(0x1::option::some<0x2::object::ID>(0xf6b71233780a3f362137b44ac219290f4fd34eb81e0cb62ddf4bb38d1f9a3a1::package_info::id(arg2)), 0x1::option::some<address>(0xf6b71233780a3f362137b44ac219290f4fd34eb81e0cb62ddf4bb38d1f9a3a1::package_info::package_address(arg2)), 0x1::option::some<0x2::object::ID>(0xf6b71233780a3f362137b44ac219290f4fd34eb81e0cb62ddf4bb38d1f9a3a1::package_info::upgrade_cap_id(arg2))));
    }

    public(friend) fun burn(arg0: AppRecord) {
        assert!(!is_immutable(&arg0), 9223372535071506441);
        let AppRecord {
            app_cap_id : _,
            ns_nft_id  : _,
            app_info   : _,
            networks   : _,
            metadata   : _,
            storage    : v5,
        } = arg0;
        0x2::object::delete(v5);
    }

    public(friend) fun burn_cap(arg0: AppCap) {
        assert!(!arg0.is_immutable, 9223372565136146439);
        let AppCap {
            id           : v0,
            name         : _,
            is_immutable : _,
            display      : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun is_cap_immutable(arg0: &AppCap) : bool {
        arg0.is_immutable
    }

    public(friend) fun is_immutable(arg0: &AppRecord) : bool {
        0x1::option::is_some<0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_info::AppInfo>(&arg0.app_info)
    }

    public(friend) fun is_valid_for(arg0: &AppCap, arg1: &AppRecord) : bool {
        arg1.app_cap_id == 0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun metadata(arg0: &AppRecord) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.metadata
    }

    public(friend) fun set_metadata_key(arg0: &mut AppRecord, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.metadata, arg1, arg2);
    }

    public(friend) fun set_network(arg0: &mut AppRecord, arg1: 0x1::string::String, arg2: 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_info::AppInfo) {
        assert!(0x2::vec_map::size<0x1::string::String, 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_info::AppInfo>(&arg0.networks) < 25, 9223372466351767557);
        0x2::vec_map::insert<0x1::string::String, 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_info::AppInfo>(&mut arg0.networks, arg1, arg2);
    }

    public(friend) fun unset_metadata_key(arg0: &mut AppRecord, arg1: 0x1::string::String) {
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.metadata, &arg1);
    }

    public(friend) fun unset_network(arg0: &mut AppRecord, arg1: 0x1::string::String) {
        assert!(0x2::vec_map::contains<0x1::string::String, 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_info::AppInfo>(&arg0.networks, &arg1), 9223372492121440259);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_info::AppInfo>(&mut arg0.networks, &arg1);
    }

    // decompiled from Move bytecode v6
}

