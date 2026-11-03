module 0x97ca45567ddf9f2b50f8883b0c3c3aab0660d90959c87b0a5f35c2e8eeb51623::oracle {
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
        poke_digest: vector<u8>,
        updated_ms: u64,
        tau_ms: u64,
        max_age_ms: u64,
    }

    struct FeedCreated<phantom T0, phantom T1> has copy, drop {
        feed_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        collateral_is_a: bool,
        price_q64: u128,
        tau_ms: u64,
        max_age_ms: u64,
    }

    struct ChainedFeedCreated<phantom T0, phantom T1, phantom T2> has copy, drop {
        feed_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        via_pool_id: 0x2::object::ID,
        price_q64: u128,
        tau_ms: u64,
        max_age_ms: u64,
    }

    struct FeedPoked<phantom T0, phantom T1> has copy, drop {
        feed_id: 0x2::object::ID,
        spot_q64: u128,
        ema_q64: u128,
        updated_ms: u64,
    }

    public fun chain(arg0: u128, arg1: u128) : u128 {
        let v0 = (arg0 as u256) * (arg1 as u256) >> 64;
        assert!(v0 > 0, 13903738765643874313);
        if (v0 > 340282366920938463463374607431768211455) {
            (340282366920938463463374607431768211455 as u128)
        } else {
            (v0 as u128)
        }
    }

    fun check_params(arg0: u64, arg1: u64) {
        assert!(arg0 >= 180000 && arg0 <= 3600000, 13903457088803569671);
        assert!(arg1 > 0 && arg1 <= 120000, 13903457093098536967);
    }

    public fun create_chained_feed<T0, T1, T2, T3, T4, T5, T6>(arg0: &0x97ca45567ddf9f2b50f8883b0c3c3aab0660d90959c87b0a5f35c2e8eeb51623::config::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T4>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T5, T6>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        check_params(arg3, arg4);
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
        assert!(v3, 13902612577973698561);
        let v4 = side_of<T0, T1, T3, T4>();
        let v5 = side_of<T1, T2, T5, T6>();
        let v6 = chain(price_from_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T3, T4>(arg1), v4), price_from_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T5, T6>(arg2), v5));
        let v7 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T5, T6>>(arg2);
        let v8 = new_feed<T0, T2>(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T4>>(arg1), v4, 0x1::option::some<0x2::object::ID>(v7), v5, v6, arg3, arg4, arg5, arg6);
        let v9 = 0x2::object::id<PriceFeed<T0, T2>>(&v8);
        let v10 = ChainedFeedCreated<T0, T1, T2>{
            feed_id     : v9,
            pool_id     : v8.pool_id,
            via_pool_id : v7,
            price_q64   : v6,
            tau_ms      : arg3,
            max_age_ms  : arg4,
        };
        0x2::event::emit<ChainedFeedCreated<T0, T1, T2>>(v10);
        0x2::transfer::share_object<PriceFeed<T0, T2>>(v8);
        v9
    }

    public fun create_feed<T0, T1, T2, T3>(arg0: &0x97ca45567ddf9f2b50f8883b0c3c3aab0660d90959c87b0a5f35c2e8eeb51623::config::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        check_params(arg2, arg3);
        let v0 = side_of<T0, T1, T2, T3>();
        let v1 = price_from_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T2, T3>(arg1), v0);
        let v2 = new_feed<T0, T1>(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg1), v0, 0x1::option::none<0x2::object::ID>(), false, v1, arg2, arg3, arg4, arg5);
        let v3 = 0x2::object::id<PriceFeed<T0, T1>>(&v2);
        let v4 = FeedCreated<T0, T1>{
            feed_id         : v3,
            pool_id         : v2.pool_id,
            collateral_is_a : v0,
            price_q64       : v1,
            tau_ms          : arg2,
            max_age_ms      : arg3,
        };
        0x2::event::emit<FeedCreated<T0, T1>>(v4);
        0x2::transfer::share_object<PriceFeed<T0, T1>>(v2);
        v3
    }

    public fun ema_price<T0, T1>(arg0: &PriceFeed<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : u128 {
        settled_ema<T0, T1>(arg0, arg1, arg2)
    }

    public fun ema_q64<T0, T1>(arg0: &PriceFeed<T0, T1>) : u128 {
        arg0.ema_q64
    }

    public fun liquidation_price<T0, T1>(arg0: &PriceFeed<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : u128 {
        let v0 = settled_ema<T0, T1>(arg0, arg1, arg2);
        if (arg0.spot_q64 > v0) {
            arg0.spot_q64
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

    fun new_feed<T0, T1>(arg0: 0x2::object::ID, arg1: bool, arg2: 0x1::option::Option<0x2::object::ID>, arg3: bool, arg4: u128, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : PriceFeed<T0, T1> {
        PriceFeed<T0, T1>{
            id              : 0x2::object::new(arg8),
            pool_id         : arg0,
            collateral_is_a : arg1,
            via_pool_id     : arg2,
            mid_is_a        : arg3,
            spot_q64        : arg4,
            ema_q64         : arg4,
            ema_before_q64  : arg4,
            spot_before_q64 : arg4,
            poke_digest     : b"",
            updated_ms      : 0x2::clock::timestamp_ms(arg7),
            tau_ms          : arg5,
            max_age_ms      : arg6,
        }
    }

    public fun poke<T0, T1, T2, T3>(arg0: &mut PriceFeed<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.via_pool_id), 13896138967042621451);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg1) == arg0.pool_id, 13902894370778120195);
        let v0 = price_from_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T2, T3>(arg1), arg0.collateral_is_a);
        update<T0, T1>(arg0, v0, 0x2::clock::timestamp_ms(arg2), arg3);
    }

    public fun poke_chained<T0, T1, T2, T3, T4, T5>(arg0: &mut PriceFeed<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T5>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.via_pool_id), 13896139027172163595);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg1) == arg0.pool_id && 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T5>>(arg2) == *0x1::option::borrow<0x2::object::ID>(&arg0.via_pool_id), 13902894430907662339);
        let v0 = chain(price_from_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T2, T3>(arg1), arg0.collateral_is_a), price_from_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T4, T5>(arg2), arg0.mid_is_a));
        update<T0, T1>(arg0, v0, 0x2::clock::timestamp_ms(arg3), arg4);
    }

    public fun pool_id<T0, T1>(arg0: &PriceFeed<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun price_from_sqrt(arg0: u128, arg1: bool) : u128 {
        let v0 = (arg0 as u256) * (arg0 as u256);
        let v1 = if (arg1) {
            v0 >> 64
        } else {
            assert!(v0 > 0, 13903739156485898249);
            6277101735386680763835789423207666416102355444464034512896 / v0
        };
        assert!(v1 > 0, 13903739169370800137);
        if (v1 > 340282366920938463463374607431768211455) {
            (340282366920938463463374607431768211455 as u128)
        } else {
            (v1 as u128)
        }
    }

    public fun seize_price<T0, T1>(arg0: &PriceFeed<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : u128 {
        let v0 = settled_ema<T0, T1>(arg0, arg1, arg2);
        let v1 = if (&arg0.poke_digest == 0x2::tx_context::digest(arg2)) {
            arg0.spot_before_q64
        } else {
            arg0.spot_q64
        };
        if (v1 < v0) {
            v1
        } else {
            v0
        }
    }

    fun settled_ema<T0, T1>(arg0: &PriceFeed<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : u128 {
        assert!(0x2::clock::timestamp_ms(arg1) <= arg0.updated_ms + arg0.max_age_ms, 13903176172172476421);
        if (&arg0.poke_digest == 0x2::tx_context::digest(arg2)) {
            arg0.ema_before_q64
        } else {
            arg0.ema_q64
        }
    }

    fun side_of<T0, T1, T2, T3>() : bool {
        let v0 = 0x1::type_name::with_original_ids<T2>();
        let v1 = 0x1::type_name::with_original_ids<T3>();
        let v2 = 0x1::type_name::with_original_ids<T0>();
        let v3 = 0x1::type_name::with_original_ids<T1>();
        if (v0 == v2 && v1 == v3) {
            true
        } else {
            assert!(v0 == v3 && v1 == v2, 13902612711117684737);
            false
        }
    }

    public fun spot_q64<T0, T1>(arg0: &PriceFeed<T0, T1>) : u128 {
        arg0.spot_q64
    }

    fun update<T0, T1>(arg0: &mut PriceFeed<T0, T1>, arg1: u128, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 13903738894492893193);
        if (&arg0.poke_digest != 0x2::tx_context::digest(arg3)) {
            arg0.ema_before_q64 = arg0.ema_q64;
            arg0.spot_before_q64 = arg0.spot_q64;
            arg0.poke_digest = *0x2::tx_context::digest(arg3);
        };
        let v0 = if (arg2 > arg0.updated_ms) {
            arg2 - arg0.updated_ms
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
            let v4 = (arg1 as u256);
            let v5 = if (v4 >= v3) {
                v3 + (v4 - v3) * v2 / (v2 + (arg0.tau_ms as u256))
            } else {
                v3 - (v3 - v4) * v2 / (v2 + (arg0.tau_ms as u256))
            };
            arg0.ema_q64 = (v5 as u128);
            arg0.updated_ms = arg2;
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

    public fun via_pool_id<T0, T1>(arg0: &PriceFeed<T0, T1>) : 0x1::option::Option<0x2::object::ID> {
        arg0.via_pool_id
    }

    // decompiled from Move bytecode v7
}

