module 0x14e2f975d0b27be31ddc6b6ece2881c0a8337758f76dd0e0fb0f026a2448c6bf::scallop_sui_adapter {
    struct SCALLOP_SUI_ADAPTER has drop {
        dummy_field: bool,
    }

    struct SCALLOP_AUTH has drop {
        dummy_field: bool,
    }

    struct ScallopSuiAdapter has key {
        id: 0x2::object::UID,
        asset_type: 0x1::option::Option<0x1::type_name::TypeName>,
        underlying_decimals: u8,
        adapter_version: u64,
        paused: bool,
        setup_complete: bool,
        last_index: u128,
        last_observed_ms: u64,
        watermark: 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::watermark::Watermark,
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

    public fun id(arg0: &ScallopSuiAdapter) : 0x2::object::ID {
        0x2::object::id<ScallopSuiAdapter>(arg0)
    }

    public fun adapter_watermark_payload_hash(arg0: u64, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = b"nemo:adapter_set_watermark:v1";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::hash_payload(v0)
    }

    public fun admin_bind_asset<T0>(arg0: &mut ScallopSuiAdapter, arg1: &0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::caps::MarketAdminCap) {
        assert!(!arg0.setup_complete, 244);
        assert!(0x1::option::is_none<0x1::type_name::TypeName>(&arg0.asset_type), 18);
        0x1::option::fill<0x1::type_name::TypeName>(&mut arg0.asset_type, 0x1::type_name::with_original_ids<T0>());
    }

    public fun admin_pause<T0>(arg0: &mut ScallopSuiAdapter, arg1: &0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::market_core::MarketCore<T0>, arg2: &0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::caps::MarketAdminCap) {
        assert_market_adapter<T0>(arg0, arg1);
        arg0.paused = true;
        let v0 = SCALLOP_AUTH{dummy_field: false};
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::market_core::emit_adapter_paused_for_adapter<T0, SCALLOP_AUTH>(arg1, &v0, 0x2::object::id<ScallopSuiAdapter>(arg0), 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::pause_state::lock_global(), 0, b"adapter admin pause");
    }

    public fun admin_set_index(arg0: &mut ScallopSuiAdapter, arg1: &0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::caps::MarketAdminCap, arg2: u128, arg3: u128, arg4: u128, arg5: &0x2::clock::Clock) {
        assert_asset_bound(arg0);
        assert!(arg0.last_observed_ms == 0, 242);
        assert!(arg0.paused, 64);
        assert!(arg2 > 0, 0);
        assert!(arg3 > 0 && arg3 <= arg4, 245);
        assert!(arg2 >= arg3 && arg2 <= arg4, 245);
        arg0.last_index = arg2;
        arg0.last_observed_ms = 0x2::clock::timestamp_ms(arg5);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::watermark::reset_window(&mut arg0.watermark, 0x2::clock::timestamp_ms(arg5), arg2);
    }

    public fun admin_set_watermark(arg0: &mut ScallopSuiAdapter, arg1: &0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::caps::MarketAdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::TimelockReceipt, arg6: &0x2::clock::Clock) {
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::consume_receipt_with_payload(arg5, 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::action_set_adapter_watermark(), 0x2::object::id<ScallopSuiAdapter>(arg0), adapter_watermark_payload_hash(arg2, arg3, arg4), arg6);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::watermark::set_drop_bps(&mut arg0.watermark, arg2);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::watermark::set_spike_apy_e9(&mut arg0.watermark, arg3);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::watermark::set_cumulative_apy_e9(&mut arg0.watermark, arg4);
    }

    public fun admin_unpause(arg0: &mut ScallopSuiAdapter, arg1: &0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::caps::MarketAdminCap, arg2: &0x2::clock::Clock) {
        admin_unpause_for_marketless_setup(arg0, arg1, arg2);
    }

    public fun admin_unpause_after_watermark<T0>(arg0: &mut ScallopSuiAdapter, arg1: &0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::market_core::MarketCore<T0>, arg2: 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::TimelockReceipt, arg3: &0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::caps::MarketAdminCap, arg4: &0x2::clock::Clock) {
        assert_market_adapter<T0>(arg0, arg1);
        assert!(arg0.last_observed_ms != 0, 243);
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::consume_receipt(arg2, 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::action_unpause_after_watermark(), 0x2::object::id<ScallopSuiAdapter>(arg0), arg4);
        arg0.paused = false;
        arg0.setup_complete = true;
        let v0 = SCALLOP_AUTH{dummy_field: false};
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::market_core::emit_adapter_unpaused_for_adapter<T0, SCALLOP_AUTH>(arg1, &v0, 0x2::object::id<ScallopSuiAdapter>(arg0));
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::watermark::reset_window(&mut arg0.watermark, 0x2::clock::timestamp_ms(arg4), arg0.last_index);
    }

    public fun admin_unpause_for_market<T0>(arg0: &mut ScallopSuiAdapter, arg1: &0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::market_core::MarketCore<T0>, arg2: &0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::caps::MarketAdminCap, arg3: &0x2::clock::Clock) {
        assert_market_adapter<T0>(arg0, arg1);
        assert!(arg0.last_observed_ms != 0, 243);
        assert!(!arg0.setup_complete, 244);
        arg0.paused = false;
        arg0.setup_complete = true;
        let v0 = SCALLOP_AUTH{dummy_field: false};
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::market_core::emit_adapter_unpaused_for_adapter<T0, SCALLOP_AUTH>(arg1, &v0, 0x2::object::id<ScallopSuiAdapter>(arg0));
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::watermark::reset_window(&mut arg0.watermark, 0x2::clock::timestamp_ms(arg3), arg0.last_index);
    }

    public fun admin_unpause_for_marketless_setup(arg0: &mut ScallopSuiAdapter, arg1: &0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::caps::MarketAdminCap, arg2: &0x2::clock::Clock) {
        assert_asset_bound(arg0);
        assert!(arg0.last_observed_ms != 0, 243);
        assert!(!arg0.setup_complete, 244);
        arg0.paused = false;
        arg0.setup_complete = true;
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::watermark::reset_window(&mut arg0.watermark, 0x2::clock::timestamp_ms(arg2), arg0.last_index);
    }

    public(friend) fun assert_asset<T0>(arg0: &ScallopSuiAdapter) {
        assert_asset_bound(arg0);
        assert!(*0x1::option::borrow<0x1::type_name::TypeName>(&arg0.asset_type) == 0x1::type_name::with_original_ids<T0>(), 17);
    }

    fun assert_asset_bound(arg0: &ScallopSuiAdapter) {
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.asset_type), 19);
    }

    public(friend) fun assert_freshness(arg0: &ScallopSuiAdapter, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg0.last_observed_ms != 0, 243);
        assert!(v0 >= arg0.last_observed_ms, 50);
        assert!(v0 - arg0.last_observed_ms <= 60000, 50);
    }

    fun assert_market_adapter<T0>(arg0: &ScallopSuiAdapter, arg1: &0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::market_core::MarketCore<T0>) {
        assert!(0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::market_core::adapter_id<T0>(arg1) == 0x2::object::id<ScallopSuiAdapter>(arg0), 16);
        assert_asset<T0>(arg0);
    }

    fun assert_setup_complete(arg0: &ScallopSuiAdapter) {
        assert!(arg0.setup_complete, 243);
    }

    public fun asset_type(arg0: &ScallopSuiAdapter) : 0x1::option::Option<0x1::type_name::TypeName> {
        arg0.asset_type
    }

    public fun auth_typename() : 0x1::type_name::TypeName {
        0x1::type_name::with_original_ids<SCALLOP_AUTH>()
    }

    fun direction_for_outcome(arg0: u8) : u8 {
        if (arg0 == 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::watermark::violation_drop()) {
            return 0
        };
        if (arg0 == 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::watermark::violation_spike()) {
            return 1
        };
        2
    }

    fun emit_violation(arg0: &ScallopSuiAdapter, arg1: u128, arg2: u128, arg3: u64, arg4: u64, arg5: u8) {
        let v0 = AdapterWatermarkViolation{
            adapter_id       : 0x2::object::id<ScallopSuiAdapter>(arg0),
            asset_type       : 0x1::type_name::with_original_ids<SCALLOP_AUTH>(),
            last_index       : arg1,
            observed_index   : arg2,
            last_observed_ms : arg3,
            now_ms           : arg4,
            direction        : arg5,
        };
        0x2::event::emit<AdapterWatermarkViolation>(v0);
    }

    public fun get_yield_index(arg0: &ScallopSuiAdapter) : u128 {
        arg0.last_index
    }

    fun init(arg0: SCALLOP_SUI_ADAPTER, arg1: &mut 0x2::tx_context::TxContext) {
        let SCALLOP_SUI_ADAPTER {  } = arg0;
        let v0 = ScallopSuiAdapter{
            id                  : 0x2::object::new(arg1),
            asset_type          : 0x1::option::none<0x1::type_name::TypeName>(),
            underlying_decimals : 9,
            adapter_version     : 1,
            paused              : true,
            setup_complete      : false,
            last_index          : 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::math_ext::rate_scale(),
            last_observed_ms    : 0,
            watermark           : 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::watermark::default(),
        };
        0x2::transfer::share_object<ScallopSuiAdapter>(v0);
        let v1 = AdapterRegistered{
            adapter_id      : 0x2::object::id<ScallopSuiAdapter>(&v0),
            asset_type      : 0x1::type_name::with_original_ids<SCALLOP_AUTH>(),
            adapter_version : 1,
        };
        0x2::event::emit<AdapterRegistered>(v1);
    }

    public fun is_paused(arg0: &ScallopSuiAdapter) : bool {
        arg0.paused
    }

    public fun last_observed_ms(arg0: &ScallopSuiAdapter) : u64 {
        arg0.last_observed_ms
    }

    public fun max_staleness_ms() : u64 {
        60000
    }

    public(friend) fun mint_auth() : SCALLOP_AUTH {
        SCALLOP_AUTH{dummy_field: false}
    }

    public(friend) fun observe_yield_index(arg0: &ScallopSuiAdapter, arg1: &0x2::clock::Clock) : u128 {
        assert!(!arg0.paused, 64);
        assert_freshness(arg0, arg1);
        arg0.last_index
    }

    public fun read_current_scallop_exchange_rate_e9(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0x2::clock::Clock) : u128 {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market(arg0, arg1, arg2);
        read_scallop_exchange_rate_e9(arg1)
    }

    public fun version(arg0: &ScallopSuiAdapter) : u64 {
        arg0.adapter_version
    }

    fun read_scallop_exchange_rate_e9(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) : u128 {
        let (v0, v1, v2, v3) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg0)), 0x1::type_name::with_defining_ids<0x2::sui::SUI>()));
        assert!(v3 > 0, 0);
        let v4 = (v0 as u128) + (v1 as u128);
        let v5 = if (v4 > (v2 as u128)) {
            v4 - (v2 as u128)
        } else {
            0
        };
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::math_ext::mul_div_down_u128(v5, 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::math_ext::rate_scale(), (v3 as u128))
    }

    public(friend) fun realize_internal<T0>(arg0: &mut ScallopSuiAdapter, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T0, 0x2::sui::SUI>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert_asset<T0>(arg0);
        assert!(!arg0.paused, 64);
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return 0x2::balance::zero<0x2::sui::SUI>()
        };
        let v0 = 0x2::coin::from_balance<T0>(arg1, arg6);
        0x2::coin::into_balance<0x2::sui::SUI>(swap_scoin_to_sui<T0>(v0, arg2, arg3, arg4, arg5, arg6))
    }

    public fun refresh_yield_index(arg0: &mut ScallopSuiAdapter, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock) {
        assert_setup_complete(arg0);
        let (v0, v1, v2, v3, v4) = refresh_yield_index_internal(arg0, arg1, arg2, arg3);
        if (v0 != 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::watermark::violation_none()) {
            emit_violation(arg0, v2, v1, v3, v4, direction_for_outcome(v0));
        };
    }

    public fun refresh_yield_index_for_market<T0>(arg0: &mut ScallopSuiAdapter, arg1: &mut 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::market_core::MarketCore<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock) {
        assert_setup_complete(arg0);
        assert_market_adapter<T0>(arg0, arg1);
        let (v0, v1, v2, v3, v4) = refresh_yield_index_internal(arg0, arg2, arg3, arg4);
        if (v0 != 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::watermark::violation_none()) {
            let v5 = SCALLOP_AUTH{dummy_field: false};
            0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::market_core::emit_watermark_violation_for_adapter<T0, SCALLOP_AUTH>(arg1, &v5, v2, v1, v3, v4, direction_for_outcome(v0));
            0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::market_core::set_entry_pause_watermark_for_adapter<T0, SCALLOP_AUTH>(arg1, &v5, arg4);
        };
    }

    fun refresh_yield_index_internal(arg0: &mut ScallopSuiAdapter, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock) : (u8, u128, u128, u64, u64) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market(arg1, arg2, arg3);
        let v0 = read_scallop_exchange_rate_e9(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::watermark::check_and_update(&mut arg0.watermark, arg0.last_index, v0, arg0.last_observed_ms, v1);
        if (v2 == 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::watermark::violation_drop()) {
            arg0.paused = true;
            arg0.last_observed_ms = v1;
            return (v2, v0, arg0.last_index, arg0.last_observed_ms, v1)
        };
        if (v2 == 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::watermark::violation_spike()) {
            arg0.paused = true;
            arg0.last_observed_ms = v1;
            return (v2, v0, arg0.last_index, arg0.last_observed_ms, v1)
        };
        if (v2 == 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::watermark::violation_cumulative()) {
            arg0.paused = true;
            arg0.last_observed_ms = v1;
            return (v2, v0, arg0.last_index, arg0.last_observed_ms, v1)
        };
        arg0.last_index = v0;
        arg0.last_observed_ms = v1;
        (v2, v0, arg0.last_index, arg0.last_observed_ms, v1)
    }

    public fun schedule_admin_set_watermark(arg0: &ScallopSuiAdapter, arg1: &0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::caps::MarketAdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::TimelockReceipt {
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::schedule_action_with_payload(arg1, 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::timelock::action_set_adapter_watermark(), 0x2::object::id<ScallopSuiAdapter>(arg0), adapter_watermark_payload_hash(arg2, arg3, arg4), arg5, arg6)
    }

    public fun setup_complete(arg0: &ScallopSuiAdapter) : bool {
        arg0.setup_complete
    }

    fun swap_scoin_to_sui<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T0, 0x2::sui::SUI>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market(arg2, arg3, arg4);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<0x2::sui::SUI>(arg2, arg3, 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::burn_s_coin<T0, 0x2::sui::SUI>(arg1, arg0, arg5), arg4, arg5)
    }

    public fun watermark(arg0: &ScallopSuiAdapter) : &0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::watermark::Watermark {
        &arg0.watermark
    }

    // decompiled from Move bytecode v7
}

