module 0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::market_registry {
    struct MarketRegistry has store, key {
        id: 0x2::object::UID,
        next_project_id: u64,
        next_series_id: u64,
        project_count: u64,
        series_count: u64,
        market_count: u64,
        series_ids: vector<u64>,
        market_ids: vector<0x2::object::ID>,
        point_program_ids: vector<0x2::object::ID>,
    }

    struct ProjectKey has copy, drop, store {
        pos0: u64,
    }

    struct RegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        creator: address,
    }

    struct SeriesKey has copy, drop, store {
        pos0: u64,
    }

    struct MarketKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct ProjectPointConfigKey has copy, drop, store {
        pos0: u64,
    }

    struct MarketPointConfigKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct PointProgramKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct MarketPointProgramKey has copy, drop, store {
        market_id: 0x2::object::ID,
        point_config_id: 0x2::object::ID,
    }

    struct MarketPointProgramIdsKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct PointProgramMarketIdsKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct ProjectMetadataKey has copy, drop, store {
        pos0: u64,
    }

    struct MarketMetadataKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct Project has copy, drop, store {
        project_id: u64,
        owner: address,
        name: vector<u8>,
        metadata_uri: vector<u8>,
    }

    struct MarketSeries has copy, drop, store {
        series_id: u64,
        project_id: u64,
        name: vector<u8>,
        metadata_uri: vector<u8>,
        default_market_id: 0x2::object::ID,
        market_ids: vector<0x2::object::ID>,
        listed: bool,
    }

    struct MarketRecord has copy, drop, store {
        project_id: u64,
        series_id: u64,
        market_id: 0x2::object::ID,
        market_state_id: 0x2::object::ID,
        py_state_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        reward_distributor_id: 0x2::object::ID,
        pt_orderbook_id: 0x2::object::ID,
        yt_orderbook_id: 0x2::object::ID,
        expiry: u64,
        listed: bool,
        display_rank: u64,
    }

    struct ProjectMetadata has copy, drop, store {
        project_id: u64,
        description: vector<u8>,
        icon_uri: vector<u8>,
        website_uri: vector<u8>,
    }

    struct MarketMetadata has copy, drop, store {
        project_id: u64,
        series_id: u64,
        market_id: 0x2::object::ID,
        adapter: vector<u8>,
        name: vector<u8>,
        symbol: vector<u8>,
        description: vector<u8>,
        icon_uri: vector<u8>,
        metadata_uri: vector<u8>,
        underlying_type: 0x1::type_name::TypeName,
        sy_type: 0x1::type_name::TypeName,
        pt_type: 0x1::type_name::TypeName,
        yt_type: 0x1::type_name::TypeName,
    }

    struct ProjectPointConfig has copy, drop, store {
        project_id: u64,
        enabled: bool,
        liquidlink_global_config_id: 0x2::object::ID,
        scoreboard_id: 0x2::object::ID,
        point_cap_id: 0x2::object::ID,
        point_config_id: 0x2::object::ID,
        point_token_market_id: 0x2::object::ID,
        point_orderbook_id: 0x2::object::ID,
        point_token_type: vector<u8>,
        quote_coin_type: vector<u8>,
        quote_symbol: vector<u8>,
        yt_multiplier_bps: u64,
        lp_multiplier_bps: u64,
        point_duration_ms: u64,
    }

    struct MarketPointConfig has copy, drop, store {
        project_id: u64,
        market_id: 0x2::object::ID,
        point_config_id: 0x2::object::ID,
        lp_point_state_id: 0x2::object::ID,
        yt_multiplier_bps: u64,
        lp_multiplier_bps: u64,
        point_duration_ms: u64,
    }

    struct PointProgram has copy, drop, store {
        point_config_id: 0x2::object::ID,
        liquidlink_global_config_id: 0x2::object::ID,
        project_object_id: 0x2::object::ID,
        scoreboard_id: 0x2::object::ID,
        name: vector<u8>,
        protocol: vector<u8>,
        season: vector<u8>,
        metadata_uri: vector<u8>,
        enabled: bool,
    }

    struct MarketPointProgram has copy, drop, store {
        market_id: 0x2::object::ID,
        point_config_id: 0x2::object::ID,
        lp_point_state_id: 0x2::object::ID,
        yt_enabled: bool,
        lp_enabled: bool,
        pool_enabled: bool,
    }

    struct ProjectRegistered has copy, drop {
        registry_id: 0x2::object::ID,
        project_id: u64,
        owner: address,
        name: vector<u8>,
        metadata_uri: vector<u8>,
    }

    struct SeriesRegistered has copy, drop {
        registry_id: 0x2::object::ID,
        project_id: u64,
        series_id: u64,
        name: vector<u8>,
        metadata_uri: vector<u8>,
        listed: bool,
    }

    struct SeriesListedUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        project_id: u64,
        series_id: u64,
        listed: bool,
    }

    struct SeriesDefaultMarketUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        project_id: u64,
        series_id: u64,
        default_market_id: 0x2::object::ID,
    }

    struct MarketRegistered has copy, drop {
        registry_id: 0x2::object::ID,
        project_id: u64,
        series_id: u64,
        market_id: 0x2::object::ID,
        market_state_id: 0x2::object::ID,
        py_state_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        reward_distributor_id: 0x2::object::ID,
        expiry: u64,
        listed: bool,
        display_rank: u64,
    }

    struct MarketOrderbookUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        pt_orderbook_id: 0x2::object::ID,
        yt_orderbook_id: 0x2::object::ID,
    }

    struct MarketListedUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        project_id: u64,
        series_id: u64,
        market_id: 0x2::object::ID,
        listed: bool,
        display_rank: u64,
    }

    struct ProjectMetadataUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        project_id: u64,
        description: vector<u8>,
        icon_uri: vector<u8>,
        website_uri: vector<u8>,
    }

    struct MarketMetadataUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        project_id: u64,
        series_id: u64,
        market_id: 0x2::object::ID,
        adapter: vector<u8>,
        name: vector<u8>,
        symbol: vector<u8>,
        description: vector<u8>,
        icon_uri: vector<u8>,
        metadata_uri: vector<u8>,
        underlying_type: 0x1::type_name::TypeName,
        sy_type: 0x1::type_name::TypeName,
        pt_type: 0x1::type_name::TypeName,
        yt_type: 0x1::type_name::TypeName,
    }

    struct ProjectPointConfigUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        project_id: u64,
        enabled: bool,
        liquidlink_global_config_id: 0x2::object::ID,
        scoreboard_id: 0x2::object::ID,
        point_cap_id: 0x2::object::ID,
        point_config_id: 0x2::object::ID,
        point_token_market_id: 0x2::object::ID,
        point_orderbook_id: 0x2::object::ID,
        point_token_type: vector<u8>,
        quote_coin_type: vector<u8>,
        quote_symbol: vector<u8>,
        yt_multiplier_bps: u64,
        lp_multiplier_bps: u64,
        point_duration_ms: u64,
    }

    struct MarketPointConfigUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        project_id: u64,
        market_id: 0x2::object::ID,
        point_config_id: 0x2::object::ID,
        lp_point_state_id: 0x2::object::ID,
        yt_multiplier_bps: u64,
        lp_multiplier_bps: u64,
        point_duration_ms: u64,
    }

    struct PointProgramRegistered has copy, drop {
        registry_id: 0x2::object::ID,
        point_config_id: 0x2::object::ID,
        liquidlink_global_config_id: 0x2::object::ID,
        project_object_id: 0x2::object::ID,
        scoreboard_id: 0x2::object::ID,
        name: vector<u8>,
        protocol: vector<u8>,
        season: vector<u8>,
        metadata_uri: vector<u8>,
        enabled: bool,
    }

    struct PointProgramEnabledUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        point_config_id: 0x2::object::ID,
        enabled: bool,
    }

    struct MarketPointProgramAttached has copy, drop {
        registry_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        point_config_id: 0x2::object::ID,
        lp_point_state_id: 0x2::object::ID,
        yt_enabled: bool,
        lp_enabled: bool,
        pool_enabled: bool,
    }

    struct MarketPointProgramDetached has copy, drop {
        registry_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        point_config_id: 0x2::object::ID,
    }

    public fun id(arg0: &MarketRegistry) : 0x2::object::ID {
        0x2::object::id<MarketRegistry>(arg0)
    }

    fun assert_market_state_record<T0: drop, T1: drop, T2: drop>(arg0: &MarketRecord, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>) {
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg1);
        assert!(arg0.market_id == v0, 3203);
        assert!(arg0.market_state_id == v0, 3203);
        assert!(arg0.py_state_id == none_id(), 3203);
        assert!(arg0.pool_id == none_id(), 3203);
        let v1 = if (0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::reward_distributor_required<T0, T1, T2>(arg1)) {
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::reward_distributor_id<T0, T1, T2>(arg1)
        } else {
            none_id()
        };
        assert!(arg0.reward_distributor_id == v1, 3203);
        assert!(arg0.expiry == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::expiry<T0, T1, T2>(arg1), 3203);
    }

    fun assert_metadata_size(arg0: &vector<u8>, arg1: u64) {
        assert!(0x1::vector::length<u8>(arg0) <= arg1, 3216);
    }

    fun attach_market_point_program(arg0: &mut MarketRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: bool, arg5: bool, arg6: bool) {
        assert!(market_registered(arg0, arg1), 3202);
        assert!(point_program_exists(arg0, arg2), 3211);
        let v0 = point_program(arg0, arg2);
        assert!(v0.enabled, 3211);
        let v1 = if (arg4) {
            true
        } else if (arg5) {
            true
        } else {
            arg6
        };
        assert!(v1, 3214);
        assert!(arg5 == arg6, 3214);
        if (arg5) {
            assert!(arg3 != none_id(), 3214);
        } else {
            assert!(arg3 == none_id(), 3214);
        };
        assert!(!market_point_program_exists(arg0, arg1, arg2), 3212);
        let v2 = MarketPointProgramKey{
            market_id       : arg1,
            point_config_id : arg2,
        };
        let v3 = MarketPointProgram{
            market_id         : arg1,
            point_config_id   : arg2,
            lp_point_state_id : arg3,
            yt_enabled        : arg4,
            lp_enabled        : arg5,
            pool_enabled      : arg6,
        };
        0x2::dynamic_field::add<MarketPointProgramKey, MarketPointProgram>(&mut arg0.id, v2, v3);
        let v4 = MarketPointProgramIdsKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<MarketPointProgramIdsKey>(&arg0.id, v4)) {
            let v5 = MarketPointProgramIdsKey{pos0: arg1};
            0x2::dynamic_field::add<MarketPointProgramIdsKey, vector<0x2::object::ID>>(&mut arg0.id, v5, 0x1::vector::empty<0x2::object::ID>());
        };
        let v6 = MarketPointProgramIdsKey{pos0: arg1};
        0x1::vector::push_back<0x2::object::ID>(0x2::dynamic_field::borrow_mut<MarketPointProgramIdsKey, vector<0x2::object::ID>>(&mut arg0.id, v6), arg2);
        let v7 = PointProgramMarketIdsKey{pos0: arg2};
        0x1::vector::push_back<0x2::object::ID>(0x2::dynamic_field::borrow_mut<PointProgramMarketIdsKey, vector<0x2::object::ID>>(&mut arg0.id, v7), arg1);
        let v8 = MarketPointProgramAttached{
            registry_id       : 0x2::object::id<MarketRegistry>(arg0),
            market_id         : arg1,
            point_config_id   : arg2,
            lp_point_state_id : arg3,
            yt_enabled        : arg4,
            lp_enabled        : arg5,
            pool_enabled      : arg6,
        };
        0x2::event::emit<MarketPointProgramAttached>(v8);
    }

    public fun attach_market_state_point_program_by_admin<T0: drop, T1: drop, T2: drop>(arg0: &mut MarketRegistry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: bool, arg7: bool, arg8: bool) {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg1);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg3);
        let v1 = market_record(arg0, v0);
        assert_market_state_record<T0, T1, T2>(&v1, arg3);
        attach_market_point_program(arg0, v0, arg4, arg5, arg6, arg7, arg8);
    }

    fun borrow_market_record_mut(arg0: &mut MarketRegistry, arg1: 0x2::object::ID) : &mut MarketRecord {
        assert!(market_registered(arg0, arg1), 3202);
        let v0 = MarketKey{pos0: arg1};
        0x2::dynamic_field::borrow_mut<MarketKey, MarketRecord>(&mut arg0.id, v0)
    }

    public fun clear_market_state_point_config_by_admin<T0: drop, T1: drop, T2: drop>(arg0: &mut MarketRegistry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>) {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg1);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg3);
        let v1 = market_record(arg0, v0);
        assert_market_state_record<T0, T1, T2>(&v1, arg3);
        set_market_point_config(arg0, v1.project_id, v0, none_id(), none_id(), 0, 0, 0);
    }

    public fun clear_project_point_config_by_admin(arg0: &mut MarketRegistry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: u64) {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg1);
        set_project_point_config(arg0, arg3, false, none_id(), none_id(), none_id(), none_id(), none_id(), none_id(), b"", b"", b"", 0, 0, 0);
    }

    fun create(arg0: &mut 0x2::tx_context::TxContext) : MarketRegistry {
        let v0 = MarketRegistry{
            id                : 0x2::object::new(arg0),
            next_project_id   : 1,
            next_series_id    : 1,
            project_count     : 0,
            series_count      : 0,
            market_count      : 0,
            series_ids        : vector[],
            market_ids        : 0x1::vector::empty<0x2::object::ID>(),
            point_program_ids : 0x1::vector::empty<0x2::object::ID>(),
        };
        let v1 = RegistryCreated{
            registry_id : 0x2::object::id<MarketRegistry>(&v0),
            creator     : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<RegistryCreated>(v1);
        v0
    }

    public fun create_and_share_by_admin(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg0);
        let v0 = create(arg2);
        0x2::transfer::share_object<MarketRegistry>(v0);
        0x2::object::id<MarketRegistry>(&v0)
    }

    public fun create_by_admin(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) : MarketRegistry {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg0);
        create(arg2)
    }

    fun detach_market_point_program(arg0: &mut MarketRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        assert!(market_point_program_exists(arg0, arg1, arg2), 3213);
        let v0 = MarketPointProgramKey{
            market_id       : arg1,
            point_config_id : arg2,
        };
        let MarketPointProgram {
            market_id         : _,
            point_config_id   : _,
            lp_point_state_id : _,
            yt_enabled        : _,
            lp_enabled        : _,
            pool_enabled      : _,
        } = 0x2::dynamic_field::remove<MarketPointProgramKey, MarketPointProgram>(&mut arg0.id, v0);
        let v7 = MarketPointProgramIdsKey{pos0: arg1};
        let v8 = 0x2::dynamic_field::borrow_mut<MarketPointProgramIdsKey, vector<0x2::object::ID>>(&mut arg0.id, v7);
        remove_id(v8, arg2);
        let v9 = PointProgramMarketIdsKey{pos0: arg2};
        let v10 = 0x2::dynamic_field::borrow_mut<PointProgramMarketIdsKey, vector<0x2::object::ID>>(&mut arg0.id, v9);
        remove_id(v10, arg1);
        let v11 = MarketPointProgramDetached{
            registry_id     : 0x2::object::id<MarketRegistry>(arg0),
            market_id       : arg1,
            point_config_id : arg2,
        };
        0x2::event::emit<MarketPointProgramDetached>(v11);
    }

    public fun detach_market_state_point_program_by_admin<T0: drop, T1: drop, T2: drop>(arg0: &mut MarketRegistry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: 0x2::object::ID) {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg1);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg3);
        let v1 = market_record(arg0, v0);
        assert_market_state_record<T0, T1, T2>(&v1, arg3);
        detach_market_point_program(arg0, v0, arg4);
    }

    public fun market_count(arg0: &MarketRegistry) : u64 {
        arg0.market_count
    }

    public fun market_display_rank(arg0: &MarketRegistry, arg1: 0x2::object::ID) : u64 {
        let v0 = market_record(arg0, arg1);
        v0.display_rank
    }

    public fun market_expiry(arg0: &MarketRegistry, arg1: 0x2::object::ID) : u64 {
        let v0 = market_record(arg0, arg1);
        v0.expiry
    }

    public fun market_id_at(arg0: &MarketRegistry, arg1: u64) : 0x2::object::ID {
        assert!(arg1 < 0x1::vector::length<0x2::object::ID>(&arg0.market_ids), 3207);
        *0x1::vector::borrow<0x2::object::ID>(&arg0.market_ids, arg1)
    }

    public fun market_ids(arg0: &MarketRegistry) : vector<0x2::object::ID> {
        arg0.market_ids
    }

    public fun market_listed(arg0: &MarketRegistry, arg1: 0x2::object::ID) : bool {
        let v0 = market_record(arg0, arg1);
        v0.listed
    }

    public fun market_lp_point_state_id(arg0: &MarketRegistry, arg1: 0x2::object::ID) : 0x2::object::ID {
        if (!market_point_config_exists(arg0, arg1)) {
            none_id()
        } else {
            let v1 = market_point_config(arg0, arg1);
            v1.lp_point_state_id
        }
    }

    public fun market_metadata(arg0: &MarketRegistry, arg1: 0x2::object::ID) : MarketMetadata {
        assert!(market_metadata_exists(arg0, arg1), 3202);
        let v0 = MarketMetadataKey{pos0: arg1};
        *0x2::dynamic_field::borrow<MarketMetadataKey, MarketMetadata>(&arg0.id, v0)
    }

    public fun market_metadata_exists(arg0: &MarketRegistry, arg1: 0x2::object::ID) : bool {
        let v0 = MarketMetadataKey{pos0: arg1};
        0x2::dynamic_field::exists<MarketMetadataKey>(&arg0.id, v0)
    }

    public fun market_point_config(arg0: &MarketRegistry, arg1: 0x2::object::ID) : MarketPointConfig {
        assert!(market_point_config_exists(arg0, arg1), 3202);
        let v0 = MarketPointConfigKey{pos0: arg1};
        *0x2::dynamic_field::borrow<MarketPointConfigKey, MarketPointConfig>(&arg0.id, v0)
    }

    public fun market_point_config_exists(arg0: &MarketRegistry, arg1: 0x2::object::ID) : bool {
        let v0 = MarketPointConfigKey{pos0: arg1};
        0x2::dynamic_field::exists<MarketPointConfigKey>(&arg0.id, v0)
    }

    public fun market_point_config_ids(arg0: &MarketRegistry, arg1: 0x2::object::ID) : (u64, 0x2::object::ID, 0x2::object::ID, 0x2::object::ID) {
        let v0 = market_point_config(arg0, arg1);
        (v0.project_id, v0.market_id, v0.point_config_id, v0.lp_point_state_id)
    }

    public fun market_point_config_params(arg0: &MarketRegistry, arg1: 0x2::object::ID) : (u64, u64, u64) {
        let v0 = market_point_config(arg0, arg1);
        (v0.yt_multiplier_bps, v0.lp_multiplier_bps, v0.point_duration_ms)
    }

    public fun market_point_program(arg0: &MarketRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : MarketPointProgram {
        assert!(market_point_program_exists(arg0, arg1, arg2), 3213);
        let v0 = MarketPointProgramKey{
            market_id       : arg1,
            point_config_id : arg2,
        };
        *0x2::dynamic_field::borrow<MarketPointProgramKey, MarketPointProgram>(&arg0.id, v0)
    }

    public fun market_point_program_config(arg0: &MarketRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID, bool, bool, bool) {
        let v0 = market_point_program(arg0, arg1, arg2);
        (v0.market_id, v0.point_config_id, v0.lp_point_state_id, v0.yt_enabled, v0.lp_enabled, v0.pool_enabled)
    }

    public fun market_point_program_count(arg0: &MarketRegistry, arg1: 0x2::object::ID) : u64 {
        let v0 = MarketPointProgramIdsKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<MarketPointProgramIdsKey>(&arg0.id, v0)) {
            0
        } else {
            let v2 = MarketPointProgramIdsKey{pos0: arg1};
            0x1::vector::length<0x2::object::ID>(0x2::dynamic_field::borrow<MarketPointProgramIdsKey, vector<0x2::object::ID>>(&arg0.id, v2))
        }
    }

    public fun market_point_program_exists(arg0: &MarketRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : bool {
        let v0 = MarketPointProgramKey{
            market_id       : arg1,
            point_config_id : arg2,
        };
        0x2::dynamic_field::exists<MarketPointProgramKey>(&arg0.id, v0)
    }

    public fun market_point_program_id_at(arg0: &MarketRegistry, arg1: 0x2::object::ID, arg2: u64) : 0x2::object::ID {
        assert!(arg2 < market_point_program_count(arg0, arg1), 3207);
        let v0 = MarketPointProgramIdsKey{pos0: arg1};
        *0x1::vector::borrow<0x2::object::ID>(0x2::dynamic_field::borrow<MarketPointProgramIdsKey, vector<0x2::object::ID>>(&arg0.id, v0), arg2)
    }

    public fun market_point_program_ids(arg0: &MarketRegistry, arg1: 0x2::object::ID) : vector<0x2::object::ID> {
        let v0 = MarketPointProgramIdsKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<MarketPointProgramIdsKey>(&arg0.id, v0)) {
            0x1::vector::empty<0x2::object::ID>()
        } else {
            let v2 = MarketPointProgramIdsKey{pos0: arg1};
            *0x2::dynamic_field::borrow<MarketPointProgramIdsKey, vector<0x2::object::ID>>(&arg0.id, v2)
        }
    }

    public fun market_project_id(arg0: &MarketRegistry, arg1: 0x2::object::ID) : u64 {
        let v0 = market_record(arg0, arg1);
        v0.project_id
    }

    public fun market_record(arg0: &MarketRegistry, arg1: 0x2::object::ID) : MarketRecord {
        assert!(market_registered(arg0, arg1), 3202);
        let v0 = MarketKey{pos0: arg1};
        *0x2::dynamic_field::borrow<MarketKey, MarketRecord>(&arg0.id, v0)
    }

    public fun market_record_at(arg0: &MarketRegistry, arg1: u64) : MarketRecord {
        market_record(arg0, market_id_at(arg0, arg1))
    }

    public fun market_registered(arg0: &MarketRegistry, arg1: 0x2::object::ID) : bool {
        let v0 = MarketKey{pos0: arg1};
        0x2::dynamic_field::exists<MarketKey>(&arg0.id, v0)
    }

    public fun market_reward_distributor_id(arg0: &MarketRegistry, arg1: 0x2::object::ID) : 0x2::object::ID {
        let v0 = market_record(arg0, arg1);
        v0.reward_distributor_id
    }

    public fun market_series_id(arg0: &MarketRegistry, arg1: 0x2::object::ID) : u64 {
        let v0 = market_record(arg0, arg1);
        v0.series_id
    }

    public fun market_state_id(arg0: &MarketRegistry, arg1: 0x2::object::ID) : 0x2::object::ID {
        let v0 = market_record(arg0, arg1);
        v0.market_state_id
    }

    public fun none_id() : 0x2::object::ID {
        0x2::object::id_from_address(@0x0)
    }

    public fun point_program(arg0: &MarketRegistry, arg1: 0x2::object::ID) : PointProgram {
        assert!(point_program_exists(arg0, arg1), 3211);
        let v0 = PointProgramKey{pos0: arg1};
        *0x2::dynamic_field::borrow<PointProgramKey, PointProgram>(&arg0.id, v0)
    }

    public fun point_program_count(arg0: &MarketRegistry) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.point_program_ids)
    }

    public fun point_program_exists(arg0: &MarketRegistry, arg1: 0x2::object::ID) : bool {
        let v0 = PointProgramKey{pos0: arg1};
        0x2::dynamic_field::exists<PointProgramKey>(&arg0.id, v0)
    }

    public fun point_program_id_at(arg0: &MarketRegistry, arg1: u64) : 0x2::object::ID {
        assert!(arg1 < 0x1::vector::length<0x2::object::ID>(&arg0.point_program_ids), 3207);
        *0x1::vector::borrow<0x2::object::ID>(&arg0.point_program_ids, arg1)
    }

    public fun point_program_ids(arg0: &MarketRegistry) : vector<0x2::object::ID> {
        arg0.point_program_ids
    }

    public fun point_program_ids_config(arg0: &MarketRegistry, arg1: 0x2::object::ID) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID, 0x2::object::ID) {
        let v0 = point_program(arg0, arg1);
        (v0.liquidlink_global_config_id, v0.project_object_id, v0.scoreboard_id, v0.point_config_id)
    }

    public fun point_program_market_count(arg0: &MarketRegistry, arg1: 0x2::object::ID) : u64 {
        assert!(point_program_exists(arg0, arg1), 3211);
        let v0 = PointProgramMarketIdsKey{pos0: arg1};
        0x1::vector::length<0x2::object::ID>(0x2::dynamic_field::borrow<PointProgramMarketIdsKey, vector<0x2::object::ID>>(&arg0.id, v0))
    }

    public fun point_program_market_id_at(arg0: &MarketRegistry, arg1: 0x2::object::ID, arg2: u64) : 0x2::object::ID {
        assert!(arg2 < point_program_market_count(arg0, arg1), 3207);
        let v0 = PointProgramMarketIdsKey{pos0: arg1};
        *0x1::vector::borrow<0x2::object::ID>(0x2::dynamic_field::borrow<PointProgramMarketIdsKey, vector<0x2::object::ID>>(&arg0.id, v0), arg2)
    }

    public fun point_program_market_ids(arg0: &MarketRegistry, arg1: 0x2::object::ID) : vector<0x2::object::ID> {
        assert!(point_program_exists(arg0, arg1), 3211);
        let v0 = PointProgramMarketIdsKey{pos0: arg1};
        *0x2::dynamic_field::borrow<PointProgramMarketIdsKey, vector<0x2::object::ID>>(&arg0.id, v0)
    }

    public fun point_program_metadata(arg0: &MarketRegistry, arg1: 0x2::object::ID) : (vector<u8>, vector<u8>, vector<u8>, vector<u8>, bool) {
        let v0 = point_program(arg0, arg1);
        (v0.name, v0.protocol, v0.season, v0.metadata_uri, v0.enabled)
    }

    public fun project(arg0: &MarketRegistry, arg1: u64) : Project {
        assert!(project_exists(arg0, arg1), 3200);
        let v0 = ProjectKey{pos0: arg1};
        *0x2::dynamic_field::borrow<ProjectKey, Project>(&arg0.id, v0)
    }

    public fun project_count(arg0: &MarketRegistry) : u64 {
        arg0.project_count
    }

    public fun project_exists(arg0: &MarketRegistry, arg1: u64) : bool {
        let v0 = ProjectKey{pos0: arg1};
        0x2::dynamic_field::exists<ProjectKey>(&arg0.id, v0)
    }

    public fun project_id_at(arg0: &MarketRegistry, arg1: u64) : u64 {
        assert!(arg1 < arg0.project_count, 3207);
        arg1 + 1
    }

    public fun project_metadata(arg0: &MarketRegistry, arg1: u64) : ProjectMetadata {
        assert!(project_metadata_exists(arg0, arg1), 3200);
        let v0 = ProjectMetadataKey{pos0: arg1};
        *0x2::dynamic_field::borrow<ProjectMetadataKey, ProjectMetadata>(&arg0.id, v0)
    }

    public fun project_metadata_exists(arg0: &MarketRegistry, arg1: u64) : bool {
        let v0 = ProjectMetadataKey{pos0: arg1};
        0x2::dynamic_field::exists<ProjectMetadataKey>(&arg0.id, v0)
    }

    public fun project_point_config(arg0: &MarketRegistry, arg1: u64) : ProjectPointConfig {
        assert!(project_point_config_exists(arg0, arg1), 3200);
        let v0 = ProjectPointConfigKey{pos0: arg1};
        *0x2::dynamic_field::borrow<ProjectPointConfigKey, ProjectPointConfig>(&arg0.id, v0)
    }

    public fun project_point_config_exists(arg0: &MarketRegistry, arg1: u64) : bool {
        let v0 = ProjectPointConfigKey{pos0: arg1};
        0x2::dynamic_field::exists<ProjectPointConfigKey>(&arg0.id, v0)
    }

    public fun project_point_config_ids(arg0: &MarketRegistry, arg1: u64) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID, 0x2::object::ID, 0x2::object::ID, 0x2::object::ID) {
        let v0 = project_point_config(arg0, arg1);
        (v0.liquidlink_global_config_id, v0.scoreboard_id, v0.point_cap_id, v0.point_config_id, v0.point_token_market_id, v0.point_orderbook_id)
    }

    public fun project_point_config_metadata(arg0: &MarketRegistry, arg1: u64) : (vector<u8>, vector<u8>, vector<u8>) {
        let v0 = project_point_config(arg0, arg1);
        (v0.point_token_type, v0.quote_coin_type, v0.quote_symbol)
    }

    public fun project_point_config_params(arg0: &MarketRegistry, arg1: u64) : (bool, u64, u64, u64) {
        let v0 = project_point_config(arg0, arg1);
        (v0.enabled, v0.yt_multiplier_bps, v0.lp_multiplier_bps, v0.point_duration_ms)
    }

    public fun project_points_enabled(arg0: &MarketRegistry, arg1: u64) : bool {
        if (!project_point_config_exists(arg0, arg1)) {
            false
        } else {
            let v1 = project_point_config(arg0, arg1);
            v1.enabled
        }
    }

    fun register_market_state<T0: drop, T1: drop, T2: drop>(arg0: &mut MarketRegistry, arg1: u64, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg3: bool, arg4: u64) {
        assert!(series_exists(arg0, arg1), 3208);
        let v0 = series(arg0, arg1);
        let v1 = v0.project_id;
        assert!(project_exists(arg0, v1), 3200);
        let v2 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg2);
        assert!(!market_registered(arg0, v2), 3201);
        let v3 = if (0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::reward_distributor_required<T0, T1, T2>(arg2)) {
            0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::reward_distributor_id<T0, T1, T2>(arg2)
        } else {
            none_id()
        };
        let v4 = MarketRecord{
            project_id            : v1,
            series_id             : arg1,
            market_id             : v2,
            market_state_id       : v2,
            py_state_id           : none_id(),
            pool_id               : none_id(),
            reward_distributor_id : v3,
            pt_orderbook_id       : none_id(),
            yt_orderbook_id       : none_id(),
            expiry                : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::expiry<T0, T1, T2>(arg2),
            listed                : arg3,
            display_rank          : arg4,
        };
        let v5 = MarketKey{pos0: v2};
        0x2::dynamic_field::add<MarketKey, MarketRecord>(&mut arg0.id, v5, v4);
        arg0.market_count = arg0.market_count + 1;
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.market_ids, v2);
        let v6 = SeriesKey{pos0: arg1};
        let v7 = 0x2::dynamic_field::borrow_mut<SeriesKey, MarketSeries>(&mut arg0.id, v6);
        0x1::vector::push_back<0x2::object::ID>(&mut v7.market_ids, v2);
        if (v7.default_market_id == none_id() && arg3) {
            v7.default_market_id = v2;
        };
        let v8 = MarketRegistered{
            registry_id           : 0x2::object::id<MarketRegistry>(arg0),
            project_id            : v1,
            series_id             : arg1,
            market_id             : v2,
            market_state_id       : v4.market_state_id,
            py_state_id           : v4.py_state_id,
            pool_id               : v4.pool_id,
            reward_distributor_id : v3,
            expiry                : v4.expiry,
            listed                : arg3,
            display_rank          : arg4,
        };
        0x2::event::emit<MarketRegistered>(v8);
    }

    public fun register_market_state_by_admin<T0: drop, T1: drop, T2: drop>(arg0: &mut MarketRegistry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: u64, arg4: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg5: bool, arg6: u64) {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg1);
        register_market_state<T0, T1, T2>(arg0, arg3, arg4, arg5, arg6);
    }

    fun register_point_program(arg0: &mut MarketRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: bool) {
        assert!(!point_program_exists(arg0, arg4), 3210);
        assert!(arg4 != none_id(), 3211);
        assert!(arg2 != none_id(), 3211);
        assert!(arg3 != none_id(), 3211);
        let v0 = PointProgram{
            point_config_id             : arg4,
            liquidlink_global_config_id : arg1,
            project_object_id           : arg2,
            scoreboard_id               : arg3,
            name                        : arg5,
            protocol                    : arg6,
            season                      : arg7,
            metadata_uri                : arg8,
            enabled                     : arg9,
        };
        let v1 = PointProgramKey{pos0: arg4};
        0x2::dynamic_field::add<PointProgramKey, PointProgram>(&mut arg0.id, v1, v0);
        let v2 = PointProgramMarketIdsKey{pos0: arg4};
        0x2::dynamic_field::add<PointProgramMarketIdsKey, vector<0x2::object::ID>>(&mut arg0.id, v2, 0x1::vector::empty<0x2::object::ID>());
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.point_program_ids, arg4);
        let v3 = PointProgramRegistered{
            registry_id                 : 0x2::object::id<MarketRegistry>(arg0),
            point_config_id             : arg4,
            liquidlink_global_config_id : arg1,
            project_object_id           : arg2,
            scoreboard_id               : arg3,
            name                        : arg5,
            protocol                    : arg6,
            season                      : arg7,
            metadata_uri                : arg8,
            enabled                     : arg9,
        };
        0x2::event::emit<PointProgramRegistered>(v3);
    }

    public fun register_point_program_by_admin(arg0: &mut MarketRegistry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: bool) {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg1);
        register_point_program(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    fun register_project(arg0: &mut MarketRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: address) : u64 {
        let v0 = arg0.next_project_id;
        assert!(v0 > 0, 3206);
        arg0.next_project_id = v0 + 1;
        arg0.project_count = arg0.project_count + 1;
        let v1 = ProjectKey{pos0: v0};
        let v2 = Project{
            project_id   : v0,
            owner        : arg3,
            name         : arg1,
            metadata_uri : arg2,
        };
        0x2::dynamic_field::add<ProjectKey, Project>(&mut arg0.id, v1, v2);
        let v3 = ProjectRegistered{
            registry_id  : 0x2::object::id<MarketRegistry>(arg0),
            project_id   : v0,
            owner        : arg3,
            name         : arg1,
            metadata_uri : arg2,
        };
        0x2::event::emit<ProjectRegistered>(v3);
        v0
    }

    public fun register_project_by_admin(arg0: &mut MarketRegistry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::tx_context::TxContext) : u64 {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg1);
        register_project(arg0, arg3, arg4, 0x2::tx_context::sender(arg5))
    }

    fun register_series(arg0: &mut MarketRegistry, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: bool) : u64 {
        assert!(project_exists(arg0, arg1), 3200);
        let v0 = arg0.next_series_id;
        assert!(v0 > 0, 3206);
        arg0.next_series_id = v0 + 1;
        arg0.series_count = arg0.series_count + 1;
        0x1::vector::push_back<u64>(&mut arg0.series_ids, v0);
        let v1 = SeriesKey{pos0: v0};
        let v2 = MarketSeries{
            series_id         : v0,
            project_id        : arg1,
            name              : arg2,
            metadata_uri      : arg3,
            default_market_id : none_id(),
            market_ids        : 0x1::vector::empty<0x2::object::ID>(),
            listed            : arg4,
        };
        0x2::dynamic_field::add<SeriesKey, MarketSeries>(&mut arg0.id, v1, v2);
        let v3 = SeriesRegistered{
            registry_id  : 0x2::object::id<MarketRegistry>(arg0),
            project_id   : arg1,
            series_id    : v0,
            name         : arg2,
            metadata_uri : arg3,
            listed       : arg4,
        };
        0x2::event::emit<SeriesRegistered>(v3);
        v0
    }

    public fun register_series_by_admin(arg0: &mut MarketRegistry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: bool) : u64 {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg1);
        register_series(arg0, arg3, arg4, arg5, arg6)
    }

    fun remove_id(arg0: &mut vector<0x2::object::ID>, arg1: 0x2::object::ID) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(arg0, v0) == arg1) {
                0x1::vector::remove<0x2::object::ID>(arg0, v0);
                return
            };
            v0 = v0 + 1;
        };
        abort 3213
    }

    public fun series(arg0: &MarketRegistry, arg1: u64) : MarketSeries {
        assert!(series_exists(arg0, arg1), 3208);
        let v0 = SeriesKey{pos0: arg1};
        *0x2::dynamic_field::borrow<SeriesKey, MarketSeries>(&arg0.id, v0)
    }

    public fun series_at(arg0: &MarketRegistry, arg1: u64) : MarketSeries {
        series(arg0, series_id_at(arg0, arg1))
    }

    public fun series_count(arg0: &MarketRegistry) : u64 {
        arg0.series_count
    }

    public fun series_default_market_id(arg0: &MarketRegistry, arg1: u64) : 0x2::object::ID {
        let v0 = series(arg0, arg1);
        v0.default_market_id
    }

    public fun series_exists(arg0: &MarketRegistry, arg1: u64) : bool {
        let v0 = SeriesKey{pos0: arg1};
        0x2::dynamic_field::exists<SeriesKey>(&arg0.id, v0)
    }

    public fun series_id_at(arg0: &MarketRegistry, arg1: u64) : u64 {
        assert!(arg1 < 0x1::vector::length<u64>(&arg0.series_ids), 3207);
        *0x1::vector::borrow<u64>(&arg0.series_ids, arg1)
    }

    public fun series_ids(arg0: &MarketRegistry) : vector<u64> {
        arg0.series_ids
    }

    public fun series_listed(arg0: &MarketRegistry, arg1: u64) : bool {
        let v0 = series(arg0, arg1);
        v0.listed
    }

    public fun series_market_id_at(arg0: &MarketRegistry, arg1: u64, arg2: u64) : 0x2::object::ID {
        let v0 = series(arg0, arg1);
        assert!(arg2 < 0x1::vector::length<0x2::object::ID>(&v0.market_ids), 3207);
        *0x1::vector::borrow<0x2::object::ID>(&v0.market_ids, arg2)
    }

    public fun series_market_ids(arg0: &MarketRegistry, arg1: u64) : vector<0x2::object::ID> {
        let v0 = series(arg0, arg1);
        v0.market_ids
    }

    public fun series_project_id(arg0: &MarketRegistry, arg1: u64) : u64 {
        let v0 = series(arg0, arg1);
        v0.project_id
    }

    fun set_default_market(arg0: &mut MarketRegistry, arg1: u64, arg2: 0x2::object::ID) {
        assert!(series_exists(arg0, arg1), 3208);
        if (arg2 != none_id()) {
            let v0 = market_record(arg0, arg2);
            assert!(v0.series_id == arg1, 3209);
        };
        let v1 = SeriesKey{pos0: arg1};
        let v2 = 0x2::dynamic_field::borrow_mut<SeriesKey, MarketSeries>(&mut arg0.id, v1);
        v2.default_market_id = arg2;
        let v3 = SeriesDefaultMarketUpdated{
            registry_id       : 0x2::object::id<MarketRegistry>(arg0),
            project_id        : v2.project_id,
            series_id         : arg1,
            default_market_id : arg2,
        };
        0x2::event::emit<SeriesDefaultMarketUpdated>(v3);
    }

    public fun set_default_market_by_admin(arg0: &mut MarketRegistry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: u64, arg4: 0x2::object::ID) {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg1);
        set_default_market(arg0, arg3, arg4);
    }

    fun set_market_point_config(arg0: &mut MarketRegistry, arg1: u64, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64) {
        assert!(project_exists(arg0, arg1), 3200);
        assert!(market_registered(arg0, arg2), 3202);
        let v0 = MarketPointConfig{
            project_id        : arg1,
            market_id         : arg2,
            point_config_id   : arg3,
            lp_point_state_id : arg4,
            yt_multiplier_bps : arg5,
            lp_multiplier_bps : arg6,
            point_duration_ms : arg7,
        };
        let v1 = MarketPointConfigKey{pos0: arg2};
        if (0x2::dynamic_field::exists<MarketPointConfigKey>(&arg0.id, v1)) {
            *0x2::dynamic_field::borrow_mut<MarketPointConfigKey, MarketPointConfig>(&mut arg0.id, v1) = v0;
        } else {
            0x2::dynamic_field::add<MarketPointConfigKey, MarketPointConfig>(&mut arg0.id, v1, v0);
        };
        let v2 = MarketPointConfigUpdated{
            registry_id       : 0x2::object::id<MarketRegistry>(arg0),
            project_id        : arg1,
            market_id         : arg2,
            point_config_id   : arg3,
            lp_point_state_id : arg4,
            yt_multiplier_bps : arg5,
            lp_multiplier_bps : arg6,
            point_duration_ms : arg7,
        };
        0x2::event::emit<MarketPointConfigUpdated>(v2);
    }

    public fun set_market_state_listing_by_admin<T0: drop, T1: drop, T2: drop>(arg0: &mut MarketRegistry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: bool, arg5: u64) {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg1);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg3);
        let v1 = 0x2::object::id<MarketRegistry>(arg0);
        let v2 = borrow_market_record_mut(arg0, v0);
        assert_market_state_record<T0, T1, T2>(v2, arg3);
        v2.listed = arg4;
        v2.display_rank = arg5;
        let v3 = MarketListedUpdated{
            registry_id  : v1,
            project_id   : v2.project_id,
            series_id    : v2.series_id,
            market_id    : v0,
            listed       : arg4,
            display_rank : arg5,
        };
        0x2::event::emit<MarketListedUpdated>(v3);
    }

    public fun set_market_state_metadata_by_admin<T0: drop, T1: drop, T2: drop>(arg0: &mut MarketRegistry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::SyState, arg4: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>) {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg1);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg4);
        let v1 = market_record(arg0, v0);
        assert_market_state_record<T0, T1, T2>(&v1, arg4);
        assert_metadata_size(&arg5, 64);
        assert_metadata_size(&arg6, 64);
        assert_metadata_size(&arg7, 64);
        assert_metadata_size(&arg8, 512);
        assert_metadata_size(&arg9, 512);
        assert_metadata_size(&arg10, 512);
        let v2 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::market_underlying_type<T0>(arg3, arg1, v0);
        let v3 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::sy_type_name<T0, T1, T2>(arg4);
        let v4 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::pt_type_name<T0, T1, T2>(arg4);
        let v5 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::yt_type_name<T0, T1, T2>(arg4);
        let v6 = MarketMetadata{
            project_id      : v1.project_id,
            series_id       : v1.series_id,
            market_id       : v0,
            adapter         : arg5,
            name            : arg6,
            symbol          : arg7,
            description     : arg8,
            icon_uri        : arg9,
            metadata_uri    : arg10,
            underlying_type : v2,
            sy_type         : v3,
            pt_type         : v4,
            yt_type         : v5,
        };
        if (market_metadata_exists(arg0, v0)) {
            let v7 = MarketMetadataKey{pos0: v0};
            *0x2::dynamic_field::borrow_mut<MarketMetadataKey, MarketMetadata>(&mut arg0.id, v7) = v6;
        } else {
            let v8 = MarketMetadataKey{pos0: v0};
            0x2::dynamic_field::add<MarketMetadataKey, MarketMetadata>(&mut arg0.id, v8, v6);
        };
        let v9 = MarketMetadataUpdated{
            registry_id     : 0x2::object::id<MarketRegistry>(arg0),
            project_id      : v1.project_id,
            series_id       : v1.series_id,
            market_id       : v0,
            adapter         : arg5,
            name            : arg6,
            symbol          : arg7,
            description     : arg8,
            icon_uri        : arg9,
            metadata_uri    : arg10,
            underlying_type : v2,
            sy_type         : v3,
            pt_type         : v4,
            yt_type         : v5,
        };
        0x2::event::emit<MarketMetadataUpdated>(v9);
    }

    public fun set_market_state_point_config_by_admin<T0: drop, T1: drop, T2: drop>(arg0: &mut MarketRegistry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64) {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg1);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg3);
        let v1 = market_record(arg0, v0);
        assert_market_state_record<T0, T1, T2>(&v1, arg3);
        set_market_point_config(arg0, v1.project_id, v0, arg4, arg5, arg6, arg7, arg8);
    }

    public fun set_market_state_pt_orderbook_id_by_admin<T0: drop, T1: drop, T2: drop>(arg0: &mut MarketRegistry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: 0x2::object::ID) {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg1);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg3);
        let v1 = 0x2::object::id<MarketRegistry>(arg0);
        let v2 = borrow_market_record_mut(arg0, v0);
        assert_market_state_record<T0, T1, T2>(v2, arg3);
        v2.pt_orderbook_id = arg4;
        let v3 = MarketOrderbookUpdated{
            registry_id     : v1,
            market_id       : v0,
            pt_orderbook_id : v2.pt_orderbook_id,
            yt_orderbook_id : v2.yt_orderbook_id,
        };
        0x2::event::emit<MarketOrderbookUpdated>(v3);
    }

    public fun set_market_state_yt_orderbook_id_by_admin<T0: drop, T1: drop, T2: drop>(arg0: &mut MarketRegistry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: 0x2::object::ID) {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg1);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg3);
        let v1 = 0x2::object::id<MarketRegistry>(arg0);
        let v2 = borrow_market_record_mut(arg0, v0);
        assert_market_state_record<T0, T1, T2>(v2, arg3);
        v2.yt_orderbook_id = arg4;
        let v3 = MarketOrderbookUpdated{
            registry_id     : v1,
            market_id       : v0,
            pt_orderbook_id : v2.pt_orderbook_id,
            yt_orderbook_id : v2.yt_orderbook_id,
        };
        0x2::event::emit<MarketOrderbookUpdated>(v3);
    }

    fun set_point_program_enabled(arg0: &mut MarketRegistry, arg1: 0x2::object::ID, arg2: bool) {
        assert!(point_program_exists(arg0, arg1), 3211);
        if (!arg2) {
            assert!(point_program_market_count(arg0, arg1) == 0, 3215);
        };
        let v0 = PointProgramKey{pos0: arg1};
        0x2::dynamic_field::borrow_mut<PointProgramKey, PointProgram>(&mut arg0.id, v0).enabled = arg2;
        let v1 = PointProgramEnabledUpdated{
            registry_id     : 0x2::object::id<MarketRegistry>(arg0),
            point_config_id : arg1,
            enabled         : arg2,
        };
        0x2::event::emit<PointProgramEnabledUpdated>(v1);
    }

    public fun set_point_program_enabled_by_admin(arg0: &mut MarketRegistry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: 0x2::object::ID, arg4: bool) {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg1);
        set_point_program_enabled(arg0, arg3, arg4);
    }

    public fun set_project_metadata_by_admin(arg0: &mut MarketRegistry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>) {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg1);
        assert!(project_exists(arg0, arg3), 3200);
        assert_metadata_size(&arg4, 512);
        assert_metadata_size(&arg5, 512);
        assert_metadata_size(&arg6, 512);
        let v0 = ProjectMetadata{
            project_id  : arg3,
            description : arg4,
            icon_uri    : arg5,
            website_uri : arg6,
        };
        if (project_metadata_exists(arg0, arg3)) {
            let v1 = ProjectMetadataKey{pos0: arg3};
            *0x2::dynamic_field::borrow_mut<ProjectMetadataKey, ProjectMetadata>(&mut arg0.id, v1) = v0;
        } else {
            let v2 = ProjectMetadataKey{pos0: arg3};
            0x2::dynamic_field::add<ProjectMetadataKey, ProjectMetadata>(&mut arg0.id, v2, v0);
        };
        let v3 = ProjectMetadataUpdated{
            registry_id : 0x2::object::id<MarketRegistry>(arg0),
            project_id  : arg3,
            description : arg4,
            icon_uri    : arg5,
            website_uri : arg6,
        };
        0x2::event::emit<ProjectMetadataUpdated>(v3);
    }

    fun set_project_point_config(arg0: &mut MarketRegistry, arg1: u64, arg2: bool, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: 0x2::object::ID, arg8: 0x2::object::ID, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: u64, arg13: u64, arg14: u64) {
        assert!(project_exists(arg0, arg1), 3200);
        let v0 = ProjectPointConfig{
            project_id                  : arg1,
            enabled                     : arg2,
            liquidlink_global_config_id : arg3,
            scoreboard_id               : arg4,
            point_cap_id                : arg5,
            point_config_id             : arg6,
            point_token_market_id       : arg7,
            point_orderbook_id          : arg8,
            point_token_type            : arg9,
            quote_coin_type             : arg10,
            quote_symbol                : arg11,
            yt_multiplier_bps           : arg12,
            lp_multiplier_bps           : arg13,
            point_duration_ms           : arg14,
        };
        let v1 = ProjectPointConfigKey{pos0: arg1};
        if (0x2::dynamic_field::exists<ProjectPointConfigKey>(&arg0.id, v1)) {
            *0x2::dynamic_field::borrow_mut<ProjectPointConfigKey, ProjectPointConfig>(&mut arg0.id, v1) = v0;
        } else {
            0x2::dynamic_field::add<ProjectPointConfigKey, ProjectPointConfig>(&mut arg0.id, v1, v0);
        };
        let v2 = ProjectPointConfigUpdated{
            registry_id                 : 0x2::object::id<MarketRegistry>(arg0),
            project_id                  : arg1,
            enabled                     : arg2,
            liquidlink_global_config_id : arg3,
            scoreboard_id               : arg4,
            point_cap_id                : arg5,
            point_config_id             : arg6,
            point_token_market_id       : arg7,
            point_orderbook_id          : arg8,
            point_token_type            : arg9,
            quote_coin_type             : arg10,
            quote_symbol                : arg11,
            yt_multiplier_bps           : arg12,
            lp_multiplier_bps           : arg13,
            point_duration_ms           : arg14,
        };
        0x2::event::emit<ProjectPointConfigUpdated>(v2);
    }

    public fun set_project_point_config_by_admin(arg0: &mut MarketRegistry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: u64, arg4: bool, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: 0x2::object::ID, arg8: 0x2::object::ID, arg9: 0x2::object::ID, arg10: 0x2::object::ID, arg11: vector<u8>, arg12: vector<u8>, arg13: vector<u8>, arg14: u64, arg15: u64, arg16: u64) {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg1);
        set_project_point_config(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
    }

    fun set_series_listed(arg0: &mut MarketRegistry, arg1: u64, arg2: bool) {
        assert!(series_exists(arg0, arg1), 3208);
        let v0 = SeriesKey{pos0: arg1};
        let v1 = 0x2::dynamic_field::borrow_mut<SeriesKey, MarketSeries>(&mut arg0.id, v0);
        v1.listed = arg2;
        let v2 = SeriesListedUpdated{
            registry_id : 0x2::object::id<MarketRegistry>(arg0),
            project_id  : v1.project_id,
            series_id   : arg1,
            listed      : arg2,
        };
        0x2::event::emit<SeriesListedUpdated>(v2);
    }

    public fun set_series_listed_by_admin(arg0: &mut MarketRegistry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: u64, arg4: bool) {
        0x3230ccc6e4274c504393acaff98f38cd18b0141356cc5080b6e1994e1e40a677::package_version::assert_current(arg1);
        set_series_listed(arg0, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

