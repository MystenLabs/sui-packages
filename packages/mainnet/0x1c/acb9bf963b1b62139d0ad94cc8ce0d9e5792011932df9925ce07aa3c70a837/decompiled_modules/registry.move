module 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        market_manager: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::MarketManager,
        allowed_pause_caps: 0x2::vec_set::VecSet<0x2::object::ID>,
        allowed_lifecycle_caps: 0x2::vec_set::VecSet<0x2::object::ID>,
        allowed_pool_valuation_caps: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    public fun id(arg0: &Registry) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun cadence_config(arg0: &Registry, arg1: u32, arg2: u8) : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::CadenceConfig {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::cadence_config(&arg0.market_manager, arg1, arg2)
    }

    public fun cadence_configs(arg0: &Registry, arg1: u32) : vector<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::CadenceConfig> {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::cadence_configs(&arg0.market_manager, arg1)
    }

    public fun expiry_market_id(arg0: &Registry, arg1: u32, arg2: u64) : 0x1::option::Option<0x2::object::ID> {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::expiry_market_id(&arg0.market_manager, arg1, arg2)
    }

    public fun register_underlying(arg0: &mut Registry, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg3: u32) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::assert_version(arg1);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::register_underlying(&mut arg0.market_manager, arg3);
    }

    public fun set_template_cadence_config(arg0: &mut Registry, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg3: u32, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::assert_version(arg1);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::set_template_cadence_config(&mut arg0.market_manager, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::emit_cadence_config_updated(id(arg0), arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    fun assert_valid_lifecycle_cap(arg0: &Registry, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_lifecycle_cap::MarketLifecycleCap) {
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_lifecycle_cap::id(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_lifecycle_caps, &v0), 1);
    }

    fun assert_valid_pause_cap(arg0: &Registry, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pause_cap::PauseCap) {
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pause_cap::id(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_pause_caps, &v0), 0);
    }

    fun assert_valid_pool_valuation_cap(arg0: &Registry, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_valuation_cap::PoolValuationCap) {
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_valuation_cap::id(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_pool_valuation_caps, &v0), 3);
    }

    public fun create_and_share_builder_code(arg0: &mut Registry, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::assert_version(arg1);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::builder_code::create_and_share(&mut arg0.id, arg2, arg3)
    }

    public fun create_and_share_expiry_market(arg0: &mut Registry, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::plp::PoolVault, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg3: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg4: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_lifecycle_cap::MarketLifecycleCap, arg5: u32, arg6: u8, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::assert_version(arg2);
        assert_valid_lifecycle_cap(arg0, arg4);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::assert_trading_allowed(arg2);
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::next_deployable_market(&arg0.market_manager, arg3, arg5, arg6, arg7);
        let v1 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::expiry(&v0);
        let v2 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::tick_size(&v0);
        let v3 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::admission_tick_size(&v0);
        let v4 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::max_expiry_allocation(&v0);
        let v5 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::initial_expiry_cash(&v0);
        let v6 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::create_and_share(arg2, arg5, v1, v2, v3, v1 - 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::cadence_period_ms(arg6), v4, arg8);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::plp::register_expiry(arg1, v6, v1, v4, v5, arg7);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::record_expiry_creation(&mut arg0.market_manager, arg5, arg6, v1, v6);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::emit_market_created(v6, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::plp::id(arg1), arg5, v1, v2, v3, v4, v5, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::strike_exposure_template_config(arg2));
        v6
    }

    public fun freeze_protocol_pause_cap(arg0: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg1: &Registry, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pause_cap::PauseCap) {
        assert_valid_pause_cap(arg1, arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::freeze_protocol(arg0);
    }

    public fun generate_pool_valuation_proof(arg0: &Registry, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_valuation_cap::PoolValuationCap) : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::plp::PoolValuationProof {
        assert_valid_pool_valuation_cap(arg0, arg1);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::plp::new_pool_valuation_proof()
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_registry_and_admin_cap(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::create_and_share(arg0);
        0x2::transfer::share_object<Registry>(v0);
        0x2::transfer::public_transfer<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun mint_lifecycle_cap(arg0: &mut Registry, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg3: &mut 0x2::tx_context::TxContext) : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_lifecycle_cap::MarketLifecycleCap {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::assert_version(arg1);
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_lifecycle_cap::new(arg3);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allowed_lifecycle_caps, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_lifecycle_cap::id(&v0));
        v0
    }

    public fun mint_pause_cap(arg0: &mut Registry, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pause_cap::PauseCap {
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pause_cap::new(arg2);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allowed_pause_caps, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pause_cap::id(&v0));
        v0
    }

    public fun mint_pool_valuation_cap(arg0: &mut Registry, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg3: &mut 0x2::tx_context::TxContext) : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_valuation_cap::PoolValuationCap {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::assert_version(arg2);
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_valuation_cap::new(arg3);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allowed_pool_valuation_caps, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_valuation_cap::id(&v0));
        v0
    }

    fun new_registry_and_admin_cap(arg0: &mut 0x2::tx_context::TxContext) : (Registry, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap) {
        let v0 = Registry{
            id                          : 0x2::object::new(arg0),
            market_manager              : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::new(arg0),
            allowed_pause_caps          : 0x2::vec_set::empty<0x2::object::ID>(),
            allowed_lifecycle_caps      : 0x2::vec_set::empty<0x2::object::ID>(),
            allowed_pool_valuation_caps : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        (v0, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::new(arg0))
    }

    public fun pause_expiry_market_mint_pause_cap(arg0: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg1: &Registry, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pause_cap::PauseCap) {
        assert_valid_pause_cap(arg1, arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::pause_mint(arg0);
    }

    public fun pause_trading_pause_cap(arg0: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg1: &Registry, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pause_cap::PauseCap) {
        assert_valid_pause_cap(arg1, arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::pause_trading(arg0);
    }

    public fun revoke_lifecycle_cap(arg0: &mut Registry, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: 0x2::object::ID) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_lifecycle_caps, &arg2), 2);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.allowed_lifecycle_caps, &arg2);
    }

    public fun revoke_pause_cap(arg0: &mut Registry, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: 0x2::object::ID) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_pause_caps, &arg2), 0);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.allowed_pause_caps, &arg2);
    }

    public fun revoke_pool_valuation_cap(arg0: &mut Registry, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: 0x2::object::ID) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_pool_valuation_caps, &arg2), 4);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.allowed_pool_valuation_caps, &arg2);
    }

    // decompiled from Move bytecode v7
}

