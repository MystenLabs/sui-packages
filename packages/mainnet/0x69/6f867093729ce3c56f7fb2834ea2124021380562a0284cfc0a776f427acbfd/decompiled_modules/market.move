module 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market {
    struct EmaPrice has store {
        value: u64,
        cached_value: u64,
    }

    struct Market<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        config: Config,
        pool: 0xdee9::clob_v2::Pool<T0, T1>,
        matched_orders: 0x2::table::Table<address, vector<0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::matched_order::MatchedOrder>>,
        ltp: EmaPrice,
        ob_mid_price: EmaPrice,
        ema_calc_duration: u64,
        prices_updated_at: u64,
        cached_prices_updated_at: u64,
    }

    struct Config has store {
        iou_scaling: u64,
        max_mm_ratio: u64,
        max_im_ratio: u64,
        tick_size: u64,
        lot_size: u64,
        oi_limit: u64,
        order_notional_limit: u64,
        position_notional_limit: u64,
        min_liquidation_ratio: u64,
        liq_fee: u64,
        is_long_cooldown: bool,
        is_short_cooldown: bool,
        order_matching_mark_price_variance: u64,
        bid_order_matching_slippage_limit: u64,
    }

    public(friend) fun new<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: 0x2::coin::Coin<0x2::sui::SUI>, arg16: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0xdee9::clob_v2::PoolOwnerCap) {
        let (v0, v1) = 0xdee9::clob_v2::create_customized_pool_v2<T0, T1>(arg0, arg1, arg2, arg3, arg15, arg16);
        let v2 = Config{
            iou_scaling                        : arg7,
            max_mm_ratio                       : arg8,
            max_im_ratio                       : arg9,
            tick_size                          : arg0,
            lot_size                           : arg1,
            oi_limit                           : arg4,
            order_notional_limit               : arg5,
            position_notional_limit            : arg6,
            min_liquidation_ratio              : arg10,
            liq_fee                            : arg11,
            is_long_cooldown                   : false,
            is_short_cooldown                  : false,
            order_matching_mark_price_variance : arg12,
            bid_order_matching_slippage_limit  : arg13,
        };
        let v3 = EmaPrice{
            value        : 0,
            cached_value : 0,
        };
        let v4 = EmaPrice{
            value        : 0,
            cached_value : 0,
        };
        let v5 = Market<T0, T1>{
            id                       : 0x2::object::new(arg16),
            config                   : v2,
            pool                     : v0,
            matched_orders           : 0x2::table::new<address, vector<0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::matched_order::MatchedOrder>>(arg16),
            ltp                      : v3,
            ob_mid_price             : v4,
            ema_calc_duration        : arg14,
            prices_updated_at        : 0,
            cached_prices_updated_at : 0,
        };
        0x2::transfer::share_object<Market<T0, T1>>(v5);
        (*0x2::object::uid_as_inner(&v5.id), v1)
    }

    public fun assert_not_long_cd<T0, T1>(arg0: &Market<T0, T1>) {
        assert!(!is_long_cooldown<T0, T1>(arg0), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::long_cooldown_active());
    }

    public fun assert_not_short_cd<T0, T1>(arg0: &Market<T0, T1>) {
        assert!(!is_short_cooldown<T0, T1>(arg0), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::short_cooldown_active());
    }

    public fun assert_oi_limit<T0, T1>(arg0: &Market<T0, T1>, arg1: u64) {
        assert!(arg1 <= oi_limit<T0, T1>(arg0), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::oi_limit_reached());
    }

    public fun assert_order_notional_limit<T0, T1>(arg0: &Market<T0, T1>, arg1: u64) {
        assert!(arg1 <= order_notional_limit<T0, T1>(arg0), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::order_notional_err());
    }

    public fun assert_position_notional_limit<T0, T1>(arg0: &Market<T0, T1>, arg1: u64) {
        assert!(arg1 <= position_notional_limit<T0, T1>(arg0), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::position_notional_err());
    }

    public fun bid_order_matching_slippage_limit<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.config.bid_order_matching_slippage_limit
    }

    public fun ema_calc_duration<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.ema_calc_duration
    }

    public fun get_matched_orders<T0, T1>(arg0: &Market<T0, T1>, arg1: address) : vector<0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::matched_order::MatchedOrder> {
        if (matched_orders_exist<T0, T1>(arg0, arg1)) {
            *0x2::table::borrow<address, vector<0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::matched_order::MatchedOrder>>(&arg0.matched_orders, arg1)
        } else {
            0x1::vector::empty<0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::matched_order::MatchedOrder>()
        }
    }

    public fun iou_scaling<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.config.iou_scaling
    }

    public fun is_long_cooldown<T0, T1>(arg0: &Market<T0, T1>) : bool {
        arg0.config.is_long_cooldown
    }

    public fun is_short_cooldown<T0, T1>(arg0: &Market<T0, T1>) : bool {
        arg0.config.is_short_cooldown
    }

    public fun liq_fee<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.config.liq_fee
    }

    public fun lot_size<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.config.lot_size
    }

    public fun ltp<T0, T1>(arg0: &Market<T0, T1>) : (u64, u64) {
        (arg0.ltp.value, arg0.ltp.cached_value)
    }

    public fun matched_orders_exist<T0, T1>(arg0: &Market<T0, T1>, arg1: address) : bool {
        0x2::table::contains<address, vector<0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::matched_order::MatchedOrder>>(&arg0.matched_orders, arg1)
    }

    public fun max_im_ratio<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.config.max_im_ratio
    }

    public fun max_mm_ratio<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.config.max_mm_ratio
    }

    public fun min_liq_ratio<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.config.min_liquidation_ratio
    }

    public fun ob_mid_price<T0, T1>(arg0: &Market<T0, T1>) : (u64, u64) {
        (arg0.ltp.value, arg0.ltp.cached_value)
    }

    public fun oi_limit<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.config.oi_limit
    }

    public fun order_matching_mark_price_variance<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.config.order_matching_mark_price_variance
    }

    public fun order_notional_limit<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.config.order_notional_limit
    }

    public fun pool<T0, T1>(arg0: &Market<T0, T1>) : &0xdee9::clob_v2::Pool<T0, T1> {
        &arg0.pool
    }

    public(friend) fun pool_mut<T0, T1>(arg0: &mut Market<T0, T1>) : &mut 0xdee9::clob_v2::Pool<T0, T1> {
        &mut arg0.pool
    }

    public fun position_notional_limit<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.config.position_notional_limit
    }

    public fun prices_updated_at<T0, T1>(arg0: &Market<T0, T1>) : (u64, u64) {
        (arg0.prices_updated_at, arg0.cached_prices_updated_at)
    }

    public(friend) fun set_bid_order_matching_slippage_limit<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64) {
        arg0.config.bid_order_matching_slippage_limit = arg1;
    }

    public(friend) fun set_ema_calc_duration<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64) {
        arg0.ema_calc_duration = arg1;
    }

    public(friend) fun set_is_long_cooldown<T0, T1>(arg0: &mut Market<T0, T1>, arg1: bool) {
        arg0.config.is_long_cooldown = arg1;
    }

    public(friend) fun set_is_short_cooldown<T0, T1>(arg0: &mut Market<T0, T1>, arg1: bool) {
        arg0.config.is_short_cooldown = arg1;
    }

    public(friend) fun set_ltp<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64, arg2: bool) {
        if (arg2) {
            arg0.ltp.cached_value = arg0.ltp.value;
        };
        arg0.ltp.value = arg1;
    }

    public(friend) fun set_max_im_ratio<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64) {
        arg0.config.max_im_ratio = arg1;
    }

    public(friend) fun set_max_mm_ratio<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64) {
        arg0.config.max_mm_ratio = arg1;
    }

    public(friend) fun set_ob_mid_price<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64, arg2: bool) {
        if (arg2) {
            arg0.ob_mid_price.cached_value = arg0.ob_mid_price.value;
        };
        arg0.ob_mid_price.value = arg1;
    }

    public(friend) fun set_oi_limit<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64) {
        arg0.config.oi_limit = arg1;
    }

    public(friend) fun set_order_matching_mark_price_variance<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64) {
        arg0.config.order_matching_mark_price_variance = arg1;
    }

    public(friend) fun set_order_notional_limit<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64) {
        arg0.config.order_notional_limit = arg1;
    }

    public(friend) fun set_position_notional_limit<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64) {
        arg0.config.position_notional_limit = arg1;
    }

    public(friend) fun set_prices_updated_at<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64) {
        arg0.cached_prices_updated_at = arg0.prices_updated_at;
        arg0.prices_updated_at = arg1;
    }

    public fun tick_size<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.config.tick_size
    }

    // decompiled from Move bytecode v6
}

