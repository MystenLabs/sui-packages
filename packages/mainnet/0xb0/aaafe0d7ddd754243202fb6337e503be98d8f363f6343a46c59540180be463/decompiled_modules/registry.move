module 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        market_manager: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::MarketManager,
        allowed_pause_caps: 0x2::vec_set::VecSet<0x2::object::ID>,
        allowed_lifecycle_caps: 0x2::vec_set::VecSet<0x2::object::ID>,
        allowed_pool_valuation_caps: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct CadencePeriodsKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun id(arg0: &Registry) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun cadence_config(arg0: &Registry, arg1: u32, arg2: u8) : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::CadenceConfig {
        let v0 = cad_periods(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::cadence_config(&arg0.market_manager, &v0, arg1, arg2)
    }

    public fun cadence_configs(arg0: &Registry, arg1: u32) : vector<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::CadenceConfig> {
        let v0 = cad_periods(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::cadence_configs(&arg0.market_manager, &v0, arg1)
    }

    public fun expiry_market_id(arg0: &Registry, arg1: u32, arg2: u64) : 0x1::option::Option<0x2::object::ID> {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::expiry_market_id(&arg0.market_manager, arg1, arg2)
    }

    public fun register_underlying(arg0: &mut Registry, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg3: u32) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_version(arg1);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::register_underlying(&mut arg0.market_manager, arg3);
    }

    public fun set_template_cadence_config(arg0: &mut Registry, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg3: u32, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_version(arg1);
        let v0 = cad_periods(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::set_template_cadence_config(&mut arg0.market_manager, &v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::cad_upd(id(arg0), arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun add_cadence(arg0: &mut Registry, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg3: u64) : u8 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_version(arg1);
        let v0 = CadencePeriodsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<CadencePeriodsKey>(&arg0.id, v0)) {
            let v1 = CadencePeriodsKey{dummy_field: false};
            0x2::dynamic_field::add<CadencePeriodsKey, vector<u64>>(&mut arg0.id, v1, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::base_per());
        };
        let v2 = CadencePeriodsKey{dummy_field: false};
        let v3 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::add_period(0x2::dynamic_field::borrow_mut<CadencePeriodsKey, vector<u64>>(&mut arg0.id, v2), arg3);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::cad_add(id(arg0), v3, arg3);
        v3
    }

    fun cad_periods(arg0: &Registry) : vector<u64> {
        let v0 = CadencePeriodsKey{dummy_field: false};
        if (0x2::dynamic_field::exists<CadencePeriodsKey>(&arg0.id, v0)) {
            let v2 = CadencePeriodsKey{dummy_field: false};
            *0x2::dynamic_field::borrow<CadencePeriodsKey, vector<u64>>(&arg0.id, v2)
        } else {
            0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::base_per()
        }
    }

    public fun cadence_periods(arg0: &Registry) : vector<u64> {
        cad_periods(arg0)
    }

    fun chk_lc_cap(arg0: &Registry, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_lifecycle_cap::MarketLifecycleCap) {
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_lifecycle_cap::id(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_lifecycle_caps, &v0), 1);
    }

    fun chk_pausecap(arg0: &Registry, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pause_cap::PauseCap) {
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pause_cap::id(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_pause_caps, &v0), 0);
    }

    fun chk_pv_cap(arg0: &Registry, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_valuation_cap::PoolValuationCap) {
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_valuation_cap::id(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_pool_valuation_caps, &v0), 3);
    }

    public fun create_and_share_builder_code(arg0: &mut Registry, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_version(arg1);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::builder_code::create_and_share(&mut arg0.id, arg2, arg3)
    }

    public fun create_and_share_expiry_market(arg0: &mut Registry, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::plp::PoolVault, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg3: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg4: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_lifecycle_cap::MarketLifecycleCap, arg5: u32, arg6: u8, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        create_and_share_expiry_market_with_band(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x1::option::none<u64>(), 0, 18446744073709551615, arg7, arg8)
    }

    public fun create_and_share_expiry_market_at(arg0: &mut Registry, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::plp::PoolVault, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg3: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg4: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_lifecycle_cap::MarketLifecycleCap, arg5: u32, arg6: u8, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        create_and_share_expiry_market_with_band(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x1::option::some<u64>(arg7), 0, 18446744073709551615, arg8, arg9)
    }

    public fun create_and_share_expiry_market_with_band(arg0: &mut Registry, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::plp::PoolVault, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg3: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg4: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_lifecycle_cap::MarketLifecycleCap, arg5: u32, arg6: u8, arg7: 0x1::option::Option<u64>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_version(arg2);
        chk_lc_cap(arg0, arg4);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_trading(arg2);
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::se_snap(arg2);
        let (v1, v2) = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::narrow(&mut v0, arg8, arg9);
        let v3 = cad_periods(arg0);
        let v4 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::next_deploy(&arg0.market_manager, &v3, arg3, arg5, arg6, arg10);
        let v5 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::expiry(&v4);
        if (0x1::option::is_some<u64>(&arg7)) {
            assert!(v5 == 0x1::option::destroy_some<u64>(arg7), 5);
        } else {
            0x1::option::destroy_none<u64>(arg7);
        };
        let v6 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::tick_size(&v4);
        let v7 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::admission_tick_size(&v4);
        let v8 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::max_alloc(&v4);
        let v9 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::init_cash(&v4);
        let v10 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::create_and_share(arg2, v0, arg5, v5, v6, v7, v5 - 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::cad_period(&v3, arg6), v8, arg11);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::plp::reg_exp(arg1, v10, v5, v8, v9, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::fee_incentive_lifetime_cap_rate(arg2), arg10);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_manager::note_expiry(&mut arg0.market_manager, &v3, arg5, arg6, v5, v10);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::mkt_new(v10, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::plp::id(arg1), arg5, v5, v6, v7, v8, v9, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::se_tmpl(arg2), v1, v2);
        v10
    }

    public fun freeze_protocol_pause_cap(arg0: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg1: &Registry, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pause_cap::PauseCap) {
        chk_pausecap(arg1, arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::freeze_all(arg0);
    }

    public fun generate_pool_valuation_proof(arg0: &Registry, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_valuation_cap::PoolValuationCap) : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::plp::PoolValuationProof {
        chk_pv_cap(arg0, arg1);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::plp::new_proof()
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_registry(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::create_and_share(arg0);
        0x2::transfer::share_object<Registry>(v0);
        0x2::transfer::public_transfer<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun mint_lifecycle_cap(arg0: &mut Registry, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg3: &mut 0x2::tx_context::TxContext) : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::market_lifecycle_cap::MarketLifecycleCap {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_version(arg1);
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
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_version(arg2);
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_valuation_cap::new(arg3);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allowed_pool_valuation_caps, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_valuation_cap::id(&v0));
        v0
    }

    fun new_registry(arg0: &mut 0x2::tx_context::TxContext) : (Registry, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap) {
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
        chk_pausecap(arg1, arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::pause_mint(arg0);
    }

    public fun pause_trading_pause_cap(arg0: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg1: &Registry, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pause_cap::PauseCap) {
        chk_pausecap(arg1, arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::pause_all(arg0);
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

