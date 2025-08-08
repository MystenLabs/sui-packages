module 0xa9e63b520470ff9abf66b300c54957e7c573c7376e9a281b2114a703631a5e33::auto_rebalance {
    struct NewAutoRebalanceStrategyEvent has drop {
        strategy_id: 0x2::object::ID,
        owner: address,
        description: 0x1::string::String,
        price_change_threshold_bps: u64,
        rebalance_cooldown_secs: u64,
        range_multiplier: u64,
        rebalance_max_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        rebalance_min_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        profit_take_threshold: u64,
        rebalance_paused: bool,
        tx_gas_limit: u64,
        price_feed_source: u64,
        lp_slippage_tolerance_bps: u64,
    }

    struct AutoRebalanceEvent has drop {
        strategy_id: 0x2::object::ID,
        price: u64,
        timestamp: u64,
    }

    struct AutoRebalanceStrategy<T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        description: 0x1::string::String,
        lower_sqrt_price_change_threshold_bps: u64,
        upper_sqrt_price_change_threshold_bps: u64,
        lower_sqrt_price_change_threshold_direction: bool,
        upper_sqrt_price_change_threshold_direction: bool,
        rebalance_cooldown_secs: u64,
        range_multiplier: u64,
        rebalance_max_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        rebalance_min_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        profit_take_threshold: u64,
        rebalance_paused: bool,
        tx_gas_limit: u64,
        price_feed_source: u64,
        lp_slippage_tolerance_bps: u64,
        last_rebalance_timestamp: u64,
        current_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        position: 0x1::option::Option<T0>,
    }

    struct AutoRebalanceReceipt<phantom T0> {
        dummy_field: bool,
    }

    public fun decode_auto_rebalance_strategy_data(arg0: vector<u8>) : (0x1::string::String, u64, u64, bool, bool, u64, u64, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, u64, bool, u64, u64, u64) {
        let v0 = 0x2::bcs::new(arg0);
        (0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_bool(&mut v0), 0x2::bcs::peel_bool(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0x2::bcs::peel_u32(&mut v0)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0x2::bcs::peel_u32(&mut v0)), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_bool(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    public fun new_auto_rebalance_strategy<T0>(arg0: vector<u8>, arg1: T0, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : AutoRebalanceStrategy<T0> {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13) = decode_auto_rebalance_strategy_data(arg0);
        AutoRebalanceStrategy<T0>{
            id                                          : 0x2::object::new(arg4),
            owner                                       : 0x2::tx_context::sender(arg4),
            description                                 : v0,
            lower_sqrt_price_change_threshold_bps       : v1,
            upper_sqrt_price_change_threshold_bps       : v2,
            lower_sqrt_price_change_threshold_direction : v3,
            upper_sqrt_price_change_threshold_direction : v4,
            rebalance_cooldown_secs                     : v5,
            range_multiplier                            : v6,
            rebalance_max_tick                          : v7,
            rebalance_min_tick                          : v8,
            profit_take_threshold                       : v9,
            rebalance_paused                            : v10,
            tx_gas_limit                                : v11,
            price_feed_source                           : v12,
            lp_slippage_tolerance_bps                   : v13,
            last_rebalance_timestamp                    : 0x2::clock::timestamp_ms(arg3),
            current_tick                                : arg2,
            position                                    : 0x1::option::some<T0>(arg1),
        }
    }

    public fun prepare_rebalance<T0: key>(arg0: &mut AutoRebalanceStrategy<T0>, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: &0x2::clock::Clock) : (u64, u64, bool, bool, u64, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, T0, AutoRebalanceReceipt<T0>) {
        if (arg0.last_rebalance_timestamp > 0x2::clock::timestamp_ms(arg2)) {
            abort 0xa9e63b520470ff9abf66b300c54957e7c573c7376e9a281b2114a703631a5e33::errors::error_last_rebalance_timestamp_after_current_timestamp()
        };
        if (arg0.last_rebalance_timestamp + arg0.rebalance_cooldown_secs > 0x2::clock::timestamp_ms(arg2)) {
            abort 0xa9e63b520470ff9abf66b300c54957e7c573c7376e9a281b2114a703631a5e33::errors::error_invalid_rebalance_cooldown()
        };
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::cmp(arg1, arg0.rebalance_min_tick) == 0 || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::cmp(arg1, arg0.rebalance_max_tick) == 2) {
            abort 0xa9e63b520470ff9abf66b300c54957e7c573c7376e9a281b2114a703631a5e33::errors::error_current_tick_out_of_range()
        };
        if (arg0.rebalance_paused) {
            abort 0xa9e63b520470ff9abf66b300c54957e7c573c7376e9a281b2114a703631a5e33::errors::error_invalid_rebalance_paused()
        };
        let v0 = AutoRebalanceReceipt<T0>{dummy_field: false};
        (arg0.lower_sqrt_price_change_threshold_bps, arg0.upper_sqrt_price_change_threshold_bps, arg0.lower_sqrt_price_change_threshold_direction, arg0.upper_sqrt_price_change_threshold_direction, arg0.range_multiplier, arg0.rebalance_max_tick, arg0.rebalance_min_tick, 0x1::option::extract<T0>(&mut arg0.position), v0)
    }

    public fun repay_receipt<T0>(arg0: &mut AutoRebalanceStrategy<T0>, arg1: AutoRebalanceReceipt<T0>, arg2: T0) {
        let AutoRebalanceReceipt {  } = arg1;
        0x1::option::fill<T0>(&mut arg0.position, arg2);
    }

    // decompiled from Move bytecode v6
}

