module 0x7b5e98c62abc83e65959ba0cb9732a3c9b2715f56702f883fa418ba0af7a9434::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<address, PoolConfig>,
        package_version: u64,
    }

    struct MediaInfo has drop, store {
        name: 0x1::string::String,
        link: 0x1::string::String,
    }

    struct PoolConfig has drop, store {
        pool_address: address,
        is_close: bool,
        banners: vector<0x1::string::String>,
        introduction: 0x1::string::String,
        website: 0x1::string::String,
        tokenomics: 0x1::string::String,
        social_media: 0x2::vec_map::VecMap<0x1::string::String, MediaInfo>,
        terms: 0x1::string::String,
        white_list_terms: 0x1::string::String,
        regulation: 0x1::string::String,
        project_details: 0x1::string::String,
    }

    struct InitEvent has copy, drop, store {
        conf_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
    }

    struct AddPoolEvent has copy, drop, store {
        pool_address: address,
    }

    struct UpdatePoolEvent has copy, drop, store {
        pool_address: address,
    }

    struct RemovePoolEvent has copy, drop, store {
        pool_address: address,
    }

    struct AddMediaToPoolEvent has copy, drop, store {
        pool_address: address,
        name: 0x1::string::String,
        link: 0x1::string::String,
    }

    struct RemoveMediaFromPoolEvent has copy, drop, store {
        pool_address: address,
        name: 0x1::string::String,
    }

    struct ClosePoolEvent has copy, drop, store {
        pool_address: address,
    }

    struct OpenPoolEvent has copy, drop, store {
        pool_address: address,
    }

    public fun add_media_to_pool(arg0: &AdminCap, arg1: &mut Config, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        checked_package_version(arg1);
        assert!(0x2::table::contains<address, PoolConfig>(&arg1.pools, arg2), 2);
        let v0 = 0x2::table::borrow_mut<address, PoolConfig>(&mut arg1.pools, arg2);
        assert!(!0x2::vec_map::contains<0x1::string::String, MediaInfo>(&v0.social_media, &arg3), 4);
        let v1 = MediaInfo{
            name : arg3,
            link : arg4,
        };
        0x2::vec_map::insert<0x1::string::String, MediaInfo>(&mut v0.social_media, arg3, v1);
        let v2 = AddMediaToPoolEvent{
            pool_address : arg2,
            name         : arg3,
            link         : arg4,
        };
        0x2::event::emit<AddMediaToPoolEvent>(v2);
    }

    public fun add_pool_conf(arg0: &AdminCap, arg1: &mut Config, arg2: address, arg3: bool, arg4: vector<0x1::string::String>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String) {
        checked_package_version(arg1);
        assert!(!0x2::table::contains<address, PoolConfig>(&arg1.pools, arg2), 1);
        let v0 = PoolConfig{
            pool_address     : arg2,
            is_close         : arg3,
            banners          : arg4,
            introduction     : arg5,
            website          : arg6,
            tokenomics       : arg7,
            social_media     : 0x2::vec_map::empty<0x1::string::String, MediaInfo>(),
            terms            : arg8,
            white_list_terms : arg9,
            regulation       : arg10,
            project_details  : arg11,
        };
        0x2::table::add<address, PoolConfig>(&mut arg1.pools, arg2, v0);
        let v1 = AddPoolEvent{pool_address: arg2};
        0x2::event::emit<AddPoolEvent>(v1);
    }

    fun checked_package_version(arg0: &Config) {
        assert!(arg0.package_version == 1, 0);
    }

    public fun close_pool(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        checked_package_version(arg1);
        assert!(0x2::table::contains<address, PoolConfig>(&arg1.pools, arg2), 2);
        0x2::table::borrow_mut<address, PoolConfig>(&mut arg1.pools, arg2).is_close = true;
        let v0 = ClosePoolEvent{pool_address: arg2};
        0x2::event::emit<ClosePoolEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Config{
            id              : 0x2::object::new(arg0),
            pools           : 0x2::table::new<address, PoolConfig>(arg0),
            package_version : 1,
        };
        0x2::transfer::share_object<Config>(v1);
        let v2 = InitEvent{
            conf_id      : 0x2::object::id<Config>(&v1),
            admin_cap_id : 0x2::object::id<AdminCap>(&v0),
        };
        0x2::event::emit<InitEvent>(v2);
    }

    public fun open_pool(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        checked_package_version(arg1);
        assert!(0x2::table::contains<address, PoolConfig>(&arg1.pools, arg2), 2);
        0x2::table::borrow_mut<address, PoolConfig>(&mut arg1.pools, arg2).is_close = false;
        let v0 = OpenPoolEvent{pool_address: arg2};
        0x2::event::emit<OpenPoolEvent>(v0);
    }

    public fun remove_media_from_pool(arg0: &AdminCap, arg1: &mut Config, arg2: address, arg3: 0x1::string::String) {
        checked_package_version(arg1);
        assert!(0x2::table::contains<address, PoolConfig>(&arg1.pools, arg2), 2);
        let v0 = 0x2::table::borrow_mut<address, PoolConfig>(&mut arg1.pools, arg2);
        assert!(0x2::vec_map::contains<0x1::string::String, MediaInfo>(&v0.social_media, &arg3), 3);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, MediaInfo>(&mut v0.social_media, &arg3);
        let v3 = RemoveMediaFromPoolEvent{
            pool_address : arg2,
            name         : arg3,
        };
        0x2::event::emit<RemoveMediaFromPoolEvent>(v3);
    }

    public fun remove_pool_conf(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        checked_package_version(arg1);
        assert!(0x2::table::contains<address, PoolConfig>(&arg1.pools, arg2), 2);
        0x2::table::remove<address, PoolConfig>(&mut arg1.pools, arg2);
        let v0 = RemovePoolEvent{pool_address: arg2};
        0x2::event::emit<RemovePoolEvent>(v0);
    }

    public fun update_pool_conf(arg0: &AdminCap, arg1: &mut Config, arg2: address, arg3: bool, arg4: vector<0x1::string::String>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String) {
        checked_package_version(arg1);
        assert!(0x2::table::contains<address, PoolConfig>(&arg1.pools, arg2), 2);
        let v0 = 0x2::table::borrow_mut<address, PoolConfig>(&mut arg1.pools, arg2);
        v0.pool_address = arg2;
        v0.is_close = arg3;
        v0.banners = arg4;
        v0.introduction = arg5;
        v0.website = arg6;
        v0.tokenomics = arg7;
        v0.terms = arg8;
        v0.white_list_terms = arg9;
        v0.regulation = arg10;
        v0.project_details = arg11;
        let v1 = UpdatePoolEvent{pool_address: arg2};
        0x2::event::emit<UpdatePoolEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

