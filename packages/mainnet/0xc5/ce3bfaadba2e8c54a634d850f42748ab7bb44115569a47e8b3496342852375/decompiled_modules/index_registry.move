module 0xc5ce3bfaadba2e8c54a634d850f42748ab7bb44115569a47e8b3496342852375::index_registry {
    struct Registry has key {
        id: 0x2::object::UID,
        admin: address,
        assets: 0x2::vec_map::VecMap<0x1::string::String, AssetInfo>,
    }

    struct AssetInfo has copy, drop, store {
        pyth_feed_id: 0x1::string::String,
        tier: u8,
        active: bool,
    }

    struct AssetAdded has copy, drop {
        symbol: 0x1::string::String,
        pyth_feed_id: 0x1::string::String,
        tier: u8,
    }

    struct AssetRemoved has copy, drop {
        symbol: 0x1::string::String,
    }

    struct AssetUpdated has copy, drop {
        symbol: 0x1::string::String,
        active: bool,
    }

    public entry fun add_asset(arg0: &mut Registry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0);
        assert!(!0x2::vec_map::contains<0x1::string::String, AssetInfo>(&arg0.assets, &arg1), 1);
        assert!(arg3 >= 1 && arg3 <= 3, 3);
        let v0 = AssetInfo{
            pyth_feed_id : arg2,
            tier         : arg3,
            active       : true,
        };
        0x2::vec_map::insert<0x1::string::String, AssetInfo>(&mut arg0.assets, arg1, v0);
        let v1 = AssetAdded{
            symbol       : arg1,
            pyth_feed_id : arg2,
            tier         : arg3,
        };
        0x2::event::emit<AssetAdded>(v1);
    }

    public fun asset_count(arg0: &Registry) : u64 {
        0x2::vec_map::length<0x1::string::String, AssetInfo>(&arg0.assets)
    }

    public fun get_feed_id(arg0: &Registry, arg1: &0x1::string::String) : 0x1::string::String {
        0x2::vec_map::get<0x1::string::String, AssetInfo>(&arg0.assets, arg1).pyth_feed_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id     : 0x2::object::new(arg0),
            admin  : 0x2::tx_context::sender(arg0),
            assets : 0x2::vec_map::empty<0x1::string::String, AssetInfo>(),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun is_active_asset(arg0: &Registry, arg1: &0x1::string::String) : bool {
        if (!0x2::vec_map::contains<0x1::string::String, AssetInfo>(&arg0.assets, arg1)) {
            return false
        };
        0x2::vec_map::get<0x1::string::String, AssetInfo>(&arg0.assets, arg1).active
    }

    public entry fun remove_asset(arg0: &mut Registry, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        assert!(0x2::vec_map::contains<0x1::string::String, AssetInfo>(&arg0.assets, &arg1), 2);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, AssetInfo>(&mut arg0.assets, &arg1);
        let v2 = AssetRemoved{symbol: arg1};
        0x2::event::emit<AssetRemoved>(v2);
    }

    public entry fun set_asset_active(arg0: &mut Registry, arg1: 0x1::string::String, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        assert!(0x2::vec_map::contains<0x1::string::String, AssetInfo>(&arg0.assets, &arg1), 2);
        0x2::vec_map::get_mut<0x1::string::String, AssetInfo>(&mut arg0.assets, &arg1).active = arg2;
        let v0 = AssetUpdated{
            symbol : arg1,
            active : arg2,
        };
        0x2::event::emit<AssetUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

