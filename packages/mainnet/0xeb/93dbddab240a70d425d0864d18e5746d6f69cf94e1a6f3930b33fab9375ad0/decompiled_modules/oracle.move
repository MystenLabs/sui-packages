module 0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::oracle {
    struct PriceFeed<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        collateral_is_a: bool,
        via_pool_id: 0x1::option::Option<0x2::object::ID>,
        mid_is_a: bool,
        spot_q64: u128,
        ema_q64: u128,
        ema_before_q64: u128,
        spot_before_q64: u128,
        updated_before_ms: u64,
        poke_digest: vector<u8>,
        updated_ms: u64,
        tau_ms: u64,
        max_age_ms: u64,
        venue: u8,
    }

    struct FeedCreated<phantom T0, phantom T1> has copy, drop {
        feed_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        collateral_is_a: bool,
        price_q64: u128,
        tau_ms: u64,
        max_age_ms: u64,
        venue: u8,
    }

    struct ChainedFeedCreated<phantom T0, phantom T1, phantom T2> has copy, drop {
        feed_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        via_pool_id: 0x2::object::ID,
        price_q64: u128,
        tau_ms: u64,
        max_age_ms: u64,
        venue: u8,
    }

    struct FeedPoked<phantom T0, phantom T1> has copy, drop {
        feed_id: 0x2::object::ID,
        spot_q64: u128,
        ema_q64: u128,
        updated_ms: u64,
    }

    fun band(arg0: u128) : (u128, u128) {
        let v0 = (((arg0 as u256) * (1000 as u256) / 10000) as u128);
        let v1 = if ((340282366920938463463374607431768211455 as u128) - arg0 < v0) {
            (340282366920938463463374607431768211455 as u128)
        } else {
            arg0 + v0
        };
        (arg0 - v0, v1)
    }

    public fun chain(arg0: u128, arg1: u128) : u128 {
        let v0 = (arg0 as u256) * (arg1 as u256) >> 64;
        assert!(v0 > 0, 13903738997572108297);
        if (v0 > 340282366920938463463374607431768211455) {
            (340282366920938463463374607431768211455 as u128)
        } else {
            (v0 as u128)
        }
    }

    public(friend) fun chain_sides<T0, T1, T2, T3, T4, T5, T6>() : (bool, bool) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x1::type_name::with_original_ids<T1>();
        let v2 = 0x1::type_name::with_original_ids<T2>();
        let v3 = if (v0 != v1) {
            if (v1 != v2) {
                v0 != v2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 13902612766952259585);
        (side_of<T0, T1, T3, T4>(), side_of<T1, T2, T5, T6>())
    }

    fun check_params(arg0: u64, arg1: u64) {
        assert!(arg0 >= 180000 && arg0 <= 3600000, 13903457303551934471);
        assert!(arg1 > 0 && arg1 <= 120000, 13903457307846901767);
    }

    fun check_poker<T0, T1>(arg0: &0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::config::Config, arg1: &PriceFeed<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : bool {
        if (0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::config::is_keeper(arg0, 0x2::tx_context::sender(arg3))) {
            return true
        };
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.updated_ms + 600000, 13896420983185211403);
        false
    }

    public fun collateral_is_a<T0, T1>(arg0: &PriceFeed<T0, T1>) : bool {
        arg0.collateral_is_a
    }

    public fun create_chained_feed<T0, T1, T2, T3, T4, T5, T6>(arg0: &0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::config::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T4>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T5, T6>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1) = chain_sides<T0, T1, T2, T3, T4, T5, T6>();
        share_chained_feed<T0, T1, T2>(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T4>>(arg1), v0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T5, T6>>(arg2), v1, 0, chain(price_from_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T3, T4>(arg1), v0), price_from_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T5, T6>(arg2), v1)), arg3, arg4, arg5, arg6)
    }

    public fun create_feed<T0, T1, T2, T3>(arg0: &0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::config::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = side_of<T0, T1, T2, T3>();
        share_feed<T0, T1>(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg1), v0, 0, price_from_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T2, T3>(arg1), v0), arg2, arg3, arg4, arg5)
    }

    public fun ema_price<T0, T1>(arg0: &PriceFeed<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : u128 {
        settled_ema<T0, T1>(arg0, arg1, arg2)
    }

    public fun ema_q64<T0, T1>(arg0: &PriceFeed<T0, T1>) : u128 {
        arg0.ema_q64
    }

    public fun liquidation_price<T0, T1>(arg0: &PriceFeed<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : u128 {
        let v0 = settled_ema<T0, T1>(arg0, arg1, arg2);
        let v1 = settled_spot<T0, T1>(arg0, arg2);
        if (v1 > v0) {
            v1
        } else {
            v0
        }
    }

    public fun loan_price<T0, T1>(arg0: &PriceFeed<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : u128 {
        let v0 = settled_ema<T0, T1>(arg0, arg1, arg2);
        if (arg0.spot_q64 < v0) {
            arg0.spot_q64
        } else {
            v0
        }
    }

    public fun mid_is_a<T0, T1>(arg0: &PriceFeed<T0, T1>) : bool {
        arg0.mid_is_a
    }

    fun new_feed<T0, T1>(arg0: 0x2::object::ID, arg1: bool, arg2: 0x1::option::Option<0x2::object::ID>, arg3: bool, arg4: u8, arg5: u128, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : PriceFeed<T0, T1> {
        assert!(arg4 == 0 || arg4 == 1, 13890791049859432461);
        PriceFeed<T0, T1>{
            id                : 0x2::object::new(arg9),
            pool_id           : arg0,
            collateral_is_a   : arg1,
            via_pool_id       : arg2,
            mid_is_a          : arg3,
            spot_q64          : arg5,
            ema_q64           : arg5,
            ema_before_q64    : arg5,
            spot_before_q64   : arg5,
            updated_before_ms : 0x2::clock::timestamp_ms(arg8),
            poke_digest       : b"",
            updated_ms        : 0x2::clock::timestamp_ms(arg8),
            tau_ms            : arg6,
            max_age_ms        : arg7,
            venue             : arg4,
        }
    }

    fun open_poke_prices(arg0: u128, arg1: u128) : (u128, u128) {
        let (v0, v1) = band(arg1);
        let v2 = if (arg0 > v1) {
            v1
        } else {
            arg0
        };
        let v3 = if (arg0 < v0) {
            v0
        } else if (arg0 > v1) {
            v1
        } else {
            arg0
        };
        (v2, v3)
    }

    public fun poke<T0, T1, T2, T3>(arg0: &0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::config::Config, arg1: &mut PriceFeed<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = price_from_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T2, T3>(arg2), arg1.collateral_is_a);
        poke_with<T0, T1>(arg0, arg1, 0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2), 0x1::option::none<0x2::object::ID>(), v0, arg3, arg4);
    }

    public fun poke_chained<T0, T1, T2, T3, T4, T5>(arg0: &0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::config::Config, arg1: &mut PriceFeed<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T5>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = chain(price_from_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T2, T3>(arg2), arg1.collateral_is_a), price_from_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T4, T5>(arg3), arg1.mid_is_a));
        poke_with<T0, T1>(arg0, arg1, 0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2), 0x1::option::some<0x2::object::ID>(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T5>>(arg3)), v0, arg4, arg5);
    }

    public(friend) fun poke_with<T0, T1>(arg0: &0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::config::Config, arg1: &mut PriceFeed<T0, T1>, arg2: u8, arg3: 0x2::object::ID, arg4: 0x1::option::Option<0x2::object::ID>, arg5: u128, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0xeb93dbddab240a70d425d0864d18e5746d6f69cf94e1a6f3930b33fab9375ad0::config::assert_version(arg0);
        assert!(arg1.venue == arg2, 13890791281787666445);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg1.via_pool_id) == 0x1::option::is_some<0x2::object::ID>(&arg4), 13896139310640267279);
        assert!(arg3 == arg1.pool_id && arg4 == arg1.via_pool_id, 13902894714375503875);
        let (v0, v1) = if (check_poker<T0, T1>(arg0, arg1, arg6, arg7)) {
            (arg5, arg5)
        } else {
            open_poke_prices(arg5, arg1.ema_q64)
        };
        update<T0, T1>(arg1, v0, v1, 0x2::clock::timestamp_ms(arg6), arg7);
    }

    public fun pool_id<T0, T1>(arg0: &PriceFeed<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun price_from_sqrt(arg0: u128, arg1: bool) : u128 {
        let v0 = (arg0 as u256) * (arg0 as u256);
        let v1 = if (arg1) {
            v0 >> 64
        } else {
            assert!(v0 > 0, 13903739736306483209);
            6277101735386680763835789423207666416102355444464034512896 / v0
        };
        assert!(v1 > 0, 13903739749191385097);
        if (v1 > 340282366920938463463374607431768211455) {
            (340282366920938463463374607431768211455 as u128)
        } else {
            (v1 as u128)
        }
    }

    public fun seize_price<T0, T1>(arg0: &PriceFeed<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : u128 {
        let v0 = settled_ema<T0, T1>(arg0, arg1, arg2);
        let v1 = settled_spot<T0, T1>(arg0, arg2);
        let v2 = if (v1 < v0) {
            v1
        } else {
            v0
        };
        let v3 = (((v0 as u256) * (8500 as u256) / 10000) as u128);
        if (v2 < v3) {
            v3
        } else {
            v2
        }
    }

    fun settled_ema<T0, T1>(arg0: &PriceFeed<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : u128 {
        let v0 = &arg0.poke_digest == 0x2::tx_context::digest(arg2);
        let v1 = if (v0) {
            arg0.updated_before_ms
        } else {
            arg0.updated_ms
        };
        assert!(0x2::clock::timestamp_ms(arg1) <= v1 + arg0.max_age_ms, 13903176751993061381);
        if (v0) {
            arg0.ema_before_q64
        } else {
            arg0.ema_q64
        }
    }

    fun settled_spot<T0, T1>(arg0: &PriceFeed<T0, T1>, arg1: &0x2::tx_context::TxContext) : u128 {
        if (&arg0.poke_digest == 0x2::tx_context::digest(arg1)) {
            arg0.spot_before_q64
        } else {
            arg0.spot_q64
        }
    }

    public(friend) fun share_chained_feed<T0, T1, T2>(arg0: 0x2::object::ID, arg1: bool, arg2: 0x2::object::ID, arg3: bool, arg4: u8, arg5: u128, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        check_params(arg6, arg7);
        let v0 = new_feed<T0, T2>(arg0, arg1, 0x1::option::some<0x2::object::ID>(arg2), arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v1 = 0x2::object::id<PriceFeed<T0, T2>>(&v0);
        let v2 = ChainedFeedCreated<T0, T1, T2>{
            feed_id     : v1,
            pool_id     : arg0,
            via_pool_id : arg2,
            price_q64   : arg5,
            tau_ms      : arg6,
            max_age_ms  : arg7,
            venue       : arg4,
        };
        0x2::event::emit<ChainedFeedCreated<T0, T1, T2>>(v2);
        0x2::transfer::share_object<PriceFeed<T0, T2>>(v0);
        v1
    }

    public(friend) fun share_feed<T0, T1>(arg0: 0x2::object::ID, arg1: bool, arg2: u8, arg3: u128, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        check_params(arg4, arg5);
        let v0 = new_feed<T0, T1>(arg0, arg1, 0x1::option::none<0x2::object::ID>(), false, arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = 0x2::object::id<PriceFeed<T0, T1>>(&v0);
        let v2 = FeedCreated<T0, T1>{
            feed_id         : v1,
            pool_id         : arg0,
            collateral_is_a : arg1,
            price_q64       : arg3,
            tau_ms          : arg4,
            max_age_ms      : arg5,
            venue           : arg2,
        };
        0x2::event::emit<FeedCreated<T0, T1>>(v2);
        0x2::transfer::share_object<PriceFeed<T0, T1>>(v0);
        v1
    }

    public(friend) fun side_of<T0, T1, T2, T3>() : bool {
        let v0 = 0x1::type_name::with_original_ids<T2>();
        let v1 = 0x1::type_name::with_original_ids<T3>();
        let v2 = 0x1::type_name::with_original_ids<T0>();
        let v3 = 0x1::type_name::with_original_ids<T1>();
        if (v0 == v2 && v1 == v3) {
            true
        } else {
            assert!(v0 == v3 && v1 == v2, 13902612925866049537);
            false
        }
    }

    public fun spot_q64<T0, T1>(arg0: &PriceFeed<T0, T1>) : u128 {
        arg0.spot_q64
    }

    fun update<T0, T1>(arg0: &mut PriceFeed<T0, T1>, arg1: u128, arg2: u128, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1 > 0 && arg2 > 0, 13903739397004066825);
        if (&arg0.poke_digest != 0x2::tx_context::digest(arg4)) {
            arg0.ema_before_q64 = arg0.ema_q64;
            arg0.spot_before_q64 = arg0.spot_q64;
            arg0.updated_before_ms = arg0.updated_ms;
            arg0.poke_digest = *0x2::tx_context::digest(arg4);
        };
        let v0 = if (arg3 > arg0.updated_ms) {
            arg3 - arg0.updated_ms
        } else {
            0
        };
        let v1 = v0;
        if (v0 > 60000) {
            v1 = 60000;
        };
        if (v1 > 0) {
            let v2 = (v1 as u256);
            let v3 = (arg0.ema_q64 as u256);
            let v4 = (arg2 as u256);
            let v5 = if (v4 >= v3) {
                v3 + (v4 - v3) * v2 / (v2 + (arg0.tau_ms as u256))
            } else {
                v3 - (v3 - v4) * v2 / (v2 + (arg0.tau_ms as u256))
            };
            arg0.ema_q64 = (v5 as u128);
            arg0.updated_ms = arg3;
        };
        arg0.spot_q64 = arg1;
        let v6 = FeedPoked<T0, T1>{
            feed_id    : 0x2::object::id<PriceFeed<T0, T1>>(arg0),
            spot_q64   : arg1,
            ema_q64    : arg0.ema_q64,
            updated_ms : arg0.updated_ms,
        };
        0x2::event::emit<FeedPoked<T0, T1>>(v6);
    }

    public fun updated_ms<T0, T1>(arg0: &PriceFeed<T0, T1>) : u64 {
        arg0.updated_ms
    }

    public fun venue<T0, T1>(arg0: &PriceFeed<T0, T1>) : u8 {
        arg0.venue
    }

    public(friend) fun venue_bluefin() : u8 {
        1
    }

    public fun via_pool_id<T0, T1>(arg0: &PriceFeed<T0, T1>) : 0x1::option::Option<0x2::object::ID> {
        arg0.via_pool_id
    }

    // decompiled from Move bytecode v7
}

