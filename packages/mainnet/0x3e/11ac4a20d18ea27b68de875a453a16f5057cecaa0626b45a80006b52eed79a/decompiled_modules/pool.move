module 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool {
    struct BasePoolLiquidityCoin<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct QuotePoolLiquidityCoin<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct OracleConfig has store {
        base_feed_id_pro: u32,
        quote_feed_id_pro: u32,
        base_feed_id_core: vector<u8>,
        quote_feed_id_core: vector<u8>,
        base_max_age_ms: u64,
        quote_max_age_ms: u64,
        base_core_max_age_sec: u64,
        quote_core_max_age_sec: u64,
    }

    struct DeviationConfig has store {
        max_bid_deviation_bps: u64,
        max_ask_deviation_bps: u64,
    }

    struct StaleConfig has store {
        widen_gap_ms: u64,
        one_way_gap_ms: u64,
        pause_gap_ms: u64,
    }

    struct PenaltyConfig has store {
        bid_penalty_bps: u64,
        ask_penalty_bps: u64,
        bid_tail_penalty_bps: u64,
        ask_tail_penalty_bps: u64,
    }

    struct InventoryConfig has store {
        target_base_ratio_bps: u64,
        warn_ratio_bps: u64,
        critical_ratio_bps: u64,
        block_ratio_bps: u64,
        warn_penalty_bps: u64,
        critical_penalty_bps: u64,
    }

    struct TimeSlippageKey has copy, drop, store {
        dummy_field: bool,
    }

    struct TimeSlippageConfig has copy, drop, store {
        penalty_bps: u64,
        period_ms: u64,
    }

    struct PermissionFlags has store {
        trade_allowed: bool,
        deposit_base_allowed: bool,
        deposit_quote_allowed: bool,
        withdraw_allowed: bool,
        closed: bool,
    }

    struct PoolState<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        version: u64,
        maintainer: address,
        regime_id: 0x2::object::ID,
        base_coin_decimals: u8,
        quote_coin_decimals: u8,
        oracle: OracleConfig,
        deviation: DeviationConfig,
        stale: StaleConfig,
        penalty: PenaltyConfig,
        max_public_trade_usd_notional: u64,
        max_regime_bucket_count: u8,
        inventory: InventoryConfig,
        permissions: PermissionFlags,
        local_state_seq: u64,
        trade_num: u64,
        base_coin: 0x2::balance::Balance<T0>,
        quote_coin: 0x2::balance::Balance<T1>,
        base_capital_supply: 0x2::balance::Supply<BasePoolLiquidityCoin<T0, T1>>,
        quote_capital_supply: 0x2::balance::Supply<QuotePoolLiquidityCoin<T0, T1>>,
    }

    struct RegimeState has key {
        id: 0x2::object::UID,
        regime_version: u64,
        last_update_ts_ms: u64,
        bucket_count: u8,
        directional_mode: u8,
        stale_one_way_mode: u8,
        reference_snapshot_price: u64,
        bid_bucket_upper_notional_usd: vector<u64>,
        ask_bucket_upper_notional_usd: vector<u64>,
        bid_remaining_notional_usd: vector<u64>,
        ask_remaining_notional_usd: vector<u64>,
        bid_prices: vector<u64>,
        ask_prices: vector<u64>,
        inventory_bid_penalty_bps: u64,
        inventory_ask_penalty_bps: u64,
        current_regime_bid_filled_notional_usd: vector<u64>,
        current_regime_ask_filled_notional_usd: vector<u64>,
        current_regime_tail_bid_filled_notional_usd: u64,
        current_regime_tail_ask_filled_notional_usd: u64,
        current_regime_trade_count: u64,
    }

    public fun absolute_max_regime_bucket_count() : u8 {
        32
    }

    public fun ask_penalty_bps<T0, T1>(arg0: &PoolState<T0, T1>) : u64 {
        arg0.penalty.ask_penalty_bps
    }

    public(friend) fun ask_remaining_notional_mut(arg0: &mut RegimeState, arg1: u64) : &mut u64 {
        0x1::vector::borrow_mut<u64>(&mut arg0.ask_remaining_notional_usd, arg1)
    }

    public fun ask_tail_penalty_bps<T0, T1>(arg0: &PoolState<T0, T1>) : u64 {
        arg0.penalty.ask_tail_penalty_bps
    }

    public(friend) fun assert_claim_allowed<T0, T1>(arg0: &PoolState<T0, T1>) {
        assert!(arg0.permissions.closed, 7);
        assert_withdraw_allowed<T0, T1>(arg0);
    }

    public(friend) fun assert_deposit_base_allowed<T0, T1>(arg0: &PoolState<T0, T1>) {
        assert!(arg0.permissions.deposit_base_allowed, 3);
        assert!(!arg0.permissions.closed, 6);
    }

    public(friend) fun assert_deposit_quote_allowed<T0, T1>(arg0: &PoolState<T0, T1>) {
        assert!(arg0.permissions.deposit_quote_allowed, 4);
        assert!(!arg0.permissions.closed, 6);
    }

    public(friend) fun assert_matching_regime<T0, T1>(arg0: &PoolState<T0, T1>, arg1: &RegimeState) {
        assert!(0x2::object::id<RegimeState>(arg1) == arg0.regime_id, 1);
    }

    public(friend) fun assert_pool_version<T0, T1>(arg0: &PoolState<T0, T1>) {
        assert!(arg0.version == 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::version::get_program_version(), 8);
    }

    public(friend) fun assert_trade_allowed<T0, T1>(arg0: &PoolState<T0, T1>) {
        assert!(arg0.permissions.trade_allowed, 2);
        assert!(!arg0.permissions.closed, 6);
    }

    public(friend) fun assert_withdraw_allowed<T0, T1>(arg0: &PoolState<T0, T1>) {
        assert!(arg0.permissions.withdraw_allowed, 5);
    }

    public fun base_balance<T0, T1>(arg0: &PoolState<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.base_coin)
    }

    public fun base_coin_decimals<T0, T1>(arg0: &PoolState<T0, T1>) : u8 {
        arg0.base_coin_decimals
    }

    public(friend) fun base_coin_pay_in<T0, T1>(arg0: &mut PoolState<T0, T1>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.base_coin, arg1);
    }

    public(friend) fun base_coin_pay_out<T0, T1>(arg0: &mut PoolState<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.base_coin, arg1), arg2)
    }

    public fun base_core_max_age_sec<T0, T1>(arg0: &PoolState<T0, T1>) : u64 {
        arg0.oracle.base_core_max_age_sec
    }

    public fun base_feed_id_core<T0, T1>(arg0: &PoolState<T0, T1>) : vector<u8> {
        arg0.oracle.base_feed_id_core
    }

    public fun base_feed_id_pro<T0, T1>(arg0: &PoolState<T0, T1>) : u32 {
        arg0.oracle.base_feed_id_pro
    }

    public fun base_max_age_ms<T0, T1>(arg0: &PoolState<T0, T1>) : u64 {
        arg0.oracle.base_max_age_ms
    }

    public fun bid_penalty_bps<T0, T1>(arg0: &PoolState<T0, T1>) : u64 {
        arg0.penalty.bid_penalty_bps
    }

    public(friend) fun bid_remaining_notional_mut(arg0: &mut RegimeState, arg1: u64) : &mut u64 {
        0x1::vector::borrow_mut<u64>(&mut arg0.bid_remaining_notional_usd, arg1)
    }

    public fun bid_tail_penalty_bps<T0, T1>(arg0: &PoolState<T0, T1>) : u64 {
        arg0.penalty.bid_tail_penalty_bps
    }

    public fun bucket_count(arg0: &RegimeState) : u8 {
        arg0.bucket_count
    }

    fun build_remaining_notional(arg0: &vector<u64>) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            0x1::vector::push_back<u64>(&mut v0, *0x1::vector::borrow<u64>(arg0, v1) - 0);
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun burn_base_capital_coin<T0, T1>(arg0: &mut PoolState<T0, T1>, arg1: 0x2::balance::Balance<BasePoolLiquidityCoin<T0, T1>>) {
        0x2::balance::decrease_supply<BasePoolLiquidityCoin<T0, T1>>(&mut arg0.base_capital_supply, arg1);
    }

    public(friend) fun burn_quote_capital_coin<T0, T1>(arg0: &mut PoolState<T0, T1>, arg1: 0x2::balance::Balance<QuotePoolLiquidityCoin<T0, T1>>) {
        0x2::balance::decrease_supply<QuotePoolLiquidityCoin<T0, T1>>(&mut arg0.quote_capital_supply, arg1);
    }

    public(friend) fun claim_assets<T0, T1>(arg0: &mut PoolState<T0, T1>, arg1: 0x2::coin::Coin<BasePoolLiquidityCoin<T0, T1>>, arg2: 0x2::coin::Coin<QuotePoolLiquidityCoin<T0, T1>>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_claim_allowed<T0, T1>(arg0);
        let v0 = 0x2::coin::value<BasePoolLiquidityCoin<T0, T1>>(&arg1);
        let v1 = 0x2::coin::value<QuotePoolLiquidityCoin<T0, T1>>(&arg2);
        let v2 = get_base_capital_coin_supply<T0, T1>(arg0);
        let v3 = get_quote_capital_coin_supply<T0, T1>(arg0);
        let v4 = if (v0 > 0 && v2 > 0) {
            0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::safe_math::safe_mul_div_u64(0x2::balance::value<T0>(&arg0.base_coin), v0, v2)
        } else {
            0
        };
        let v5 = if (v1 > 0 && v3 > 0) {
            0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::safe_math::safe_mul_div_u64(0x2::balance::value<T1>(&arg0.quote_coin), v1, v3)
        } else {
            0
        };
        burn_base_capital_coin<T0, T1>(arg0, 0x2::coin::into_balance<BasePoolLiquidityCoin<T0, T1>>(arg1));
        burn_quote_capital_coin<T0, T1>(arg0, 0x2::coin::into_balance<QuotePoolLiquidityCoin<T0, T1>>(arg2));
        let v6 = base_coin_pay_out<T0, T1>(arg0, v4, arg3);
        (v6, quote_coin_pay_out<T0, T1>(arg0, v5, arg3))
    }

    public(friend) fun create_pool_and_regime<T0, T1>(arg0: address, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : (PoolState<T0, T1>, RegimeState) {
        let v0 = RegimeState{
            id                                          : 0x2::object::new(arg3),
            regime_version                              : 0,
            last_update_ts_ms                           : 0,
            bucket_count                                : 0,
            directional_mode                            : 0,
            stale_one_way_mode                          : 1,
            reference_snapshot_price                    : 0,
            bid_bucket_upper_notional_usd               : 0x1::vector::empty<u64>(),
            ask_bucket_upper_notional_usd               : 0x1::vector::empty<u64>(),
            bid_remaining_notional_usd                  : 0x1::vector::empty<u64>(),
            ask_remaining_notional_usd                  : 0x1::vector::empty<u64>(),
            bid_prices                                  : 0x1::vector::empty<u64>(),
            ask_prices                                  : 0x1::vector::empty<u64>(),
            inventory_bid_penalty_bps                   : 0,
            inventory_ask_penalty_bps                   : 0,
            current_regime_bid_filled_notional_usd      : 0x1::vector::empty<u64>(),
            current_regime_ask_filled_notional_usd      : 0x1::vector::empty<u64>(),
            current_regime_tail_bid_filled_notional_usd : 0,
            current_regime_tail_ask_filled_notional_usd : 0,
            current_regime_trade_count                  : 0,
        };
        let v1 = OracleConfig{
            base_feed_id_pro       : 0,
            quote_feed_id_pro      : 0,
            base_feed_id_core      : 0x1::vector::empty<u8>(),
            quote_feed_id_core     : 0x1::vector::empty<u8>(),
            base_max_age_ms        : 3000,
            quote_max_age_ms       : 3000,
            base_core_max_age_sec  : 3,
            quote_core_max_age_sec : 3,
        };
        let v2 = DeviationConfig{
            max_bid_deviation_bps : 1000,
            max_ask_deviation_bps : 1000,
        };
        let v3 = StaleConfig{
            widen_gap_ms   : 3000,
            one_way_gap_ms : 6000,
            pause_gap_ms   : 9000,
        };
        let v4 = PenaltyConfig{
            bid_penalty_bps      : 20,
            ask_penalty_bps      : 20,
            bid_tail_penalty_bps : 100,
            ask_tail_penalty_bps : 100,
        };
        let v5 = InventoryConfig{
            target_base_ratio_bps : 5000,
            warn_ratio_bps        : 1000,
            critical_ratio_bps    : 2000,
            block_ratio_bps       : 3000,
            warn_penalty_bps      : 30,
            critical_penalty_bps  : 80,
        };
        let v6 = PermissionFlags{
            trade_allowed         : false,
            deposit_base_allowed  : true,
            deposit_quote_allowed : true,
            withdraw_allowed      : true,
            closed                : false,
        };
        let v7 = BasePoolLiquidityCoin<T0, T1>{dummy_field: false};
        let v8 = QuotePoolLiquidityCoin<T0, T1>{dummy_field: false};
        let v9 = PoolState<T0, T1>{
            id                            : 0x2::object::new(arg3),
            version                       : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::version::get_program_version(),
            maintainer                    : arg0,
            regime_id                     : 0x2::object::id<RegimeState>(&v0),
            base_coin_decimals            : arg1,
            quote_coin_decimals           : arg2,
            oracle                        : v1,
            deviation                     : v2,
            stale                         : v3,
            penalty                       : v4,
            max_public_trade_usd_notional : 50000000000000,
            max_regime_bucket_count       : 8,
            inventory                     : v5,
            permissions                   : v6,
            local_state_seq               : 0,
            trade_num                     : 0,
            base_coin                     : 0x2::balance::zero<T0>(),
            quote_coin                    : 0x2::balance::zero<T1>(),
            base_capital_supply           : 0x2::balance::create_supply<BasePoolLiquidityCoin<T0, T1>>(v7),
            quote_capital_supply          : 0x2::balance::create_supply<QuotePoolLiquidityCoin<T0, T1>>(v8),
        };
        (v9, v0)
    }

    public fun current_regime_tail_ask_filled_notional_usd(arg0: &RegimeState) : u64 {
        arg0.current_regime_tail_ask_filled_notional_usd
    }

    public fun current_regime_tail_bid_filled_notional_usd(arg0: &RegimeState) : u64 {
        arg0.current_regime_tail_bid_filled_notional_usd
    }

    public fun current_regime_trade_count(arg0: &RegimeState) : u64 {
        arg0.current_regime_trade_count
    }

    public fun default_max_regime_bucket_count() : u8 {
        8
    }

    public fun directional_mode(arg0: &RegimeState) : u8 {
        arg0.directional_mode
    }

    public(friend) fun final_settlement<T0, T1>(arg0: &mut PoolState<T0, T1>) {
        arg0.permissions.trade_allowed = false;
        arg0.permissions.deposit_base_allowed = false;
        arg0.permissions.deposit_quote_allowed = false;
        arg0.permissions.withdraw_allowed = true;
        arg0.permissions.closed = true;
    }

    public fun get_ask_bucket_upper_notional(arg0: &RegimeState, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.ask_bucket_upper_notional_usd, arg1)
    }

    public fun get_ask_bucket_upper_notional_vec(arg0: &RegimeState) : vector<u64> {
        arg0.ask_bucket_upper_notional_usd
    }

    public fun get_ask_price(arg0: &RegimeState, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.ask_prices, arg1)
    }

    public fun get_ask_remaining_notional(arg0: &RegimeState, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.ask_remaining_notional_usd, arg1)
    }

    public fun get_ask_remaining_notional_vec(arg0: &RegimeState) : vector<u64> {
        arg0.ask_remaining_notional_usd
    }

    public fun get_base_capital_coin_supply<T0, T1>(arg0: &PoolState<T0, T1>) : u64 {
        0x2::balance::supply_value<BasePoolLiquidityCoin<T0, T1>>(&arg0.base_capital_supply)
    }

    public fun get_base_one<T0, T1>(arg0: &PoolState<T0, T1>) : u64 {
        0x1::u64::pow(10, arg0.base_coin_decimals)
    }

    public fun get_bid_bucket_upper_notional(arg0: &RegimeState, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.bid_bucket_upper_notional_usd, arg1)
    }

    public fun get_bid_bucket_upper_notional_vec(arg0: &RegimeState) : vector<u64> {
        arg0.bid_bucket_upper_notional_usd
    }

    public fun get_bid_price(arg0: &RegimeState, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.bid_prices, arg1)
    }

    public fun get_bid_remaining_notional(arg0: &RegimeState, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.bid_remaining_notional_usd, arg1)
    }

    public fun get_bid_remaining_notional_vec(arg0: &RegimeState) : vector<u64> {
        arg0.bid_remaining_notional_usd
    }

    public fun get_current_regime_ask_filled_notional(arg0: &RegimeState, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.current_regime_ask_filled_notional_usd, arg1)
    }

    public fun get_current_regime_ask_filled_notional_vec(arg0: &RegimeState) : vector<u64> {
        arg0.current_regime_ask_filled_notional_usd
    }

    public fun get_current_regime_bid_filled_notional(arg0: &RegimeState, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.current_regime_bid_filled_notional_usd, arg1)
    }

    public fun get_current_regime_bid_filled_notional_vec(arg0: &RegimeState) : vector<u64> {
        arg0.current_regime_bid_filled_notional_usd
    }

    public fun get_quote_capital_coin_supply<T0, T1>(arg0: &PoolState<T0, T1>) : u64 {
        0x2::balance::supply_value<QuotePoolLiquidityCoin<T0, T1>>(&arg0.quote_capital_supply)
    }

    public fun get_quote_one<T0, T1>(arg0: &PoolState<T0, T1>) : u64 {
        0x1::u64::pow(10, arg0.quote_coin_decimals)
    }

    public(friend) fun increase_trade_num<T0, T1>(arg0: &mut PoolState<T0, T1>) {
        arg0.trade_num = arg0.trade_num + 1;
        arg0.local_state_seq = arg0.local_state_seq + 1;
    }

    public fun inventory_ask_penalty_bps(arg0: &RegimeState) : u64 {
        arg0.inventory_ask_penalty_bps
    }

    public fun inventory_bid_penalty_bps(arg0: &RegimeState) : u64 {
        arg0.inventory_bid_penalty_bps
    }

    public fun inventory_block_ratio_bps<T0, T1>(arg0: &PoolState<T0, T1>) : u64 {
        arg0.inventory.block_ratio_bps
    }

    public fun inventory_critical_penalty_bps<T0, T1>(arg0: &PoolState<T0, T1>) : u64 {
        arg0.inventory.critical_penalty_bps
    }

    public fun inventory_critical_ratio_bps<T0, T1>(arg0: &PoolState<T0, T1>) : u64 {
        arg0.inventory.critical_ratio_bps
    }

    public fun inventory_target_base_ratio_bps<T0, T1>(arg0: &PoolState<T0, T1>) : u64 {
        arg0.inventory.target_base_ratio_bps
    }

    public fun inventory_warn_penalty_bps<T0, T1>(arg0: &PoolState<T0, T1>) : u64 {
        arg0.inventory.warn_penalty_bps
    }

    public fun inventory_warn_ratio_bps<T0, T1>(arg0: &PoolState<T0, T1>) : u64 {
        arg0.inventory.warn_ratio_bps
    }

    public fun last_update_ts_ms(arg0: &RegimeState) : u64 {
        arg0.last_update_ts_ms
    }

    public fun max_ask_deviation_bps<T0, T1>(arg0: &PoolState<T0, T1>) : u64 {
        arg0.deviation.max_ask_deviation_bps
    }

    public fun max_bid_deviation_bps<T0, T1>(arg0: &PoolState<T0, T1>) : u64 {
        arg0.deviation.max_bid_deviation_bps
    }

    public fun max_public_trade_usd_notional<T0, T1>(arg0: &PoolState<T0, T1>) : u64 {
        arg0.max_public_trade_usd_notional
    }

    public fun max_regime_bucket_count<T0, T1>(arg0: &PoolState<T0, T1>) : u8 {
        arg0.max_regime_bucket_count
    }

    public(friend) fun migrate_pool_version<T0, T1>(arg0: &mut PoolState<T0, T1>) {
        arg0.version = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::version::get_program_version();
    }

    public(friend) fun mint_base_capital<T0, T1>(arg0: &mut PoolState<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BasePoolLiquidityCoin<T0, T1>> {
        base_coin_pay_in<T0, T1>(arg0, arg1);
        0x2::coin::from_balance<BasePoolLiquidityCoin<T0, T1>>(0x2::balance::increase_supply<BasePoolLiquidityCoin<T0, T1>>(&mut arg0.base_capital_supply, arg2), arg3)
    }

    public(friend) fun mint_quote_capital<T0, T1>(arg0: &mut PoolState<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<QuotePoolLiquidityCoin<T0, T1>> {
        quote_coin_pay_in<T0, T1>(arg0, arg1);
        0x2::coin::from_balance<QuotePoolLiquidityCoin<T0, T1>>(0x2::balance::increase_supply<QuotePoolLiquidityCoin<T0, T1>>(&mut arg0.quote_capital_supply, arg2), arg3)
    }

    public fun mode_ask_only() : u8 {
        2
    }

    public fun mode_bid_only() : u8 {
        1
    }

    public fun mode_paused() : u8 {
        3
    }

    public fun mode_two_way() : u8 {
        0
    }

    public fun pool_id<T0, T1>(arg0: &PoolState<T0, T1>) : 0x2::object::ID {
        0x2::object::id<PoolState<T0, T1>>(arg0)
    }

    public fun quote_balance<T0, T1>(arg0: &PoolState<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.quote_coin)
    }

    public fun quote_coin_decimals<T0, T1>(arg0: &PoolState<T0, T1>) : u8 {
        arg0.quote_coin_decimals
    }

    public(friend) fun quote_coin_pay_in<T0, T1>(arg0: &mut PoolState<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(&mut arg0.quote_coin, arg1);
    }

    public(friend) fun quote_coin_pay_out<T0, T1>(arg0: &mut PoolState<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.quote_coin, arg1), arg2)
    }

    public fun quote_core_max_age_sec<T0, T1>(arg0: &PoolState<T0, T1>) : u64 {
        arg0.oracle.quote_core_max_age_sec
    }

    public fun quote_feed_id_core<T0, T1>(arg0: &PoolState<T0, T1>) : vector<u8> {
        arg0.oracle.quote_feed_id_core
    }

    public fun quote_feed_id_pro<T0, T1>(arg0: &PoolState<T0, T1>) : u32 {
        arg0.oracle.quote_feed_id_pro
    }

    public fun quote_max_age_ms<T0, T1>(arg0: &PoolState<T0, T1>) : u64 {
        arg0.oracle.quote_max_age_ms
    }

    public(friend) fun record_current_regime_ask_fill(arg0: &mut RegimeState, arg1: u64, arg2: u64) {
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.current_regime_ask_filled_notional_usd, arg1);
        *v0 = *v0 + arg2;
    }

    public(friend) fun record_current_regime_bid_fill(arg0: &mut RegimeState, arg1: u64, arg2: u64) {
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.current_regime_bid_filled_notional_usd, arg1);
        *v0 = *v0 + arg2;
    }

    public(friend) fun record_current_regime_tail_ask_fill(arg0: &mut RegimeState, arg1: u64) {
        arg0.current_regime_tail_ask_filled_notional_usd = arg0.current_regime_tail_ask_filled_notional_usd + arg1;
    }

    public(friend) fun record_current_regime_tail_bid_fill(arg0: &mut RegimeState, arg1: u64) {
        arg0.current_regime_tail_bid_filled_notional_usd = arg0.current_regime_tail_bid_filled_notional_usd + arg1;
    }

    public(friend) fun record_current_regime_trade(arg0: &mut RegimeState) {
        arg0.current_regime_trade_count = arg0.current_regime_trade_count + 1;
    }

    public fun reference_snapshot_price(arg0: &RegimeState) : u64 {
        arg0.reference_snapshot_price
    }

    public fun regime_id<T0, T1>(arg0: &PoolState<T0, T1>) : 0x2::object::ID {
        arg0.regime_id
    }

    public fun regime_version(arg0: &RegimeState) : u64 {
        arg0.regime_version
    }

    public(friend) fun replace_regime(arg0: &mut RegimeState, arg1: u64, arg2: u8, arg3: u8, arg4: u64, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u64>, arg9: u64, arg10: u64) {
        arg0.regime_version = arg0.regime_version + 1;
        arg0.last_update_ts_ms = arg1;
        arg0.bucket_count = (0x1::vector::length<u64>(&arg5) as u8);
        arg0.directional_mode = arg2;
        arg0.stale_one_way_mode = arg3;
        arg0.reference_snapshot_price = arg4;
        arg0.bid_bucket_upper_notional_usd = arg5;
        arg0.ask_bucket_upper_notional_usd = arg6;
        arg0.bid_remaining_notional_usd = build_remaining_notional(&arg5);
        arg0.ask_remaining_notional_usd = build_remaining_notional(&arg6);
        arg0.bid_prices = arg7;
        arg0.ask_prices = arg8;
        arg0.inventory_bid_penalty_bps = arg9;
        arg0.inventory_ask_penalty_bps = arg10;
        let v0 = 0x1::vector::length<u64>(&arg0.bid_bucket_upper_notional_usd);
        arg0.current_regime_bid_filled_notional_usd = zero_vector(v0);
        arg0.current_regime_ask_filled_notional_usd = zero_vector(v0);
        arg0.current_regime_tail_bid_filled_notional_usd = 0;
        arg0.current_regime_tail_ask_filled_notional_usd = 0;
        arg0.current_regime_trade_count = 0;
    }

    public(friend) fun set_deviation_config<T0, T1>(arg0: &mut PoolState<T0, T1>, arg1: u64, arg2: u64) {
        arg0.deviation.max_bid_deviation_bps = arg1;
        arg0.deviation.max_ask_deviation_bps = arg2;
    }

    public(friend) fun set_inventory_config<T0, T1>(arg0: &mut PoolState<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        arg0.inventory.target_base_ratio_bps = arg1;
        arg0.inventory.warn_ratio_bps = arg2;
        arg0.inventory.critical_ratio_bps = arg3;
        arg0.inventory.block_ratio_bps = arg4;
        arg0.inventory.warn_penalty_bps = arg5;
        arg0.inventory.critical_penalty_bps = arg6;
    }

    public(friend) fun set_max_regime_bucket_count<T0, T1>(arg0: &mut PoolState<T0, T1>, arg1: u8) {
        arg0.max_regime_bucket_count = arg1;
    }

    public(friend) fun set_oracle_config<T0, T1>(arg0: &mut PoolState<T0, T1>, arg1: u32, arg2: u32, arg3: u64, arg4: u64) {
        arg0.oracle.base_feed_id_pro = arg1;
        arg0.oracle.quote_feed_id_pro = arg2;
        arg0.oracle.base_max_age_ms = arg3;
        arg0.oracle.quote_max_age_ms = arg4;
    }

    public(friend) fun set_public_trade_limit<T0, T1>(arg0: &mut PoolState<T0, T1>, arg1: u64) {
        arg0.max_public_trade_usd_notional = arg1;
    }

    public(friend) fun set_pyth_core_oracle_config<T0, T1>(arg0: &mut PoolState<T0, T1>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64) {
        arg0.oracle.base_feed_id_core = arg1;
        arg0.oracle.quote_feed_id_core = arg2;
        arg0.oracle.base_core_max_age_sec = arg3;
        arg0.oracle.quote_core_max_age_sec = arg4;
    }

    public(friend) fun set_stale_config<T0, T1>(arg0: &mut PoolState<T0, T1>, arg1: u64, arg2: u64, arg3: u64) {
        arg0.stale.widen_gap_ms = arg1;
        arg0.stale.one_way_gap_ms = arg2;
        arg0.stale.pause_gap_ms = arg3;
    }

    public(friend) fun set_stale_penalty_bps<T0, T1>(arg0: &mut PoolState<T0, T1>, arg1: u64, arg2: u64) {
        arg0.penalty.bid_penalty_bps = arg1;
        arg0.penalty.ask_penalty_bps = arg2;
    }

    public(friend) fun set_tail_penalty_bps<T0, T1>(arg0: &mut PoolState<T0, T1>, arg1: u64, arg2: u64) {
        arg0.penalty.bid_tail_penalty_bps = arg1;
        arg0.penalty.ask_tail_penalty_bps = arg2;
    }

    public(friend) fun set_time_penalty_config<T0, T1>(arg0: &mut PoolState<T0, T1>, arg1: u64, arg2: u64) {
        let v0 = TimeSlippageConfig{
            penalty_bps : arg1,
            period_ms   : arg2,
        };
        let v1 = TimeSlippageKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<TimeSlippageKey>(&arg0.id, v1)) {
            let v2 = TimeSlippageKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<TimeSlippageKey, TimeSlippageConfig>(&mut arg0.id, v2) = v0;
        } else {
            let v3 = TimeSlippageKey{dummy_field: false};
            0x2::dynamic_field::add<TimeSlippageKey, TimeSlippageConfig>(&mut arg0.id, v3, v0);
        };
    }

    public(friend) fun set_trade_allowed<T0, T1>(arg0: &mut PoolState<T0, T1>, arg1: bool) {
        arg0.permissions.trade_allowed = arg1;
    }

    public(friend) fun share_pool_and_regime<T0, T1>(arg0: PoolState<T0, T1>, arg1: RegimeState) {
        0x2::transfer::share_object<PoolState<T0, T1>>(arg0);
        0x2::transfer::share_object<RegimeState>(arg1);
    }

    public fun stale_one_way_gap_ms<T0, T1>(arg0: &PoolState<T0, T1>) : u64 {
        arg0.stale.one_way_gap_ms
    }

    public fun stale_one_way_mode(arg0: &RegimeState) : u8 {
        arg0.stale_one_way_mode
    }

    public fun stale_pause_gap_ms<T0, T1>(arg0: &PoolState<T0, T1>) : u64 {
        arg0.stale.pause_gap_ms
    }

    public fun stale_widen_gap_ms<T0, T1>(arg0: &PoolState<T0, T1>) : u64 {
        arg0.stale.widen_gap_ms
    }

    public fun time_penalty_config<T0, T1>(arg0: &PoolState<T0, T1>) : (u64, u64) {
        let v0 = TimeSlippageKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<TimeSlippageKey>(&arg0.id, v0)) {
            let v3 = TimeSlippageKey{dummy_field: false};
            let v4 = 0x2::dynamic_field::borrow<TimeSlippageKey, TimeSlippageConfig>(&arg0.id, v3);
            (v4.penalty_bps, v4.period_ms)
        } else {
            (0, 0)
        }
    }

    public fun trade_allowed<T0, T1>(arg0: &PoolState<T0, T1>) : bool {
        arg0.permissions.trade_allowed
    }

    public fun trade_num<T0, T1>(arg0: &PoolState<T0, T1>) : u64 {
        arg0.trade_num
    }

    fun zero_vector(arg0: u64) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < arg0) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

