module 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::pool {
    struct Bin has drop, store {
        x: u64,
        y: u64,
        supply: u256,
        fee_x_growth: u256,
        fee_y_growth: u256,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        preset: 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::Preset,
        active_id: u32,
        bins: 0x2::table::Table<u32, Bin>,
        bitmap: 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::bin_bitmap::BinBitmap,
        reserve_x: 0x2::balance::Balance<T0>,
        reserve_y: 0x2::balance::Balance<T1>,
        lp_fees_x: 0x2::balance::Balance<T0>,
        lp_fees_y: 0x2::balance::Balance<T1>,
        protocol_fees_x: 0x2::balance::Balance<T0>,
        protocol_fees_y: 0x2::balance::Balance<T1>,
        volatility: 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::Volatility,
    }

    struct PoolCreated has copy, drop {
        pool: 0x2::object::ID,
        coin_x: 0x1::ascii::String,
        coin_y: 0x1::ascii::String,
        bin_step: u64,
        active_id: u32,
    }

    struct Swapped has copy, drop {
        pool: 0x2::object::ID,
        sender: address,
        x_for_y: bool,
        amount_in: u64,
        amount_out: u64,
        fee: u64,
        protocol_fee: u64,
        active_before: u32,
        active_after: u32,
        volatility: u64,
    }

    struct LiquidityAdded has copy, drop {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
        fee_x: u64,
        fee_y: u64,
        active_id: u32,
    }

    struct LiquidityRemoved has copy, drop {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
    }

    struct FeesClaimed has copy, drop {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
    }

    struct ProtocolFeesCollected has copy, drop {
        pool: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
    }

    public fun preset<T0, T1>(arg0: &Pool<T0, T1>) : 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::Preset {
        arg0.preset
    }

    public fun active_id<T0, T1>(arg0: &Pool<T0, T1>) : u32 {
        arg0.active_id
    }

    public fun active_price<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::price(arg0.active_id, 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::bin_step(&arg0.preset))
    }

    public fun add_liquidity<T0, T1>(arg0: &0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::Config, arg1: &mut Pool<T0, T1>, arg2: &mut 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::Position, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: vector<u64>, arg6: vector<u64>, arg7: u32, arg8: u32, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::assert_open(arg0);
        assert!(0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::pool(arg2) == 0x2::object::id<Pool<T0, T1>>(arg1), 1);
        let v0 = (0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::width(arg2) as u64);
        assert!(0x1::vector::length<u64>(&arg5) == v0 && 0x1::vector::length<u64>(&arg6) == v0, 7);
        let v1 = arg1.active_id;
        assert!(v1 >= arg7 && v1 <= arg8, 4);
        let v2 = 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::protocol_share_bps(&arg1.preset);
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        while (v9 < v0) {
            let v10 = *0x1::vector::borrow<u64>(&arg5, v9);
            let v11 = *0x1::vector::borrow<u64>(&arg6, v9);
            if (v10 > 0 || v11 > 0) {
                let v12 = 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::lower(arg2) + (v9 as u32);
                assert!((v12 <= v1 || v11 == 0) && (v12 >= v1 || v10 == 0), 2);
                let v13 = 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::price(v12, 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::bin_step(&arg1.preset));
                if (!0x2::table::contains<u32, Bin>(&arg1.bins, v12)) {
                    let v14 = Bin{
                        x            : 0,
                        y            : 0,
                        supply       : 0,
                        fee_x_growth : 0,
                        fee_y_growth : 0,
                    };
                    0x2::table::add<u32, Bin>(&mut arg1.bins, v12, v14);
                };
                let v15 = 0x2::table::borrow_mut<u32, Bin>(&mut arg1.bins, v12);
                let (v16, v17) = if (v12 == v1) {
                    0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::composition_fee(v15.x, v15.y, v10, v11, v13, current_fee_rate<T0, T1>(arg1))
                } else {
                    (0, 0)
                };
                let v18 = protocol_part(v16, v2, v15.supply);
                let v19 = protocol_part(v17, v2, v15.supply);
                if (v16 > v18) {
                    v15.fee_x_growth = v15.fee_x_growth + (((v16 - v18) as u256) << 128) / v15.supply;
                };
                if (v17 > v19) {
                    v15.fee_y_growth = v15.fee_y_growth + (((v17 - v19) as u256) << 128) / v15.supply;
                };
                0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::settle(arg2, v9, v15.fee_x_growth, v15.fee_y_growth);
                let v20 = v10 - v16;
                let v21 = v11 - v17;
                let v22 = if (v15.supply == 0) {
                    0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::liquidity(v20, v21, v13)
                } else {
                    0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::liquidity(v20, v21, v13) * v15.supply / 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::liquidity(v15.x, v15.y, v13)
                };
                assert!(v22 > 0, 6);
                v15.x = v15.x + v20;
                v15.y = v15.y + v21;
                v15.supply = v15.supply + v22;
                0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::add_shares(arg2, v9, v22);
                0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::bin_bitmap::set(&mut arg1.bitmap, v12);
                v6 = v6 + v10;
                v5 = v5 + v11;
                v4 = v4 + v16;
                v3 = v3 + v17;
                v8 = v8 + v18;
                v7 = v7 + v19;
            };
            v9 = v9 + 1;
        };
        assert!(v4 <= arg9 && v3 <= arg10, 10);
        let v23 = 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v6, arg11));
        let v24 = 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, v5, arg11));
        0x2::balance::join<T0>(&mut arg1.protocol_fees_x, 0x2::balance::split<T0>(&mut v23, v8));
        0x2::balance::join<T1>(&mut arg1.protocol_fees_y, 0x2::balance::split<T1>(&mut v24, v7));
        0x2::balance::join<T0>(&mut arg1.lp_fees_x, 0x2::balance::split<T0>(&mut v23, v4 - v8));
        0x2::balance::join<T1>(&mut arg1.lp_fees_y, 0x2::balance::split<T1>(&mut v24, v3 - v7));
        0x2::balance::join<T0>(&mut arg1.reserve_x, v23);
        0x2::balance::join<T1>(&mut arg1.reserve_y, v24);
        let v25 = LiquidityAdded{
            pool      : 0x2::object::id<Pool<T0, T1>>(arg1),
            position  : 0x2::object::id<0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::Position>(arg2),
            amount_x  : v6,
            amount_y  : v5,
            fee_x     : v4,
            fee_y     : v3,
            active_id : v1,
        };
        0x2::event::emit<LiquidityAdded>(v25);
        (arg3, arg4)
    }

    public fun bin<T0, T1>(arg0: &Pool<T0, T1>, arg1: u32) : (u64, u64, u256) {
        if (!0x2::table::contains<u32, Bin>(&arg0.bins, arg1)) {
            return (0, 0, 0)
        };
        let v0 = 0x2::table::borrow<u32, Bin>(&arg0.bins, arg1);
        (v0.x, v0.y, v0.supply)
    }

    public fun claim_fees<T0, T1>(arg0: &0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::Config, arg1: &mut Pool<T0, T1>, arg2: &mut 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::Position, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::assert_version(arg0);
        assert!(0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::pool(arg2) == 0x2::object::id<Pool<T0, T1>>(arg1), 1);
        let (v0, v1) = pay_fees<T0, T1>(arg1, arg2);
        (0x2::coin::take<T0>(&mut arg1.lp_fees_x, v0, arg3), 0x2::coin::take<T1>(&mut arg1.lp_fees_y, v1, arg3))
    }

    public fun close_position<T0, T1>(arg0: &0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::Config, arg1: &Pool<T0, T1>, arg2: 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::Position) {
        0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::assert_version(arg0);
        assert!(0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::pool(&arg2) == 0x2::object::id<Pool<T0, T1>>(arg1), 1);
        0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::destroy(arg2);
    }

    public fun collect_protocol_fees<T0, T1>(arg0: &0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::Config, arg1: &mut Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::assert_version(arg0);
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

    public fun create<T0, T1>(arg0: &mut 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::Config, arg1: u64, arg2: u32, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::assert_open(arg0);
        0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::price(arg2, arg1);
        let v0 = Pool<T0, T1>{
            id              : 0x2::object::new(arg4),
            preset          : 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::preset(arg0, arg1),
            active_id       : arg2,
            bins            : 0x2::table::new<u32, Bin>(arg4),
            bitmap          : 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::bin_bitmap::new(arg4),
            reserve_x       : 0x2::balance::zero<T0>(),
            reserve_y       : 0x2::balance::zero<T1>(),
            lp_fees_x       : 0x2::balance::zero<T0>(),
            lp_fees_y       : 0x2::balance::zero<T1>(),
            protocol_fees_x : 0x2::balance::zero<T0>(),
            protocol_fees_y : 0x2::balance::zero<T1>(),
            volatility      : 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::new_volatility(arg2, 0x2::clock::timestamp_ms(arg3)),
        };
        0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::register_pool<T0, T1>(arg0, arg1, 0x2::object::id<Pool<T0, T1>>(&v0));
        let v1 = PoolCreated{
            pool      : 0x2::object::id<Pool<T0, T1>>(&v0),
            coin_x    : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            coin_y    : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            bin_step  : arg1,
            active_id : arg2,
        };
        0x2::event::emit<PoolCreated>(v1);
        0x2::transfer::share_object<Pool<T0, T1>>(v0);
    }

    fun current_fee_rate<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        let v0 = arg0.preset;
        0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::total_fee_rate(0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::base_factor(&v0), 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::bin_step(&v0), 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::accumulator(&arg0.volatility), 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::variable_fee_control(&v0))
    }

    public fun fee_rate<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        current_fee_rate<T0, T1>(arg0)
    }

    fun has_out_side<T0, T1>(arg0: &Pool<T0, T1>, arg1: u32, arg2: bool) : bool {
        if (!0x2::table::contains<u32, Bin>(&arg0.bins, arg1)) {
            return false
        };
        arg2 && 0x2::table::borrow<u32, Bin>(&arg0.bins, arg1).y > 0 || 0x2::table::borrow<u32, Bin>(&arg0.bins, arg1).x > 0
    }

    public fun next_bins<T0, T1>(arg0: &Pool<T0, T1>, arg1: u32) : (0x1::option::Option<u32>, 0x1::option::Option<u32>) {
        (0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::bin_bitmap::next_above(&arg0.bitmap, arg1), 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::bin_bitmap::next_below(&arg0.bitmap, arg1))
    }

    public fun open_position<T0, T1>(arg0: &0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::Config, arg1: &Pool<T0, T1>, arg2: u32, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) : 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::Position {
        0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::assert_version(arg0);
        assert!(arg2 <= 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::max_id() && arg3 <= 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::max_id() - arg2 + 1, 1);
        0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::price(arg2, 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::bin_step(&arg1.preset));
        0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::price(arg2 + arg3 - 1, 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::bin_step(&arg1.preset));
        0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::new(0x2::object::id<Pool<T0, T1>>(arg1), arg2, arg3, arg4)
    }

    fun pay_fees<T0, T1>(arg0: &Pool<T0, T1>, arg1: &mut 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::Position) : (u64, u64) {
        let v0 = 0;
        while (v0 < (0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::width(arg1) as u64)) {
            let v1 = 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::lower(arg1) + (v0 as u32);
            if (0x2::table::contains<u32, Bin>(&arg0.bins, v1)) {
                let v2 = 0x2::table::borrow<u32, Bin>(&arg0.bins, v1);
                0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::settle(arg1, v0, v2.fee_x_growth, v2.fee_y_growth);
            };
            v0 = v0 + 1;
        };
        let (v3, v4) = 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::take_owed(arg1);
        let v5 = FeesClaimed{
            pool     : 0x2::object::id<Pool<T0, T1>>(arg0),
            position : 0x2::object::id<0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::Position>(arg1),
            amount_x : v3,
            amount_y : v4,
        };
        0x2::event::emit<FeesClaimed>(v5);
        (v3, v4)
    }

    public fun protocol_fees<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.protocol_fees_x), 0x2::balance::value<T1>(&arg0.protocol_fees_y))
    }

    fun protocol_part(arg0: u64, arg1: u64, arg2: u256) : u64 {
        if (arg2 == 0) {
            return arg0
        };
        (((arg0 as u128) * (arg1 as u128) / (0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::basis() as u128)) as u64)
    }

    public fun remove_liquidity<T0, T1>(arg0: &0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::Config, arg1: &mut Pool<T0, T1>, arg2: &mut 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::Position, arg3: u32, arg4: u32, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::assert_version(arg0);
        assert!(0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::pool(arg2) == 0x2::object::id<Pool<T0, T1>>(arg1), 1);
        let v0 = if (arg5 > 0) {
            if (arg5 <= 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::basis()) {
                arg3 <= arg4
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 8);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::index(arg2, arg3);
        while (v3 <= 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::index(arg2, arg4)) {
            let v4 = 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::lower(arg2) + (v3 as u32);
            let v5 = 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::share(arg2, v3);
            if (v5 > 0) {
                let v6 = 0x2::table::borrow_mut<u32, Bin>(&mut arg1.bins, v4);
                0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::settle(arg2, v3, v6.fee_x_growth, v6.fee_y_growth);
                let v7 = if (arg5 == 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::basis()) {
                    v5
                } else {
                    v5 * (arg5 as u256) / (0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::basis() as u256)
                };
                if (v7 > 0) {
                    let v8 = 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::share_of(v6.x, v7, v6.supply);
                    let v9 = 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::share_of(v6.y, v7, v6.supply);
                    v6.x = v6.x - v8;
                    v6.y = v6.y - v9;
                    v6.supply = v6.supply - v7;
                    0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::remove_shares(arg2, v3, v7);
                    v2 = v2 + v8;
                    v1 = v1 + v9;
                    let v10 = v6.x == 0 && v6.y == 0;
                    if (v10) {
                        0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::bin_bitmap::unset(&mut arg1.bitmap, v4);
                    };
                    if (v10 && v6.supply == 0) {
                        0x2::table::remove<u32, Bin>(&mut arg1.bins, v4);
                    };
                };
            };
            v3 = v3 + 1;
        };
        assert!(v2 >= arg6 && v1 >= arg7, 5);
        let v11 = LiquidityRemoved{
            pool     : 0x2::object::id<Pool<T0, T1>>(arg1),
            position : 0x2::object::id<0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::position::Position>(arg2),
            amount_x : v2,
            amount_y : v1,
        };
        0x2::event::emit<LiquidityRemoved>(v11);
        let (v12, v13) = pay_fees<T0, T1>(arg1, arg2);
        let v14 = 0x2::coin::take<T0>(&mut arg1.reserve_x, v2, arg8);
        let v15 = 0x2::coin::take<T1>(&mut arg1.reserve_y, v1, arg8);
        0x2::coin::join<T0>(&mut v14, 0x2::coin::take<T0>(&mut arg1.lp_fees_x, v12, arg8));
        0x2::coin::join<T1>(&mut v15, 0x2::coin::take<T1>(&mut arg1.lp_fees_y, v13, arg8));
        (v14, v15)
    }

    public fun reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.reserve_x), 0x2::balance::value<T1>(&arg0.reserve_y))
    }

    fun split_to_recipients<T0>(arg0: &0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::Config, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = (((0x2::balance::value<T0>(&arg1) as u128) * (0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::ppx_bps(arg0) as u128) / (0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::basis() as u128)) as u64);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1, v0), arg2), 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::ppx_recipient(arg0));
        };
        if (0x2::balance::value<T0>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg1, arg2), 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::treasury(arg0));
        } else {
            0x2::balance::destroy_zero<T0>(arg1);
        };
    }

    fun swap_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (u64, u64, u64, u64) {
        assert!(arg1 > 0, 3);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = arg0.preset;
        let v2 = arg0.active_id;
        0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::refresh(&mut arg0.volatility, v2, v0, 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::filter_period_ms(&v1), 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::decay_period_ms(&v1), 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::reduction_factor(&v1));
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = arg1;
        let v7 = 0;
        while (v6 > 0 && v7 < 200) {
            let v8 = arg0.active_id;
            if (!has_out_side<T0, T1>(arg0, v8, arg2)) {
                let v9 = if (arg2) {
                    0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::bin_bitmap::next_below(&arg0.bitmap, v8)
                } else {
                    0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::bin_bitmap::next_above(&arg0.bitmap, v8)
                };
                let v10 = v9;
                if (0x1::option::is_none<u32>(&v10)) {
                    break
                };
                arg0.active_id = 0x1::option::destroy_some<u32>(v10);
                continue
            };
            0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::accumulate(&mut arg0.volatility, v8, 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::max_volatility_accumulator(&v1));
            let v11 = 0x2::table::borrow_mut<u32, Bin>(&mut arg0.bins, v8);
            let (v12, v13, v14, v15) = 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::swap_in_bin(v11.x, v11.y, 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::price(v8, 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::bin_step(&v1)), v6, arg2, 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::total_fee_rate(0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::base_factor(&v1), 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::bin_step(&v1), 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::accumulator(&arg0.volatility), 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::variable_fee_control(&v1)));
            if (v12 == 0) {
                break
            };
            let v16 = protocol_part(v14, 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::protocol_share_bps(&v1), v11.supply);
            let v17 = v14 - v16;
            if (arg2) {
                v11.x = v11.x + v13;
                v11.y = v11.y - v15;
                if (v17 > 0) {
                    v11.fee_x_growth = v11.fee_x_growth + ((v17 as u256) << 128) / v11.supply;
                };
            } else {
                v11.y = v11.y + v13;
                v11.x = v11.x - v15;
                if (v17 > 0) {
                    v11.fee_y_growth = v11.fee_y_growth + ((v17 as u256) << 128) / v11.supply;
                };
            };
            v6 = v6 - v12;
            v5 = v5 + v15;
            v4 = v4 + v17;
            v3 = v3 + v16;
            v7 = v7 + 1;
        };
        let v18 = arg1 - v6;
        assert!(v18 > 0 && v5 > 0, 9);
        0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::touch(&mut arg0.volatility, v0);
        let v19 = Swapped{
            pool          : 0x2::object::id<Pool<T0, T1>>(arg0),
            sender        : 0x2::tx_context::sender(arg4),
            x_for_y       : arg2,
            amount_in     : v18,
            amount_out    : v5,
            fee           : v4 + v3,
            protocol_fee  : v3,
            active_before : v2,
            active_after  : arg0.active_id,
            volatility    : 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::accumulator(&arg0.volatility),
        };
        0x2::event::emit<Swapped>(v19);
        (v18, v5, v4, v3)
    }

    public fun swap_x_for_y<T0, T1>(arg0: &0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::Config, arg1: &mut Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::assert_open(arg0);
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let (v1, v2, v3, v4) = swap_internal<T0, T1>(arg1, 0x2::balance::value<T0>(&v0), true, arg4, arg5);
        assert!(v2 >= arg3, 5);
        0x2::balance::join<T0>(&mut arg1.protocol_fees_x, 0x2::balance::split<T0>(&mut v0, v4));
        0x2::balance::join<T0>(&mut arg1.lp_fees_x, 0x2::balance::split<T0>(&mut v0, v3));
        0x2::balance::join<T0>(&mut arg1.reserve_x, 0x2::balance::split<T0>(&mut v0, v1 - v3 - v4));
        (0x2::coin::from_balance<T0>(v0, arg5), 0x2::coin::take<T1>(&mut arg1.reserve_y, v2, arg5))
    }

    public fun swap_y_for_x<T0, T1>(arg0: &0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::Config, arg1: &mut Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config::assert_open(arg0);
        let v0 = 0x2::coin::into_balance<T1>(arg2);
        let (v1, v2, v3, v4) = swap_internal<T0, T1>(arg1, 0x2::balance::value<T1>(&v0), false, arg4, arg5);
        assert!(v2 >= arg3, 5);
        0x2::balance::join<T1>(&mut arg1.protocol_fees_y, 0x2::balance::split<T1>(&mut v0, v4));
        0x2::balance::join<T1>(&mut arg1.lp_fees_y, 0x2::balance::split<T1>(&mut v0, v3));
        0x2::balance::join<T1>(&mut arg1.reserve_y, 0x2::balance::split<T1>(&mut v0, v1 - v3 - v4));
        (0x2::coin::from_balance<T1>(v0, arg5), 0x2::coin::take<T0>(&mut arg1.reserve_x, v2, arg5))
    }

    public fun volatility<T0, T1>(arg0: &Pool<T0, T1>) : 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::Volatility {
        arg0.volatility
    }

    // decompiled from Move bytecode v7
}

