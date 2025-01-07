module 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_record {
    struct AppRecord has store {
        app_cap_id: 0x2::object::ID,
        ns_nft_id: 0x2::object::ID,
        app_info: 0x1::option::Option<0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_info::AppInfo>,
        networks: 0x2::vec_map::VecMap<0x1::string::String, 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_info::AppInfo>,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        storage: 0x2::object::UID,
    }

    struct AppCap has store, key {
        id: 0x2::object::UID,
        name: 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::name::Name,
        is_immutable: bool,
    }

    public(friend) fun new(arg0: 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::name::Name, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : (AppRecord, AppCap) {
        let v0 = AppCap{
            id           : 0x2::object::new(arg2),
            name         : arg0,
            is_immutable : false,
        };
        let v1 = AppRecord{
            app_cap_id : 0x2::object::uid_to_inner(&v0.id),
            ns_nft_id  : arg1,
            app_info   : 0x1::option::none<0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_info::AppInfo>(),
            networks   : 0x2::vec_map::empty<0x1::string::String, 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_info::AppInfo>(),
            metadata   : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            storage    : 0x2::object::new(arg2),
        };
        (v1, v0)
    }

    public(friend) fun app(arg0: &AppCap) : 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::name::Name {
        arg0.name
    }

    public fun name(arg0: &AppCap) : 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::name::Name {
        arg0.name
    }

    public(friend) fun assign_package(arg0: &mut AppRecord, arg1: &mut AppCap, arg2: &0x3f59564f9caa6769a2b16e30ab0756441bad340339858373c6c38bbc15f67eb9::package_info::PackageInfo) {
        assert!(0x1::option::is_none<0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_info::AppInfo>(&arg0.app_info), 1);
        arg1.is_immutable = true;
        arg0.app_info = 0x1::option::some<0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_info::AppInfo>(0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_info::new(0x1::option::some<0x2::object::ID>(0x3f59564f9caa6769a2b16e30ab0756441bad340339858373c6c38bbc15f67eb9::package_info::id(arg2)), 0x1::option::some<address>(0x3f59564f9caa6769a2b16e30ab0756441bad340339858373c6c38bbc15f67eb9::package_info::package_address(arg2)), 0x1::option::some<0x2::object::ID>(0x3f59564f9caa6769a2b16e30ab0756441bad340339858373c6c38bbc15f67eb9::package_info::upgrade_cap_id(arg2))));
    }

    public(friend) fun burn(arg0: AppRecord) {
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

    public fun is_cap_immutable(arg0: &AppCap) : bool {
        arg0.is_immutable
    }

    public(friend) fun is_immutable(arg0: &AppRecord) : bool {
        0x1::option::is_some<0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_info::AppInfo>(&arg0.app_info)
    }

    public(friend) fun is_valid_for(arg0: &AppCap, arg1: &AppRecord) : bool {
        arg1.app_cap_id == 0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun set_network(arg0: &mut AppRecord, arg1: 0x1::string::String, arg2: 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_info::AppInfo) {
        if (0x2::vec_map::contains<0x1::string::String, 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_info::AppInfo>(&arg0.networks, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_info::AppInfo>(&mut arg0.networks, &arg1);
        };
        assert!(0x2::vec_map::size<0x1::string::String, 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_info::AppInfo>(&arg0.networks) < 25, 3);
        0x2::vec_map::insert<0x1::string::String, 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_info::AppInfo>(&mut arg0.networks, arg1, arg2);
    }

    public(friend) fun unset_network(arg0: &mut AppRecord, arg1: 0x1::string::String) {
        assert!(0x2::vec_map::contains<0x1::string::String, 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_info::AppInfo>(&arg0.networks, &arg1), 2);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0xdc7979da429684890fdff92ff48ec566f4b192c8fb7bcf12ab68e9ed7d4eb5e0::app_info::AppInfo>(&mut arg0.networks, &arg1);
    }

    // decompiled from Move bytecode v6
}

