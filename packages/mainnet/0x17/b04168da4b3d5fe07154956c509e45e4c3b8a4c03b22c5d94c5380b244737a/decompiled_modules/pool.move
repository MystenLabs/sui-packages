module 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool {
    struct Tick has drop, store {
        liquidity_lower: u128,
        liquidity_upper: u128,
        fee_growth_outside_x: u256,
        fee_growth_outside_y: u256,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        tier: 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::FeeTier,
        sqrt_price: u128,
        tick: u32,
        liquidity: u128,
        fee_growth_x: u256,
        fee_growth_y: u256,
        ticks: 0x2::table::Table<u32, Tick>,
        bitmap: 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_bitmap::TickBitmap,
        reserve_x: 0x2::balance::Balance<T0>,
        reserve_y: 0x2::balance::Balance<T1>,
        lp_fees_x: 0x2::balance::Balance<T0>,
        lp_fees_y: 0x2::balance::Balance<T1>,
        protocol_fees_x: 0x2::balance::Balance<T0>,
        protocol_fees_y: 0x2::balance::Balance<T1>,
    }

    struct SwapResult has copy, drop {
        amount_in: u64,
        amount_out: u64,
        fee: u64,
        protocol_fee: u64,
        sqrt_price: u128,
        tick: u32,
        liquidity: u128,
        crossed: u64,
        unfilled: u64,
    }

    struct PoolCreated has copy, drop {
        pool: 0x2::object::ID,
        coin_x: 0x1::ascii::String,
        coin_y: 0x1::ascii::String,
        fee_rate: u64,
        tick_spacing: u32,
        protocol_share_bps: u64,
        sqrt_price: u128,
        tick: u32,
    }

    struct Swapped has copy, drop {
        pool: 0x2::object::ID,
        sender: address,
        x_for_y: bool,
        exact_in: bool,
        amount_in: u64,
        amount_out: u64,
        fee: u64,
        protocol_fee: u64,
        sqrt_price_before: u128,
        sqrt_price_after: u128,
        tick_before: u32,
        tick_after: u32,
        liquidity: u128,
        reserve_x: u64,
        reserve_y: u64,
    }

    struct LiquidityAdded has copy, drop {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
        sender: address,
        lower: u32,
        upper: u32,
        liquidity: u128,
        amount_x: u64,
        amount_y: u64,
        sqrt_price: u128,
        tick: u32,
        pool_liquidity: u128,
        reserve_x: u64,
        reserve_y: u64,
    }

    struct LiquidityRemoved has copy, drop {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
        sender: address,
        lower: u32,
        upper: u32,
        liquidity: u128,
        amount_x: u64,
        amount_y: u64,
        sqrt_price: u128,
        tick: u32,
        pool_liquidity: u128,
        reserve_x: u64,
        reserve_y: u64,
    }

    struct FeesCollected has copy, drop {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
        sender: address,
        amount_x: u64,
        amount_y: u64,
    }

    struct ProtocolFeesCollected has copy, drop {
        pool: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
    }

    public fun fee_rate<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::fee_rate(&arg0.tier)
    }

    public fun fee_tier<T0, T1>(arg0: &Pool<T0, T1>) : 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::FeeTier {
        arg0.tier
    }

    public fun tick_spacing<T0, T1>(arg0: &Pool<T0, T1>) : u32 {
        0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::tick_spacing(&arg0.tier)
    }

    fun add_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::Position, arg2: u128, arg3: &0x2::tx_context::TxContext) : (u64, u64) {
        assert!(0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::pool(arg1) == 0x2::object::id<Pool<T0, T1>>(arg0), 1);
        assert!(arg2 > 0, 4);
        let v0 = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::lower(arg1);
        let v1 = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::upper(arg1);
        update_tick<T0, T1>(arg0, v0, arg2, true, false);
        update_tick<T0, T1>(arg0, v1, arg2, true, true);
        let (v2, v3) = fee_growth_inside<T0, T1>(arg0, v0, v1);
        0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::settle(arg1, v2, v3);
        0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::add_liquidity(arg1, arg2);
        if (v0 <= arg0.tick && arg0.tick < v1) {
            arg0.liquidity = arg0.liquidity + arg2;
        };
        let (v4, v5) = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::amounts_for_liquidity(arg0.sqrt_price, 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_math::sqrt_price_at_tick(v0), 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_math::sqrt_price_at_tick(v1), arg2, true);
        let v6 = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::to_u64(v4);
        let v7 = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::to_u64(v5);
        let v8 = LiquidityAdded{
            pool           : 0x2::object::id<Pool<T0, T1>>(arg0),
            position       : 0x2::object::id<0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::Position>(arg1),
            sender         : 0x2::tx_context::sender(arg3),
            lower          : v0,
            upper          : v1,
            liquidity      : arg2,
            amount_x       : v6,
            amount_y       : v7,
            sqrt_price     : arg0.sqrt_price,
            tick           : arg0.tick,
            pool_liquidity : arg0.liquidity,
            reserve_x      : 0x2::balance::value<T0>(&arg0.reserve_x) + v6,
            reserve_y      : 0x2::balance::value<T1>(&arg0.reserve_y) + v7,
        };
        0x2::event::emit<LiquidityAdded>(v8);
        (v6, v7)
    }

    public fun add_liquidity<T0, T1>(arg0: &0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::Config, arg1: &mut Pool<T0, T1>, arg2: &mut 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::Position, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u128, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::assert_open(arg0);
        let (v0, v1) = add_internal<T0, T1>(arg1, arg2, arg5, arg8);
        assert!(v0 <= arg6 && v1 <= arg7, 6);
        pay_in<T0, T1>(arg1, arg3, arg4, v0, v1, arg8)
    }

    public fun add_liquidity_by_amounts<T0, T1>(arg0: &0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::Config, arg1: &mut Pool<T0, T1>, arg2: &mut 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::Position, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::assert_open(arg0);
        let v0 = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::liquidity_for_amounts(arg1.sqrt_price, 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_math::sqrt_price_at_tick(0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::lower(arg2)), 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_math::sqrt_price_at_tick(0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::upper(arg2)), arg5, arg6);
        let (v1, v2) = add_internal<T0, T1>(arg1, arg2, v0, arg9);
        assert!(v1 >= arg7 && v2 >= arg8, 5);
        pay_in<T0, T1>(arg1, arg3, arg4, v1, v2, arg9)
    }

    public fun close_position<T0, T1>(arg0: &0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::Config, arg1: &Pool<T0, T1>, arg2: 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::Position) {
        0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::assert_version(arg0);
        assert!(0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::pool(&arg2) == 0x2::object::id<Pool<T0, T1>>(arg1), 1);
        0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::destroy(arg2);
    }

    public fun collect_fees<T0, T1>(arg0: &0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::Config, arg1: &mut Pool<T0, T1>, arg2: &mut 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::Position, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::assert_version(arg0);
        assert!(0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::pool(arg2) == 0x2::object::id<Pool<T0, T1>>(arg1), 1);
        if (0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::liquidity(arg2) > 0) {
            let (v0, v1) = fee_growth_inside<T0, T1>(arg1, 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::lower(arg2), 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::upper(arg2));
            0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::settle(arg2, v0, v1);
        };
        let (v2, v3) = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::take_owed(arg2);
        let v4 = FeesCollected{
            pool     : 0x2::object::id<Pool<T0, T1>>(arg1),
            position : 0x2::object::id<0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::Position>(arg2),
            sender   : 0x2::tx_context::sender(arg3),
            amount_x : v2,
            amount_y : v3,
        };
        0x2::event::emit<FeesCollected>(v4);
        (0x2::coin::take<T0>(&mut arg1.lp_fees_x, v2, arg3), 0x2::coin::take<T1>(&mut arg1.lp_fees_y, v3, arg3))
    }

    public fun collect_protocol_fees<T0, T1>(arg0: &0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::Config, arg1: &mut Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::assert_version(arg0);
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg1.protocol_fees_x);
        let v1 = 0x2::balance::withdraw_all<T1>(&mut arg1.protocol_fees_y);
        let v2 = ProtocolFeesCollected{
            pool     : 0x2::object::id<Pool<T0, T1>>(arg1),
            amount_x : 0x2::balance::value<T0>(&v0),
            amount_y : 0x2::balance::value<T1>(&v1),
        };
        0x2::event::emit<ProtocolFeesCollected>(v2);
        split_to_recipients<T0>(arg0, v0, arg2);
        split_to_recipients<T1>(arg0, v1, arg2);
    }

    fun compute_swap<T0, T1>(arg0: &Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: u128) : (SwapResult, u256, vector<u32>, vector<u256>) {
        assert!(arg3 > 0, 3);
        let v0 = if (arg4 == 0) {
            if (arg1) {
                0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_math::min_sqrt_price()
            } else {
                0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_math::max_sqrt_price()
            }
        } else {
            arg4
        };
        assert!(arg1 && v0 < arg0.sqrt_price && v0 >= 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_math::min_sqrt_price() || v0 > arg0.sqrt_price && v0 <= 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_math::max_sqrt_price(), 7);
        let v1 = arg0.sqrt_price;
        let v2 = arg0.liquidity;
        let v3 = arg0.tick;
        let v4 = v1;
        let v5 = if (arg1) {
            arg0.fee_growth_x
        } else {
            arg0.fee_growth_y
        };
        let v6 = v5;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0;
        let v11 = arg3;
        let v12 = vector[];
        let v13 = vector[];
        let v14 = 0;
        loop {
            let v15 = if (v11 > 0) {
                if (v4 != v0) {
                    v14 < 150
                } else {
                    false
                }
            } else {
                false
            };
            if (v15) {
                let v16 = if (arg1) {
                    0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_bitmap::next_at_or_below(&arg0.bitmap, v3)
                } else {
                    0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_bitmap::next_above(&arg0.bitmap, v3)
                };
                let v17 = v16;
                if (0x1::option::is_none<u32>(&v17)) {
                    break
                };
                let v18 = 0x1::option::destroy_some<u32>(v17);
                let v19 = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_math::sqrt_price_at_tick(v18);
                let v20 = if (arg1) {
                    if (v19 > v0) {
                        v19
                    } else {
                        v0
                    }
                } else if (v19 < v0) {
                    v19
                } else {
                    v0
                };
                let (v21, v22, v23, v24) = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::swap_step(v4, v20, v2, v11, 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::fee_rate(&arg0.tier), arg2);
                let v25 = if (arg2) {
                    v11 - v22 - v24
                } else {
                    v11 - v23
                };
                v11 = v25;
                v9 = v9 + v23;
                let v26 = v10 + v22;
                v10 = v26 + v24;
                if (v24 > 0) {
                    let v27 = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::protocol_part(v24, 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::protocol_share_bps(&arg0.tier));
                    v7 = v7 + v27;
                    v8 = v8 + v24;
                    v6 = v6 + (((v24 - v27) as u256) << 128) / (v2 as u256);
                };
                if (v21 == v19) {
                    let v28 = 0x2::table::borrow<u32, Tick>(&arg0.ticks, v18);
                    let v29 = if (arg1) {
                        v2 + v28.liquidity_upper - v28.liquidity_lower
                    } else {
                        v2 + v28.liquidity_lower - v28.liquidity_upper
                    };
                    v2 = v29;
                    0x1::vector::push_back<u32>(&mut v13, v18);
                    0x1::vector::push_back<u256>(&mut v12, v6);
                    let v30 = if (arg1) {
                        v18 - 1
                    } else {
                        v18
                    };
                    v3 = v30;
                } else if (v21 != v1) {
                    v3 = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_math::tick_at_sqrt_price(v21);
                };
                v4 = v21;
                v14 = v14 + 1;
            } else {
                break
            };
        };
        let v31 = SwapResult{
            amount_in    : v10,
            amount_out   : v9,
            fee          : v8,
            protocol_fee : v7,
            sqrt_price   : v4,
            tick         : v3,
            liquidity    : v2,
            crossed      : 0x1::vector::length<u32>(&v13),
            unfilled     : v11,
        };
        (v31, v6, v13, v12)
    }

    public fun create<T0, T1>(arg0: &mut 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::Config, arg1: u64, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::assert_open(arg0);
        let v0 = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::fee_tier(arg0, arg1);
        assert!(arg2 >= 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_math::min_sqrt_price() && arg2 <= 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_math::max_sqrt_price(), 10);
        let v1 = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_math::tick_at_sqrt_price(arg2);
        let v2 = Pool<T0, T1>{
            id              : 0x2::object::new(arg3),
            tier            : v0,
            sqrt_price      : arg2,
            tick            : v1,
            liquidity       : 0,
            fee_growth_x    : 0,
            fee_growth_y    : 0,
            ticks           : 0x2::table::new<u32, Tick>(arg3),
            bitmap          : 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_bitmap::new(arg3),
            reserve_x       : 0x2::balance::zero<T0>(),
            reserve_y       : 0x2::balance::zero<T1>(),
            lp_fees_x       : 0x2::balance::zero<T0>(),
            lp_fees_y       : 0x2::balance::zero<T1>(),
            protocol_fees_x : 0x2::balance::zero<T0>(),
            protocol_fees_y : 0x2::balance::zero<T1>(),
        };
        let v3 = 0x2::object::id<Pool<T0, T1>>(&v2);
        0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::register_pool<T0, T1>(arg0, arg1, v3);
        let v4 = PoolCreated{
            pool               : v3,
            coin_x             : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            coin_y             : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            fee_rate           : arg1,
            tick_spacing       : 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::tick_spacing(&v0),
            protocol_share_bps : 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::protocol_share_bps(&v0),
            sqrt_price         : arg2,
            tick               : v1,
        };
        0x2::event::emit<PoolCreated>(v4);
        0x2::transfer::share_object<Pool<T0, T1>>(v2);
        v3
    }

    public fun fee_growth<T0, T1>(arg0: &Pool<T0, T1>) : (u256, u256) {
        (arg0.fee_growth_x, arg0.fee_growth_y)
    }

    fun fee_growth_inside<T0, T1>(arg0: &Pool<T0, T1>, arg1: u32, arg2: u32) : (u256, u256) {
        let v0 = 0x2::table::borrow<u32, Tick>(&arg0.ticks, arg1);
        let v1 = 0x2::table::borrow<u32, Tick>(&arg0.ticks, arg2);
        let (v2, v3) = if (arg0.tick >= arg1) {
            (v0.fee_growth_outside_x, v0.fee_growth_outside_y)
        } else {
            (0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::wrapping_sub(arg0.fee_growth_x, v0.fee_growth_outside_x), 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::wrapping_sub(arg0.fee_growth_y, v0.fee_growth_outside_y))
        };
        let (v4, v5) = if (arg0.tick < arg2) {
            (v1.fee_growth_outside_x, v1.fee_growth_outside_y)
        } else {
            (0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::wrapping_sub(arg0.fee_growth_x, v1.fee_growth_outside_x), 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::wrapping_sub(arg0.fee_growth_y, v1.fee_growth_outside_y))
        };
        (0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::wrapping_sub(0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::wrapping_sub(arg0.fee_growth_x, v2), v4), 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::wrapping_sub(0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::wrapping_sub(arg0.fee_growth_y, v3), v5))
    }

    public fun in_range<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::Position) : bool {
        0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::lower(arg1) <= arg0.tick && arg0.tick < 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::upper(arg1)
    }

    public fun liquidity<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.liquidity
    }

    public fun lp_fees<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.lp_fees_x), 0x2::balance::value<T1>(&arg0.lp_fees_y))
    }

    public fun max_liquidity_per_tick(arg0: u32) : u128 {
        340282366920938463463374607431768211455 / (0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_math::usable_ticks(arg0) as u128)
    }

    public fun next_ticks<T0, T1>(arg0: &Pool<T0, T1>, arg1: u32) : (0x1::option::Option<u32>, 0x1::option::Option<u32>) {
        (0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_bitmap::next_above(&arg0.bitmap, arg1), 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_bitmap::next_below(&arg0.bitmap, arg1))
    }

    public fun open_position<T0, T1>(arg0: &0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::Config, arg1: &Pool<T0, T1>, arg2: u32, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) : 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::Position {
        0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::assert_version(arg0);
        let v0 = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::tick_spacing(&arg1.tier);
        let (v1, v2) = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_math::full_range(v0);
        let v3 = if (arg2 < arg3) {
            if (arg2 >= v1) {
                arg3 <= v2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 2);
        assert!(0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_math::is_aligned(arg2, v0) && 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_math::is_aligned(arg3, v0), 2);
        0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::new(0x2::object::id<Pool<T0, T1>>(arg1), arg2, arg3, arg4)
    }

    fun pay_in<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T0>(&arg1) >= arg3 && 0x2::coin::value<T1>(&arg2) >= arg4, 3);
        0x2::balance::join<T0>(&mut arg0.reserve_x, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, arg3, arg5)));
        0x2::balance::join<T1>(&mut arg0.reserve_y, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, arg4, arg5)));
        (arg1, arg2)
    }

    public fun position_amounts<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::Position) : (u64, u64) {
        assert!(0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::pool(arg1) == 0x2::object::id<Pool<T0, T1>>(arg0), 1);
        if (0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::liquidity(arg1) == 0) {
            return (0, 0)
        };
        let (v0, v1) = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::amounts_for_liquidity(arg0.sqrt_price, 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_math::sqrt_price_at_tick(0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::lower(arg1)), 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_math::sqrt_price_at_tick(0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::upper(arg1)), 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::liquidity(arg1), false);
        (0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::to_u64(v0), 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::to_u64(v1))
    }

    public fun position_fees<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::Position) : (u64, u64) {
        assert!(0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::pool(arg1) == 0x2::object::id<Pool<T0, T1>>(arg0), 1);
        let (v0, v1) = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::owed(arg1);
        if (0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::liquidity(arg1) == 0) {
            return (v0, v1)
        };
        let (v2, v3) = fee_growth_inside<T0, T1>(arg0, 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::lower(arg1), 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::upper(arg1));
        let (v4, v5) = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::fee_growth_inside(arg1);
        let v6 = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::fees_earned(0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::liquidity(arg1), 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::wrapping_sub(v2, v4));
        let v7 = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::fees_earned(0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::liquidity(arg1), 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::wrapping_sub(v3, v5));
        let v8 = 18446744073709551615;
        let v9 = if (v6 > v8 - v0) {
            v8
        } else {
            v0 + v6
        };
        let v10 = if (v7 > v8 - v1) {
            v8
        } else {
            v1 + v7
        };
        (v9, v10)
    }

    public fun protocol_fees<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.protocol_fees_x), 0x2::balance::value<T1>(&arg0.protocol_fees_y))
    }

    public fun quote_exact_in<T0, T1>(arg0: &Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u128) : SwapResult {
        let (v0, _, _, _) = compute_swap<T0, T1>(arg0, arg1, true, arg2, arg3);
        v0
    }

    public fun quote_exact_out<T0, T1>(arg0: &Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u128) : SwapResult {
        let (v0, _, _, _) = compute_swap<T0, T1>(arg0, arg1, false, arg2, arg3);
        v0
    }

    public fun remove_liquidity<T0, T1>(arg0: &0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::Config, arg1: &mut Pool<T0, T1>, arg2: &mut 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::Position, arg3: u128, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::assert_version(arg0);
        assert!(0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::pool(arg2) == 0x2::object::id<Pool<T0, T1>>(arg1), 1);
        assert!(arg3 > 0 && arg3 <= 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::liquidity(arg2), 4);
        let v0 = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::lower(arg2);
        let v1 = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::upper(arg2);
        let (v2, v3) = fee_growth_inside<T0, T1>(arg1, v0, v1);
        0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::settle(arg2, v2, v3);
        0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::remove_liquidity(arg2, arg3);
        update_tick<T0, T1>(arg1, v0, arg3, false, false);
        update_tick<T0, T1>(arg1, v1, arg3, false, true);
        if (v0 <= arg1.tick && arg1.tick < v1) {
            arg1.liquidity = arg1.liquidity - arg3;
        };
        let (v4, v5) = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::amounts_for_liquidity(arg1.sqrt_price, 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_math::sqrt_price_at_tick(v0), 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_math::sqrt_price_at_tick(v1), arg3, false);
        let v6 = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::to_u64(v4);
        let v7 = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::to_u64(v5);
        assert!(v6 >= arg4 && v7 >= arg5, 5);
        let v8 = LiquidityRemoved{
            pool           : 0x2::object::id<Pool<T0, T1>>(arg1),
            position       : 0x2::object::id<0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::position::Position>(arg2),
            sender         : 0x2::tx_context::sender(arg6),
            lower          : v0,
            upper          : v1,
            liquidity      : arg3,
            amount_x       : v6,
            amount_y       : v7,
            sqrt_price     : arg1.sqrt_price,
            tick           : arg1.tick,
            pool_liquidity : arg1.liquidity,
            reserve_x      : 0x2::balance::value<T0>(&arg1.reserve_x),
            reserve_y      : 0x2::balance::value<T1>(&arg1.reserve_y),
        };
        0x2::event::emit<LiquidityRemoved>(v8);
        (0x2::coin::take<T0>(&mut arg1.reserve_x, v6, arg6), 0x2::coin::take<T1>(&mut arg1.reserve_y, v7, arg6))
    }

    public fun reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.reserve_x), 0x2::balance::value<T1>(&arg0.reserve_y))
    }

    public fun result_amount_in(arg0: &SwapResult) : u64 {
        arg0.amount_in
    }

    public fun result_amount_out(arg0: &SwapResult) : u64 {
        arg0.amount_out
    }

    public fun result_crossed(arg0: &SwapResult) : u64 {
        arg0.crossed
    }

    public fun result_fee(arg0: &SwapResult) : u64 {
        arg0.fee
    }

    public fun result_liquidity(arg0: &SwapResult) : u128 {
        arg0.liquidity
    }

    public fun result_protocol_fee(arg0: &SwapResult) : u64 {
        arg0.protocol_fee
    }

    public fun result_sqrt_price(arg0: &SwapResult) : u128 {
        arg0.sqrt_price
    }

    public fun result_tick(arg0: &SwapResult) : u32 {
        arg0.tick
    }

    public fun result_unfilled(arg0: &SwapResult) : u64 {
        arg0.unfilled
    }

    fun split_to_recipients<T0>(arg0: &0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::Config, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = (((0x2::balance::value<T0>(&arg1) as u128) * (0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::ppx_bps(arg0) as u128) / (0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::basis() as u128)) as u64);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1, v0), arg2), 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::ppx_recipient(arg0));
        };
        if (0x2::balance::value<T0>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg1, arg2), 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::treasury(arg0));
        } else {
            0x2::balance::destroy_zero<T0>(arg1);
        };
    }

    public fun sqrt_price<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.sqrt_price
    }

    fun swap_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: u128, arg5: &0x2::tx_context::TxContext) : SwapResult {
        let (v0, v1, v2, v3) = compute_swap<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        let v4 = v3;
        let v5 = v2;
        let v6 = v0;
        assert!(v6.amount_out > 0, 8);
        let v7 = if (arg1) {
            arg0.fee_growth_y
        } else {
            arg0.fee_growth_x
        };
        let v8 = 0;
        while (v8 < 0x1::vector::length<u32>(&v5)) {
            let v9 = 0x2::table::borrow_mut<u32, Tick>(&mut arg0.ticks, *0x1::vector::borrow<u32>(&v5, v8));
            let (v10, v11) = if (arg1) {
                (&mut v9.fee_growth_outside_x, &mut v9.fee_growth_outside_y)
            } else {
                (&mut v9.fee_growth_outside_y, &mut v9.fee_growth_outside_x)
            };
            *v10 = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::wrapping_sub(*0x1::vector::borrow<u256>(&v4, v8), *v10);
            *v11 = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::wrapping_sub(v7, *v11);
            v8 = v8 + 1;
        };
        if (arg1) {
            arg0.fee_growth_x = v1;
        } else {
            arg0.fee_growth_y = v1;
        };
        arg0.sqrt_price = v6.sqrt_price;
        arg0.tick = v6.tick;
        arg0.liquidity = v6.liquidity;
        let (v12, v13) = if (arg1) {
            (0x2::balance::value<T0>(&arg0.reserve_x) + v6.amount_in - v6.fee, 0x2::balance::value<T1>(&arg0.reserve_y) - v6.amount_out)
        } else {
            (0x2::balance::value<T0>(&arg0.reserve_x) - v6.amount_out, 0x2::balance::value<T1>(&arg0.reserve_y) + v6.amount_in - v6.fee)
        };
        let v14 = Swapped{
            pool              : 0x2::object::id<Pool<T0, T1>>(arg0),
            sender            : 0x2::tx_context::sender(arg5),
            x_for_y           : arg1,
            exact_in          : arg2,
            amount_in         : v6.amount_in,
            amount_out        : v6.amount_out,
            fee               : v6.fee,
            protocol_fee      : v6.protocol_fee,
            sqrt_price_before : arg0.sqrt_price,
            sqrt_price_after  : v6.sqrt_price,
            tick_before       : arg0.tick,
            tick_after        : v6.tick,
            liquidity         : v6.liquidity,
            reserve_x         : v12,
            reserve_y         : v13,
        };
        0x2::event::emit<Swapped>(v14);
        v6
    }

    public fun swap_x_for_exact_y<T0, T1>(arg0: &0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::Config, arg1: &mut Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u128, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::assert_open(arg0);
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = swap_internal<T0, T1>(arg1, true, false, arg3, arg5, arg6);
        assert!(v1.unfilled == 0, 8);
        assert!(v1.amount_in <= arg4 && v1.amount_in <= 0x2::balance::value<T0>(&v0), 6);
        let v2 = &mut v0;
        take_in_x<T0, T1>(arg1, v2, &v1);
        (0x2::coin::from_balance<T0>(v0, arg6), 0x2::coin::take<T1>(&mut arg1.reserve_y, v1.amount_out, arg6))
    }

    public fun swap_x_for_y<T0, T1>(arg0: &0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::Config, arg1: &mut Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::assert_open(arg0);
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = swap_internal<T0, T1>(arg1, true, true, 0x2::balance::value<T0>(&v0), arg4, arg5);
        assert!(v1.amount_out >= arg3, 5);
        let v2 = &mut v0;
        take_in_x<T0, T1>(arg1, v2, &v1);
        (0x2::coin::from_balance<T0>(v0, arg5), 0x2::coin::take<T1>(&mut arg1.reserve_y, v1.amount_out, arg5))
    }

    public fun swap_y_for_exact_x<T0, T1>(arg0: &0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::Config, arg1: &mut Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u128, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::assert_open(arg0);
        let v0 = 0x2::coin::into_balance<T1>(arg2);
        let v1 = swap_internal<T0, T1>(arg1, false, false, arg3, arg5, arg6);
        assert!(v1.unfilled == 0, 8);
        assert!(v1.amount_in <= arg4 && v1.amount_in <= 0x2::balance::value<T1>(&v0), 6);
        let v2 = &mut v0;
        take_in_y<T0, T1>(arg1, v2, &v1);
        (0x2::coin::from_balance<T1>(v0, arg6), 0x2::coin::take<T0>(&mut arg1.reserve_x, v1.amount_out, arg6))
    }

    public fun swap_y_for_x<T0, T1>(arg0: &0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::Config, arg1: &mut Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::assert_open(arg0);
        let v0 = 0x2::coin::into_balance<T1>(arg2);
        let v1 = swap_internal<T0, T1>(arg1, false, true, 0x2::balance::value<T1>(&v0), arg4, arg5);
        assert!(v1.amount_out >= arg3, 5);
        let v2 = &mut v0;
        take_in_y<T0, T1>(arg1, v2, &v1);
        (0x2::coin::from_balance<T1>(v0, arg5), 0x2::coin::take<T0>(&mut arg1.reserve_x, v1.amount_out, arg5))
    }

    fun take_in_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::balance::Balance<T0>, arg2: &SwapResult) {
        0x2::balance::join<T0>(&mut arg0.protocol_fees_x, 0x2::balance::split<T0>(arg1, arg2.protocol_fee));
        0x2::balance::join<T0>(&mut arg0.lp_fees_x, 0x2::balance::split<T0>(arg1, arg2.fee - arg2.protocol_fee));
        0x2::balance::join<T0>(&mut arg0.reserve_x, 0x2::balance::split<T0>(arg1, arg2.amount_in - arg2.fee));
    }

    fun take_in_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::balance::Balance<T1>, arg2: &SwapResult) {
        0x2::balance::join<T1>(&mut arg0.protocol_fees_y, 0x2::balance::split<T1>(arg1, arg2.protocol_fee));
        0x2::balance::join<T1>(&mut arg0.lp_fees_y, 0x2::balance::split<T1>(arg1, arg2.fee - arg2.protocol_fee));
        0x2::balance::join<T1>(&mut arg0.reserve_y, 0x2::balance::split<T1>(arg1, arg2.amount_in - arg2.fee));
    }

    public fun tick<T0, T1>(arg0: &Pool<T0, T1>) : u32 {
        arg0.tick
    }

    public fun tick_info<T0, T1>(arg0: &Pool<T0, T1>, arg1: u32) : (u128, u128, u256, u256) {
        if (!0x2::table::contains<u32, Tick>(&arg0.ticks, arg1)) {
            return (0, 0, 0, 0)
        };
        let v0 = 0x2::table::borrow<u32, Tick>(&arg0.ticks, arg1);
        (v0.liquidity_lower, v0.liquidity_upper, v0.fee_growth_outside_x, v0.fee_growth_outside_y)
    }

    fun update_tick<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u32, arg2: u128, arg3: bool, arg4: bool) {
        if (arg3) {
            if (!0x2::table::contains<u32, Tick>(&arg0.ticks, arg1)) {
                let v0 = arg1 <= arg0.tick;
                let v1 = if (v0) {
                    arg0.fee_growth_x
                } else {
                    0
                };
                let v2 = if (v0) {
                    arg0.fee_growth_y
                } else {
                    0
                };
                let v3 = Tick{
                    liquidity_lower      : 0,
                    liquidity_upper      : 0,
                    fee_growth_outside_x : v1,
                    fee_growth_outside_y : v2,
                };
                0x2::table::add<u32, Tick>(&mut arg0.ticks, arg1, v3);
                0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_bitmap::set(&mut arg0.bitmap, arg1);
            };
            let v4 = max_liquidity_per_tick(0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::tick_spacing(&arg0.tier));
            let v5 = 0x2::table::borrow_mut<u32, Tick>(&mut arg0.ticks, arg1);
            let v6 = if (arg2 <= v4) {
                if (v5.liquidity_lower <= v4 - arg2) {
                    v5.liquidity_upper <= v4 - arg2 - v5.liquidity_lower
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v6, 9);
            if (arg4) {
                v5.liquidity_upper = v5.liquidity_upper + arg2;
            } else {
                v5.liquidity_lower = v5.liquidity_lower + arg2;
            };
        } else {
            let v7 = 0x2::table::borrow_mut<u32, Tick>(&mut arg0.ticks, arg1);
            if (arg4) {
                v7.liquidity_upper = v7.liquidity_upper - arg2;
            } else {
                v7.liquidity_lower = v7.liquidity_lower - arg2;
            };
            if (v7.liquidity_lower == 0 && v7.liquidity_upper == 0) {
                0x2::table::remove<u32, Tick>(&mut arg0.ticks, arg1);
                0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_bitmap::unset(&mut arg0.bitmap, arg1);
            };
        };
    }

    // decompiled from Move bytecode v7
}

