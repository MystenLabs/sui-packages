module 0xac17a14996146ba4d989ad5696cd784d87069f4869894658991c64526d674260::haedal_hasui_adapter {
    struct HAEDAL_HASUI_ADAPTER has drop {
        dummy_field: bool,
    }

    struct HAEDAL_AUTH has drop {
        dummy_field: bool,
    }

    struct HaedalHasuiAdapter has key {
        id: 0x2::object::UID,
        asset_type: 0x1::option::Option<0x1::type_name::TypeName>,
        underlying_decimals: u8,
        adapter_version: u64,
        paused: bool,
        setup_complete: bool,
        last_index: u128,
        last_observed_ms: u64,
        watermark: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::watermark::Watermark,
    }

    struct AdapterRegistered has copy, drop {
        adapter_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        adapter_version: u64,
    }

    struct AdapterWatermarkViolation has copy, drop {
        adapter_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        last_index: u128,
        observed_index: u128,
        last_observed_ms: u64,
        now_ms: u64,
        direction: u8,
    }

    public fun id(arg0: &HaedalHasuiAdapter) : 0x2::object::ID {
        0x2::object::id<HaedalHasuiAdapter>(arg0)
    }

    public fun adapter_watermark_payload_hash(arg0: u64, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = b"nemo:haedal_adapter_set_watermark:v1";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::hash_payload(v0)
    }

    public fun admin_bind_asset<T0>(arg0: &mut HaedalHasuiAdapter, arg1: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::caps::MarketAdminCap) {
        assert!(!arg0.setup_complete, 244);
        assert!(0x1::option::is_none<0x1::type_name::TypeName>(&arg0.asset_type), 18);
        assert!(0x1::type_name::with_original_ids<T0>() == 0x1::type_name::with_original_ids<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(), 17);
        0x1::option::fill<0x1::type_name::TypeName>(&mut arg0.asset_type, 0x1::type_name::with_original_ids<T0>());
    }

    public fun admin_pause<T0>(arg0: &mut HaedalHasuiAdapter, arg1: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<T0>, arg2: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::caps::MarketAdminCap) {
        assert_market_adapter<T0>(arg0, arg1);
        arg0.paused = true;
        let v0 = HAEDAL_AUTH{dummy_field: false};
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::emit_adapter_paused_for_adapter<T0, HAEDAL_AUTH>(arg1, &v0, 0x2::object::id<HaedalHasuiAdapter>(arg0), 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pause_state::lock_global(), 0, b"adapter admin pause");
    }

    public fun admin_set_index(arg0: &mut HaedalHasuiAdapter, arg1: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::caps::MarketAdminCap, arg2: u128, arg3: u128, arg4: u128, arg5: &0x2::clock::Clock) {
        assert_asset_bound(arg0);
        assert!(arg0.last_observed_ms == 0, 242);
        assert!(arg0.paused, 64);
        assert!(arg2 > 0, 0);
        assert!(arg3 > 0 && arg3 <= arg4, 245);
        assert!(arg2 >= arg3 && arg2 <= arg4, 245);
        arg0.last_index = arg2;
        arg0.last_observed_ms = 0x2::clock::timestamp_ms(arg5);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::watermark::reset_window(&mut arg0.watermark, 0x2::clock::timestamp_ms(arg5), arg2);
    }

    public fun admin_set_watermark(arg0: &mut HaedalHasuiAdapter, arg1: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::caps::MarketAdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::TimelockReceipt, arg6: &0x2::clock::Clock) {
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::consume_receipt_with_payload(arg5, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::action_set_adapter_watermark(), 0x2::object::id<HaedalHasuiAdapter>(arg0), adapter_watermark_payload_hash(arg2, arg3, arg4), arg6);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::watermark::set_drop_bps(&mut arg0.watermark, arg2);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::watermark::set_spike_apy_e9(&mut arg0.watermark, arg3);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::watermark::set_cumulative_apy_e9(&mut arg0.watermark, arg4);
    }

    public fun admin_unpause(arg0: &mut HaedalHasuiAdapter, arg1: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::caps::MarketAdminCap, arg2: &0x2::clock::Clock) {
        admin_unpause_for_marketless_setup(arg0, arg1, arg2);
    }

    public fun admin_unpause_after_watermark<T0>(arg0: &mut HaedalHasuiAdapter, arg1: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<T0>, arg2: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::TimelockReceipt, arg3: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::caps::MarketAdminCap, arg4: &0x2::clock::Clock) {
        assert_market_adapter<T0>(arg0, arg1);
        assert!(arg0.last_observed_ms != 0, 243);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::consume_receipt(arg2, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::action_unpause_after_watermark(), 0x2::object::id<HaedalHasuiAdapter>(arg0), arg4);
        arg0.paused = false;
        arg0.setup_complete = true;
        let v0 = HAEDAL_AUTH{dummy_field: false};
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::emit_adapter_unpaused_for_adapter<T0, HAEDAL_AUTH>(arg1, &v0, 0x2::object::id<HaedalHasuiAdapter>(arg0));
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::watermark::reset_window(&mut arg0.watermark, 0x2::clock::timestamp_ms(arg4), arg0.last_index);
    }

    public fun admin_unpause_for_market<T0>(arg0: &mut HaedalHasuiAdapter, arg1: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<T0>, arg2: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::caps::MarketAdminCap, arg3: &0x2::clock::Clock) {
        assert_market_adapter<T0>(arg0, arg1);
        assert!(arg0.last_observed_ms != 0, 243);
        assert!(!arg0.setup_complete, 244);
        arg0.paused = false;
        arg0.setup_complete = true;
        let v0 = HAEDAL_AUTH{dummy_field: false};
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::emit_adapter_unpaused_for_adapter<T0, HAEDAL_AUTH>(arg1, &v0, 0x2::object::id<HaedalHasuiAdapter>(arg0));
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::watermark::reset_window(&mut arg0.watermark, 0x2::clock::timestamp_ms(arg3), arg0.last_index);
    }

    public fun admin_unpause_for_marketless_setup(arg0: &mut HaedalHasuiAdapter, arg1: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::caps::MarketAdminCap, arg2: &0x2::clock::Clock) {
        assert_asset_bound(arg0);
        assert!(arg0.last_observed_ms != 0, 243);
        assert!(!arg0.setup_complete, 244);
        arg0.paused = false;
        arg0.setup_complete = true;
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::watermark::reset_window(&mut arg0.watermark, 0x2::clock::timestamp_ms(arg2), arg0.last_index);
    }

    public(friend) fun assert_asset<T0>(arg0: &HaedalHasuiAdapter) {
        assert_asset_bound(arg0);
        assert!(*0x1::option::borrow<0x1::type_name::TypeName>(&arg0.asset_type) == 0x1::type_name::with_original_ids<T0>(), 17);
    }

    fun assert_asset_bound(arg0: &HaedalHasuiAdapter) {
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.asset_type), 19);
    }

    public(friend) fun assert_freshness(arg0: &HaedalHasuiAdapter, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg0.last_observed_ms != 0, 243);
        assert!(v0 >= arg0.last_observed_ms, 50);
        assert!(v0 - arg0.last_observed_ms <= 60000, 50);
    }

    fun assert_market_adapter<T0>(arg0: &HaedalHasuiAdapter, arg1: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<T0>) {
        assert!(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::adapter_id<T0>(arg1) == 0x2::object::id<HaedalHasuiAdapter>(arg0), 16);
        assert_asset<T0>(arg0);
    }

    fun assert_setup_complete(arg0: &HaedalHasuiAdapter) {
        assert!(arg0.setup_complete, 243);
    }

    public fun asset_type(arg0: &HaedalHasuiAdapter) : 0x1::option::Option<0x1::type_name::TypeName> {
        arg0.asset_type
    }

    public fun auth_typename() : 0x1::type_name::TypeName {
        0x1::type_name::with_original_ids<HAEDAL_AUTH>()
    }

    fun direction_for_outcome(arg0: u8) : u8 {
        if (arg0 == 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::watermark::violation_drop()) {
            return 0
        };
        if (arg0 == 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::watermark::violation_spike()) {
            return 1
        };
        2
    }

    fun emit_violation(arg0: &HaedalHasuiAdapter, arg1: u128, arg2: u128, arg3: u64, arg4: u64, arg5: u8) {
        let v0 = AdapterWatermarkViolation{
            adapter_id       : 0x2::object::id<HaedalHasuiAdapter>(arg0),
            asset_type       : 0x1::type_name::with_original_ids<HAEDAL_AUTH>(),
            last_index       : arg1,
            observed_index   : arg2,
            last_observed_ms : arg3,
            now_ms           : arg4,
            direction        : arg5,
        };
        0x2::event::emit<AdapterWatermarkViolation>(v0);
    }

    public fun get_yield_index(arg0: &HaedalHasuiAdapter) : u128 {
        arg0.last_index
    }

    fun init(arg0: HAEDAL_HASUI_ADAPTER, arg1: &mut 0x2::tx_context::TxContext) {
        let HAEDAL_HASUI_ADAPTER {  } = arg0;
        let v0 = HaedalHasuiAdapter{
            id                  : 0x2::object::new(arg1),
            asset_type          : 0x1::option::none<0x1::type_name::TypeName>(),
            underlying_decimals : 9,
            adapter_version     : 1,
            paused              : true,
            setup_complete      : false,
            last_index          : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::math_ext::rate_scale(),
            last_observed_ms    : 0,
            watermark           : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::watermark::default(),
        };
        0x2::transfer::share_object<HaedalHasuiAdapter>(v0);
        let v1 = AdapterRegistered{
            adapter_id      : 0x2::object::id<HaedalHasuiAdapter>(&v0),
            asset_type      : 0x1::type_name::with_original_ids<HAEDAL_AUTH>(),
            adapter_version : 1,
        };
        0x2::event::emit<AdapterRegistered>(v1);
    }

    public fun is_paused(arg0: &HaedalHasuiAdapter) : bool {
        arg0.paused
    }

    public fun last_observed_ms(arg0: &HaedalHasuiAdapter) : u64 {
        arg0.last_observed_ms
    }

    public fun max_staleness_ms() : u64 {
        60000
    }

    public(friend) fun mint_auth() : HAEDAL_AUTH {
        HAEDAL_AUTH{dummy_field: false}
    }

    public(friend) fun observe_yield_index(arg0: &HaedalHasuiAdapter, arg1: &0x2::clock::Clock) : u128 {
        assert!(!arg0.paused, 64);
        assert_freshness(arg0, arg1);
        arg0.last_index
    }

    public fun read_current_haedal_exchange_rate_e9(arg0: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : u128 {
        read_haedal_exchange_rate_e9(arg0)
    }

    fun read_haedal_exchange_rate_e9(arg0: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : u128 {
        0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg0);
        (0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_sui_by_stsui(arg0, 1000000000) as u128)
    }

    public fun refresh_yield_index(arg0: &mut HaedalHasuiAdapter, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: &0x2::clock::Clock) {
        assert_setup_complete(arg0);
        let (v0, v1, v2, v3, v4) = refresh_yield_index_internal(arg0, arg1, arg2);
        if (v0 != 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::watermark::violation_none()) {
            emit_violation(arg0, v2, v1, v3, v4, direction_for_outcome(v0));
        };
    }

    public fun refresh_yield_index_for_market<T0>(arg0: &mut HaedalHasuiAdapter, arg1: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<T0>, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &0x2::clock::Clock) {
        assert_setup_complete(arg0);
        assert_market_adapter<T0>(arg0, arg1);
        let (v0, v1, v2, v3, v4) = refresh_yield_index_internal(arg0, arg2, arg3);
        if (v0 != 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::watermark::violation_none()) {
            let v5 = HAEDAL_AUTH{dummy_field: false};
            0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::emit_watermark_violation_for_adapter<T0, HAEDAL_AUTH>(arg1, &v5, v2, v1, v3, v4, direction_for_outcome(v0));
            0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::set_entry_pause_watermark_for_adapter<T0, HAEDAL_AUTH>(arg1, &v5, arg3);
        };
    }

    fun refresh_yield_index_internal(arg0: &mut HaedalHasuiAdapter, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: &0x2::clock::Clock) : (u8, u128, u128, u64, u64) {
        let v0 = read_haedal_exchange_rate_e9(arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::watermark::check_and_update(&mut arg0.watermark, arg0.last_index, v0, arg0.last_observed_ms, v1);
        if (v2 == 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::watermark::violation_drop()) {
            arg0.paused = true;
            arg0.last_observed_ms = v1;
            return (v2, v0, arg0.last_index, arg0.last_observed_ms, v1)
        };
        if (v2 == 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::watermark::violation_spike()) {
            arg0.paused = true;
            arg0.last_observed_ms = v1;
            return (v2, v0, arg0.last_index, arg0.last_observed_ms, v1)
        };
        if (v2 == 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::watermark::violation_cumulative()) {
            arg0.paused = true;
            arg0.last_observed_ms = v1;
            return (v2, v0, arg0.last_index, arg0.last_observed_ms, v1)
        };
        arg0.last_index = v0;
        arg0.last_observed_ms = v1;
        (v2, v0, arg0.last_index, arg0.last_observed_ms, v1)
    }

    public(friend) fun request_unstake_delay_internal(arg0: &HaedalHasuiAdapter, arg1: 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert_asset<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg0);
        assert!(!arg0.paused, 64);
        let v0 = 0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg1);
            return (0, 0)
        };
        if (v0 < 1000000000) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>>(0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg1, arg4), 0x2::tx_context::sender(arg4));
            return (v0, 0)
        };
        0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::request_unstake_delay(arg2, arg3, 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg1, arg4), arg4);
        (v0, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_sui_by_stsui(arg2, v0))
    }

    public fun schedule_admin_set_watermark(arg0: &HaedalHasuiAdapter, arg1: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::caps::MarketAdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::TimelockReceipt {
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::schedule_action_with_payload(arg1, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::action_set_adapter_watermark(), 0x2::object::id<HaedalHasuiAdapter>(arg0), adapter_watermark_payload_hash(arg2, arg3, arg4), arg5, arg6)
    }

    public fun setup_complete(arg0: &HaedalHasuiAdapter) : bool {
        arg0.setup_complete
    }

    public fun version(arg0: &HaedalHasuiAdapter) : u64 {
        arg0.adapter_version
    }

    public fun watermark(arg0: &HaedalHasuiAdapter) : &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::watermark::Watermark {
        &arg0.watermark
    }

    // decompiled from Move bytecode v7
}

