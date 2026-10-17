module 0xa6244236d5d19ba42f479a1444e6c24ec0ede1d2fe8f9aed562abf331b9491f2::market_registry {
    struct Registry has store, key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        sy_state_id: 0x2::object::ID,
        schema_version: u64,
        next_protocol_id: u64,
        next_series_id: u64,
        protocols: 0x2::table::Table<u64, Protocol>,
        series: 0x2::table::Table<u64, Series>,
        markets: 0x2::table::Table<0x2::object::ID, MarketRecord>,
        programs: 0x2::table::Table<0x2::object::ID, PointProgram>,
        sources: 0x2::table::Table<0x2::object::ID, PointSource>,
        market_sources: 0x2::table::Table<MarketSourceKey, MarketPointSource>,
        extensions: 0x2::bag::Bag,
    }

    struct ProtocolMetadata has copy, drop, store {
        name: vector<u8>,
        slug: vector<u8>,
        description: vector<u8>,
        icon_uri: vector<u8>,
        website_uri: vector<u8>,
        docs_uri: vector<u8>,
        metadata_uri: vector<u8>,
    }

    struct SeriesMetadata has copy, drop, store {
        name: vector<u8>,
        symbol: vector<u8>,
        description: vector<u8>,
        icon_uri: vector<u8>,
        category: vector<u8>,
        metadata_uri: vector<u8>,
    }

    struct MarketMetadata has copy, drop, store {
        name: vector<u8>,
        description: vector<u8>,
        icon_uri: vector<u8>,
        metadata_uri: vector<u8>,
    }

    struct ProgramMetadata has copy, drop, store {
        name: vector<u8>,
        season: vector<u8>,
        description: vector<u8>,
        icon_uri: vector<u8>,
        metadata_uri: vector<u8>,
    }

    struct Protocol has store {
        protocol_id: u64,
        metadata: ProtocolMetadata,
        listed: bool,
        display_rank: u64,
        revision: u64,
        series_ids: 0x2::table::Table<u64, bool>,
    }

    struct Series has store {
        series_id: u64,
        protocol_id: u64,
        underlying_type: 0x1::type_name::TypeName,
        receipt_type: 0x1::type_name::TypeName,
        metadata: SeriesMetadata,
        default_market_id: 0x1::option::Option<0x2::object::ID>,
        listed: bool,
        display_rank: u64,
        revision: u64,
        market_ids: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct MarketRecord has store {
        market_id: 0x2::object::ID,
        series_id: u64,
        expiry_ms: u64,
        sy_type: 0x1::type_name::TypeName,
        pt_type: 0x1::type_name::TypeName,
        yt_type: 0x1::type_name::TypeName,
        metadata: MarketMetadata,
        listed: bool,
        display_rank: u64,
        revision: u64,
        source_ids: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct PointProgram has store {
        scoreboard_id: 0x2::object::ID,
        project_object_id: 0x2::object::ID,
        liquidlink_config_id: 0x2::object::ID,
        protocol_id: 0x1::option::Option<u64>,
        metadata: ProgramMetadata,
        listed: bool,
        revision: u64,
        source_ids: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct PointSource has store {
        source_id: 0x2::object::ID,
        scoreboard_id: 0x2::object::ID,
        policy_type: 0x1::type_name::TypeName,
        source_type: 0x1::type_name::TypeName,
        label: vector<u8>,
        archived: bool,
        revision: u64,
        market_ids: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct MarketSourceKey has copy, drop, store {
        market_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
    }

    struct MarketPointSource has copy, drop, store {
        market_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
        lp_point_state_id: 0x1::option::Option<0x2::object::ID>,
        yt_enabled: bool,
        lp_enabled: bool,
        archived: bool,
        revision: u64,
    }

    struct ScallopBinding has copy, drop, store {
        scallop_market_id: 0x2::object::ID,
        version_id: 0x2::object::ID,
    }

    struct HaedalBinding has copy, drop, store {
        staking_id: 0x2::object::ID,
    }

    struct EmberBinding has copy, drop, store {
        ember_vault_id: 0x2::object::ID,
    }

    struct AdapterKey<phantom T0: copy + drop + store> has copy, drop, store {
        market_id: 0x2::object::ID,
    }

    struct AdapterBinding<T0: copy + drop + store> has copy, drop, store {
        market_id: 0x2::object::ID,
        adapter_type: 0x1::type_name::TypeName,
        vault_id: 0x2::object::ID,
        revision: u64,
        payload: T0,
    }

    struct OrderbookKey has copy, drop, store {
        market_id: 0x2::object::ID,
    }

    struct OrderbookLinks has copy, drop, store {
        pt_orderbook_id: 0x1::option::Option<0x2::object::ID>,
        yt_orderbook_id: 0x1::option::Option<0x2::object::ID>,
        revision: u64,
    }

    struct PointTradingKey has copy, drop, store {
        scoreboard_id: 0x2::object::ID,
    }

    struct PointTradingLink has copy, drop, store {
        scoreboard_id: 0x2::object::ID,
        point_token_market_id: 0x2::object::ID,
        orderbook_id: 0x1::option::Option<0x2::object::ID>,
        revision: u64,
    }

    struct RegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        creator: address,
        config_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        sy_state_id: 0x2::object::ID,
        schema_version: u64,
    }

    struct ProtocolRegistered has copy, drop {
        registry_id: 0x2::object::ID,
        protocol_id: u64,
        metadata: ProtocolMetadata,
        listed: bool,
        display_rank: u64,
        revision: u64,
    }

    struct ProtocolUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        protocol_id: u64,
        metadata: ProtocolMetadata,
        listed: bool,
        display_rank: u64,
        revision: u64,
    }

    struct SeriesRegistered has copy, drop {
        registry_id: 0x2::object::ID,
        series_id: u64,
        protocol_id: u64,
        underlying_type: 0x1::type_name::TypeName,
        receipt_type: 0x1::type_name::TypeName,
        metadata: SeriesMetadata,
        default_market_id: 0x1::option::Option<0x2::object::ID>,
        listed: bool,
        display_rank: u64,
        revision: u64,
    }

    struct SeriesUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        series_id: u64,
        protocol_id: u64,
        underlying_type: 0x1::type_name::TypeName,
        receipt_type: 0x1::type_name::TypeName,
        metadata: SeriesMetadata,
        default_market_id: 0x1::option::Option<0x2::object::ID>,
        listed: bool,
        display_rank: u64,
        revision: u64,
    }

    struct MarketRegistered has copy, drop {
        registry_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        series_id: u64,
        expiry_ms: u64,
        sy_type: 0x1::type_name::TypeName,
        pt_type: 0x1::type_name::TypeName,
        yt_type: 0x1::type_name::TypeName,
        metadata: MarketMetadata,
        listed: bool,
        display_rank: u64,
        revision: u64,
    }

    struct MarketUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        series_id: u64,
        expiry_ms: u64,
        sy_type: 0x1::type_name::TypeName,
        pt_type: 0x1::type_name::TypeName,
        yt_type: 0x1::type_name::TypeName,
        metadata: MarketMetadata,
        listed: bool,
        display_rank: u64,
        revision: u64,
    }

    struct ProgramRegistered has copy, drop {
        registry_id: 0x2::object::ID,
        scoreboard_id: 0x2::object::ID,
        project_object_id: 0x2::object::ID,
        liquidlink_config_id: 0x2::object::ID,
        protocol_id: 0x1::option::Option<u64>,
        metadata: ProgramMetadata,
        listed: bool,
        revision: u64,
    }

    struct ProgramUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        scoreboard_id: 0x2::object::ID,
        project_object_id: 0x2::object::ID,
        liquidlink_config_id: 0x2::object::ID,
        protocol_id: 0x1::option::Option<u64>,
        metadata: ProgramMetadata,
        listed: bool,
        revision: u64,
    }

    struct SourceRegistered has copy, drop {
        registry_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
        scoreboard_id: 0x2::object::ID,
        policy_type: 0x1::type_name::TypeName,
        source_type: 0x1::type_name::TypeName,
        label: vector<u8>,
        archived: bool,
        revision: u64,
    }

    struct SourceArchived has copy, drop {
        registry_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
        archived: bool,
        revision: u64,
    }

    struct MarketSourceAttached has copy, drop {
        registry_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
        lp_point_state_id: 0x1::option::Option<0x2::object::ID>,
        yt_enabled: bool,
        lp_enabled: bool,
        archived: bool,
        revision: u64,
    }

    struct MarketSourceArchived has copy, drop {
        registry_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
        archived: bool,
        revision: u64,
    }

    struct MarketSourceUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
        lp_point_state_id: 0x1::option::Option<0x2::object::ID>,
        yt_enabled: bool,
        lp_enabled: bool,
        archived: bool,
        revision: u64,
    }

    struct AdapterBindingUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        adapter_type: 0x1::type_name::TypeName,
        payload_type: 0x1::type_name::TypeName,
        vault_id: 0x2::object::ID,
        revision: u64,
        payload_bcs: vector<u8>,
    }

    struct OrderbooksUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        pt_orderbook_id: 0x1::option::Option<0x2::object::ID>,
        yt_orderbook_id: 0x1::option::Option<0x2::object::ID>,
        revision: u64,
    }

    struct PointTradingUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        scoreboard_id: 0x2::object::ID,
        point_token_market_id: 0x2::object::ID,
        orderbook_id: 0x1::option::Option<0x2::object::ID>,
        revision: u64,
    }

    public fun id(arg0: &Registry) : 0x2::object::ID {
        0x2::object::id<Registry>(arg0)
    }

    fun advance(arg0: u64, arg1: u64) : u64 {
        assert!(0xa6244236d5d19ba42f479a1444e6c24ec0ede1d2fe8f9aed562abf331b9491f2::registry_rules::revision_matches(arg0, arg1), 3207);
        0xa6244236d5d19ba42f479a1444e6c24ec0ede1d2fe8f9aed562abf331b9491f2::registry_rules::next_revision(arg0)
    }

    public fun archive_market_source(arg0: &mut Registry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: bool) {
        authorize(arg0, arg1, arg2);
        let v0 = MarketSourceKey{
            market_id : arg3,
            source_id : arg4,
        };
        let v1 = 0x2::table::borrow_mut<MarketSourceKey, MarketPointSource>(&mut arg0.market_sources, v0);
        v1.revision = advance(v1.revision, arg5);
        v1.archived = arg6;
        let v2 = MarketSourceArchived{
            registry_id : 0x2::object::id<Registry>(arg0),
            market_id   : arg3,
            source_id   : arg4,
            archived    : arg6,
            revision    : v1.revision,
        };
        0x2::event::emit<MarketSourceArchived>(v2);
    }

    public fun archive_source(arg0: &mut Registry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: 0x2::object::ID, arg4: u64, arg5: bool) {
        authorize(arg0, arg1, arg2);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, PointSource>(&mut arg0.sources, arg3);
        v0.revision = advance(v0.revision, arg4);
        v0.archived = arg5;
        let v1 = SourceArchived{
            registry_id : 0x2::object::id<Registry>(arg0),
            source_id   : arg3,
            archived    : arg5,
            revision    : v0.revision,
        };
        0x2::event::emit<SourceArchived>(v1);
    }

    fun assert_sy_state(arg0: &Registry, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::SyState) {
        assert!(arg0.sy_state_id == 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::SyState>(arg1), 3202);
    }

    public fun attach_source(arg0: &mut Registry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x1::option::Option<0x2::object::ID>, arg6: bool, arg7: bool) {
        authorize(arg0, arg1, arg2);
        assert!(0x2::table::contains<0x2::object::ID, MarketRecord>(&arg0.markets, arg3) && 0x2::table::contains<0x2::object::ID, PointSource>(&arg0.sources, arg4), 3203);
        assert!(0xa6244236d5d19ba42f479a1444e6c24ec0ede1d2fe8f9aed562abf331b9491f2::registry_rules::valid_scopes(arg6, arg7, 0x1::option::is_some<0x2::object::ID>(&arg5)), 3208);
        assert!(!0x2::table::borrow<0x2::object::ID, PointSource>(&arg0.sources, arg4).archived, 3211);
        let v0 = MarketSourceKey{
            market_id : arg3,
            source_id : arg4,
        };
        assert!(!0x2::table::contains<MarketSourceKey, MarketPointSource>(&arg0.market_sources, v0), 3204);
        let v1 = MarketPointSource{
            market_id         : arg3,
            source_id         : arg4,
            lp_point_state_id : arg5,
            yt_enabled        : arg6,
            lp_enabled        : arg7,
            archived          : false,
            revision          : 1,
        };
        0x2::table::add<MarketSourceKey, MarketPointSource>(&mut arg0.market_sources, v0, v1);
        0x2::table::add<0x2::object::ID, bool>(&mut 0x2::table::borrow_mut<0x2::object::ID, MarketRecord>(&mut arg0.markets, arg3).source_ids, arg4, true);
        0x2::table::add<0x2::object::ID, bool>(&mut 0x2::table::borrow_mut<0x2::object::ID, PointSource>(&mut arg0.sources, arg4).market_ids, arg3, true);
        let v2 = MarketSourceAttached{
            registry_id       : 0x2::object::id<Registry>(arg0),
            market_id         : arg3,
            source_id         : arg4,
            lp_point_state_id : arg5,
            yt_enabled        : arg6,
            lp_enabled        : arg7,
            archived          : false,
            revision          : 1,
        };
        0x2::event::emit<MarketSourceAttached>(v2);
    }

    fun authorize(arg0: &Registry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap) {
        0xa6244236d5d19ba42f479a1444e6c24ec0ede1d2fe8f9aed562abf331b9491f2::package_version::assert_current(arg1);
        assert!(arg0.config_id == 0x2::object::id<0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig>(arg1), 3200);
        assert!(arg0.admin_cap_id == 0x2::object::id<0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap>(arg2), 3201);
    }

    fun bounded<T0>(arg0: &T0) {
        let v0 = 0x2::bcs::to_bytes<T0>(arg0);
        assert!(0xa6244236d5d19ba42f479a1444e6c24ec0ede1d2fe8f9aed562abf331b9491f2::registry_rules::within_size(0x1::vector::length<u8>(&v0), 16384), 3209);
    }

    public fun counts(arg0: &Registry) : (u64, u64, u64, u64, u64, u64) {
        (0x2::table::length<u64, Protocol>(&arg0.protocols), 0x2::table::length<u64, Series>(&arg0.series), 0x2::table::length<0x2::object::ID, MarketRecord>(&arg0.markets), 0x2::table::length<0x2::object::ID, PointProgram>(&arg0.programs), 0x2::table::length<0x2::object::ID, PointSource>(&arg0.sources), 0x2::table::length<MarketSourceKey, MarketPointSource>(&arg0.market_sources))
    }

    public fun create(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::SyState, arg3: &mut 0x2::tx_context::TxContext) : Registry {
        0xa6244236d5d19ba42f479a1444e6c24ec0ede1d2fe8f9aed562abf331b9491f2::package_version::assert_current(arg0);
        let v0 = Registry{
            id               : 0x2::object::new(arg3),
            config_id        : 0x2::object::id<0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig>(arg0),
            admin_cap_id     : 0x2::object::id<0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap>(arg1),
            sy_state_id      : 0x2::object::id<0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::SyState>(arg2),
            schema_version   : 1,
            next_protocol_id : 1,
            next_series_id   : 1,
            protocols        : 0x2::table::new<u64, Protocol>(arg3),
            series           : 0x2::table::new<u64, Series>(arg3),
            markets          : 0x2::table::new<0x2::object::ID, MarketRecord>(arg3),
            programs         : 0x2::table::new<0x2::object::ID, PointProgram>(arg3),
            sources          : 0x2::table::new<0x2::object::ID, PointSource>(arg3),
            market_sources   : 0x2::table::new<MarketSourceKey, MarketPointSource>(arg3),
            extensions       : 0x2::bag::new(arg3),
        };
        let v1 = RegistryCreated{
            registry_id    : 0x2::object::id<Registry>(&v0),
            creator        : 0x2::tx_context::sender(arg3),
            config_id      : v0.config_id,
            admin_cap_id   : v0.admin_cap_id,
            sy_state_id    : v0.sy_state_id,
            schema_version : 1,
        };
        0x2::event::emit<RegistryCreated>(v1);
        v0
    }

    public fun create_shared(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::SyState, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = create(arg0, arg1, arg2, arg3);
        0x2::transfer::share_object<Registry>(v0);
        0x2::object::id<Registry>(&v0)
    }

    fun description_text(arg0: &vector<u8>) {
        text(arg0, 512);
    }

    public fun ember_binding(arg0: 0x2::object::ID) : EmberBinding {
        EmberBinding{ember_vault_id: arg0}
    }

    fun emit_market(arg0: &Registry, arg1: 0x2::object::ID) {
        let v0 = 0x2::table::borrow<0x2::object::ID, MarketRecord>(&arg0.markets, arg1);
        let v1 = MarketUpdated{
            registry_id  : 0x2::object::id<Registry>(arg0),
            market_id    : arg1,
            series_id    : v0.series_id,
            expiry_ms    : v0.expiry_ms,
            sy_type      : v0.sy_type,
            pt_type      : v0.pt_type,
            yt_type      : v0.yt_type,
            metadata     : v0.metadata,
            listed       : v0.listed,
            display_rank : v0.display_rank,
            revision     : v0.revision,
        };
        0x2::event::emit<MarketUpdated>(v1);
    }

    fun emit_program(arg0: &Registry, arg1: 0x2::object::ID) {
        let v0 = 0x2::table::borrow<0x2::object::ID, PointProgram>(&arg0.programs, arg1);
        let v1 = ProgramUpdated{
            registry_id          : 0x2::object::id<Registry>(arg0),
            scoreboard_id        : arg1,
            project_object_id    : v0.project_object_id,
            liquidlink_config_id : v0.liquidlink_config_id,
            protocol_id          : v0.protocol_id,
            metadata             : v0.metadata,
            listed               : v0.listed,
            revision             : v0.revision,
        };
        0x2::event::emit<ProgramUpdated>(v1);
    }

    fun emit_protocol(arg0: &Registry, arg1: u64) {
        let v0 = 0x2::table::borrow<u64, Protocol>(&arg0.protocols, arg1);
        let v1 = ProtocolUpdated{
            registry_id  : 0x2::object::id<Registry>(arg0),
            protocol_id  : arg1,
            metadata     : v0.metadata,
            listed       : v0.listed,
            display_rank : v0.display_rank,
            revision     : v0.revision,
        };
        0x2::event::emit<ProtocolUpdated>(v1);
    }

    fun emit_series(arg0: &Registry, arg1: u64) {
        let v0 = 0x2::table::borrow<u64, Series>(&arg0.series, arg1);
        let v1 = SeriesUpdated{
            registry_id       : 0x2::object::id<Registry>(arg0),
            series_id         : arg1,
            protocol_id       : v0.protocol_id,
            underlying_type   : v0.underlying_type,
            receipt_type      : v0.receipt_type,
            metadata          : v0.metadata,
            default_market_id : v0.default_market_id,
            listed            : v0.listed,
            display_rank      : v0.display_rank,
            revision          : v0.revision,
        };
        0x2::event::emit<SeriesUpdated>(v1);
    }

    public fun haedal_binding(arg0: 0x2::object::ID) : HaedalBinding {
        HaedalBinding{staking_id: arg0}
    }

    public fun market(arg0: &Registry, arg1: 0x2::object::ID) : &MarketRecord {
        0x2::table::borrow<0x2::object::ID, MarketRecord>(&arg0.markets, arg1)
    }

    public fun market_metadata(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) : MarketMetadata {
        validate_label(&arg0, false);
        description_text(&arg1);
        uri(&arg2);
        uri(&arg3);
        MarketMetadata{
            name         : arg0,
            description  : arg1,
            icon_uri     : arg2,
            metadata_uri : arg3,
        }
    }

    public fun market_source(arg0: &Registry, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : MarketPointSource {
        let v0 = MarketSourceKey{
            market_id : arg1,
            source_id : arg2,
        };
        *0x2::table::borrow<MarketSourceKey, MarketPointSource>(&arg0.market_sources, v0)
    }

    public fun program(arg0: &Registry, arg1: 0x2::object::ID) : &PointProgram {
        0x2::table::borrow<0x2::object::ID, PointProgram>(&arg0.programs, arg1)
    }

    public fun program_metadata(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) : ProgramMetadata {
        validate_label(&arg0, true);
        validate_label(&arg1, false);
        description_text(&arg2);
        uri(&arg3);
        uri(&arg4);
        ProgramMetadata{
            name         : arg0,
            season       : arg1,
            description  : arg2,
            icon_uri     : arg3,
            metadata_uri : arg4,
        }
    }

    public fun protocol(arg0: &Registry, arg1: u64) : &Protocol {
        0x2::table::borrow<u64, Protocol>(&arg0.protocols, arg1)
    }

    public fun protocol_metadata(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>) : ProtocolMetadata {
        validate_label(&arg0, true);
        validate_label(&arg1, true);
        description_text(&arg2);
        uri(&arg3);
        uri(&arg4);
        uri(&arg5);
        uri(&arg6);
        ProtocolMetadata{
            name         : arg0,
            slug         : arg1,
            description  : arg2,
            icon_uri     : arg3,
            website_uri  : arg4,
            docs_uri     : arg5,
            metadata_uri : arg6,
        }
    }

    public fun register_market<T0: drop, T1: drop, T2: drop>(arg0: &mut Registry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::SyState, arg4: u64, arg5: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg6: MarketMetadata, arg7: &mut 0x2::tx_context::TxContext) {
        authorize(arg0, arg1, arg2);
        assert_sy_state(arg0, arg3);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg5);
        assert!(!0x2::table::contains<0x2::object::ID, MarketRecord>(&arg0.markets, v0), 3204);
        assert!(0x2::table::contains<u64, Series>(&arg0.series, arg4), 3203);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::market_underlying_type<T0>(arg3, arg1, v0) == 0x2::table::borrow<u64, Series>(&arg0.series, arg4).underlying_type, 3206);
        let v1 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::expiry<T0, T1, T2>(arg5);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        let v3 = 0x1::type_name::with_defining_ids<T1>();
        let v4 = 0x1::type_name::with_defining_ids<T2>();
        let v5 = MarketRecord{
            market_id    : v0,
            series_id    : arg4,
            expiry_ms    : v1,
            sy_type      : v2,
            pt_type      : v3,
            yt_type      : v4,
            metadata     : arg6,
            listed       : true,
            display_rank : 0,
            revision     : 1,
            source_ids   : 0x2::table::new<0x2::object::ID, bool>(arg7),
        };
        0x2::table::add<0x2::object::ID, MarketRecord>(&mut arg0.markets, v0, v5);
        bounded<MarketRecord>(0x2::table::borrow<0x2::object::ID, MarketRecord>(&arg0.markets, v0));
        0x2::table::add<0x2::object::ID, bool>(&mut 0x2::table::borrow_mut<u64, Series>(&mut arg0.series, arg4).market_ids, v0, true);
        let v6 = MarketRegistered{
            registry_id  : 0x2::object::id<Registry>(arg0),
            market_id    : v0,
            series_id    : arg4,
            expiry_ms    : v1,
            sy_type      : v2,
            pt_type      : v3,
            yt_type      : v4,
            metadata     : arg6,
            listed       : true,
            display_rank : 0,
            revision     : 1,
        };
        0x2::event::emit<MarketRegistered>(v6);
    }

    public fun register_program(arg0: &mut Registry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: 0x1::option::Option<u64>, arg7: ProgramMetadata, arg8: &mut 0x2::tx_context::TxContext) {
        authorize(arg0, arg1, arg2);
        assert!(!0x2::table::contains<0x2::object::ID, PointProgram>(&arg0.programs, arg3), 3204);
        if (0x1::option::is_some<u64>(&arg6)) {
            assert!(0x2::table::contains<u64, Protocol>(&arg0.protocols, *0x1::option::borrow<u64>(&arg6)), 3203);
        };
        let v0 = PointProgram{
            scoreboard_id        : arg3,
            project_object_id    : arg4,
            liquidlink_config_id : arg5,
            protocol_id          : arg6,
            metadata             : arg7,
            listed               : true,
            revision             : 1,
            source_ids           : 0x2::table::new<0x2::object::ID, bool>(arg8),
        };
        0x2::table::add<0x2::object::ID, PointProgram>(&mut arg0.programs, arg3, v0);
        let v1 = ProgramRegistered{
            registry_id          : 0x2::object::id<Registry>(arg0),
            scoreboard_id        : arg3,
            project_object_id    : arg4,
            liquidlink_config_id : arg5,
            protocol_id          : arg6,
            metadata             : arg7,
            listed               : true,
            revision             : 1,
        };
        0x2::event::emit<ProgramRegistered>(v1);
    }

    public fun register_protocol(arg0: &mut Registry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: ProtocolMetadata, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        authorize(arg0, arg1, arg2);
        let v0 = arg0.next_protocol_id;
        arg0.next_protocol_id = 0xa6244236d5d19ba42f479a1444e6c24ec0ede1d2fe8f9aed562abf331b9491f2::registry_rules::next_revision(v0);
        let v1 = Protocol{
            protocol_id  : v0,
            metadata     : arg3,
            listed       : true,
            display_rank : 0,
            revision     : 1,
            series_ids   : 0x2::table::new<u64, bool>(arg4),
        };
        0x2::table::add<u64, Protocol>(&mut arg0.protocols, v0, v1);
        let v2 = ProtocolRegistered{
            registry_id  : 0x2::object::id<Registry>(arg0),
            protocol_id  : v0,
            metadata     : arg3,
            listed       : true,
            display_rank : 0,
            revision     : 1,
        };
        0x2::event::emit<ProtocolRegistered>(v2);
        v0
    }

    public fun register_series<T0, T1>(arg0: &mut Registry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: u64, arg4: SeriesMetadata, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        authorize(arg0, arg1, arg2);
        assert!(0x2::table::contains<u64, Protocol>(&arg0.protocols, arg3), 3203);
        let v0 = arg0.next_series_id;
        arg0.next_series_id = 0xa6244236d5d19ba42f479a1444e6c24ec0ede1d2fe8f9aed562abf331b9491f2::registry_rules::next_revision(v0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = 0x1::type_name::with_defining_ids<T1>();
        let v3 = Series{
            series_id         : v0,
            protocol_id       : arg3,
            underlying_type   : v1,
            receipt_type      : v2,
            metadata          : arg4,
            default_market_id : 0x1::option::none<0x2::object::ID>(),
            listed            : true,
            display_rank      : 0,
            revision          : 1,
            market_ids        : 0x2::table::new<0x2::object::ID, bool>(arg5),
        };
        0x2::table::add<u64, Series>(&mut arg0.series, v0, v3);
        bounded<Series>(0x2::table::borrow<u64, Series>(&arg0.series, v0));
        0x2::table::add<u64, bool>(&mut 0x2::table::borrow_mut<u64, Protocol>(&mut arg0.protocols, arg3).series_ids, v0, true);
        let v4 = SeriesRegistered{
            registry_id       : 0x2::object::id<Registry>(arg0),
            series_id         : v0,
            protocol_id       : arg3,
            underlying_type   : v1,
            receipt_type      : v2,
            metadata          : arg4,
            default_market_id : 0x1::option::none<0x2::object::ID>(),
            listed            : true,
            display_rank      : 0,
            revision          : 1,
        };
        0x2::event::emit<SeriesRegistered>(v4);
        v0
    }

    public fun register_source<T0: key, T1: drop>(arg0: &mut Registry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: 0x2::object::ID, arg4: &T0, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        authorize(arg0, arg1, arg2);
        validate_label(&arg5, true);
        assert!(0x2::table::contains<0x2::object::ID, PointProgram>(&arg0.programs, arg3), 3203);
        let v0 = 0x2::object::id<T0>(arg4);
        assert!(!0x2::table::contains<0x2::object::ID, PointSource>(&arg0.sources, v0), 3204);
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        let v3 = PointSource{
            source_id     : v0,
            scoreboard_id : arg3,
            policy_type   : v1,
            source_type   : v2,
            label         : arg5,
            archived      : false,
            revision      : 1,
            market_ids    : 0x2::table::new<0x2::object::ID, bool>(arg6),
        };
        0x2::table::add<0x2::object::ID, PointSource>(&mut arg0.sources, v0, v3);
        bounded<PointSource>(0x2::table::borrow<0x2::object::ID, PointSource>(&arg0.sources, v0));
        0x2::table::add<0x2::object::ID, bool>(&mut 0x2::table::borrow_mut<0x2::object::ID, PointProgram>(&mut arg0.programs, arg3).source_ids, v0, true);
        let v4 = SourceRegistered{
            registry_id   : 0x2::object::id<Registry>(arg0),
            source_id     : v0,
            scoreboard_id : arg3,
            policy_type   : v1,
            source_type   : v2,
            label         : arg5,
            archived      : false,
            revision      : 1,
        };
        0x2::event::emit<SourceRegistered>(v4);
    }

    public fun scallop_binding(arg0: 0x2::object::ID, arg1: 0x2::object::ID) : ScallopBinding {
        ScallopBinding{
            scallop_market_id : arg0,
            version_id        : arg1,
        }
    }

    public fun series(arg0: &Registry, arg1: u64) : &Series {
        0x2::table::borrow<u64, Series>(&arg0.series, arg1)
    }

    public fun series_metadata(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>) : SeriesMetadata {
        validate_label(&arg0, true);
        validate_label(&arg1, true);
        description_text(&arg2);
        uri(&arg3);
        validate_label(&arg4, false);
        uri(&arg5);
        SeriesMetadata{
            name         : arg0,
            symbol       : arg1,
            description  : arg2,
            icon_uri     : arg3,
            category     : arg4,
            metadata_uri : arg5,
        }
    }

    public fun set_adapter_binding<T0: drop, T1: drop, T2: drop, T3: drop, T4: copy + drop + store>(arg0: &mut Registry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::SyState, arg4: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg5: u64, arg6: 0x2::object::ID, arg7: T4) {
        authorize(arg0, arg1, arg2);
        assert_sy_state(arg0, arg3);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg4);
        assert!(0x2::table::contains<0x2::object::ID, MarketRecord>(&arg0.markets, v0), 3203);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::market_underlying_type<T0>(arg3, arg1, v0) == 0x2::table::borrow<u64, Series>(&arg0.series, 0x2::table::borrow<0x2::object::ID, MarketRecord>(&arg0.markets, v0).series_id).underlying_type, 3206);
        let v1 = 0x2::bcs::to_bytes<T4>(&arg7);
        assert!(0xa6244236d5d19ba42f479a1444e6c24ec0ede1d2fe8f9aed562abf331b9491f2::registry_rules::within_size(0x1::vector::length<u8>(&v1), 16384), 3209);
        let v2 = AdapterKey<T4>{market_id: v0};
        let v3 = if (0x2::bag::contains<AdapterKey<T4>>(&arg0.extensions, v2)) {
            let v4 = 0x2::bag::remove<AdapterKey<T4>, AdapterBinding<T4>>(&mut arg0.extensions, v2);
            advance(v4.revision, arg5)
        } else {
            assert!(arg5 == 0, 3207);
            1
        };
        let v5 = 0x1::type_name::with_defining_ids<T3>();
        let v6 = AdapterBinding<T4>{
            market_id    : v0,
            adapter_type : v5,
            vault_id     : arg6,
            revision     : v3,
            payload      : arg7,
        };
        0x2::bag::add<AdapterKey<T4>, AdapterBinding<T4>>(&mut arg0.extensions, v2, v6);
        bounded<AdapterBinding<T4>>(0x2::bag::borrow<AdapterKey<T4>, AdapterBinding<T4>>(&arg0.extensions, v2));
        let v7 = AdapterBindingUpdated{
            registry_id  : 0x2::object::id<Registry>(arg0),
            market_id    : v0,
            adapter_type : v5,
            payload_type : 0x1::type_name::with_defining_ids<T4>(),
            vault_id     : arg6,
            revision     : v3,
            payload_bcs  : v1,
        };
        0x2::event::emit<AdapterBindingUpdated>(v7);
    }

    public fun set_default_market(arg0: &mut Registry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: u64, arg4: u64, arg5: 0x1::option::Option<0x2::object::ID>) {
        authorize(arg0, arg1, arg2);
        if (0x1::option::is_some<0x2::object::ID>(&arg5)) {
            let v0 = *0x1::option::borrow<0x2::object::ID>(&arg5);
            assert!(0x2::table::contains<0x2::object::ID, MarketRecord>(&arg0.markets, v0), 3203);
            assert!(0xa6244236d5d19ba42f479a1444e6c24ec0ede1d2fe8f9aed562abf331b9491f2::registry_rules::same_parent(0x2::table::borrow<0x2::object::ID, MarketRecord>(&arg0.markets, v0).series_id, arg3), 3205);
        };
        let v1 = 0x2::table::borrow_mut<u64, Series>(&mut arg0.series, arg3);
        v1.revision = advance(v1.revision, arg4);
        v1.default_market_id = arg5;
        bounded<Series>(v1);
        emit_series(arg0, arg3);
    }

    public fun set_market_listing(arg0: &mut Registry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: 0x2::object::ID, arg4: u64, arg5: bool, arg6: u64) {
        authorize(arg0, arg1, arg2);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, MarketRecord>(&mut arg0.markets, arg3);
        v0.revision = advance(v0.revision, arg4);
        v0.listed = arg5;
        v0.display_rank = arg6;
        emit_market(arg0, arg3);
    }

    public fun set_orderbooks(arg0: &mut Registry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: 0x2::object::ID, arg4: u64, arg5: 0x1::option::Option<0x2::object::ID>, arg6: 0x1::option::Option<0x2::object::ID>) {
        authorize(arg0, arg1, arg2);
        assert!(0x2::table::contains<0x2::object::ID, MarketRecord>(&arg0.markets, arg3), 3203);
        let v0 = OrderbookKey{market_id: arg3};
        let v1 = if (0x2::bag::contains<OrderbookKey>(&arg0.extensions, v0)) {
            let v2 = 0x2::bag::remove<OrderbookKey, OrderbookLinks>(&mut arg0.extensions, v0);
            advance(v2.revision, arg4)
        } else {
            assert!(arg4 == 0, 3207);
            1
        };
        let v3 = OrderbookLinks{
            pt_orderbook_id : arg5,
            yt_orderbook_id : arg6,
            revision        : v1,
        };
        0x2::bag::add<OrderbookKey, OrderbookLinks>(&mut arg0.extensions, v0, v3);
        let v4 = OrderbooksUpdated{
            registry_id     : 0x2::object::id<Registry>(arg0),
            market_id       : arg3,
            pt_orderbook_id : arg5,
            yt_orderbook_id : arg6,
            revision        : v1,
        };
        0x2::event::emit<OrderbooksUpdated>(v4);
    }

    public fun set_point_trading(arg0: &mut Registry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: 0x2::object::ID, arg4: u64, arg5: 0x2::object::ID, arg6: 0x1::option::Option<0x2::object::ID>) {
        authorize(arg0, arg1, arg2);
        assert!(0x2::table::contains<0x2::object::ID, PointProgram>(&arg0.programs, arg3), 3203);
        let v0 = PointTradingKey{scoreboard_id: arg3};
        let v1 = if (0x2::bag::contains<PointTradingKey>(&arg0.extensions, v0)) {
            let v2 = 0x2::bag::remove<PointTradingKey, PointTradingLink>(&mut arg0.extensions, v0);
            advance(v2.revision, arg4)
        } else {
            assert!(arg4 == 0, 3207);
            1
        };
        let v3 = PointTradingLink{
            scoreboard_id         : arg3,
            point_token_market_id : arg5,
            orderbook_id          : arg6,
            revision              : v1,
        };
        0x2::bag::add<PointTradingKey, PointTradingLink>(&mut arg0.extensions, v0, v3);
        let v4 = PointTradingUpdated{
            registry_id           : 0x2::object::id<Registry>(arg0),
            scoreboard_id         : arg3,
            point_token_market_id : arg5,
            orderbook_id          : arg6,
            revision              : v1,
        };
        0x2::event::emit<PointTradingUpdated>(v4);
    }

    public fun set_program_listing(arg0: &mut Registry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: 0x2::object::ID, arg4: u64, arg5: bool) {
        authorize(arg0, arg1, arg2);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, PointProgram>(&mut arg0.programs, arg3);
        v0.revision = advance(v0.revision, arg4);
        v0.listed = arg5;
        emit_program(arg0, arg3);
    }

    public fun set_protocol_listing(arg0: &mut Registry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: u64, arg4: u64, arg5: bool, arg6: u64) {
        authorize(arg0, arg1, arg2);
        let v0 = 0x2::table::borrow_mut<u64, Protocol>(&mut arg0.protocols, arg3);
        v0.revision = advance(v0.revision, arg4);
        v0.listed = arg5;
        v0.display_rank = arg6;
        emit_protocol(arg0, arg3);
    }

    public fun set_series_listing(arg0: &mut Registry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: u64, arg4: u64, arg5: bool, arg6: u64) {
        authorize(arg0, arg1, arg2);
        let v0 = 0x2::table::borrow_mut<u64, Series>(&mut arg0.series, arg3);
        v0.revision = advance(v0.revision, arg4);
        v0.listed = arg5;
        v0.display_rank = arg6;
        emit_series(arg0, arg3);
    }

    public fun source(arg0: &Registry, arg1: 0x2::object::ID) : &PointSource {
        0x2::table::borrow<0x2::object::ID, PointSource>(&arg0.sources, arg1)
    }

    public fun table_ids(arg0: &Registry) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID, 0x2::object::ID, 0x2::object::ID, 0x2::object::ID, 0x2::object::ID) {
        (0x2::object::id<0x2::table::Table<u64, Protocol>>(&arg0.protocols), 0x2::object::id<0x2::table::Table<u64, Series>>(&arg0.series), 0x2::object::id<0x2::table::Table<0x2::object::ID, MarketRecord>>(&arg0.markets), 0x2::object::id<0x2::table::Table<0x2::object::ID, PointProgram>>(&arg0.programs), 0x2::object::id<0x2::table::Table<0x2::object::ID, PointSource>>(&arg0.sources), 0x2::object::id<0x2::table::Table<MarketSourceKey, MarketPointSource>>(&arg0.market_sources), 0x2::object::id<0x2::bag::Bag>(&arg0.extensions))
    }

    fun text(arg0: &vector<u8>, arg1: u64) {
        assert!(0xa6244236d5d19ba42f479a1444e6c24ec0ede1d2fe8f9aed562abf331b9491f2::registry_rules::within_size(0x1::vector::length<u8>(arg0), arg1), 3209);
        0x1::string::utf8(*arg0);
    }

    public fun update_market(arg0: &mut Registry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: 0x2::object::ID, arg4: u64, arg5: MarketMetadata) {
        authorize(arg0, arg1, arg2);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, MarketRecord>(&mut arg0.markets, arg3);
        v0.revision = advance(v0.revision, arg4);
        v0.metadata = arg5;
        bounded<MarketRecord>(v0);
        emit_market(arg0, arg3);
    }

    public fun update_market_source(arg0: &mut Registry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: 0x1::option::Option<0x2::object::ID>, arg7: bool, arg8: bool) {
        authorize(arg0, arg1, arg2);
        assert!(0xa6244236d5d19ba42f479a1444e6c24ec0ede1d2fe8f9aed562abf331b9491f2::registry_rules::valid_scopes(arg7, arg8, 0x1::option::is_some<0x2::object::ID>(&arg6)), 3208);
        let v0 = MarketSourceKey{
            market_id : arg3,
            source_id : arg4,
        };
        let v1 = 0x2::table::borrow_mut<MarketSourceKey, MarketPointSource>(&mut arg0.market_sources, v0);
        v1.revision = advance(v1.revision, arg5);
        v1.lp_point_state_id = arg6;
        v1.yt_enabled = arg7;
        v1.lp_enabled = arg8;
        let v2 = MarketSourceUpdated{
            registry_id       : 0x2::object::id<Registry>(arg0),
            market_id         : arg3,
            source_id         : arg4,
            lp_point_state_id : arg6,
            yt_enabled        : arg7,
            lp_enabled        : arg8,
            archived          : v1.archived,
            revision          : v1.revision,
        };
        0x2::event::emit<MarketSourceUpdated>(v2);
    }

    public fun update_program(arg0: &mut Registry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: 0x2::object::ID, arg4: u64, arg5: ProgramMetadata) {
        authorize(arg0, arg1, arg2);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, PointProgram>(&mut arg0.programs, arg3);
        v0.revision = advance(v0.revision, arg4);
        v0.metadata = arg5;
        emit_program(arg0, arg3);
    }

    public fun update_protocol(arg0: &mut Registry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: u64, arg4: u64, arg5: ProtocolMetadata) {
        authorize(arg0, arg1, arg2);
        let v0 = 0x2::table::borrow_mut<u64, Protocol>(&mut arg0.protocols, arg3);
        v0.revision = advance(v0.revision, arg4);
        v0.metadata = arg5;
        emit_protocol(arg0, arg3);
    }

    public fun update_series(arg0: &mut Registry, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg3: u64, arg4: u64, arg5: SeriesMetadata) {
        authorize(arg0, arg1, arg2);
        let v0 = 0x2::table::borrow_mut<u64, Series>(&mut arg0.series, arg3);
        v0.revision = advance(v0.revision, arg4);
        v0.metadata = arg5;
        bounded<Series>(v0);
        emit_series(arg0, arg3);
    }

    fun uri(arg0: &vector<u8>) {
        text(arg0, 512);
    }

    fun validate_label(arg0: &vector<u8>, arg1: bool) {
        if (arg1) {
            assert!(!0x1::vector::is_empty<u8>(arg0), 3210);
        };
        text(arg0, 64);
    }

    // decompiled from Move bytecode v7
}

