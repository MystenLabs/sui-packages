module 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::pool_price {
    struct RecorderCap has store, key {
        id: 0x2::object::UID,
        oracle_id: 0x2::object::ID,
    }

    struct Observation has copy, drop, store {
        ms: u64,
        cumulative: u256,
    }

    struct PoolPriceOracle has key {
        id: 0x2::object::UID,
        version: u64,
        pool_id: 0x2::object::ID,
        collateral_type: 0x1::type_name::TypeName,
        collateral_is_a: bool,
        min_interval_ms: u64,
        max_step_bps: u64,
        window_ms: u64,
        last_price: u128,
        last_ms: u64,
        cumulative: u256,
        observations: vector<Observation>,
        next: u64,
    }

    struct PoolPriceUpdated has copy, drop {
        oracle_id: 0x2::object::ID,
        spot: u128,
        recorded: u128,
        timestamp_ms: u64,
    }

    fun assert_params(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 >= 1000 && arg0 <= 300000, 2);
        assert!(arg1 >= 10 && arg1 <= 500, 2);
        let v0 = if (arg2 >= 60000) {
            if (arg2 <= 7200000) {
                arg2 >= 4 * arg0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        assert!(arg2 <= (96 - 1) * arg0, 2);
    }

    public fun collateral_is_a(arg0: &PoolPriceOracle) : bool {
        arg0.collateral_is_a
    }

    public fun collateral_type(arg0: &PoolPriceOracle) : 0x1::type_name::TypeName {
        arg0.collateral_type
    }

    public fun create<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : RecorderCap {
        let v0 = if (arg1) {
            0x1::type_name::with_defining_ids<T1>()
        } else {
            0x1::type_name::with_defining_ids<T0>()
        };
        assert!(v0 == 0x1::type_name::with_defining_ids<0x2::sui::SUI>(), 4);
        assert_params(arg2, arg3, arg4);
        let v1 = if (arg1) {
            0x1::type_name::with_defining_ids<T0>()
        } else {
            0x1::type_name::with_defining_ids<T1>()
        };
        let v2 = new_oracle(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg0), v1, spot_price<T0, T1>(arg0, arg1), 0x2::clock::timestamp_ms(arg5), arg1, arg2, arg3, arg4, arg6);
        let v3 = RecorderCap{
            id        : 0x2::object::new(arg6),
            oracle_id : 0x2::object::id<PoolPriceOracle>(&v2),
        };
        0x2::transfer::share_object<PoolPriceOracle>(v2);
        v3
    }

    public fun has_twap(arg0: &PoolPriceOracle, arg1: u64) : bool {
        let v0 = twap(arg0, arg1);
        0x1::option::is_some<u128>(&v0)
    }

    public fun last_ms(arg0: &PoolPriceOracle) : u64 {
        arg0.last_ms
    }

    public fun last_price(arg0: &PoolPriceOracle) : u128 {
        arg0.last_price
    }

    public fun migrate(arg0: &mut PoolPriceOracle, arg1: &RecorderCap) {
        assert!(arg1.oracle_id == 0x2::object::id<PoolPriceOracle>(arg0), 3);
        assert!(arg0.version < 1, 5);
        arg0.version = 1;
    }

    fun new_oracle(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u128, arg3: u64, arg4: bool, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : PoolPriceOracle {
        let v0 = 0x1::vector::empty<Observation>();
        let v1 = Observation{
            ms         : arg3,
            cumulative : 0,
        };
        0x1::vector::push_back<Observation>(&mut v0, v1);
        PoolPriceOracle{
            id              : 0x2::object::new(arg8),
            version         : 1,
            pool_id         : arg0,
            collateral_type : arg1,
            collateral_is_a : arg4,
            min_interval_ms : arg5,
            max_step_bps    : arg6,
            window_ms       : arg7,
            last_price      : arg2,
            last_ms         : arg3,
            cumulative      : 0,
            observations    : v0,
            next            : 1,
        }
    }

    public fun params(arg0: &PoolPriceOracle) : (u64, u64, u64) {
        (arg0.min_interval_ms, arg0.max_step_bps, arg0.window_ms)
    }

    public fun pool_id(arg0: &PoolPriceOracle) : 0x2::object::ID {
        arg0.pool_id
    }

    fun record(arg0: &mut PoolPriceOracle, arg1: u128, arg2: u64) {
        if (arg2 < arg0.last_ms + arg0.min_interval_ms) {
            return
        };
        let v0 = arg2 - arg0.last_ms;
        arg0.cumulative = arg0.cumulative + (arg0.last_price as u256) * (v0 as u256);
        let v1 = 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::mul_div_128(arg0.last_price, ((arg0.max_step_bps * 0x1::u64::min(v0 / arg0.min_interval_ms, 2)) as u128), (0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::bps() as u128));
        let v2 = if (arg1 > arg0.last_price + v1) {
            arg0.last_price + v1
        } else if (arg1 + v1 < arg0.last_price) {
            arg0.last_price - v1
        } else {
            arg1
        };
        let v3 = if (v2 == 0) {
            1
        } else {
            v2
        };
        arg0.last_price = v3;
        arg0.last_ms = arg2;
        let v4 = Observation{
            ms         : arg2,
            cumulative : arg0.cumulative,
        };
        if (0x1::vector::length<Observation>(&arg0.observations) < 96) {
            0x1::vector::push_back<Observation>(&mut arg0.observations, v4);
        } else {
            *0x1::vector::borrow_mut<Observation>(&mut arg0.observations, arg0.next % 96) = v4;
        };
        arg0.next = (arg0.next + 1) % 96;
        let v5 = PoolPriceUpdated{
            oracle_id    : 0x2::object::id<PoolPriceOracle>(arg0),
            spot         : arg1,
            recorded     : arg0.last_price,
            timestamp_ms : arg2,
        };
        0x2::event::emit<PoolPriceUpdated>(v5);
    }

    public fun spot_price<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool) : u128 {
        let v0 = (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0) as u256);
        let v1 = if (arg1) {
            v0 * v0 * (0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::e18() as u256) / 340282366920938463463374607431768211456
        } else {
            340282366920938463463374607431768211456 * (0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::e18() as u256) / v0 * v0
        };
        if (v1 == 0) {
            1
        } else if (v1 > 340282366920938463463374607431768211455) {
            340282366920938463463374607431768211455
        } else {
            (v1 as u128)
        }
    }

    public fun twap(arg0: &PoolPriceOracle, arg1: u64) : 0x1::option::Option<u128> {
        if (arg0.version != 1 || arg1 < arg0.last_ms) {
            return 0x1::option::none<u128>()
        };
        let v0 = if (arg1 > arg0.window_ms) {
            arg1 - arg0.window_ms
        } else {
            0
        };
        let v1 = 0x1::option::none<Observation>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<Observation>(&arg0.observations)) {
            let v3 = *0x1::vector::borrow<Observation>(&arg0.observations, v2);
            if (v3.ms <= v0 && (0x1::option::is_none<Observation>(&v1) || v3.ms > 0x1::option::borrow<Observation>(&v1).ms)) {
                v1 = 0x1::option::some<Observation>(v3);
            };
            v2 = v2 + 1;
        };
        if (0x1::option::is_none<Observation>(&v1)) {
            return 0x1::option::none<u128>()
        };
        let v4 = 0x1::option::destroy_some<Observation>(v1);
        if (arg1 <= v4.ms) {
            return 0x1::option::none<u128>()
        };
        0x1::option::some<u128>((((arg0.cumulative + (arg0.last_price as u256) * ((arg1 - arg0.last_ms) as u256) - v4.cumulative) / ((arg1 - v4.ms) as u256)) as u128))
    }

    public fun update<T0, T1>(arg0: &mut PoolPriceOracle, arg1: &RecorderCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) {
        assert!(arg0.version == 1, 5);
        assert!(arg1.oracle_id == 0x2::object::id<PoolPriceOracle>(arg0), 3);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2) == arg0.pool_id, 1);
        let v0 = spot_price<T0, T1>(arg2, arg0.collateral_is_a);
        record(arg0, v0, 0x2::clock::timestamp_ms(arg3));
    }

    // decompiled from Move bytecode v7
}

