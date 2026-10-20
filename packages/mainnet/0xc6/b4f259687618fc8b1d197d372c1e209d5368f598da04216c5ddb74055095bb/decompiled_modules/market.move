module 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::market {
    struct MarketRegistry has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct RegistryStateV1 has store, key {
        id: 0x2::object::UID,
        market_ids: vector<0x2::object::ID>,
    }

    struct Market<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct OracleParamsV1 has copy, drop, store {
        storage_id: 0x2::object::ID,
        source_id: u64,
        feed_info_id: 0x2::object::ID,
        lazer_feed_id: u32,
        max_age_ms: u64,
        max_conf_age_ms: u64,
        max_future_ms: u64,
        max_twap_dev_bps: u64,
        min_spread_bps: u64,
    }

    struct RiskParamsV1 has copy, drop, store {
        min_leverage: u64,
        max_leverage: u64,
        bust_buffer_wad: u128,
        min_margin: u64,
        min_notional: u64,
        max_position_notional: u64,
        max_tx_notional: u64,
        max_block_notional: u64,
        max_account_notional: u64,
        oi_cap_lp_ratio_bps: u64,
        liq_bounty_bps: u64,
    }

    struct ImpactParamsV1 has copy, drop, store {
        c_num: u128,
        c_den: u128,
        deadband_div: u64,
        reference_notional: u64,
        p_num: u128,
        p_den: u128,
        effective_depth: u64,
        deadband_ppm: u64,
        close_fee_ppm: u64,
    }

    struct TimingParamsV1 has copy, drop, store {
        min_hold_ms: u64,
    }

    struct Listing has drop {
        symbol: vector<u8>,
        oracle: OracleParamsV1,
        risk: RiskParamsV1,
        impact: ImpactParamsV1,
        min_hold_ms: u64,
        taker_fee_bps: u64,
        hours_mode: u8,
    }

    struct NotionalWindowV1 has copy, drop, store {
        checkpoint_ts_ms: u64,
        checkpoint_notional: u64,
        last_tx_digest: vector<u8>,
        tx_notional: u64,
    }

    struct MarketFlagsV1 has copy, drop, store {
        enabled: bool,
        opens_paused: bool,
        closes_paused: bool,
        oracle_killed: bool,
        configured: bool,
        shared: bool,
    }

    struct SideBookV1 has copy, drop, store {
        long_oi: u64,
        short_oi: u64,
        long_locked_exposure: u64,
        short_locked_exposure: u64,
        long_qty: u128,
        short_qty: u128,
        long_min_entry_wad: u128,
        short_max_entry_wad: u128,
    }

    struct SideCapsV1 has copy, drop, store {
        max_long_exposure: u64,
        max_short_exposure: u64,
        max_long_oi: u64,
        max_short_oi: u64,
        stress_bps: u64,
    }

    struct OracleTrackV1 has copy, drop, store {
        last_mark_wad: u128,
        closed_seen_ts_ms: u64,
        last_oracle_ts_ms: u64,
        last_oracle_sequence: u64,
        last_oracle_slot: u64,
    }

    struct MarketStateV1<phantom T0> has store, key {
        id: 0x2::object::UID,
        exchange_id: 0x2::object::ID,
        symbol: vector<u8>,
        kind: u8,
        taker_fee_bps: u64,
        win_fee_bps: u64,
        flags: MarketFlagsV1,
        oracle: OracleParamsV1,
        risk: RiskParamsV1,
        impact: ImpactParamsV1,
        timing: TimingParamsV1,
        sides: SideBookV1,
        status: u8,
        hours_mode: u8,
        track: OracleTrackV1,
        window: NotionalWindowV1,
        settlement_px_wad: 0x1::option::Option<u128>,
        caps: SideCapsV1,
        snap_upnl: u64,
        snap_stress: u64,
        liq: 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::LiqBook,
        order: OrderParamsV1,
        extra_fields: 0x2::bag::Bag,
    }

    struct OrderParamsV1 has copy, drop, store {
        fill_window_ms: u64,
        fill_deadline_ms: u64,
        cancel_delay_ms: u64,
        emergency_after_ms: u64,
        exec_fee: u64,
        one_step_spread_bps: u64,
    }

    struct SessionCloseKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SessionCloseV1 has copy, drop, store {
        armed: bool,
        snapshot_price_wad: u128,
        snapshot_ts_ms: u64,
        snapshot_seq: u64,
        position_id_watermark: u64,
        remaining: u64,
        closed_count: u64,
    }

    public fun assert_version<T0>(arg0: &Market<T0>) {
        assert!(arg0.version == 1, 13835062174155800577);
    }

    public fun add_locked<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut Market<T0>, arg2: bool, arg3: u64) {
        let v0 = state_mut<T0>(arg1);
        if (arg2) {
            v0.sides.long_locked_exposure = v0.sides.long_locked_exposure + arg3;
        } else {
            v0.sides.short_locked_exposure = v0.sides.short_locked_exposure + arg3;
        };
    }

    public fun add_oi<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut Market<T0>, arg2: bool, arg3: u64) {
        let v0 = state_mut<T0>(arg1);
        if (arg2) {
            v0.sides.long_oi = v0.sides.long_oi + arg3;
        } else {
            v0.sides.short_oi = v0.sides.short_oi + arg3;
        };
    }

    public fun add_qty<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut Market<T0>, arg2: bool, arg3: u64, arg4: u128) {
        let v0 = state_mut<T0>(arg1);
        if (arg2) {
            v0.sides.long_qty = v0.sides.long_qty + qty_of(arg3, arg4);
            if (v0.sides.long_min_entry_wad == 0 || arg4 < v0.sides.long_min_entry_wad) {
                v0.sides.long_min_entry_wad = arg4;
            };
        } else {
            v0.sides.short_qty = v0.sides.short_qty + qty_of(arg3, arg4);
            if (arg4 > v0.sides.short_max_entry_wad) {
                v0.sides.short_max_entry_wad = arg4;
            };
        };
    }

    public fun arm_session_close<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut Market<T0>, arg2: u128, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = SessionCloseV1{
            armed                 : arg6 > 0,
            snapshot_price_wad    : arg2,
            snapshot_ts_ms        : arg3,
            snapshot_seq          : arg4,
            position_id_watermark : arg5,
            remaining             : arg6,
            closed_count          : 0,
        };
        let v1 = &mut state_mut<T0>(arg1).extra_fields;
        let v2 = SessionCloseKey{dummy_field: false};
        if (0x2::bag::contains<SessionCloseKey>(v1, v2)) {
            let v3 = SessionCloseKey{dummy_field: false};
            *0x2::bag::borrow_mut<SessionCloseKey, SessionCloseV1>(v1, v3) = v0;
        } else {
            let v4 = SessionCloseKey{dummy_field: false};
            0x2::bag::add<SessionCloseKey, SessionCloseV1>(v1, v4, v0);
        };
    }

    fun assert_depth(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 > 0, 13835626021757648901);
        assert!(arg1 >= 1 && arg1 <= 100, 13835626026052616197);
        assert!(arg2 >= 1 && arg2 <= 100, 13835626030347583493);
    }

    public fun assert_exchange<T0>(arg0: &Market<T0>, arg1: 0x2::object::ID) {
        assert!(state<T0>(arg0).exchange_id == arg1, 13837032438864150543);
    }

    fun assert_impact(arg0: &vector<u8>, arg1: u128, arg2: u128, arg3: u64) {
        let v0 = if (arg2 > 0) {
            if (arg1 > 0) {
                arg3 >= 1
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13835626047527452677);
        if (is_sui(arg0)) {
            let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::position::c_wad(arg1, arg2);
            assert!(v1 >= 400000000000000 && v1 <= 1000000000000000, 13835626060412354565);
        };
    }

    fun assert_leverage(arg0: &vector<u8>, arg1: u64) {
        assert!(arg1 >= 1 && arg1 <= 10000, 13835626004577779717);
    }

    fun assert_mutable<T0>(arg0: &mut Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>) {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg1);
        assert!(arg0.version == 1, 13835062882825404417);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg1), arg2);
    }

    public fun bust_buffer_wad(arg0: &RiskParamsV1) : u128 {
        arg0.bust_buffer_wad
    }

    public(friend) fun c_den(arg0: &ImpactParamsV1) : u128 {
        arg0.c_den
    }

    public(friend) fun c_num(arg0: &ImpactParamsV1) : u128 {
        arg0.c_num
    }

    public fun cancel_delay_ms(arg0: &OrderParamsV1) : u64 {
        arg0.cancel_delay_ms
    }

    fun ceil_div_u256(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0) {
            0
        } else {
            (arg0 + arg1 - 1) / arg1
        }
    }

    public fun charge_notional<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut Market<T0>, arg2: u64, arg3: u64, arg4: vector<u8>) : (bool, bool) {
        let v0 = state<T0>(arg1).risk;
        let v1 = &mut state_mut<T0>(arg1).window;
        if (v1.checkpoint_ts_ms != arg3) {
            v1.checkpoint_ts_ms = arg3;
            v1.checkpoint_notional = 0;
            v1.last_tx_digest = arg4;
            v1.tx_notional = 0;
        } else if (v1.last_tx_digest != arg4) {
            v1.last_tx_digest = arg4;
            v1.tx_notional = 0;
        };
        let v2 = v1.tx_notional + arg2 <= v0.max_tx_notional;
        let v3 = v1.checkpoint_notional + arg2 <= v0.max_block_notional;
        if (v2 && v3) {
            v1.tx_notional = v1.tx_notional + arg2;
            v1.checkpoint_notional = v1.checkpoint_notional + arg2;
        };
        (v2, v3)
    }

    public fun close_fee_ppm(arg0: &ImpactParamsV1) : u64 {
        arg0.close_fee_ppm
    }

    public fun closed_seen_ts_ms<T0>(arg0: &Market<T0>) : u64 {
        state<T0>(arg0).track.closed_seen_ts_ms
    }

    public fun closes_paused<T0>(arg0: &Market<T0>) : bool {
        state<T0>(arg0).flags.closes_paused
    }

    public fun create_registry(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : MarketRegistry {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg0), arg1);
        let v0 = 1;
        let v1 = MarketRegistry{
            id      : 0x2::object::new(arg2),
            version : v0,
        };
        let v2 = RegistryStateV1{
            id         : 0x2::object::new(arg2),
            market_ids : 0x1::vector::empty<0x2::object::ID>(),
        };
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::extended_field::add<RegistryStateV1>(&mut v1.id, v0, v2);
        v1
    }

    public(friend) fun deadband_div(arg0: &ImpactParamsV1) : u64 {
        arg0.deadband_div
    }

    public fun deadband_ppm(arg0: &ImpactParamsV1) : u64 {
        arg0.deadband_ppm
    }

    fun deadline_within_max_age(arg0: u8, arg1: u64, arg2: u64) : bool {
        arg0 != 1 || arg1 <= arg2
    }

    public fun default_order_params() : OrderParamsV1 {
        OrderParamsV1{
            fill_window_ms      : 1000,
            fill_deadline_ms    : 5000,
            cancel_delay_ms     : 5000,
            emergency_after_ms  : 30000,
            exec_fee            : 50000,
            one_step_spread_bps : 5,
        }
    }

    public fun effective_depth(arg0: &ImpactParamsV1) : u64 {
        arg0.effective_depth
    }

    public fun emergency_after_ms(arg0: &OrderParamsV1) : u64 {
        arg0.emergency_after_ms
    }

    public fun emergency_retire<T0>(arg0: &mut Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>) {
        assert_mutable<T0>(arg0, arg1, arg2);
        let v0 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        set_status<T0>(&v0, arg0, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::constants::status_retired(), 0x1::option::none<u128>());
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v1, 0x2::object::id<Market<T0>>(arg0), 11);
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_value(&v2, 0x2::object::id<Market<T0>>(arg0), 11, (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::constants::status_retired() as u64));
    }

    public fun enabled<T0>(arg0: &Market<T0>) : bool {
        state<T0>(arg0).flags.enabled
    }

    public fun exchange_id<T0>(arg0: &Market<T0>) : 0x2::object::ID {
        state<T0>(arg0).exchange_id
    }

    public fun exec_fee(arg0: &OrderParamsV1) : u64 {
        arg0.exec_fee
    }

    public fun feed_info_id(arg0: &OracleParamsV1) : 0x2::object::ID {
        arg0.feed_info_id
    }

    public fun fill_deadline_ms(arg0: &OrderParamsV1) : u64 {
        arg0.fill_deadline_ms
    }

    public fun fill_window_ms(arg0: &OrderParamsV1) : u64 {
        arg0.fill_window_ms
    }

    public fun has_oi<T0>(arg0: &Market<T0>) : bool {
        let v0 = state<T0>(arg0);
        v0.sides.long_oi > 0 || v0.sides.short_oi > 0
    }

    public fun hours_mode<T0>(arg0: &Market<T0>) : u8 {
        state<T0>(arg0).hours_mode
    }

    public fun impact<T0>(arg0: &Market<T0>) : ImpactParamsV1 {
        state<T0>(arg0).impact
    }

    fun is_sui(arg0: &vector<u8>) : bool {
        let v0 = b"SUI";
        arg0 == &v0
    }

    fun kind_of_symbol(arg0: &vector<u8>) : u8 {
        let v0 = b"BTC";
        if (arg0 == &v0) {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::constants::kind_btc()
        } else if (is_sui(arg0)) {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::constants::kind_sui()
        } else {
            let v2 = b"ETH";
            if (arg0 == &v2) {
                0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::constants::kind_eth()
            } else {
                0
            }
        }
    }

    public fun last_mark_wad<T0>(arg0: &Market<T0>) : u128 {
        state<T0>(arg0).track.last_mark_wad
    }

    public fun last_oracle_sequence<T0>(arg0: &Market<T0>) : u64 {
        state<T0>(arg0).track.last_oracle_sequence
    }

    public fun last_oracle_slot<T0>(arg0: &Market<T0>) : u64 {
        state<T0>(arg0).track.last_oracle_slot
    }

    public fun last_oracle_ts_ms<T0>(arg0: &Market<T0>) : u64 {
        state<T0>(arg0).track.last_oracle_ts_ms
    }

    public fun lazer_feed_id(arg0: &OracleParamsV1) : u32 {
        arg0.lazer_feed_id
    }

    public fun liq<T0>(arg0: &Market<T0>) : &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::LiqBook {
        &state<T0>(arg0).liq
    }

    public fun liq_bounty_bps(arg0: &RiskParamsV1) : u64 {
        arg0.liq_bounty_bps
    }

    public fun liq_mut<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut Market<T0>) : &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::LiqBook {
        &mut state_mut<T0>(arg1).liq
    }

    public fun listing(arg0: vector<u8>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u32, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u128, arg20: u128, arg21: u64, arg22: u128, arg23: u128, arg24: u64, arg25: u64, arg26: u64, arg27: u64, arg28: u8) : Listing {
        let v0 = OracleParamsV1{
            storage_id       : arg1,
            source_id        : 1,
            feed_info_id     : arg2,
            lazer_feed_id    : arg3,
            max_age_ms       : arg4,
            max_conf_age_ms  : arg5,
            max_future_ms    : arg6,
            max_twap_dev_bps : arg7,
            min_spread_bps   : arg8,
        };
        let v1 = RiskParamsV1{
            min_leverage          : arg27,
            max_leverage          : arg9,
            bust_buffer_wad       : arg10,
            min_margin            : arg11,
            min_notional          : arg12,
            max_position_notional : arg13,
            max_tx_notional       : arg14,
            max_block_notional    : arg15,
            max_account_notional  : arg16,
            oi_cap_lp_ratio_bps   : arg17,
            liq_bounty_bps        : arg18,
        };
        let v2 = ImpactParamsV1{
            c_num              : arg19,
            c_den              : arg20,
            deadband_div       : arg21,
            reference_notional : 100000,
            p_num              : arg22,
            p_den              : arg23,
            effective_depth    : arg24,
            deadband_ppm       : 20,
            close_fee_ppm      : 40,
        };
        Listing{
            symbol        : arg0,
            oracle        : v0,
            risk          : v1,
            impact        : v2,
            min_hold_ms   : arg25,
            taker_fee_bps : arg26,
            hours_mode    : arg28,
        }
    }

    public fun long_locked_exposure<T0>(arg0: &Market<T0>) : u64 {
        state<T0>(arg0).sides.long_locked_exposure
    }

    public fun long_min_entry_wad<T0>(arg0: &Market<T0>) : u128 {
        state<T0>(arg0).sides.long_min_entry_wad
    }

    public fun long_oi<T0>(arg0: &Market<T0>) : u64 {
        state<T0>(arg0).sides.long_oi
    }

    public fun max_account_notional(arg0: &RiskParamsV1) : u64 {
        arg0.max_account_notional
    }

    public fun max_age_ms(arg0: &OracleParamsV1) : u64 {
        arg0.max_age_ms
    }

    public(friend) fun max_block_notional(arg0: &RiskParamsV1) : u64 {
        arg0.max_block_notional
    }

    public fun max_conf_age_ms(arg0: &OracleParamsV1) : u64 {
        arg0.max_conf_age_ms
    }

    public fun max_future_ms(arg0: &OracleParamsV1) : u64 {
        arg0.max_future_ms
    }

    public fun max_leverage(arg0: &RiskParamsV1) : u64 {
        arg0.max_leverage
    }

    public fun max_long_exposure<T0>(arg0: &Market<T0>) : u64 {
        state<T0>(arg0).caps.max_long_exposure
    }

    public fun max_long_oi<T0>(arg0: &Market<T0>) : u64 {
        state<T0>(arg0).caps.max_long_oi
    }

    public fun max_position_notional(arg0: &RiskParamsV1) : u64 {
        arg0.max_position_notional
    }

    public fun max_short_exposure<T0>(arg0: &Market<T0>) : u64 {
        state<T0>(arg0).caps.max_short_exposure
    }

    public fun max_short_oi<T0>(arg0: &Market<T0>) : u64 {
        state<T0>(arg0).caps.max_short_oi
    }

    public fun max_twap_dev_bps(arg0: &OracleParamsV1) : u64 {
        arg0.max_twap_dev_bps
    }

    public fun max_tx_notional(arg0: &RiskParamsV1) : u64 {
        arg0.max_tx_notional
    }

    public fun min_hold_ms(arg0: &TimingParamsV1) : u64 {
        arg0.min_hold_ms
    }

    public fun min_leverage(arg0: &RiskParamsV1) : u64 {
        arg0.min_leverage
    }

    public fun min_margin(arg0: &RiskParamsV1) : u64 {
        arg0.min_margin
    }

    public fun min_notional(arg0: &RiskParamsV1) : u64 {
        arg0.min_notional
    }

    public fun min_spread_bps(arg0: &OracleParamsV1) : u64 {
        arg0.min_spread_bps
    }

    public fun new_order_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : OrderParamsV1 {
        OrderParamsV1{
            fill_window_ms      : arg0,
            fill_deadline_ms    : arg1,
            cancel_delay_ms     : arg2,
            emergency_after_ms  : arg3,
            exec_fee            : arg4,
            one_step_spread_bps : arg5,
        }
    }

    public fun note_session_closed<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut Market<T0>, arg2: u64) {
        state_mut<T0>(arg1).track.closed_seen_ts_ms = arg2;
    }

    public fun note_session_force_closed<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut Market<T0>) : bool {
        let v0 = SessionCloseKey{dummy_field: false};
        let v1 = 0x2::bag::borrow_mut<SessionCloseKey, SessionCloseV1>(&mut state_mut<T0>(arg1).extra_fields, v0);
        let (v2, v3) = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::session_drain_next(v1.remaining);
        v1.remaining = v2;
        v1.closed_count = v1.closed_count + 1;
        if (!v3) {
            v1.armed = false;
            true
        } else {
            false
        }
    }

    public(friend) fun oi_cap_lp_ratio_bps(arg0: &RiskParamsV1) : u64 {
        arg0.oi_cap_lp_ratio_bps
    }

    public fun one_step_spread_bps(arg0: &OrderParamsV1) : u64 {
        arg0.one_step_spread_bps
    }

    public fun opens_paused<T0>(arg0: &Market<T0>) : bool {
        state<T0>(arg0).flags.opens_paused
    }

    public fun oracle<T0>(arg0: &Market<T0>) : OracleParamsV1 {
        state<T0>(arg0).oracle
    }

    public fun oracle_killed<T0>(arg0: &Market<T0>) : bool {
        state<T0>(arg0).flags.oracle_killed
    }

    public fun order_params<T0>(arg0: &Market<T0>) : OrderParamsV1 {
        state<T0>(arg0).order
    }

    public fun order_params_valid(arg0: &OrderParamsV1) : bool {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::order_params_ok(arg0.fill_window_ms, arg0.fill_deadline_ms, arg0.cancel_delay_ms, arg0.emergency_after_ms, arg0.exec_fee, arg0.one_step_spread_bps, 50)
    }

    public fun qty_of(arg0: u64, arg1: u128) : u128 {
        (((arg0 as u256) * 1000000000000000000 / (arg1 as u256)) as u128)
    }

    fun register_inner<T0>(arg0: &mut MarketRegistry, arg1: 0x2::object::ID, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg4: Listing, arg5: &mut 0x2::tx_context::TxContext) : Market<T0> {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg2), arg3);
        assert!(arg0.version == 1, 13835059661599932417);
        let Listing {
            symbol        : v0,
            oracle        : v1,
            risk          : v2,
            impact        : v3,
            min_hold_ms   : v4,
            taker_fee_bps : v5,
            hours_mode    : v6,
        } = arg4;
        let v7 = v3;
        let v8 = v2;
        let v9 = v1;
        let v10 = v0;
        validate_listing(&v10, &v9, &v8, &v7, v4, v5, v6);
        let v11 = kind_of_symbol(&v10);
        let v12 = 1;
        let v13 = Market<T0>{
            id      : 0x2::object::new(arg5),
            version : v12,
        };
        let v14 = TimingParamsV1{min_hold_ms: v4};
        let v15 = if (v11 == 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::constants::kind_btc() || v11 == 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::constants::kind_eth()) {
            100
        } else {
            150
        };
        let v16 = MarketFlagsV1{
            enabled       : true,
            opens_paused  : false,
            closes_paused : false,
            oracle_killed : false,
            configured    : true,
            shared        : false,
        };
        let v17 = SideBookV1{
            long_oi               : 0,
            short_oi              : 0,
            long_locked_exposure  : 0,
            short_locked_exposure : 0,
            long_qty              : 0,
            short_qty             : 0,
            long_min_entry_wad    : 0,
            short_max_entry_wad   : 0,
        };
        let v18 = OracleTrackV1{
            last_mark_wad        : 0,
            closed_seen_ts_ms    : 0,
            last_oracle_ts_ms    : 0,
            last_oracle_sequence : 0,
            last_oracle_slot     : 0,
        };
        let v19 = NotionalWindowV1{
            checkpoint_ts_ms    : 0,
            checkpoint_notional : 0,
            last_tx_digest      : b"",
            tx_notional         : 0,
        };
        let v20 = SideCapsV1{
            max_long_exposure  : 10000000000000,
            max_short_exposure : 10000000000000,
            max_long_oi        : 1000000000000000,
            max_short_oi       : 1000000000000000,
            stress_bps         : v15,
        };
        let v21 = MarketStateV1<T0>{
            id                : 0x2::object::new(arg5),
            exchange_id       : arg1,
            symbol            : v10,
            kind              : v11,
            taker_fee_bps     : v5,
            win_fee_bps       : 200,
            flags             : v16,
            oracle            : v9,
            risk              : v8,
            impact            : v7,
            timing            : v14,
            sides             : v17,
            status            : 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::constants::status_active(),
            hours_mode        : v6,
            track             : v18,
            window            : v19,
            settlement_px_wad : 0x1::option::none<u128>(),
            caps              : v20,
            snap_upnl         : 0,
            snap_stress       : 0,
            liq               : 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::liq_book::new(arg5),
            order             : default_order_params(),
            extra_fields      : 0x2::bag::new(arg5),
        };
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::extended_field::add<MarketStateV1<T0>>(&mut v13.id, v12, v21);
        let v22 = 0x2::object::id<Market<T0>>(&v13);
        0x1::vector::push_back<0x2::object::ID>(&mut registry_state_mut(arg0).market_ids, v22);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_create_market_event(v22, v11);
        v13
    }

    public fun register_market<T0>(arg0: &mut MarketRegistry, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg3: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg4: Listing, arg5: &mut 0x2::tx_context::TxContext) : Market<T0> {
        register_inner<T0>(arg0, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>>(arg1), arg2, arg3, arg4, arg5)
    }

    fun registry_state(arg0: &MarketRegistry) : &RegistryStateV1 {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::extended_field::borrow<RegistryStateV1>(&arg0.id, arg0.version)
    }

    fun registry_state_mut(arg0: &mut MarketRegistry) : &mut RegistryStateV1 {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::extended_field::borrow_mut<RegistryStateV1>(&mut arg0.id, arg0.version)
    }

    public fun reserve_at<T0>(arg0: &Market<T0>, arg1: u128, arg2: u64) : (u64, u64) {
        let v0 = state<T0>(arg0);
        let v1 = (arg1 as u256);
        let v2 = (v0.sides.long_min_entry_wad as u256);
        let v3 = (v0.sides.short_max_entry_wad as u256);
        let v4 = if (v2 > 0 && v1 > v2) {
            ceil_div_u256((v0.sides.long_locked_exposure as u256) * (v1 - v2), v2)
        } else {
            0
        };
        let v5 = if (v3 > 0 && v3 > v1) {
            ceil_div_u256((v0.sides.short_locked_exposure as u256) * (v3 - v1), v3)
        } else {
            0
        };
        let v6 = v4 + v5;
        let v7 = if (v6 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v6 as u64)
        };
        let v8 = if (v0.sides.long_oi > v0.sides.short_oi) {
            v0.sides.long_oi
        } else {
            v0.sides.short_oi
        };
        (v7, (((v8 as u256) * (v0.caps.stress_bps as u256) * (arg2 as u256) / 100000000) as u64))
    }

    public fun risk<T0>(arg0: &Market<T0>) : RiskParamsV1 {
        state<T0>(arg0).risk
    }

    public fun sc_armed(arg0: &SessionCloseV1) : bool {
        arg0.armed
    }

    public fun sc_closed_count(arg0: &SessionCloseV1) : u64 {
        arg0.closed_count
    }

    public fun sc_price_wad(arg0: &SessionCloseV1) : u128 {
        arg0.snapshot_price_wad
    }

    public fun sc_remaining(arg0: &SessionCloseV1) : u64 {
        arg0.remaining
    }

    public fun sc_ts_ms(arg0: &SessionCloseV1) : u64 {
        arg0.snapshot_ts_ms
    }

    public fun sc_watermark(arg0: &SessionCloseV1) : u64 {
        arg0.position_id_watermark
    }

    public fun session_close<T0>(arg0: &Market<T0>) : 0x1::option::Option<SessionCloseV1> {
        let v0 = &state<T0>(arg0).extra_fields;
        let v1 = SessionCloseKey{dummy_field: false};
        if (0x2::bag::contains<SessionCloseKey>(v0, v1)) {
            let v3 = SessionCloseKey{dummy_field: false};
            0x1::option::some<SessionCloseV1>(*0x2::bag::borrow<SessionCloseKey, SessionCloseV1>(v0, v3))
        } else {
            0x1::option::none<SessionCloseV1>()
        }
    }

    public fun session_pending<T0>(arg0: &Market<T0>) : bool {
        let v0 = &state<T0>(arg0).extra_fields;
        let v1 = SessionCloseKey{dummy_field: false};
        if (!0x2::bag::contains<SessionCloseKey>(v0, v1)) {
            return false
        };
        let v2 = SessionCloseKey{dummy_field: false};
        let v3 = 0x2::bag::borrow<SessionCloseKey, SessionCloseV1>(v0, v2);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::session_pending(v3.armed, v3.remaining)
    }

    public fun set_closes_paused<T0>(arg0: &mut Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: bool) {
        assert_mutable<T0>(arg0, arg1, arg2);
        let v0 = state_mut<T0>(arg0);
        v0.flags.closes_paused = arg3;
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v1, 0x2::object::id<Market<T0>>(arg0), 9);
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        let v3 = if (arg3) {
            1
        } else {
            0
        };
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_value(&v2, 0x2::object::id<Market<T0>>(arg0), 9, v3);
    }

    public fun set_depth<T0>(arg0: &mut Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: u64, arg4: u64, arg5: u64) {
        assert_mutable<T0>(arg0, arg1, arg2);
        assert_depth(arg3, arg4, arg5);
        let v0 = state_mut<T0>(arg0);
        v0.impact.effective_depth = arg3;
        v0.impact.deadband_ppm = arg4;
        v0.impact.close_fee_ppm = arg5;
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_update_market_params_event(0x2::object::id<Market<T0>>(arg0));
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v1, 0x2::object::id<Market<T0>>(arg0), 19);
    }

    public fun set_enabled<T0>(arg0: &mut Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: bool) {
        assert_mutable<T0>(arg0, arg1, arg2);
        let v0 = state_mut<T0>(arg0);
        v0.flags.enabled = arg3;
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v1, 0x2::object::id<Market<T0>>(arg0), 7);
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        let v3 = if (arg3) {
            1
        } else {
            0
        };
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_value(&v2, 0x2::object::id<Market<T0>>(arg0), 7, v3);
    }

    public fun set_impact_params<T0>(arg0: &mut Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: u128, arg4: u128, arg5: u64, arg6: u128, arg7: u128) {
        assert_mutable<T0>(arg0, arg1, arg2);
        assert_impact(&state<T0>(arg0).symbol, arg3, arg4, arg5);
        assert!(arg7 > 0, 13835623771194785797);
        let v0 = state_mut<T0>(arg0);
        v0.impact.c_num = arg3;
        v0.impact.c_den = arg4;
        v0.impact.deadband_div = arg5;
        v0.impact.p_num = arg6;
        v0.impact.p_den = arg7;
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_update_market_params_event(0x2::object::id<Market<T0>>(arg0));
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v1, 0x2::object::id<Market<T0>>(arg0), 17);
    }

    public fun set_min_hold<T0>(arg0: &mut Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: u64) {
        assert_mutable<T0>(arg0, arg1, arg2);
        assert!(arg3 >= 1 && arg3 <= 120000, 13835623930108575749);
        let v0 = state_mut<T0>(arg0);
        v0.timing.min_hold_ms = arg3;
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_update_market_params_event(0x2::object::id<Market<T0>>(arg0));
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v1, 0x2::object::id<Market<T0>>(arg0), 18);
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_value(&v2, 0x2::object::id<Market<T0>>(arg0), 18, arg3);
    }

    public fun set_min_leverage<T0>(arg0: &mut Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: u64) {
        assert_mutable<T0>(arg0, arg1, arg2);
        assert!(arg3 >= 1 && arg3 < state<T0>(arg0).risk.max_leverage, 13835623681000472581);
        let v0 = state_mut<T0>(arg0);
        v0.risk.min_leverage = arg3;
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_update_market_params_event(0x2::object::id<Market<T0>>(arg0));
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v1, 0x2::object::id<Market<T0>>(arg0), 38);
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_value(&v2, 0x2::object::id<Market<T0>>(arg0), 38, arg3);
    }

    public fun set_oi_caps<T0>(arg0: &mut Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: u64, arg4: u64) {
        assert_mutable<T0>(arg0, arg1, arg2);
        let v0 = 10000000000000000;
        assert!(arg3 >= 1 && arg4 >= 1, 13835624686022819845);
        assert!(arg3 <= v0 && arg4 <= v0, 13835624690317787141);
        let v1 = state_mut<T0>(arg0);
        v1.caps.max_long_oi = arg3;
        v1.caps.max_short_oi = arg4;
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_update_market_params_event(0x2::object::id<Market<T0>>(arg0));
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v2, 0x2::object::id<Market<T0>>(arg0), 75);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_oi_caps_event(0x2::object::id<Market<T0>>(arg0), arg3, arg4);
    }

    public fun set_opens_paused<T0>(arg0: &mut Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: bool) {
        assert_mutable<T0>(arg0, arg1, arg2);
        let v0 = state_mut<T0>(arg0);
        v0.flags.opens_paused = arg3;
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v1, 0x2::object::id<Market<T0>>(arg0), 8);
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        let v3 = if (arg3) {
            1
        } else {
            0
        };
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_value(&v2, 0x2::object::id<Market<T0>>(arg0), 8, v3);
    }

    public fun set_oracle_killed<T0>(arg0: &mut Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: bool) {
        assert_mutable<T0>(arg0, arg1, arg2);
        let v0 = state_mut<T0>(arg0);
        v0.flags.oracle_killed = arg3;
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v1, 0x2::object::id<Market<T0>>(arg0), 10);
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        let v3 = if (arg3) {
            1
        } else {
            0
        };
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_value(&v2, 0x2::object::id<Market<T0>>(arg0), 10, v3);
    }

    public fun set_oracle_params<T0>(arg0: &mut Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u32, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) {
        assert_mutable<T0>(arg0, arg1, arg2);
        let v0 = if (0x2::object::id_to_address(&arg3) != @0x0) {
            if (0x2::object::id_to_address(&arg4) != @0x0) {
                arg5 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13835341849541345283);
        assert!(arg6 >= 1 && arg6 <= 10000, 13835623328813154309);
        assert!(arg7 >= 1 && arg7 <= 15000, 13835623333108121605);
        assert!(arg8 >= 1 && arg8 <= 6000, 13835623337403088901);
        assert!(arg10 >= 1 && arg10 <= 50, 13835623341698056197);
        let v1 = state<T0>(arg0);
        assert!(deadline_within_max_age(v1.hours_mode, v1.order.fill_deadline_ms, arg6), 13835623350287990789);
        let v2 = v1.oracle;
        let v3 = if (arg3 != v2.storage_id) {
            true
        } else if (arg4 != v2.feed_info_id) {
            true
        } else {
            arg5 != v2.lazer_feed_id
        };
        assert!(!v3 || v1.sides.long_oi == 0 && v1.sides.short_oi == 0, 13836749263080259597);
        let v4 = OracleParamsV1{
            storage_id       : arg3,
            source_id        : 1,
            feed_info_id     : arg4,
            lazer_feed_id    : arg5,
            max_age_ms       : arg6,
            max_conf_age_ms  : arg7,
            max_future_ms    : arg8,
            max_twap_dev_bps : arg9,
            min_spread_bps   : arg10,
        };
        let v5 = state_mut<T0>(arg0);
        v5.oracle = v4;
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_update_market_params_event(0x2::object::id<Market<T0>>(arg0));
        let v6 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v6, 0x2::object::id<Market<T0>>(arg0), 15);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_set_oracle_pins_event(0x2::object::id<Market<T0>>(arg0), arg3, arg4, arg5);
    }

    public fun set_order_params<T0>(arg0: &mut Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: OrderParamsV1) {
        assert_mutable<T0>(arg0, arg1, arg2);
        assert!(order_params_valid(&arg3), 13835622280841134085);
        let v0 = state<T0>(arg0);
        assert!(deadline_within_max_age(v0.hours_mode, arg3.fill_deadline_ms, v0.oracle.max_age_ms), 13835622289431068677);
        let v1 = state_mut<T0>(arg0);
        v1.order = arg3;
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_update_market_params_event(0x2::object::id<Market<T0>>(arg0));
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v2, 0x2::object::id<Market<T0>>(arg0), 81);
    }

    public fun set_risk_params<T0>(arg0: &mut Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: u64, arg4: u128, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64) {
        assert_mutable<T0>(arg0, arg1, arg2);
        assert_leverage(&state<T0>(arg0).symbol, arg3);
        let v0 = state<T0>(arg0).risk.min_leverage;
        assert!(arg3 > v0, 13835623522086682629);
        assert!(arg4 <= 1000000000000000, 13835623526381649925);
        assert!(arg5 > 0 && arg6 > 0, 13835623530676617221);
        assert!(arg7 >= arg6, 13835623534971584517);
        assert!(arg8 > 0 && arg9 >= arg8, 13835623539266551813);
        assert!(arg8 >= arg6, 13837312393422569489);
        assert!(arg10 >= arg6, 13835623547856486405);
        assert!(arg11 >= 1 && arg11 <= 10000, 13835623552151453701);
        assert!(arg12 <= 500, 13835623556446420997);
        let v1 = RiskParamsV1{
            min_leverage          : v0,
            max_leverage          : arg3,
            bust_buffer_wad       : arg4,
            min_margin            : arg5,
            min_notional          : arg6,
            max_position_notional : arg7,
            max_tx_notional       : arg8,
            max_block_notional    : arg9,
            max_account_notional  : arg10,
            oi_cap_lp_ratio_bps   : arg11,
            liq_bounty_bps        : arg12,
        };
        let v2 = state_mut<T0>(arg0);
        v2.risk = v1;
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_update_market_params_event(0x2::object::id<Market<T0>>(arg0));
        let v3 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v3, 0x2::object::id<Market<T0>>(arg0), 16);
    }

    public fun set_side_caps<T0>(arg0: &mut Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: u64, arg4: u64, arg5: u64) {
        assert_mutable<T0>(arg0, arg1, arg2);
        assert!(arg3 >= 1 && arg4 >= 1, 13835624574353670149);
        let v0 = 1000000000000000;
        assert!(arg3 <= v0 && arg4 <= v0, 13835624582943604741);
        assert!(arg5 >= 50 && arg5 <= 1000, 13835624587238572037);
        let v1 = state_mut<T0>(arg0);
        v1.caps.max_long_exposure = arg3;
        v1.caps.max_short_exposure = arg4;
        v1.caps.stress_bps = arg5;
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_update_market_params_event(0x2::object::id<Market<T0>>(arg0));
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v2, 0x2::object::id<Market<T0>>(arg0), 73);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_side_caps_event(0x2::object::id<Market<T0>>(arg0), arg3, arg4, arg5);
    }

    public fun set_status<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut Market<T0>, arg2: u8, arg3: 0x1::option::Option<u128>) {
        let v0 = 0x2::object::id<Market<T0>>(arg1);
        let v1 = state_mut<T0>(arg1);
        v1.status = arg2;
        if (0x1::option::is_some<u128>(&arg3)) {
            v1.settlement_px_wad = arg3;
        };
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_change_market_status_event(v0, arg2);
    }

    public fun set_taker_fee<T0>(arg0: &mut Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: u64) {
        assert_mutable<T0>(arg0, arg1, arg2);
        assert!(arg3 <= 2, 13835623990238117893);
        let v0 = state_mut<T0>(arg0);
        v0.taker_fee_bps = arg3;
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v1, 0x2::object::id<Market<T0>>(arg0), 5);
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_value(&v2, 0x2::object::id<Market<T0>>(arg0), 5, arg3);
    }

    public fun set_win_fee<T0>(arg0: &mut Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: u64) {
        assert_mutable<T0>(arg0, arg1, arg2);
        assert!(arg3 >= 1 && arg3 <= 500, 13835624046072692741);
        let v0 = state_mut<T0>(arg0);
        v0.win_fee_bps = arg3;
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v1, 0x2::object::id<Market<T0>>(arg0), 6);
        let v2 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_value(&v2, 0x2::object::id<Market<T0>>(arg0), 6, arg3);
    }

    public(friend) fun settlement_px_wad<T0>(arg0: &Market<T0>) : 0x1::option::Option<u128> {
        state<T0>(arg0).settlement_px_wad
    }

    public fun share_market<T0>(arg0: Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>) {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg1);
        assert!(arg0.version == 1, 13835061392471752705);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg1), arg2);
        let v0 = state<T0>(&arg0);
        assert!(!v0.flags.shared, 13835905830287179783);
        assert!(v0.timing.min_hold_ms >= 1, 13836187309558988809);
        assert!(v0.oracle.max_age_ms >= 1, 13836187313853956105);
        assert!(v0.risk.max_leverage >= 1, 13836187318148923401);
        assert!(v0.impact.c_den > 0, 13836187322443890697);
        let v1 = &mut arg0;
        state_mut<T0>(v1).flags.shared = true;
        let v2 = &mut arg0;
        state_mut<T0>(v2).flags.configured = true;
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_change_market_status_event(0x2::object::id<Market<T0>>(&arg0), 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::constants::status_active());
        0x2::transfer::share_object<Market<T0>>(arg0);
    }

    public fun share_registry(arg0: MarketRegistry) {
        0x2::transfer::share_object<MarketRegistry>(arg0);
    }

    public fun short_locked_exposure<T0>(arg0: &Market<T0>) : u64 {
        state<T0>(arg0).sides.short_locked_exposure
    }

    public fun short_max_entry_wad<T0>(arg0: &Market<T0>) : u128 {
        state<T0>(arg0).sides.short_max_entry_wad
    }

    public fun short_oi<T0>(arg0: &Market<T0>) : u64 {
        state<T0>(arg0).sides.short_oi
    }

    public fun snap_stress<T0>(arg0: &Market<T0>) : u64 {
        state<T0>(arg0).snap_stress
    }

    public fun snap_upnl<T0>(arg0: &Market<T0>) : u64 {
        state<T0>(arg0).snap_upnl
    }

    public fun source_id(arg0: &OracleParamsV1) : u64 {
        arg0.source_id
    }

    public fun stamp_oracle<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut Market<T0>, arg2: u128, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = state_mut<T0>(arg1);
        v0.track.last_mark_wad = arg2;
        v0.track.closed_seen_ts_ms = 0;
        v0.track.last_oracle_ts_ms = arg3;
        v0.track.last_oracle_sequence = arg4;
        v0.track.last_oracle_slot = arg5;
    }

    fun state<T0>(arg0: &Market<T0>) : &MarketStateV1<T0> {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::extended_field::borrow<MarketStateV1<T0>>(&arg0.id, arg0.version)
    }

    fun state_mut<T0>(arg0: &mut Market<T0>) : &mut MarketStateV1<T0> {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::extended_field::borrow_mut<MarketStateV1<T0>>(&mut arg0.id, arg0.version)
    }

    public fun status<T0>(arg0: &Market<T0>) : u8 {
        state<T0>(arg0).status
    }

    public fun storage_id(arg0: &OracleParamsV1) : 0x2::object::ID {
        arg0.storage_id
    }

    public fun stress_bps<T0>(arg0: &Market<T0>) : u64 {
        state<T0>(arg0).caps.stress_bps
    }

    public fun sub_locked<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut Market<T0>, arg2: bool, arg3: u64) {
        let v0 = state_mut<T0>(arg1);
        if (arg2) {
            v0.sides.long_locked_exposure = v0.sides.long_locked_exposure - arg3;
        } else {
            v0.sides.short_locked_exposure = v0.sides.short_locked_exposure - arg3;
        };
    }

    public fun sub_oi<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut Market<T0>, arg2: bool, arg3: u64) {
        let v0 = state_mut<T0>(arg1);
        if (arg2) {
            v0.sides.long_oi = v0.sides.long_oi - arg3;
        } else {
            v0.sides.short_oi = v0.sides.short_oi - arg3;
        };
    }

    public fun sub_qty<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut Market<T0>, arg2: bool, arg3: u64, arg4: u128) {
        let v0 = state_mut<T0>(arg1);
        if (arg2) {
            v0.sides.long_qty = v0.sides.long_qty - qty_of(arg3, arg4);
            if (v0.sides.long_oi == 0 && v0.sides.long_locked_exposure == 0) {
                v0.sides.long_min_entry_wad = 0;
            };
        } else {
            v0.sides.short_qty = v0.sides.short_qty - qty_of(arg3, arg4);
            if (v0.sides.short_oi == 0 && v0.sides.short_locked_exposure == 0) {
                v0.sides.short_max_entry_wad = 0;
            };
        };
    }

    public fun swap_snapshot<T0>(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut Market<T0>, arg2: u64, arg3: u64) : (u64, u64) {
        let v0 = state_mut<T0>(arg1);
        v0.snap_upnl = arg2;
        v0.snap_stress = arg3;
        (v0.snap_upnl, v0.snap_stress)
    }

    public(friend) fun symbol<T0>(arg0: &Market<T0>) : vector<u8> {
        state<T0>(arg0).symbol
    }

    public fun taker_fee_bps<T0>(arg0: &Market<T0>) : u64 {
        state<T0>(arg0).taker_fee_bps
    }

    public fun tighten_oi<T0>(arg0: &mut Market<T0>, arg1: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::MARKET_KEEPER>, arg3: u64, arg4: u64) {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg1);
        assert!(arg0.version == 1, 13835061525615738881);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_role<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::MARKET_KEEPER>(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg1), 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg1), arg2);
        let v0 = state_mut<T0>(arg0);
        assert!(arg3 >= 1 && arg3 <= v0.caps.max_long_oi, 13836468913384849419);
        assert!(arg4 >= 1 && arg4 <= v0.caps.max_short_oi, 13836468917679816715);
        v0.caps.max_long_oi = arg3;
        v0.caps.max_short_oi = arg4;
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::new();
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_admin_action(&v1, 0x2::object::id<Market<T0>>(arg0), 25);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::events::emit_oi_caps_event(0x2::object::id<Market<T0>>(arg0), arg3, arg4);
    }

    public fun timing<T0>(arg0: &Market<T0>) : TimingParamsV1 {
        state<T0>(arg0).timing
    }

    fun validate_listing(arg0: &vector<u8>, arg1: &OracleParamsV1, arg2: &RiskParamsV1, arg3: &ImpactParamsV1, arg4: u64, arg5: u64, arg6: u8) {
        assert!(!0x1::vector::is_empty<u8>(arg0), 13835625888613662725);
        assert!(arg6 == 0 || arg6 == 1, 13835625892908630021);
        assert!(0x2::object::id_to_address(&arg1.storage_id) != @0x0, 13835344422226755587);
        assert!(0x2::object::id_to_address(&arg1.feed_info_id) != @0x0, 13835344426521722883);
        assert!(arg1.lazer_feed_id > 0, 13835344430816690179);
        assert!(arg1.max_age_ms >= 1 && arg1.max_age_ms <= 10000, 13835625910088499205);
        assert!(arg1.max_conf_age_ms >= 1 && arg1.max_conf_age_ms <= 15000, 13835625914383466501);
        assert!(arg1.max_future_ms >= 1 && arg1.max_future_ms <= 6000, 13835625918678433797);
        assert!(arg1.min_spread_bps >= 1 && arg1.min_spread_bps <= 50, 13835625922973401093);
        let v0 = default_order_params();
        assert!(deadline_within_max_age(arg6, v0.fill_deadline_ms, arg1.max_age_ms), 13835625927268368389);
        assert_leverage(arg0, arg2.max_leverage);
        assert!(arg2.min_leverage >= 1 && arg2.min_leverage < arg2.max_leverage, 13835625935858302981);
        assert!(arg2.bust_buffer_wad <= 1000000000000000, 13835625940153270277);
        assert!(arg2.min_margin > 0 && arg2.min_notional > 0, 13835625944448237573);
        assert!(arg2.max_position_notional >= arg2.min_notional, 13835625948743204869);
        assert!(arg2.max_tx_notional > 0 && arg2.max_block_notional >= arg2.max_tx_notional, 13835625953038172165);
        assert!(arg2.max_tx_notional >= arg2.min_notional, 13837314807194189841);
        assert!(arg2.max_account_notional >= arg2.min_notional, 13835625961628106757);
        assert!(arg2.oi_cap_lp_ratio_bps >= 1 && arg2.oi_cap_lp_ratio_bps <= 10000, 13835625965923074053);
        assert!(arg2.liq_bounty_bps <= 500, 13835625970218041349);
        assert_impact(arg0, arg3.c_num, arg3.c_den, arg3.deadband_div);
        assert_depth(arg3.effective_depth, arg3.deadband_ppm, arg3.close_fee_ppm);
        assert!(arg4 >= 1 && arg4 <= 120000, 13835625983102943237);
        assert!(arg5 <= 2, 13835625987397910533);
    }

    public fun win_fee_bps<T0>(arg0: &Market<T0>) : u64 {
        state<T0>(arg0).win_fee_bps
    }

    // decompiled from Move bytecode v7
}

