module 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::oracle_adapter {
    struct OracleCap has store, key {
        id: 0x2::object::UID,
    }

    struct PriceConfig<phantom T0> has key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        strike: u64,
        comparison: u8,
        expiry_ts_ms: u64,
        max_staleness_ms: u64,
        max_conf_bps: u64,
    }

    struct PriceResolved has copy, drop {
        market_id: 0x2::object::ID,
        price: u64,
        strike: u64,
        comparison: u8,
        outcome: u8,
    }

    public fun cmp_ge() : u8 {
        0
    }

    public fun cmp_le() : u8 {
        1
    }

    public fun config_market_id<T0>(arg0: &PriceConfig<T0>) : 0x2::object::ID {
        arg0.market_id
    }

    public fun config_strike<T0>(arg0: &PriceConfig<T0>) : u64 {
        arg0.strike
    }

    public fun create_price_config<T0>(arg0: &0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::Market<T0>, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == 0 || arg2 == 1, 3);
        let v0 = PriceConfig<T0>{
            id               : 0x2::object::new(arg6),
            market_id        : 0x2::object::id<0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::Market<T0>>(arg0),
            strike           : arg1,
            comparison       : arg2,
            expiry_ts_ms     : arg3,
            max_staleness_ms : arg4,
            max_conf_bps     : arg5,
        };
        0x2::transfer::share_object<PriceConfig<T0>>(v0);
    }

    public fun decide_outcome(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: u64, arg7: u64, arg8: u64) : u8 {
        assert!(arg3 >= arg6, 0);
        assert!(arg2 + arg7 >= arg3, 1);
        assert!((arg1 as u128) * 10000 <= (arg0 as u128) * (arg8 as u128), 2);
        assert!(arg5 == 0 || arg5 == 1, 3);
        if (arg5 == 0) {
            if (arg0 >= arg4) {
                1
            } else {
                0
            }
        } else if (arg0 <= arg4) {
            1
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        setup(arg0);
    }

    public fun resolve_with_price<T0>(arg0: &OracleCap, arg1: &PriceConfig<T0>, arg2: &mut 0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u64) {
        assert!(0x2::object::id<0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::Market<T0>>(arg2) == arg1.market_id, 4);
        0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::assert_closed<T0>(arg2);
        let v0 = decide_outcome(arg4, arg5, arg6, 0x2::clock::timestamp_ms(arg3), arg1.strike, arg1.comparison, arg1.expiry_ts_ms, arg1.max_staleness_ms, arg1.max_conf_bps);
        0xaeaa3f2822f2ca3fabecca228400ef7ef6aae5f4885a69a3a7d33901aa1b34b2::market::set_resolved<T0>(arg2, v0);
        let v1 = PriceResolved{
            market_id  : arg1.market_id,
            price      : arg4,
            strike     : arg1.strike,
            comparison : arg1.comparison,
            outcome    : v0,
        };
        0x2::event::emit<PriceResolved>(v1);
    }

    fun setup(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OracleCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

