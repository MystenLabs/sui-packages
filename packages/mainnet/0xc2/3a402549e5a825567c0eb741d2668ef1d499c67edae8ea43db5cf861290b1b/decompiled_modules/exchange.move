module 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::exchange {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        exchange_id: 0x2::object::ID,
    }

    struct KeeperCap has store, key {
        id: 0x2::object::UID,
        exchange_id: 0x2::object::ID,
    }

    struct Config has copy, drop, store {
        max_leverage_bps: u64,
        min_leverage_bps: u64,
        maintenance_bps: u64,
        liquidation_reward_bps: u64,
        borrow_base_e18_per_hour: u128,
        borrow_slope_e18_per_hour: u128,
        request_timeout_ms: u64,
        self_execute_after_ms: u64,
        max_price_age_ms: u64,
        max_conf_bps: u64,
        max_pool_deviation_bps: u64,
    }

    struct Market has store {
        symbol: 0x1::string::String,
        pending_open_fee_bps: u64,
        pending_close_fee_bps: u64,
        pending_fees_ready_ms: u64,
        feed_id: vector<u8>,
        enabled: bool,
        max_position_usd: u64,
        max_oi_usd: u64,
        oi_long_usd: u64,
        oi_short_usd: u64,
        open_fee_bps: u64,
        close_fee_bps: u64,
        cumulative_borrow_e18: u128,
        last_borrow_ms: u64,
        reserved: u64,
    }

    struct PositionKey has copy, drop, store {
        owner: address,
        market_id: u64,
        is_long: bool,
    }

    struct Position<phantom T0> has store {
        owner: address,
        market_id: u64,
        is_long: bool,
        size_usd: u64,
        collateral: 0x2::balance::Balance<T0>,
        entry_price: u128,
        borrow_snapshot_e18: u128,
        reserved: u64,
        trigger_orders: u64,
        seq: u64,
        opened_ms: u64,
        updated_ms: u64,
    }

    struct Request<phantom T0> has store {
        owner: address,
        market_id: u64,
        is_long: bool,
        kind: u8,
        collateral: 0x2::balance::Balance<T0>,
        size_delta_usd: u64,
        withdraw_units: u64,
        acceptable_price: u128,
        trigger_price: u128,
        trigger_above: bool,
        position_seq: u64,
        created_ms: u64,
    }

    struct CollateralPrice has copy, drop {
        spot: u128,
        twap: u128,
        recorded_ms: u64,
    }

    struct Exchange<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        liquidity: 0x2::balance::Balance<T0>,
        reserved: u64,
        fees: 0x2::balance::Balance<T0>,
        treasury: address,
        config: Config,
        markets: vector<Market>,
        positions: 0x2::table::Table<PositionKey, Position<T0>>,
        requests: 0x2::table::Table<u64, Request<T0>>,
        next_request_id: u64,
        next_position_seq: u64,
        pending_config: 0x1::option::Option<Config>,
        pending_config_ready_ms: u64,
        keepers: 0x2::vec_set::VecSet<0x2::object::ID>,
        paused: bool,
        collateral_decimals: u8,
        pool_oracle_id: 0x2::object::ID,
        sui_feed_id: vector<u8>,
        pending_pool_oracle_id: 0x1::option::Option<0x2::object::ID>,
        pending_pool_oracle_ready_ms: u64,
    }

    struct ExchangeCreated has copy, drop {
        exchange_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        pool_oracle_id: 0x2::object::ID,
    }

    struct MarketAdded has copy, drop {
        exchange_id: 0x2::object::ID,
        market_id: u64,
        symbol: 0x1::string::String,
        feed_id: vector<u8>,
    }

    struct MarketUpdated has copy, drop {
        exchange_id: 0x2::object::ID,
        market_id: u64,
        enabled: bool,
        max_position_usd: u64,
        max_oi_usd: u64,
        open_fee_bps: u64,
        close_fee_bps: u64,
    }

    struct ConfigUpdated has copy, drop {
        exchange_id: 0x2::object::ID,
        config: Config,
    }

    struct ConfigProposed has copy, drop {
        exchange_id: 0x2::object::ID,
        config: Config,
        ready_ms: u64,
    }

    struct ConfigProposalCancelled has copy, drop {
        exchange_id: 0x2::object::ID,
    }

    struct PoolOracleProposed has copy, drop {
        exchange_id: 0x2::object::ID,
        pool_oracle_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        ready_ms: u64,
    }

    struct PoolOracleProposalCancelled has copy, drop {
        exchange_id: 0x2::object::ID,
    }

    struct PoolOracleChanged has copy, drop {
        exchange_id: 0x2::object::ID,
        pool_oracle_id: 0x2::object::ID,
    }

    struct MarketFeesProposed has copy, drop {
        exchange_id: 0x2::object::ID,
        market_id: u64,
        open_fee_bps: u64,
        close_fee_bps: u64,
        ready_ms: u64,
    }

    struct PausedChanged has copy, drop {
        exchange_id: 0x2::object::ID,
        paused: bool,
    }

    struct TreasuryChanged has copy, drop {
        exchange_id: 0x2::object::ID,
        treasury: address,
    }

    struct KeeperChanged has copy, drop {
        exchange_id: 0x2::object::ID,
        keeper_cap_id: 0x2::object::ID,
        active: bool,
    }

    struct LiquidityDeposited has copy, drop {
        exchange_id: 0x2::object::ID,
        sender: address,
        amount: u64,
        total: u64,
    }

    struct LiquidityWithdrawn has copy, drop {
        exchange_id: 0x2::object::ID,
        amount: u64,
        total: u64,
    }

    struct FeesSwept has copy, drop {
        exchange_id: 0x2::object::ID,
        amount: u64,
        treasury: address,
    }

    struct RequestCreated has copy, drop {
        exchange_id: 0x2::object::ID,
        request_id: u64,
        owner: address,
        market_id: u64,
        is_long: bool,
        kind: u8,
        collateral: u64,
        size_delta_usd: u64,
        withdraw_units: u64,
        acceptable_price: u128,
        trigger_price: u128,
        trigger_above: bool,
        timestamp_ms: u64,
    }

    struct RequestCancelled has copy, drop {
        exchange_id: 0x2::object::ID,
        request_id: u64,
        owner: address,
        refunded: u64,
        expired: bool,
        timestamp_ms: u64,
    }

    struct PositionIncreased has copy, drop {
        exchange_id: 0x2::object::ID,
        request_id: u64,
        owner: address,
        market_id: u64,
        is_long: bool,
        size_delta_usd: u64,
        collateral_added: u64,
        price: u128,
        size_usd: u64,
        collateral: u64,
        entry_price: u128,
        fee_usd: u64,
        fee_units: u64,
        reserved: u64,
        timestamp_ms: u64,
    }

    struct PositionDecreased has copy, drop {
        exchange_id: 0x2::object::ID,
        request_id: u64,
        owner: address,
        market_id: u64,
        is_long: bool,
        size_delta_usd: u64,
        price: u128,
        is_profit: bool,
        pnl_usd: u64,
        pnl_units: u64,
        profit_capped: bool,
        fee_usd: u64,
        fee_units: u64,
        payout: u64,
        size_usd: u64,
        collateral: u64,
        closed: bool,
        timestamp_ms: u64,
    }

    struct CollateralAdded has copy, drop {
        exchange_id: 0x2::object::ID,
        owner: address,
        market_id: u64,
        is_long: bool,
        amount: u64,
        collateral: u64,
        reserved: u64,
        timestamp_ms: u64,
    }

    struct CollateralWithdrawn has copy, drop {
        exchange_id: 0x2::object::ID,
        request_id: u64,
        owner: address,
        market_id: u64,
        is_long: bool,
        amount: u64,
        fee_units: u64,
        collateral: u64,
        timestamp_ms: u64,
    }

    struct PositionLiquidated has copy, drop {
        exchange_id: 0x2::object::ID,
        owner: address,
        market_id: u64,
        is_long: bool,
        size_usd: u64,
        price: u128,
        collateral: u64,
        equity_negative: bool,
        equity_usd: u64,
        reward: u64,
        fee_units: u64,
        to_pool: u64,
        liquidator: address,
        timestamp_ms: u64,
    }

    fun max(arg0: u128, arg1: u128) : u128 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun min(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun accrue_all<T0>(arg0: &mut Exchange<T0>, arg1: u64) {
        let v0 = 0x2::balance::value<T0>(&arg0.liquidity);
        let v1 = if (v0 == 0) {
            0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::e18()
        } else {
            0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::mul_div_128((arg0.reserved as u128), 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::e18(), (v0 as u128))
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<Market>(&arg0.markets)) {
            let v3 = 0x1::vector::borrow_mut<Market>(&mut arg0.markets, v2);
            if (arg1 > v3.last_borrow_ms) {
                v3.cumulative_borrow_e18 = v3.cumulative_borrow_e18 + 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::mul_div_128(borrow_rate(&arg0.config, min(v1, 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::e18())), ((arg1 - v3.last_borrow_ms) as u128), 3600000);
                v3.last_borrow_ms = arg1;
            };
            v2 = v2 + 1;
        };
    }

    public fun add_collateral<T0>(arg0: &mut Exchange<T0>, arg1: u64, arg2: bool, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 7);
        let v1 = PositionKey{
            owner     : 0x2::tx_context::sender(arg5),
            market_id : arg1,
            is_long   : arg2,
        };
        assert!(0x2::table::contains<PositionKey, Position<T0>>(&arg0.positions, v1), 8);
        let v2 = 0x2::table::borrow_mut<PositionKey, Position<T0>>(&mut arg0.positions, v1);
        0x2::balance::join<T0>(&mut v2.collateral, 0x2::coin::into_balance<T0>(arg3));
        v2.updated_ms = 0x2::clock::timestamp_ms(arg4);
        let v3 = CollateralAdded{
            exchange_id  : 0x2::object::id<Exchange<T0>>(arg0),
            owner        : v1.owner,
            market_id    : arg1,
            is_long      : arg2,
            amount       : v0,
            collateral   : 0x2::balance::value<T0>(&v2.collateral),
            reserved     : v2.reserved,
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<CollateralAdded>(v3);
    }

    public fun add_market<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>, arg2: 0x1::string::String, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        assert_admin<T0>(arg0, arg1);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 6);
        assert_market_params(arg4, arg5, arg6, arg7);
        let v0 = MarketAdded{
            exchange_id : 0x2::object::id<Exchange<T0>>(arg1),
            market_id   : 0x1::vector::length<Market>(&arg1.markets),
            symbol      : arg2,
            feed_id     : arg3,
        };
        0x2::event::emit<MarketAdded>(v0);
        let v1 = Market{
            symbol                : arg2,
            pending_open_fee_bps  : 0,
            pending_close_fee_bps : 0,
            pending_fees_ready_ms : 0,
            feed_id               : arg3,
            enabled               : true,
            max_position_usd      : arg4,
            max_oi_usd            : arg5,
            oi_long_usd           : 0,
            oi_short_usd          : 0,
            open_fee_bps          : arg6,
            close_fee_bps         : arg7,
            cumulative_borrow_e18 : 0,
            last_borrow_ms        : 0x2::clock::timestamp_ms(arg8),
            reserved              : 0,
        };
        0x1::vector::push_back<Market>(&mut arg1.markets, v1);
    }

    public fun apply_config<T0>(arg0: &mut Exchange<T0>, arg1: &0x2::clock::Clock) {
        assert_version<T0>(arg0);
        assert!(0x1::option::is_some<Config>(&arg0.pending_config), 32);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.pending_config_ready_ms, 33);
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.pending_config_ready_ms + 604800000, 34);
        accrue_all<T0>(arg0, 0x2::clock::timestamp_ms(arg1));
        let v0 = 0x1::option::extract<Config>(&mut arg0.pending_config);
        arg0.config = v0;
        let v1 = ConfigUpdated{
            exchange_id : 0x2::object::id<Exchange<T0>>(arg0),
            config      : v0,
        };
        0x2::event::emit<ConfigUpdated>(v1);
    }

    public fun apply_market_fees<T0>(arg0: &mut Exchange<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        assert_version<T0>(arg0);
        assert!(arg1 < 0x1::vector::length<Market>(&arg0.markets), 28);
        let v0 = 0x1::vector::borrow_mut<Market>(&mut arg0.markets, arg1);
        assert!(v0.pending_fees_ready_ms > 0, 32);
        assert!(0x2::clock::timestamp_ms(arg2) >= v0.pending_fees_ready_ms, 33);
        assert!(0x2::clock::timestamp_ms(arg2) < v0.pending_fees_ready_ms + 604800000, 34);
        v0.open_fee_bps = v0.pending_open_fee_bps;
        v0.close_fee_bps = v0.pending_close_fee_bps;
        v0.pending_fees_ready_ms = 0;
        let v1 = MarketUpdated{
            exchange_id      : 0x2::object::id<Exchange<T0>>(arg0),
            market_id        : arg1,
            enabled          : v0.enabled,
            max_position_usd : v0.max_position_usd,
            max_oi_usd       : v0.max_oi_usd,
            open_fee_bps     : v0.open_fee_bps,
            close_fee_bps    : v0.close_fee_bps,
        };
        0x2::event::emit<MarketUpdated>(v1);
    }

    public fun apply_pool_oracle<T0>(arg0: &mut Exchange<T0>, arg1: &0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::pool_price::PoolPriceOracle, arg2: &0x2::clock::Clock) {
        assert_version<T0>(arg0);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.pending_pool_oracle_id), 32);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.pending_pool_oracle_id) == 0x2::object::id<0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::pool_price::PoolPriceOracle>(arg1), 39);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::pool_price::has_twap(arg1, v0), 37);
        let v1 = 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::pool_price::last_ms(arg1);
        assert!(v1 <= v0 && v0 - v1 <= 300000, 31);
        assert!(v0 >= arg0.pending_pool_oracle_ready_ms, 33);
        assert!(v0 < arg0.pending_pool_oracle_ready_ms + 604800000, 34);
        let v2 = 0x1::option::extract<0x2::object::ID>(&mut arg0.pending_pool_oracle_id);
        arg0.pool_oracle_id = v2;
        arg0.pending_pool_oracle_ready_ms = 0;
        let v3 = PoolOracleChanged{
            exchange_id    : 0x2::object::id<Exchange<T0>>(arg0),
            pool_oracle_id : v2,
        };
        0x2::event::emit<PoolOracleChanged>(v3);
    }

    fun assert_admin<T0>(arg0: &AdminCap, arg1: &Exchange<T0>) {
        assert_version<T0>(arg1);
        assert!(arg0.exchange_id == 0x2::object::id<Exchange<T0>>(arg1), 2);
    }

    fun assert_config(arg0: &Config) {
        assert!(arg0.max_leverage_bps <= 100000 && arg0.min_leverage_bps >= 11000, 6);
        assert!(arg0.min_leverage_bps <= arg0.max_leverage_bps, 6);
        assert!(arg0.maintenance_bps >= 50 && arg0.maintenance_bps <= 500, 6);
        assert!((arg0.maintenance_bps as u128) * (arg0.max_leverage_bps as u128) <= (10000 as u128) * (10000 as u128) / 2, 6);
        assert!(arg0.liquidation_reward_bps <= 100 && arg0.liquidation_reward_bps < arg0.maintenance_bps, 6);
        assert!(arg0.borrow_base_e18_per_hour + arg0.borrow_slope_e18_per_hour <= 1000000000000000, 6);
        assert!(arg0.request_timeout_ms >= 10000 && arg0.request_timeout_ms <= 600000, 6);
        assert!(arg0.self_execute_after_ms >= arg0.request_timeout_ms && arg0.self_execute_after_ms <= 3600000, 6);
        assert!(arg0.max_price_age_ms >= 3000 && arg0.max_price_age_ms <= 120000, 6);
        assert!(arg0.max_conf_bps >= 20 && arg0.max_conf_bps <= 200, 6);
        assert!(arg0.max_pool_deviation_bps >= 50 && arg0.max_pool_deviation_bps <= 2000, 6);
    }

    fun assert_keeper<T0>(arg0: &Exchange<T0>, arg1: &KeeperCap) {
        assert_version<T0>(arg0);
        let v0 = if (arg1.exchange_id == 0x2::object::id<Exchange<T0>>(arg0)) {
            let v1 = 0x2::object::id<KeeperCap>(arg1);
            0x2::vec_set::contains<0x2::object::ID>(&arg0.keepers, &v1)
        } else {
            false
        };
        assert!(v0, 3);
    }

    fun assert_market_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg0 > 0 && arg0 <= arg1, 6);
        assert!(arg2 <= 100 && arg3 <= 100, 6);
    }

    fun assert_open_allowed<T0>(arg0: &Exchange<T0>, arg1: u64) {
        assert_version<T0>(arg0);
        assert!(!arg0.paused, 4);
        assert!(arg1 < 0x1::vector::length<Market>(&arg0.markets), 28);
        assert!(0x1::vector::borrow<Market>(&arg0.markets, arg1).enabled, 5);
    }

    fun assert_pool_price_fresh(arg0: &CollateralPrice, arg1: u64) {
        if (arg0.recorded_ms == 18446744073709551615) {
            return
        };
        assert!(arg0.recorded_ms <= arg1 && arg1 - arg0.recorded_ms <= 300000, 31);
    }

    fun assert_version<T0>(arg0: &Exchange<T0>) {
        assert!(arg0.version == 1, 1);
    }

    fun borrow_fee_usd<T0>(arg0: &Position<T0>, arg1: u128) : u64 {
        (((arg0.size_usd as u256) * ((arg1 - arg0.borrow_snapshot_e18) as u256) / (0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::e18() as u256)) as u64)
    }

    fun borrow_rate(arg0: &Config, arg1: u128) : u128 {
        let v0 = 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::mul_div_128(0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::e18(), (8000 as u128), (10000 as u128));
        let v1 = if (arg1 > v0) {
            0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::mul_div_128(1000000000000000, arg1 - v0, 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::e18() - v0)
        } else {
            0
        };
        arg0.borrow_base_e18_per_hour + 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::mul_div_128(arg0.borrow_slope_e18_per_hour, arg1, 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::e18()) + v1
    }

    public fun cancel_config<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>) {
        assert_admin<T0>(arg0, arg1);
        arg1.pending_config = 0x1::option::none<Config>();
        arg1.pending_config_ready_ms = 0;
        let v0 = ConfigProposalCancelled{exchange_id: 0x2::object::id<Exchange<T0>>(arg1)};
        0x2::event::emit<ConfigProposalCancelled>(v0);
    }

    public fun cancel_pool_oracle<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>) {
        assert_admin<T0>(arg0, arg1);
        arg1.pending_pool_oracle_id = 0x1::option::none<0x2::object::ID>();
        arg1.pending_pool_oracle_ready_ms = 0;
        let v0 = PoolOracleProposalCancelled{exchange_id: 0x2::object::id<Exchange<T0>>(arg1)};
        0x2::event::emit<PoolOracleProposalCancelled>(v0);
    }

    public fun cancel_request<T0>(arg0: &mut Exchange<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(0x2::table::contains<u64, Request<T0>>(&arg0.requests, arg1), 24);
        let v0 = 0x2::table::borrow<u64, Request<T0>>(&arg0.requests, arg1);
        assert!(v0.owner == 0x2::tx_context::sender(arg3), 9);
        assert!(v0.kind == 3 || v0.kind == 4 || 0x2::clock::timestamp_ms(arg2) >= v0.created_ms + arg0.config.request_timeout_ms, 23);
        remove_request_refund<T0>(arg0, arg1, false, arg2, arg3);
    }

    fun check_close_price<T0>(arg0: &Exchange<T0>, arg1: &0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::Price, arg2: u64, arg3: u64, arg4: bool) {
        let v0 = 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::publish_ms(arg1);
        assert!(v0 <= arg3 && arg3 - v0 <= arg0.config.max_price_age_ms, 11);
        if (arg4) {
            assert!(v0 >= arg2, 12);
        };
        assert!(0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::price(arg1) > 0 && 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::deviation_bps(0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::price(arg1) + 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::conf(arg1), 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::price(arg1)) <= 0x1::u64::max(arg0.config.max_conf_bps, 500), 26);
    }

    public(friend) fun check_oracle_price<T0>(arg0: &Exchange<T0>, arg1: &0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::Price, arg2: u64, arg3: bool) {
        if (arg3) {
            check_close_price<T0>(arg0, arg1, 0, arg2, false);
        } else {
            check_price<T0>(arg0, arg1, 0, arg2, false);
        };
    }

    fun check_price<T0>(arg0: &Exchange<T0>, arg1: &0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::Price, arg2: u64, arg3: u64, arg4: bool) {
        let v0 = 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::publish_ms(arg1);
        assert!(v0 <= arg3 && arg3 - v0 <= arg0.config.max_price_age_ms, 11);
        if (arg4) {
            assert!(v0 >= arg2, 12);
        };
        assert!(0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::price(arg1) > 0 && 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::deviation_bps(0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::price(arg1) + 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::conf(arg1), 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::price(arg1)) <= arg0.config.max_conf_bps, 26);
    }

    public fun collateral_decimals<T0>(arg0: &Exchange<T0>) : u8 {
        arg0.collateral_decimals
    }

    public(friend) fun collateral_price_at(arg0: u128, arg1: u128, arg2: u64) : CollateralPrice {
        CollateralPrice{
            spot        : arg0,
            twap        : arg1,
            recorded_ms : arg2,
        }
    }

    public fun config<T0>(arg0: &Exchange<T0>) : Config {
        arg0.config
    }

    public fun create<T0>(arg0: address, arg1: u8, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: Config, arg5: &mut 0x2::tx_context::TxContext) : AdminCap {
        assert_config(&arg4);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 6);
        assert!(arg1 == 9, 6);
        let v0 = Exchange<T0>{
            id                           : 0x2::object::new(arg5),
            version                      : 1,
            liquidity                    : 0x2::balance::zero<T0>(),
            reserved                     : 0,
            fees                         : 0x2::balance::zero<T0>(),
            treasury                     : arg0,
            config                       : arg4,
            markets                      : 0x1::vector::empty<Market>(),
            positions                    : 0x2::table::new<PositionKey, Position<T0>>(arg5),
            requests                     : 0x2::table::new<u64, Request<T0>>(arg5),
            next_request_id              : 0,
            next_position_seq            : 1,
            pending_config               : 0x1::option::none<Config>(),
            pending_config_ready_ms      : 0,
            keepers                      : 0x2::vec_set::empty<0x2::object::ID>(),
            paused                       : false,
            collateral_decimals          : arg1,
            pool_oracle_id               : arg2,
            sui_feed_id                  : arg3,
            pending_pool_oracle_id       : 0x1::option::none<0x2::object::ID>(),
            pending_pool_oracle_ready_ms : 0,
        };
        let v1 = 0x2::object::id<Exchange<T0>>(&v0);
        let v2 = AdminCap{
            id          : 0x2::object::new(arg5),
            exchange_id : v1,
        };
        let v3 = ExchangeCreated{
            exchange_id    : v1,
            admin_cap_id   : 0x2::object::id<AdminCap>(&v2),
            pool_oracle_id : arg2,
        };
        0x2::event::emit<ExchangeCreated>(v3);
        0x2::transfer::share_object<Exchange<T0>>(v0);
        v2
    }

    fun decrease<T0>(arg0: &mut Exchange<T0>, arg1: PositionKey, arg2: u64, arg3: u128, arg4: CollateralPrice, arg5: u64, arg6: u64) : 0x2::balance::Balance<T0> {
        accrue_all<T0>(arg0, arg5);
        let v0 = arg0.collateral_decimals;
        let v1 = 0x1::vector::borrow<Market>(&arg0.markets, arg1.market_id).cumulative_borrow_e18;
        let v2 = 0x2::table::borrow_mut<PositionKey, Position<T0>>(&mut arg0.positions, arg1);
        let v3 = v2.size_usd;
        let v4 = 0x1::u64::min(arg2, v3);
        let v5 = v4 == v3;
        v2.borrow_snapshot_e18 = v1;
        let v6 = borrow_fee_usd<T0>(v2, v1) + 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::mul_div_up(v4, 0x1::vector::borrow<Market>(&arg0.markets, arg1.market_id).close_fee_bps, 10000);
        let v7 = 0x1::u64::min(0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::usd_to_units_up(v6, arg4.twap, v0), 0x2::balance::value<T0>(&v2.collateral));
        let (v8, v9) = pnl_usd<T0>(v2, arg3);
        let v10 = 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::mul_div(v9, v4, v3);
        let v11 = if (v5) {
            0x2::balance::value<T0>(&v2.collateral)
        } else {
            0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::mul_div(0x2::balance::value<T0>(&v2.collateral), v4, v3)
        };
        let v12 = if (v5) {
            v2.reserved
        } else {
            0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::mul_div(v2.reserved, v4, v3)
        };
        let v13 = 0x2::balance::split<T0>(&mut v2.collateral, v11);
        let v14 = false;
        let v15 = if (v8) {
            let v16 = 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::usd_to_units(v10, min(max(arg4.spot, arg4.twap), 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::mul_div_128(arg4.twap, ((10000 + arg0.config.max_pool_deviation_bps) as u128), (10000 as u128))), v0);
            v14 = v16 > v12;
            0x1::u64::min(v16, v12)
        } else {
            let v17 = 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::usd_to_units_up(v10, arg4.twap, v0);
            if (!v5) {
                assert!(v17 <= 0x2::balance::value<T0>(&v13), 21);
            };
            0x1::u64::min(v17, 0x2::balance::value<T0>(&v13))
        };
        v2.reserved = v2.reserved - v12;
        v2.size_usd = v3 - v4;
        v2.updated_ms = arg5;
        if (v8) {
            0x2::balance::join<T0>(&mut v13, 0x2::balance::split<T0>(&mut arg0.liquidity, v15));
        } else {
            0x2::balance::join<T0>(&mut arg0.liquidity, 0x2::balance::split<T0>(&mut v13, v15));
        };
        arg0.reserved = arg0.reserved - v12;
        0x2::balance::join<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut v2.collateral, v7));
        let v18 = 0x1::vector::borrow_mut<Market>(&mut arg0.markets, arg1.market_id);
        v18.reserved = v18.reserved - v12;
        if (arg1.is_long) {
            v18.oi_long_usd = v18.oi_long_usd - v4;
        } else {
            v18.oi_short_usd = v18.oi_short_usd - v4;
        };
        if (v5) {
            remove_position<T0>(arg0, arg1);
        };
        let v19 = PositionDecreased{
            exchange_id    : 0x2::object::id<Exchange<T0>>(arg0),
            request_id     : arg6,
            owner          : arg1.owner,
            market_id      : arg1.market_id,
            is_long        : arg1.is_long,
            size_delta_usd : v4,
            price          : arg3,
            is_profit      : v8,
            pnl_usd        : v10,
            pnl_units      : v15,
            profit_capped  : v14,
            fee_usd        : v6,
            fee_units      : v7,
            payout         : 0x2::balance::value<T0>(&v13),
            size_usd       : v3 - v4,
            collateral     : 0x2::balance::value<T0>(&v2.collateral),
            closed         : v5,
            timestamp_ms   : arg5,
        };
        0x2::event::emit<PositionDecreased>(v19);
        v13
    }

    public fun deposit_liquidity<T0>(arg0: &mut Exchange<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 7);
        accrue_all<T0>(arg0, 0x2::clock::timestamp_ms(arg2));
        0x2::balance::join<T0>(&mut arg0.liquidity, 0x2::coin::into_balance<T0>(arg1));
        let v1 = LiquidityDeposited{
            exchange_id : 0x2::object::id<Exchange<T0>>(arg0),
            sender      : 0x2::tx_context::sender(arg3),
            amount      : v0,
            total       : 0x2::balance::value<T0>(&arg0.liquidity),
        };
        0x2::event::emit<LiquidityDeposited>(v1);
    }

    fun equity_usd<T0>(arg0: &Position<T0>, arg1: u128, arg2: u128, arg3: u8, arg4: u128, arg5: u64) : (bool, u64) {
        let (v0, v1) = pnl_usd<T0>(arg0, arg1);
        let v2 = if (v0) {
            0
        } else {
            (v1 as u128)
        };
        let v3 = (borrow_fee_usd<T0>(arg0, arg4) as u128) + (0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::mul_div_up(arg0.size_usd, arg5, 10000) as u128) + v2;
        let v4 = if (v0) {
            (v1 as u128)
        } else {
            0
        };
        let v5 = (0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::units_to_usd(0x2::balance::value<T0>(&arg0.collateral), arg2, arg3) as u128) + v4;
        if (v5 >= v3) {
            (false, ((v5 - v3) as u64))
        } else {
            (true, ((v3 - v5) as u64))
        }
    }

    public(friend) fun execute_decrease<T0>(arg0: &mut Exchange<T0>, arg1: 0x1::option::Option<0x2::object::ID>, arg2: address, arg3: u64, arg4: 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::Price, arg5: CollateralPrice, arg6: u64) : (address, 0x2::balance::Balance<T0>) {
        assert_version<T0>(arg0);
        assert!(0x2::table::contains<u64, Request<T0>>(&arg0.requests, arg3), 24);
        let v0 = 0x2::table::borrow<u64, Request<T0>>(&arg0.requests, arg3).kind;
        assert!(v0 == 1 || v0 == 4, 10);
        let v1 = 0x2::table::borrow<u64, Request<T0>>(&arg0.requests, arg3).created_ms;
        let v2 = 0x1::option::is_some<0x2::object::ID>(&arg1) && 0x2::vec_set::contains<0x2::object::ID>(&arg0.keepers, 0x1::option::borrow<0x2::object::ID>(&arg1));
        let v3 = v1 + arg0.config.self_execute_after_ms;
        let v4 = if (v0 == 1) {
            if (arg2 == 0x2::table::borrow<u64, Request<T0>>(&arg0.requests, arg3).owner) {
                arg6 >= v3
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2 || v4, 3);
        if (v0 == 1) {
            let v5 = if (v2) {
                v1 + arg0.config.request_timeout_ms
            } else {
                v3 + arg0.config.request_timeout_ms
            };
            assert!(arg6 < v5, 34);
        };
        let Request {
            owner            : v6,
            market_id        : v7,
            is_long          : v8,
            kind             : v9,
            collateral       : v10,
            size_delta_usd   : v11,
            withdraw_units   : _,
            acceptable_price : v13,
            trigger_price    : v14,
            trigger_above    : v15,
            position_seq     : v16,
            created_ms       : v17,
        } = 0x2::table::remove<u64, Request<T0>>(&mut arg0.requests, arg3);
        0x2::balance::destroy_zero<T0>(v10);
        if (v9 == 4) {
            release_trigger_slot<T0>(arg0, v6, v7, v8, v16);
            assert!(trigger_reached(&arg4, v14, v15), 14);
        };
        check_close_price<T0>(arg0, &arg4, v17, arg6, true);
        let v18 = execution_price(&arg4, v8, false);
        assert!(v8 && v18 >= v13 || v18 <= v13, 13);
        let v19 = PositionKey{
            owner     : v6,
            market_id : v7,
            is_long   : v8,
        };
        assert!(0x2::table::contains<PositionKey, Position<T0>>(&arg0.positions, v19), 8);
        assert!(0x2::table::borrow<PositionKey, Position<T0>>(&arg0.positions, v19).seq == v16, 30);
        (v6, decrease<T0>(arg0, v19, v11, v18, arg5, arg6, arg3))
    }

    public(friend) fun execute_increase<T0>(arg0: &mut Exchange<T0>, arg1: &KeeperCap, arg2: u64, arg3: 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::Price, arg4: CollateralPrice, arg5: u64) {
        assert_keeper<T0>(arg0, arg1);
        assert!(0x2::table::contains<u64, Request<T0>>(&arg0.requests, arg2), 24);
        let v0 = 0x2::table::borrow<u64, Request<T0>>(&arg0.requests, arg2).kind;
        assert!(v0 == 0 || v0 == 3, 10);
        let Request {
            owner            : v1,
            market_id        : v2,
            is_long          : v3,
            kind             : v4,
            collateral       : v5,
            size_delta_usd   : v6,
            withdraw_units   : _,
            acceptable_price : v8,
            trigger_price    : v9,
            trigger_above    : v10,
            position_seq     : _,
            created_ms       : v12,
        } = 0x2::table::remove<u64, Request<T0>>(&mut arg0.requests, arg2);
        let v13 = v5;
        assert_open_allowed<T0>(arg0, v2);
        check_price<T0>(arg0, &arg3, v12, arg5, true);
        assert_pool_price_fresh(&arg4, arg5);
        if (v4 == 3) {
            assert!(trigger_reached(&arg3, v9, v10), 14);
        };
        if (v4 == 0) {
            assert!(arg5 < v12 + arg0.config.request_timeout_ms, 23);
        };
        let v14 = execution_price(&arg3, v3, true);
        assert!(v3 && v14 <= v8 || v14 >= v8, 13);
        assert!(0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::deviation_bps(arg4.spot, arg4.twap) <= arg0.config.max_pool_deviation_bps, 20);
        accrue_all<T0>(arg0, arg5);
        let v15 = PositionKey{
            owner     : v1,
            market_id : v2,
            is_long   : v3,
        };
        if (!0x2::table::contains<PositionKey, Position<T0>>(&arg0.positions, v15)) {
            let v16 = arg0.next_position_seq;
            arg0.next_position_seq = v16 + 1;
            let v17 = Position<T0>{
                owner               : v1,
                market_id           : v2,
                is_long             : v3,
                size_usd            : 0,
                collateral          : 0x2::balance::zero<T0>(),
                entry_price         : 0,
                borrow_snapshot_e18 : 0x1::vector::borrow<Market>(&arg0.markets, v2).cumulative_borrow_e18,
                reserved            : 0,
                trigger_orders      : 0,
                seq                 : v16,
                opened_ms           : arg5,
                updated_ms          : arg5,
            };
            0x2::table::add<PositionKey, Position<T0>>(&mut arg0.positions, v15, v17);
        };
        let v18 = arg0.collateral_decimals;
        let v19 = 0x1::vector::borrow<Market>(&arg0.markets, v2).cumulative_borrow_e18;
        let v20 = 0x1::vector::borrow<Market>(&arg0.markets, v2);
        let v21 = v20.open_fee_bps;
        let v22 = v20.max_position_usd;
        let v23 = v20.max_oi_usd;
        let v24 = arg0.config;
        let v25 = 0x2::table::borrow_mut<PositionKey, Position<T0>>(&mut arg0.positions, v15);
        0x2::balance::join<T0>(&mut v25.collateral, v13);
        let v26 = 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::mul_div_up(v6, v21, 10000) + borrow_fee_usd<T0>(v25, v19);
        let v27 = 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::usd_to_units_up(v26, arg4.twap, v18);
        assert!(0x2::balance::value<T0>(&v25.collateral) > v27, 21);
        let v28 = v25.size_usd + v6;
        assert!(v28 <= v22, 17);
        let v29 = if (v25.size_usd == 0) {
            v14
        } else {
            (((v28 as u256) * (v25.entry_price as u256) * (v14 as u256) / ((v25.size_usd as u256) * (v14 as u256) + (v6 as u256) * (v25.entry_price as u256))) as u128)
        };
        v25.entry_price = v29;
        v25.size_usd = v28;
        v25.borrow_snapshot_e18 = v19;
        v25.updated_ms = arg5;
        let (v30, v31) = pnl_usd<T0>(v25, execution_price(&arg3, v3, false));
        let v32 = 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::units_to_usd(0x2::balance::value<T0>(&v25.collateral), min(arg4.spot, arg4.twap), v18);
        let v33 = if (v30) {
            v32
        } else if (v32 > v31) {
            v32 - v31
        } else {
            0
        };
        assert!(v33 > 0, 15);
        let v34 = 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::mul_div(v28, 10000, v33);
        assert!(v34 <= v24.max_leverage_bps, 15);
        assert!(v34 >= v24.min_leverage_bps, 16);
        let v35 = 0x1::u64::min(mul_sat(0x2::balance::value<T0>(&v25.collateral), 4), 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::usd_to_units(0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::mul_div(v28, 4 * 10000, 100000), arg4.twap, v18));
        let v36 = if (v35 > v25.reserved) {
            v35 - v25.reserved
        } else {
            0
        };
        assert!(v36 <= free_liquidity<T0>(arg0), 19);
        v25.reserved = v25.reserved + v36;
        let v37 = v25.reserved;
        arg0.reserved = arg0.reserved + v36;
        0x2::balance::join<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut v25.collateral, v27));
        let v38 = 0x1::vector::borrow_mut<Market>(&mut arg0.markets, v2);
        v38.reserved = v38.reserved + v36;
        assert!(v36 == 0 || v38.reserved <= 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::mul_div(0x2::balance::value<T0>(&arg0.liquidity), 3500, 10000), 35);
        if (v3) {
            v38.oi_long_usd = v38.oi_long_usd + v6;
            assert!(v38.oi_long_usd <= v23, 18);
        } else {
            v38.oi_short_usd = v38.oi_short_usd + v6;
            assert!(v38.oi_short_usd <= v23, 18);
        };
        let v39 = PositionIncreased{
            exchange_id      : 0x2::object::id<Exchange<T0>>(arg0),
            request_id       : arg2,
            owner            : v1,
            market_id        : v2,
            is_long          : v3,
            size_delta_usd   : v6,
            collateral_added : 0x2::balance::value<T0>(&v13),
            price            : v14,
            size_usd         : v25.size_usd,
            collateral       : 0x2::balance::value<T0>(&v25.collateral),
            entry_price      : v25.entry_price,
            fee_usd          : v26,
            fee_units        : v27,
            reserved         : v37,
            timestamp_ms     : arg5,
        };
        0x2::event::emit<PositionIncreased>(v39);
    }

    public(friend) fun execute_withdraw<T0>(arg0: &mut Exchange<T0>, arg1: &KeeperCap, arg2: u64, arg3: 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::Price, arg4: CollateralPrice, arg5: u64) : (address, 0x2::balance::Balance<T0>) {
        assert_keeper<T0>(arg0, arg1);
        assert!(0x2::table::contains<u64, Request<T0>>(&arg0.requests, arg2), 24);
        assert!(0x2::table::borrow<u64, Request<T0>>(&arg0.requests, arg2).kind == 2, 10);
        let Request {
            owner            : v0,
            market_id        : v1,
            is_long          : v2,
            kind             : _,
            collateral       : v4,
            size_delta_usd   : _,
            withdraw_units   : v6,
            acceptable_price : _,
            trigger_price    : _,
            trigger_above    : _,
            position_seq     : v10,
            created_ms       : v11,
        } = 0x2::table::remove<u64, Request<T0>>(&mut arg0.requests, arg2);
        0x2::balance::destroy_zero<T0>(v4);
        check_price<T0>(arg0, &arg3, v11, arg5, true);
        assert!(arg5 < v11 + arg0.config.request_timeout_ms, 34);
        assert_pool_price_fresh(&arg4, arg5);
        assert!(0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::deviation_bps(arg4.spot, arg4.twap) <= arg0.config.max_pool_deviation_bps, 20);
        accrue_all<T0>(arg0, arg5);
        let v12 = PositionKey{
            owner     : v0,
            market_id : v1,
            is_long   : v2,
        };
        assert!(0x2::table::contains<PositionKey, Position<T0>>(&arg0.positions, v12), 8);
        assert!(0x2::table::borrow<PositionKey, Position<T0>>(&arg0.positions, v12).seq == v10, 30);
        let v13 = arg0.collateral_decimals;
        let v14 = 0x1::vector::borrow<Market>(&arg0.markets, v1).cumulative_borrow_e18;
        let v15 = 0x2::table::borrow_mut<PositionKey, Position<T0>>(&mut arg0.positions, v12);
        v15.borrow_snapshot_e18 = v14;
        let v16 = 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::usd_to_units_up(borrow_fee_usd<T0>(v15, v14), arg4.twap, v13);
        assert!(0x2::balance::value<T0>(&v15.collateral) > v16 + v6, 21);
        let v17 = 0x2::balance::split<T0>(&mut v15.collateral, v6);
        let (v18, v19) = pnl_usd<T0>(v15, execution_price(&arg3, v2, false));
        let v20 = 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::units_to_usd(0x2::balance::value<T0>(&v15.collateral), min(arg4.spot, arg4.twap), v13);
        let v21 = if (v18) {
            v20
        } else if (v20 > v19) {
            v20 - v19
        } else {
            0
        };
        assert!(v21 > 0 && 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::mul_div(v15.size_usd, 10000, v21) <= arg0.config.max_leverage_bps, 15);
        let v22 = mul_sat(0x2::balance::value<T0>(&v15.collateral), 4);
        let v23 = if (v15.reserved > v22) {
            v15.reserved - v22
        } else {
            0
        };
        v15.reserved = v15.reserved - v23;
        v15.updated_ms = arg5;
        let v24 = 0x2::balance::value<T0>(&v15.collateral);
        arg0.reserved = arg0.reserved - v23;
        0x2::balance::join<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut v15.collateral, v16));
        let v25 = 0x1::vector::borrow_mut<Market>(&mut arg0.markets, v1);
        v25.reserved = v25.reserved - v23;
        let v26 = CollateralWithdrawn{
            exchange_id  : 0x2::object::id<Exchange<T0>>(arg0),
            request_id   : arg2,
            owner        : v0,
            market_id    : v1,
            is_long      : v2,
            amount       : v6,
            fee_units    : v16,
            collateral   : v24,
            timestamp_ms : arg5,
        };
        0x2::event::emit<CollateralWithdrawn>(v26);
        (v0, v17)
    }

    fun execution_price(arg0: &0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::Price, arg1: bool, arg2: bool) : u128 {
        if (arg1 == arg2) {
            0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::price(arg0) + 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::conf(arg0)
        } else {
            0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::price(arg0) - 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::conf(arg0)
        }
    }

    public fun expire_request<T0>(arg0: &mut Exchange<T0>, arg1: &KeeperCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_keeper<T0>(arg0, arg1);
        assert!(0x2::table::contains<u64, Request<T0>>(&arg0.requests, arg2), 24);
        let v0 = 0x2::table::borrow<u64, Request<T0>>(&arg0.requests, arg2);
        let v1 = if (v0.kind == 3) {
            false
        } else if (v0.kind == 4) {
            let v2 = PositionKey{
                owner     : v0.owner,
                market_id : v0.market_id,
                is_long   : v0.is_long,
            };
            !0x2::table::contains<PositionKey, Position<T0>>(&arg0.positions, v2) || 0x2::table::borrow<PositionKey, Position<T0>>(&arg0.positions, v2).seq != v0.position_seq
        } else {
            v0.kind == 1 && 0x2::clock::timestamp_ms(arg3) >= v0.created_ms + arg0.config.self_execute_after_ms + arg0.config.request_timeout_ms || 0x2::clock::timestamp_ms(arg3) >= v0.created_ms + arg0.config.request_timeout_ms
        };
        assert!(v1, 23);
        remove_request_refund<T0>(arg0, arg2, true, arg3, arg4);
    }

    public fun fees<T0>(arg0: &Exchange<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.fees)
    }

    public fun free_liquidity<T0>(arg0: &Exchange<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.liquidity) - arg0.reserved
    }

    public fun hard_max_leverage_bps() : u64 {
        100000
    }

    public fun has_position<T0>(arg0: &Exchange<T0>, arg1: address, arg2: u64, arg3: bool) : bool {
        let v0 = PositionKey{
            owner     : arg1,
            market_id : arg2,
            is_long   : arg3,
        };
        0x2::table::contains<PositionKey, Position<T0>>(&arg0.positions, v0)
    }

    public fun has_request<T0>(arg0: &Exchange<T0>, arg1: u64) : bool {
        0x2::table::contains<u64, Request<T0>>(&arg0.requests, arg1)
    }

    public fun is_liquidatable<T0>(arg0: &Exchange<T0>, arg1: address, arg2: u64, arg3: bool, arg4: &0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::Price, arg5: u128, arg6: u64) : bool {
        let v0 = PositionKey{
            owner     : arg1,
            market_id : arg2,
            is_long   : arg3,
        };
        if (!0x2::table::contains<PositionKey, Position<T0>>(&arg0.positions, v0)) {
            return false
        };
        let v1 = 0x1::vector::borrow<Market>(&arg0.markets, arg2);
        let v2 = 0x2::balance::value<T0>(&arg0.liquidity);
        let v3 = if (v2 == 0) {
            0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::e18()
        } else {
            min(0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::mul_div_128((arg0.reserved as u128), 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::e18(), (v2 as u128)), 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::e18())
        };
        let v4 = if (arg6 > v1.last_borrow_ms) {
            v1.cumulative_borrow_e18 + 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::mul_div_128(borrow_rate(&arg0.config, v3), ((arg6 - v1.last_borrow_ms) as u128), 3600000)
        } else {
            v1.cumulative_borrow_e18
        };
        let v5 = 0x2::table::borrow<PositionKey, Position<T0>>(&arg0.positions, v0);
        let (v6, v7) = equity_usd<T0>(v5, liquidation_price_of<T0>(arg0, arg4, arg3), arg5, arg0.collateral_decimals, v4, v1.close_fee_bps);
        v6 || v7 <= 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::mul_div(v5.size_usd, arg0.config.maintenance_bps, 10000)
    }

    public(friend) fun liquidate<T0>(arg0: &mut Exchange<T0>, arg1: address, arg2: u64, arg3: bool, arg4: 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::Price, arg5: CollateralPrice, arg6: u64, arg7: address) : 0x2::balance::Balance<T0> {
        assert_version<T0>(arg0);
        assert!(arg2 < 0x1::vector::length<Market>(&arg0.markets), 28);
        check_close_price<T0>(arg0, &arg4, 0, arg6, false);
        let v0 = PositionKey{
            owner     : arg1,
            market_id : arg2,
            is_long   : arg3,
        };
        assert!(0x2::table::contains<PositionKey, Position<T0>>(&arg0.positions, v0), 8);
        accrue_all<T0>(arg0, arg6);
        let v1 = arg0.collateral_decimals;
        let v2 = 0x1::vector::borrow<Market>(&arg0.markets, arg2).cumulative_borrow_e18;
        let v3 = 0x1::vector::borrow<Market>(&arg0.markets, arg2).close_fee_bps;
        let v4 = liquidation_price_of<T0>(arg0, &arg4, arg3);
        let v5 = 0x2::table::borrow<PositionKey, Position<T0>>(&arg0.positions, v0);
        let v6 = v5.size_usd;
        let (v7, v8) = equity_usd<T0>(v5, v4, arg5.twap, v1, v2, v3);
        assert!(v7 || v8 <= 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::mul_div(v6, arg0.config.maintenance_bps, 10000), 22);
        let v9 = borrow_fee_usd<T0>(v5, v2) + 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::mul_div_up(v6, v3, 10000);
        let v10 = 0x2::balance::value<T0>(&v5.collateral);
        let v11 = v5.reserved;
        let v12 = 0x2::table::borrow_mut<PositionKey, Position<T0>>(&mut arg0.positions, v0);
        v12.reserved = 0;
        let v13 = 0x1::u64::min(0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::usd_to_units(0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::mul_div(v6, arg0.config.liquidation_reward_bps, 10000), arg5.twap, v1), 0x2::balance::value<T0>(&v12.collateral));
        let v14 = 0x1::u64::min(0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::usd_to_units_up(v9, arg5.twap, v1), 0x2::balance::value<T0>(&v12.collateral));
        arg0.reserved = arg0.reserved - v11;
        0x2::balance::join<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut v12.collateral, v14));
        let v15 = 0x1::vector::borrow_mut<Market>(&mut arg0.markets, arg2);
        v15.reserved = v15.reserved - v11;
        if (arg3) {
            v15.oi_long_usd = v15.oi_long_usd - v6;
        } else {
            v15.oi_short_usd = v15.oi_short_usd - v6;
        };
        remove_position<T0>(arg0, v0);
        let v16 = PositionLiquidated{
            exchange_id     : 0x2::object::id<Exchange<T0>>(arg0),
            owner           : arg1,
            market_id       : arg2,
            is_long         : arg3,
            size_usd        : v6,
            price           : v4,
            collateral      : v10,
            equity_negative : v7,
            equity_usd      : v8,
            reward          : v13,
            fee_units       : v14,
            to_pool         : 0x2::balance::value<T0>(&v12.collateral),
            liquidator      : arg7,
            timestamp_ms    : arg6,
        };
        0x2::event::emit<PositionLiquidated>(v16);
        0x2::balance::split<T0>(&mut v12.collateral, v13)
    }

    fun liquidation_price_of<T0>(arg0: &Exchange<T0>, arg1: &0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::Price, arg2: bool) : u128 {
        if (arg2) {
            0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::price(arg1) + min(0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::conf(arg1), 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::mul_div_128(0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::price(arg1), (arg0.config.max_conf_bps as u128), (10000 as u128)))
        } else {
            0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::price(arg1) - min(0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::conf(arg1), 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::mul_div_128(0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::price(arg1), (arg0.config.max_conf_bps as u128), (10000 as u128)))
        }
    }

    public fun liquidity<T0>(arg0: &Exchange<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.liquidity)
    }

    public fun market_count<T0>(arg0: &Exchange<T0>) : u64 {
        0x1::vector::length<Market>(&arg0.markets)
    }

    public fun market_feed_id<T0>(arg0: &Exchange<T0>, arg1: u64) : vector<u8> {
        0x1::vector::borrow<Market>(&arg0.markets, arg1).feed_id
    }

    public fun market_oi<T0>(arg0: &Exchange<T0>, arg1: u64) : (u64, u64) {
        (0x1::vector::borrow<Market>(&arg0.markets, arg1).oi_long_usd, 0x1::vector::borrow<Market>(&arg0.markets, arg1).oi_short_usd)
    }

    public fun market_reserved<T0>(arg0: &Exchange<T0>, arg1: u64) : u64 {
        0x1::vector::borrow<Market>(&arg0.markets, arg1).reserved
    }

    public fun max_profit_multiple() : u64 {
        4
    }

    public fun migrate<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>) {
        assert!(arg0.exchange_id == 0x2::object::id<Exchange<T0>>(arg1), 2);
        assert!(arg1.version < 1, 1);
        arg1.version = 1;
    }

    public fun mint_keeper_cap<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>, arg2: &mut 0x2::tx_context::TxContext) : KeeperCap {
        assert_admin<T0>(arg0, arg1);
        let v0 = KeeperCap{
            id          : 0x2::object::new(arg2),
            exchange_id : 0x2::object::id<Exchange<T0>>(arg1),
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.keepers, 0x2::object::id<KeeperCap>(&v0));
        let v1 = KeeperChanged{
            exchange_id   : 0x2::object::id<Exchange<T0>>(arg1),
            keeper_cap_id : 0x2::object::id<KeeperCap>(&v0),
            active        : true,
        };
        0x2::event::emit<KeeperChanged>(v1);
        v0
    }

    fun mul_sat(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0 as u64)
        }
    }

    public fun new_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: u128, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) : Config {
        let v0 = Config{
            max_leverage_bps          : arg0,
            min_leverage_bps          : arg1,
            maintenance_bps           : arg2,
            liquidation_reward_bps    : arg3,
            borrow_base_e18_per_hour  : arg4,
            borrow_slope_e18_per_hour : arg5,
            request_timeout_ms        : arg6,
            self_execute_after_ms     : arg7,
            max_price_age_ms          : arg8,
            max_conf_bps              : arg9,
            max_pool_deviation_bps    : arg10,
        };
        assert_config(&v0);
        v0
    }

    fun new_request<T0>(arg0: &mut Exchange<T0>, arg1: u64, arg2: bool, arg3: u8, arg4: 0x2::balance::Balance<T0>, arg5: u64, arg6: u64, arg7: u128, arg8: u128, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock, arg12: &0x2::tx_context::TxContext) : u64 {
        assert!(arg1 < 0x1::vector::length<Market>(&arg0.markets), 28);
        let v0 = arg0.next_request_id;
        arg0.next_request_id = v0 + 1;
        let v1 = 0x2::clock::timestamp_ms(arg11);
        let v2 = RequestCreated{
            exchange_id      : 0x2::object::id<Exchange<T0>>(arg0),
            request_id       : v0,
            owner            : 0x2::tx_context::sender(arg12),
            market_id        : arg1,
            is_long          : arg2,
            kind             : arg3,
            collateral       : 0x2::balance::value<T0>(&arg4),
            size_delta_usd   : arg5,
            withdraw_units   : arg6,
            acceptable_price : arg7,
            trigger_price    : arg8,
            trigger_above    : arg9,
            timestamp_ms     : v1,
        };
        0x2::event::emit<RequestCreated>(v2);
        let v3 = Request<T0>{
            owner            : 0x2::tx_context::sender(arg12),
            market_id        : arg1,
            is_long          : arg2,
            kind             : arg3,
            collateral       : arg4,
            size_delta_usd   : arg5,
            withdraw_units   : arg6,
            acceptable_price : arg7,
            trigger_price    : arg8,
            trigger_above    : arg9,
            position_seq     : arg10,
            created_ms       : v1,
        };
        0x2::table::add<u64, Request<T0>>(&mut arg0.requests, v0, v3);
        v0
    }

    public fun paused<T0>(arg0: &Exchange<T0>) : bool {
        arg0.paused
    }

    public fun pending_config<T0>(arg0: &Exchange<T0>) : (bool, u64) {
        (0x1::option::is_some<Config>(&arg0.pending_config), arg0.pending_config_ready_ms)
    }

    public fun pending_market_fees<T0>(arg0: &Exchange<T0>, arg1: u64) : (u64, u64, u64) {
        let v0 = 0x1::vector::borrow<Market>(&arg0.markets, arg1);
        (v0.pending_open_fee_bps, v0.pending_close_fee_bps, v0.pending_fees_ready_ms)
    }

    public fun pending_pool_oracle<T0>(arg0: &Exchange<T0>) : (0x1::option::Option<0x2::object::ID>, u64) {
        (arg0.pending_pool_oracle_id, arg0.pending_pool_oracle_ready_ms)
    }

    fun pnl_usd<T0>(arg0: &Position<T0>, arg1: u128) : (bool, u64) {
        if (arg0.size_usd == 0) {
            return (true, 0)
        };
        let v0 = arg0.entry_price;
        let v1 = arg1 >= v0;
        let v2 = if (v1) {
            arg1 - v0
        } else {
            v0 - arg1
        };
        let v3 = (arg0.size_usd as u256) * (v2 as u256) / (v0 as u256);
        let v4 = if (v3 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v3 as u64)
        };
        let v5 = v1 == arg0.is_long || v4 == 0;
        (v5, v4)
    }

    public fun pool_oracle_id<T0>(arg0: &Exchange<T0>) : 0x2::object::ID {
        arg0.pool_oracle_id
    }

    public fun position<T0>(arg0: &Exchange<T0>, arg1: address, arg2: u64, arg3: bool) : (u64, u64, u128, u64, u64) {
        let v0 = PositionKey{
            owner     : arg1,
            market_id : arg2,
            is_long   : arg3,
        };
        let v1 = 0x2::table::borrow<PositionKey, Position<T0>>(&arg0.positions, v0);
        (v1.size_usd, 0x2::balance::value<T0>(&v1.collateral), v1.entry_price, v1.reserved, v1.trigger_orders)
    }

    public fun position_seq<T0>(arg0: &Exchange<T0>, arg1: address, arg2: u64, arg3: bool) : u64 {
        let v0 = PositionKey{
            owner     : arg1,
            market_id : arg2,
            is_long   : arg3,
        };
        0x2::table::borrow<PositionKey, Position<T0>>(&arg0.positions, v0).seq
    }

    public fun propose_config<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>, arg2: Config, arg3: &0x2::clock::Clock) {
        assert_admin<T0>(arg0, arg1);
        assert_config(&arg2);
        let v0 = 0x2::clock::timestamp_ms(arg3) + 86400000;
        arg1.pending_config = 0x1::option::some<Config>(arg2);
        arg1.pending_config_ready_ms = v0;
        let v1 = ConfigProposed{
            exchange_id : 0x2::object::id<Exchange<T0>>(arg1),
            config      : arg2,
            ready_ms    : v0,
        };
        0x2::event::emit<ConfigProposed>(v1);
    }

    public fun propose_pool_oracle<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>, arg2: &0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::pool_price::PoolPriceOracle, arg3: &0x2::clock::Clock) {
        assert_admin<T0>(arg0, arg1);
        assert!(0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::pool_price::collateral_type(arg2) == 0x1::type_name::with_defining_ids<T0>(), 36);
        let (v0, v1, v2) = 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::pool_price::params(arg2);
        let v3 = if (v0 >= 30000) {
            if (v1 <= 100) {
                v2 >= 1800000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 38);
        let v4 = 0x2::object::id<0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::pool_price::PoolPriceOracle>(arg2);
        let v5 = 0x2::clock::timestamp_ms(arg3) + 86400000;
        arg1.pending_pool_oracle_id = 0x1::option::some<0x2::object::ID>(v4);
        arg1.pending_pool_oracle_ready_ms = v5;
        let v6 = PoolOracleProposed{
            exchange_id    : 0x2::object::id<Exchange<T0>>(arg1),
            pool_oracle_id : v4,
            pool_id        : 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::pool_price::pool_id(arg2),
            ready_ms       : v5,
        };
        0x2::event::emit<PoolOracleProposed>(v6);
    }

    fun release_trigger_slot<T0>(arg0: &mut Exchange<T0>, arg1: address, arg2: u64, arg3: bool, arg4: u64) {
        let v0 = PositionKey{
            owner     : arg1,
            market_id : arg2,
            is_long   : arg3,
        };
        if (0x2::table::contains<PositionKey, Position<T0>>(&arg0.positions, v0)) {
            let v1 = 0x2::table::borrow_mut<PositionKey, Position<T0>>(&mut arg0.positions, v0);
            if (v1.seq == arg4 && v1.trigger_orders > 0) {
                v1.trigger_orders = v1.trigger_orders - 1;
            };
        };
    }

    fun remove_position<T0>(arg0: &mut Exchange<T0>, arg1: PositionKey) {
        let Position {
            owner               : _,
            market_id           : _,
            is_long             : _,
            size_usd            : _,
            collateral          : v4,
            entry_price         : _,
            borrow_snapshot_e18 : _,
            reserved            : v7,
            trigger_orders      : _,
            seq                 : _,
            opened_ms           : _,
            updated_ms          : _,
        } = 0x2::table::remove<PositionKey, Position<T0>>(&mut arg0.positions, arg1);
        assert!(v7 == 0, 6);
        0x2::balance::join<T0>(&mut arg0.liquidity, v4);
    }

    fun remove_request_refund<T0>(arg0: &mut Exchange<T0>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let Request {
            owner            : v0,
            market_id        : v1,
            is_long          : v2,
            kind             : v3,
            collateral       : v4,
            size_delta_usd   : _,
            withdraw_units   : _,
            acceptable_price : _,
            trigger_price    : _,
            trigger_above    : _,
            position_seq     : v10,
            created_ms       : _,
        } = 0x2::table::remove<u64, Request<T0>>(&mut arg0.requests, arg1);
        let v12 = v4;
        if (v3 == 4) {
            release_trigger_slot<T0>(arg0, v0, v1, v2, v10);
        };
        let v13 = 0x2::balance::value<T0>(&v12);
        if (v13 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v12, arg4), v0);
        } else {
            0x2::balance::destroy_zero<T0>(v12);
        };
        let v14 = RequestCancelled{
            exchange_id  : 0x2::object::id<Exchange<T0>>(arg0),
            request_id   : arg1,
            owner        : v0,
            refunded     : v13,
            expired      : arg2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RequestCancelled>(v14);
    }

    public fun request_decrease<T0>(arg0: &mut Exchange<T0>, arg1: u64, arg2: bool, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        assert_version<T0>(arg0);
        assert!(arg3 > 0, 7);
        let v0 = PositionKey{
            owner     : 0x2::tx_context::sender(arg6),
            market_id : arg1,
            is_long   : arg2,
        };
        assert!(0x2::table::contains<PositionKey, Position<T0>>(&arg0.positions, v0), 8);
        let v1 = 0x2::table::borrow<PositionKey, Position<T0>>(&arg0.positions, v0).seq;
        new_request<T0>(arg0, arg1, arg2, 1, 0x2::balance::zero<T0>(), arg3, 0, arg4, 0, false, v1, arg5, arg6)
    }

    public fun request_increase<T0>(arg0: &mut Exchange<T0>, arg1: u64, arg2: bool, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        assert_open_allowed<T0>(arg0, arg1);
        assert!(arg4 > 0, 7);
        new_request<T0>(arg0, arg1, arg2, 0, 0x2::coin::into_balance<T0>(arg3), arg4, 0, arg5, 0, false, 0, arg6, arg7)
    }

    public fun request_kind<T0>(arg0: &Exchange<T0>, arg1: u64) : u8 {
        0x2::table::borrow<u64, Request<T0>>(&arg0.requests, arg1).kind
    }

    public fun request_limit_increase<T0>(arg0: &mut Exchange<T0>, arg1: u64, arg2: bool, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u128, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        assert_open_allowed<T0>(arg0, arg1);
        let v0 = if (arg4 > 0) {
            if (0x2::coin::value<T0>(&arg3) > 0) {
                arg5 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 7);
        new_request<T0>(arg0, arg1, arg2, 3, 0x2::coin::into_balance<T0>(arg3), arg4, 0, arg6, arg5, !arg2, 0, arg7, arg8)
    }

    public fun request_market_id<T0>(arg0: &Exchange<T0>, arg1: u64) : u64 {
        0x2::table::borrow<u64, Request<T0>>(&arg0.requests, arg1).market_id
    }

    public fun request_owner<T0>(arg0: &Exchange<T0>, arg1: u64) : address {
        0x2::table::borrow<u64, Request<T0>>(&arg0.requests, arg1).owner
    }

    public fun request_position_seq<T0>(arg0: &Exchange<T0>, arg1: u64) : u64 {
        0x2::table::borrow<u64, Request<T0>>(&arg0.requests, arg1).position_seq
    }

    public fun request_trigger_decrease<T0>(arg0: &mut Exchange<T0>, arg1: u64, arg2: bool, arg3: u64, arg4: u128, arg5: bool, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        assert_version<T0>(arg0);
        assert!(arg3 > 0 && arg4 > 0, 7);
        let v0 = PositionKey{
            owner     : 0x2::tx_context::sender(arg8),
            market_id : arg1,
            is_long   : arg2,
        };
        assert!(0x2::table::contains<PositionKey, Position<T0>>(&arg0.positions, v0), 8);
        let v1 = 0x2::table::borrow_mut<PositionKey, Position<T0>>(&mut arg0.positions, v0);
        assert!(v1.trigger_orders < 8, 27);
        v1.trigger_orders = v1.trigger_orders + 1;
        new_request<T0>(arg0, arg1, arg2, 4, 0x2::balance::zero<T0>(), arg3, 0, arg6, arg4, arg5, v1.seq, arg7, arg8)
    }

    public fun request_withdraw<T0>(arg0: &mut Exchange<T0>, arg1: u64, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        assert_version<T0>(arg0);
        assert!(arg3 > 0, 7);
        let v0 = PositionKey{
            owner     : 0x2::tx_context::sender(arg5),
            market_id : arg1,
            is_long   : arg2,
        };
        assert!(0x2::table::contains<PositionKey, Position<T0>>(&arg0.positions, v0), 8);
        let v1 = 0x2::table::borrow<PositionKey, Position<T0>>(&arg0.positions, v0).seq;
        new_request<T0>(arg0, arg1, arg2, 2, 0x2::balance::zero<T0>(), 0, arg3, 0, 0, false, v1, arg4, arg5)
    }

    public fun reserved<T0>(arg0: &Exchange<T0>) : u64 {
        arg0.reserved
    }

    public fun revoke_keeper<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>, arg2: 0x2::object::ID) {
        assert_admin<T0>(arg0, arg1);
        if (0x2::vec_set::contains<0x2::object::ID>(&arg1.keepers, &arg2)) {
            0x2::vec_set::remove<0x2::object::ID>(&mut arg1.keepers, &arg2);
        };
        let v0 = KeeperChanged{
            exchange_id   : 0x2::object::id<Exchange<T0>>(arg1),
            keeper_cap_id : arg2,
            active        : false,
        };
        0x2::event::emit<KeeperChanged>(v0);
    }

    public fun set_paused<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>, arg2: bool) {
        assert_admin<T0>(arg0, arg1);
        arg1.paused = arg2;
        let v0 = PausedChanged{
            exchange_id : 0x2::object::id<Exchange<T0>>(arg1),
            paused      : arg2,
        };
        0x2::event::emit<PausedChanged>(v0);
    }

    public fun set_treasury<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>, arg2: address) {
        assert_admin<T0>(arg0, arg1);
        arg1.treasury = arg2;
        let v0 = TreasuryChanged{
            exchange_id : 0x2::object::id<Exchange<T0>>(arg1),
            treasury    : arg2,
        };
        0x2::event::emit<TreasuryChanged>(v0);
    }

    public fun sui_feed_id<T0>(arg0: &Exchange<T0>) : vector<u8> {
        arg0.sui_feed_id
    }

    public fun sweep_fees<T0>(arg0: &mut Exchange<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::balance::value<T0>(&arg0.fees);
        if (v0 == 0) {
            return
        };
        let v1 = arg0.treasury;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.fees), arg1), v1);
        let v2 = FeesSwept{
            exchange_id : 0x2::object::id<Exchange<T0>>(arg0),
            amount      : v0,
            treasury    : v1,
        };
        0x2::event::emit<FeesSwept>(v2);
    }

    public fun treasury<T0>(arg0: &Exchange<T0>) : address {
        arg0.treasury
    }

    fun trigger_reached(arg0: &0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::Price, arg1: u128, arg2: bool) : bool {
        arg2 && 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::price(arg0) >= arg1 || 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::price(arg0) <= arg1
    }

    public fun update_market<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>, arg2: u64, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        assert_admin<T0>(arg0, arg1);
        assert!(arg2 < 0x1::vector::length<Market>(&arg1.markets), 28);
        assert_market_params(arg4, arg5, arg6, arg7);
        let v0 = 0x2::object::id<Exchange<T0>>(arg1);
        let v1 = 0x1::vector::borrow_mut<Market>(&mut arg1.markets, arg2);
        v1.enabled = arg3;
        v1.max_position_usd = arg4;
        v1.max_oi_usd = arg5;
        if (arg6 <= v1.open_fee_bps && arg7 <= v1.close_fee_bps) {
            v1.open_fee_bps = arg6;
            v1.close_fee_bps = arg7;
            v1.pending_fees_ready_ms = 0;
        } else {
            let v2 = 0x2::clock::timestamp_ms(arg8) + 86400000;
            v1.pending_open_fee_bps = arg6;
            v1.pending_close_fee_bps = arg7;
            v1.pending_fees_ready_ms = v2;
            let v3 = MarketFeesProposed{
                exchange_id   : v0,
                market_id     : arg2,
                open_fee_bps  : arg6,
                close_fee_bps : arg7,
                ready_ms      : v2,
            };
            0x2::event::emit<MarketFeesProposed>(v3);
        };
        let v4 = MarketUpdated{
            exchange_id      : v0,
            market_id        : arg2,
            enabled          : arg3,
            max_position_usd : arg4,
            max_oi_usd       : arg5,
            open_fee_bps     : v1.open_fee_bps,
            close_fee_bps    : v1.close_fee_bps,
        };
        0x2::event::emit<MarketUpdated>(v4);
    }

    public fun withdraw_liquidity<T0>(arg0: &AdminCap, arg1: &mut Exchange<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_admin<T0>(arg0, arg1);
        accrue_all<T0>(arg1, 0x2::clock::timestamp_ms(arg3));
        assert!(arg2 > 0 && arg2 <= free_liquidity<T0>(arg1), 25);
        assert!((arg1.reserved as u128) * (10000 as u128) <= ((0x2::balance::value<T0>(&arg1.liquidity) - arg2) as u128) * (8000 as u128), 25);
        let v0 = LiquidityWithdrawn{
            exchange_id : 0x2::object::id<Exchange<T0>>(arg1),
            amount      : arg2,
            total       : 0x2::balance::value<T0>(&arg1.liquidity),
        };
        0x2::event::emit<LiquidityWithdrawn>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.liquidity, arg2), arg4)
    }

    // decompiled from Move bytecode v7
}

