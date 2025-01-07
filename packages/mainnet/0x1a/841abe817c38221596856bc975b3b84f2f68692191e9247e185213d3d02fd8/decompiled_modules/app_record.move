module 0x1a841abe817c38221596856bc975b3b84f2f68692191e9247e185213d3d02fd8::app_record {
    struct AppRecord has store, key {
        id: 0x2::object::UID,
        app_cap_id: 0x2::object::ID,
        app_info: 0x1::option::Option<0x1a841abe817c38221596856bc975b3b84f2f68692191e9247e185213d3d02fd8::app_info::AppInfo>,
        networks: 0x2::vec_map::VecMap<0x1::string::String, 0x1a841abe817c38221596856bc975b3b84f2f68692191e9247e185213d3d02fd8::app_info::AppInfo>,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct AppCap has store, key {
        id: 0x2::object::UID,
        name: 0x1a841abe817c38221596856bc975b3b84f2f68692191e9247e185213d3d02fd8::name::Name,
    }

    public(friend) fun new(arg0: 0x1a841abe817c38221596856bc975b3b84f2f68692191e9247e185213d3d02fd8::name::Name, arg1: &mut 0x2::tx_context::TxContext) : (AppRecord, AppCap) {
        let v0 = AppCap{
            id   : 0x2::object::new(arg1),
            name : arg0,
        };
        let v1 = AppRecord{
            id         : 0x2::object::new(arg1),
            app_cap_id : 0x2::object::uid_to_inner(&v0.id),
            app_info   : 0x1::option::none<0x1a841abe817c38221596856bc975b3b84f2f68692191e9247e185213d3d02fd8::app_info::AppInfo>(),
            networks   : 0x2::vec_map::empty<0x1::string::String, 0x1a841abe817c38221596856bc975b3b84f2f68692191e9247e185213d3d02fd8::app_info::AppInfo>(),
            metadata   : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        };
        (v1, v0)
    }

    public(friend) fun assign_package(arg0: &mut AppRecord, arg1: &0x9664b1e243682f6db0d103cb972da6bf95927737d50d8e333ab53c2b3ed64f28::package_info::PackageInfo) {
        assert!(0x1::option::is_none<0x1a841abe817c38221596856bc975b3b84f2f68692191e9247e185213d3d02fd8::app_info::AppInfo>(&arg0.app_info), 1);
        arg0.app_info = 0x1::option::some<0x1a841abe817c38221596856bc975b3b84f2f68692191e9247e185213d3d02fd8::app_info::AppInfo>(0x1a841abe817c38221596856bc975b3b84f2f68692191e9247e185213d3d02fd8::app_info::new(0x1::option::some<0x2::object::ID>(0x9664b1e243682f6db0d103cb972da6bf95927737d50d8e333ab53c2b3ed64f28::package_info::id(arg1)), 0x1::option::some<address>(0x9664b1e243682f6db0d103cb972da6bf95927737d50d8e333ab53c2b3ed64f28::package_info::package_address(arg1)), 0x1::option::some<0x2::object::ID>(0x9664b1e243682f6db0d103cb972da6bf95927737d50d8e333ab53c2b3ed64f28::package_info::upgrade_cap_id(arg1))));
    }

    public(friend) fun burn(arg0: AppRecord) {
        let AppRecord {
            id         : v0,
            app_cap_id : _,
            app_info   : _,
            networks   : _,
            metadata   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun is_immutable(arg0: &AppRecord) : bool {
        0x1::option::is_some<0x1a841abe817c38221596856bc975b3b84f2f68692191e9247e185213d3d02fd8::app_info::AppInfo>(&arg0.app_info)
    }

    public(friend) fun is_valid_for(arg0: &AppCap, arg1: &AppRecord) : bool {
        arg1.app_cap_id == 0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun name(arg0: &AppCap) : 0x1a841abe817c38221596856bc975b3b84f2f68692191e9247e185213d3d02fd8::name::Name {
        arg0.name
    }

    public(friend) fun set_network(arg0: &mut AppRecord, arg1: 0x1::string::String, arg2: 0x1a841abe817c38221596856bc975b3b84f2f68692191e9247e185213d3d02fd8::app_info::AppInfo) {
        if (0x2::vec_map::contains<0x1::string::String, 0x1a841abe817c38221596856bc975b3b84f2f68692191e9247e185213d3d02fd8::app_info::AppInfo>(&arg0.networks, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1a841abe817c38221596856bc975b3b84f2f68692191e9247e185213d3d02fd8::app_info::AppInfo>(&mut arg0.networks, &arg1);
        };
        0x2::vec_map::insert<0x1::string::String, 0x1a841abe817c38221596856bc975b3b84f2f68692191e9247e185213d3d02fd8::app_info::AppInfo>(&mut arg0.networks, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

