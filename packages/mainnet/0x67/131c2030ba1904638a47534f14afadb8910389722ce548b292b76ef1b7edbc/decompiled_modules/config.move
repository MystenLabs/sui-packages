module 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        owner: address,
        enabled: bool,
        mm_enabled: bool,
        arb_enabled: bool,
        inner_spread_bps: u64,
        outer_spread_bps: u64,
        price_tolerance_bps: u64,
        vol_threshold_bps: u64,
        vol_spread_scale: u64,
        outer_tier_enabled: bool,
        inner_base_size: u64,
        outer_base_size: u64,
        min_order_size: u64,
        max_position_sui: u64,
        skew_weight: u64,
        rebalance_trigger_pct: u64,
        order_expiry_ms: u64,
        min_refresh_ms: u64,
        min_arb_gap_bps: u64,
        arb_size_factor: u64,
        max_arb_size: u64,
        arb_cooldown_ms: u64,
        deepbook_taker_fee: u64,
        deepbook_maker_rebate: u64,
        cetus_fee_rate: u64,
        max_gas_price: u64,
        min_sui_for_gas: u64,
        target_sui_for_gas: u64,
        max_price_tick: u64,
        min_price_tick: u64,
    }

    struct ConfigUpdateEvent has copy, drop {
        field: vector<u8>,
        old_value: u64,
        new_value: u64,
    }

    public fun abs_diff(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public fun arb_cooldown_ms(arg0: &GlobalConfig) : u64 {
        arg0.arb_cooldown_ms
    }

    public fun arb_size_factor(arg0: &GlobalConfig) : u64 {
        arg0.arb_size_factor
    }

    public fun bps_base() : u64 {
        10000
    }

    public fun calculate_spreads(arg0: &GlobalConfig, arg1: u64, arg2: u64) : (u64, u64) {
        let v0 = arg1 / 10000;
        let v1 = v0 * arg0.inner_spread_bps / 1000;
        let v2 = v1;
        let v3 = v0 * arg0.outer_spread_bps / 1000;
        let v4 = v3;
        if (arg2 > arg0.vol_threshold_bps) {
            let v5 = 10000 + arg0.vol_spread_scale * (arg2 - arg0.vol_threshold_bps);
            v2 = v1 * v5 / 10000;
            v4 = v3 * v5 / 10000;
        };
        (v2, v4)
    }

    public fun cetus_fee_rate(arg0: &GlobalConfig) : u64 {
        arg0.cetus_fee_rate
    }

    public fun create_config(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id                    : 0x2::object::new(arg1),
            owner                 : 0x2::tx_context::sender(arg1),
            enabled               : false,
            mm_enabled            : true,
            arb_enabled           : true,
            inner_spread_bps      : 15,
            outer_spread_bps      : 80,
            price_tolerance_bps   : 3,
            vol_threshold_bps     : 20,
            vol_spread_scale      : 5,
            outer_tier_enabled    : false,
            inner_base_size       : 50000000000,
            outer_base_size       : 200000000000,
            min_order_size        : 1000000000,
            max_position_sui      : 500000000000,
            skew_weight           : 500,
            rebalance_trigger_pct : 85,
            order_expiry_ms       : 60000,
            min_refresh_ms        : 0,
            min_arb_gap_bps       : 8,
            arb_size_factor       : 1000,
            max_arb_size          : 100000000000,
            arb_cooldown_ms       : 500,
            deepbook_taker_fee    : 1000,
            deepbook_maker_rebate : 50,
            cetus_fee_rate        : 3330,
            max_gas_price         : 3000,
            min_sui_for_gas       : 500000000,
            target_sui_for_gas    : 2000000000,
            max_price_tick        : 100000000,
            min_price_tick        : 1000,
        };
        0x2::transfer::share_object<GlobalConfig>(v0);
    }

    public fun deepbook_maker_rebate(arg0: &GlobalConfig) : u64 {
        arg0.deepbook_maker_rebate
    }

    public fun deepbook_taker_fee(arg0: &GlobalConfig) : u64 {
        arg0.deepbook_taker_fee
    }

    public fun fee_base() : u64 {
        1000000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun inner_base_size(arg0: &GlobalConfig) : u64 {
        arg0.inner_base_size
    }

    public fun inner_spread_bps(arg0: &GlobalConfig) : u64 {
        arg0.inner_spread_bps
    }

    public fun is_arb_enabled(arg0: &GlobalConfig) : bool {
        arg0.enabled && arg0.arb_enabled
    }

    public fun is_enabled(arg0: &GlobalConfig) : bool {
        arg0.enabled
    }

    public fun is_mm_enabled(arg0: &GlobalConfig) : bool {
        arg0.enabled && arg0.mm_enabled
    }

    public fun max_arb_size(arg0: &GlobalConfig) : u64 {
        arg0.max_arb_size
    }

    public fun max_gas_price(arg0: &GlobalConfig) : u64 {
        arg0.max_gas_price
    }

    public fun max_position_sui(arg0: &GlobalConfig) : u64 {
        arg0.max_position_sui
    }

    public fun max_price_tick(arg0: &GlobalConfig) : u64 {
        arg0.max_price_tick
    }

    public fun min_arb_gap_bps(arg0: &GlobalConfig) : u64 {
        arg0.min_arb_gap_bps
    }

    public fun min_order_size(arg0: &GlobalConfig) : u64 {
        arg0.min_order_size
    }

    public fun min_price_tick(arg0: &GlobalConfig) : u64 {
        arg0.min_price_tick
    }

    public fun min_refresh_ms(arg0: &GlobalConfig) : u64 {
        arg0.min_refresh_ms
    }

    public fun min_sui_for_gas(arg0: &GlobalConfig) : u64 {
        arg0.min_sui_for_gas
    }

    public fun order_expiry_ms(arg0: &GlobalConfig) : u64 {
        arg0.order_expiry_ms
    }

    public fun outer_base_size(arg0: &GlobalConfig) : u64 {
        arg0.outer_base_size
    }

    public fun outer_spread_bps(arg0: &GlobalConfig) : u64 {
        arg0.outer_spread_bps
    }

    public fun outer_tier_enabled(arg0: &GlobalConfig) : bool {
        arg0.outer_tier_enabled
    }

    public fun owner(arg0: &GlobalConfig) : address {
        arg0.owner
    }

    public fun price_tolerance_bps(arg0: &GlobalConfig) : u64 {
        arg0.price_tolerance_bps
    }

    public fun rebalance_trigger_pct(arg0: &GlobalConfig) : u64 {
        arg0.rebalance_trigger_pct
    }

    public fun set_arb_cooldown_ms(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.arb_cooldown_ms = arg2;
    }

    public fun set_arb_enabled(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: bool) {
        arg1.arb_enabled = arg2;
    }

    public fun set_cetus_fee_rate(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.cetus_fee_rate = arg2;
    }

    public fun set_enabled(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: bool) {
        arg1.enabled = arg2;
    }

    public fun set_inner_base_size(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        assert!(arg2 > 0, 3);
        arg1.inner_base_size = arg2;
    }

    public fun set_inner_spread_bps(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        assert!(arg2 > 0 && arg2 < 1000, 2);
        arg1.inner_spread_bps = arg2;
        let v0 = ConfigUpdateEvent{
            field     : b"inner_spread_bps",
            old_value : arg1.inner_spread_bps,
            new_value : arg2,
        };
        0x2::event::emit<ConfigUpdateEvent>(v0);
    }

    public fun set_max_arb_size(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.max_arb_size = arg2;
    }

    public fun set_max_gas_price(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.max_gas_price = arg2;
    }

    public fun set_max_position_sui(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.max_position_sui = arg2;
    }

    public fun set_max_price_tick(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.max_price_tick = arg2;
    }

    public fun set_min_arb_gap_bps(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.min_arb_gap_bps = arg2;
    }

    public fun set_min_price_tick(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.min_price_tick = arg2;
    }

    public fun set_mm_enabled(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: bool) {
        arg1.mm_enabled = arg2;
    }

    public fun set_order_expiry_ms(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.order_expiry_ms = arg2;
    }

    public fun set_outer_base_size(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        assert!(arg2 > 0, 3);
        arg1.outer_base_size = arg2;
    }

    public fun set_outer_spread_bps(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        assert!(arg2 > 0 && arg2 < 2000, 2);
        arg1.outer_spread_bps = arg2;
        let v0 = ConfigUpdateEvent{
            field     : b"outer_spread_bps",
            old_value : arg1.outer_spread_bps,
            new_value : arg2,
        };
        0x2::event::emit<ConfigUpdateEvent>(v0);
    }

    public fun set_outer_tier_enabled(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: bool) {
        arg1.outer_tier_enabled = arg2;
    }

    public fun set_price_tolerance_bps(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.price_tolerance_bps = arg2;
    }

    public fun set_skew_weight(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        assert!(arg2 <= 1000, 3);
        arg1.skew_weight = arg2;
    }

    public fun set_vol_spread_scale(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.vol_spread_scale = arg2;
    }

    public fun set_vol_threshold_bps(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.vol_threshold_bps = arg2;
    }

    public fun size_factor_base() : u64 {
        1000
    }

    public fun skew_weight(arg0: &GlobalConfig) : u64 {
        arg0.skew_weight
    }

    public fun target_sui_for_gas(arg0: &GlobalConfig) : u64 {
        arg0.target_sui_for_gas
    }

    public fun verify_owner(arg0: &GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 1);
    }

    public fun vol_spread_scale(arg0: &GlobalConfig) : u64 {
        arg0.vol_spread_scale
    }

    public fun vol_threshold_bps(arg0: &GlobalConfig) : u64 {
        arg0.vol_threshold_bps
    }

    // decompiled from Move bytecode v6
}

