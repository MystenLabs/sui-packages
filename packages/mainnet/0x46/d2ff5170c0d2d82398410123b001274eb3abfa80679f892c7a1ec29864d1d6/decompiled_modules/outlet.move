module 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::outlet {
    struct PositionKey has copy, drop, store {
        pool_id: 0x2::object::ID,
    }

    struct TwapKey has copy, drop, store {
        pool_id: 0x2::object::ID,
    }

    struct Twap has copy, drop, store {
        gen: u64,
        first_ms: u64,
        last_ms: u64,
        last_px: u128,
        cum: u256,
        wsum: u64,
        samples: u64,
    }

    struct OutletAddLiquidity has copy, drop {
        pool: 0x2::object::ID,
        soo: u64,
        pay: u64,
        position: 0x2::object::ID,
    }

    struct OutletRemoved has copy, drop {
        pool: 0x2::object::ID,
        soo: u64,
        pay: u64,
        liquidity: u128,
    }

    struct FeesCollected has copy, drop {
        pool: 0x2::object::ID,
        soo: u64,
        pay: u64,
    }

    struct OutletSwap has copy, drop {
        pool: 0x2::object::ID,
        a2b: bool,
        amount_in: u64,
        amount_out: u64,
        min_out: u64,
    }

    struct Rebalanced has copy, drop {
        pool: 0x2::object::ID,
        usdc_bps_before: u64,
        direction: u8,
        size: u64,
    }

    struct TwapObserved has copy, drop {
        pool: 0x2::object::ID,
        price: u128,
        samples: u64,
    }

    public(friend) fun add_liq_pre<T0>(arg0: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::OperatorCap, arg1: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk, arg2: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Treasury, arg3: 0x2::object::ID, arg4: u128, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        op_checks<T0>(arg0, arg1, arg2);
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::assert_lp_funding_ok<T0>(arg1, arg2);
        gate_soo_core(arg1, arg3, arg4, arg6);
        assert!(arg5 > 0, 211);
    }

    public(friend) fun add_liq_settle<T0>(arg0: &mut 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Treasury, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : (0x2::balance::Balance<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE>, 0x2::balance::Balance<T0>) {
        assert!(arg5 <= arg3 && arg6 <= arg4, 210);
        let v0 = OutletAddLiquidity{
            pool     : arg1,
            soo      : arg5,
            pay      : arg6,
            position : arg2,
        };
        0x2::event::emit<OutletAddLiquidity>(v0);
        (0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::take_soo_reserve(arg0, arg5), 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::take_bucket<T0>(arg0, 0, arg6))
    }

    public fun amounts_at(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : (u64, u64) {
        let v0 = (arg3 as u256);
        let v1 = (arg0 as u256);
        let v2 = (arg1 as u256);
        assert!(v1 > 0 && v1 <= v2, 216);
        let v3 = if ((arg2 as u256) < v1) {
            v1
        } else if ((arg2 as u256) > v2) {
            v2
        } else {
            (arg2 as u256)
        };
        let v4 = if (v3 >= v2) {
            0
        } else {
            let v5 = v0 * (v2 - v3) / v3;
            assert!(v5 < 6277101735386680763835789423207666416102355444464034512896, 216);
            (v5 << 64) / v2
        };
        let v6 = if (v3 <= v1) {
            0
        } else {
            v0 * (v3 - v1) >> 64
        };
        ((v4 as u64), (v6 as u64))
    }

    fun assert_soo_pool(arg0: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::PoolFeed) {
        let (_, v1, _, _, _, v5) = 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pool_feed_parts(arg0);
        assert!(v5 && v1, 207);
    }

    fun assert_wired(arg0: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk) {
        assert!(0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::outlet_wired(arg0), 200);
    }

    public fun execute_hbtc_swap<T0, T1>(arg0: &mut 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk, arg1: &mut 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Treasury, arg2: &mut 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Proposal, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_wired(arg0);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4);
        let v1 = 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pool_feed(arg0, v0);
        let (v2, v3, v4) = hbtc_pre<T0, T1>(arg0, arg1, arg2, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg4), read_pyth(&v1, arg5, arg6), arg7);
        if (v2 == 0) {
            let (v5, v6) = swap_b2a<T0, T1>(arg3, arg4, 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::take_bucket<T1>(arg1, 0, v3), v4, arg6);
            hbtc_finish<T0, T1>(arg1, v2, v5, v6);
        } else {
            let (v7, v8) = swap_a2b<T0, T1>(arg3, arg4, 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::take_bucket<T0>(arg1, 4, v3), v4, arg6);
            hbtc_finish<T0, T1>(arg1, v2, v8, v7);
        };
    }

    public(friend) fun fees_pre<T0>(arg0: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::OperatorCap, arg1: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk, arg2: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Treasury, arg3: 0x2::object::ID) {
        op_checks<T0>(arg0, arg1, arg2);
        let v0 = 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pool_feed(arg1, arg3);
        assert_soo_pool(&v0);
    }

    public(friend) fun fees_settle<T0>(arg0: &mut 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Treasury, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE>, arg3: 0x2::balance::Balance<T0>) {
        let v0 = FeesCollected{
            pool : arg1,
            soo  : 0x2::balance::value<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE>(&arg2),
            pay  : 0x2::balance::value<T0>(&arg3),
        };
        0x2::event::emit<FeesCollected>(v0);
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::put_soo_reserve(arg0, arg2);
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::route_profit_balance<T0>(arg0, arg3, b"cetus_fees");
    }

    public fun gate_pyth<T0, T1>(arg0: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : (u128, u128) {
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pkg_assert_version(arg0);
        assert_wired(arg0);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1);
        let v1 = 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pool_feed(arg0, v0);
        let v2 = read_pyth(&v1, arg2, arg3);
        (gate_pyth_core(arg0, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), v2), v2)
    }

    public(friend) fun gate_pyth_core(arg0: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk, arg1: 0x2::object::ID, arg2: u128, arg3: u128) : u128 {
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pkg_assert_version(arg0);
        let v0 = 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pool_feed(arg0, arg1);
        let (_, v2, _, _, _, v6) = 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pool_feed_parts(&v0);
        assert!(!v6 && v2, 206);
        let v7 = pool_priced_price(arg2, true);
        assert!(0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::feed_ok(v7, arg3), 203);
        v7
    }

    public fun gate_soo<T0>(arg0: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE, T0>, arg2: &0x2::tx_context::TxContext) : u128 {
        assert_wired(arg0);
        gate_soo_core(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE, T0>>(arg1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE, T0>(arg1), arg2)
    }

    public(friend) fun gate_soo_core(arg0: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk, arg1: 0x2::object::ID, arg2: u128, arg3: &0x2::tx_context::TxContext) : u128 {
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pkg_assert_version(arg0);
        let v0 = 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pool_feed(arg0, arg1);
        assert_soo_pool(&v0);
        let v1 = pool_priced_price(arg2, true);
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::check_outlet_price_logic(arg0, arg1, v1, arg3);
        v1
    }

    public fun guardian_remove_liquidity<T0>(arg0: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::GuardianCap, arg1: &mut 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk, arg2: &mut 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Treasury, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE, T0>, arg5: u128, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE, T0>>(arg4);
        guardian_remove_pre<T0>(arg0, arg1, arg2, v0);
        let v1 = PositionKey{pool_id: v0};
        assert!(0x2::dynamic_object_field::exists<PositionKey>(0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::desk_uid(arg1), v1), 209);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE, T0>(arg3, arg4, 0x2::dynamic_object_field::borrow_mut<PositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::desk_uid_mut(arg1), v1), arg5, arg8);
        remove_settle<T0>(arg2, v0, arg5, v2, v3, 0, 0, arg6, arg7);
    }

    public(friend) fun guardian_remove_pre<T0>(arg0: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::GuardianCap, arg1: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk, arg2: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Treasury, arg3: 0x2::object::ID) {
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pkg_assert_version(arg1);
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pkg_assert_guardian(arg0, arg1);
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pkg_assert_pair(arg1, arg2);
        assert!(0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::payout_coin(arg1) == 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_original_ids<T0>()), 208);
        let v0 = 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pool_feed(arg1, arg3);
        assert_soo_pool(&v0);
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pkg_assert_pool_allowed(arg1, arg3);
    }

    public(friend) fun hbtc_finish<T0, T1>(arg0: &mut 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Treasury, arg1: u8, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>) {
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::put_bucket<T0>(arg0, 4, arg2);
        if (arg1 == 0) {
            0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::put_bucket<T1>(arg0, 0, arg3);
        } else {
            0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::put_bucket<T1>(arg0, 3, arg3);
        };
    }

    public(friend) fun hbtc_pre<T0, T1>(arg0: &mut 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk, arg1: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Treasury, arg2: &mut 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Proposal, arg3: 0x2::object::ID, arg4: u128, arg5: u128, arg6: &0x2::tx_context::TxContext) : (u8, u64, u64) {
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pkg_assert_version(arg0);
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pkg_assert_pair(arg0, arg1);
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::assert_not_paused(arg1);
        assert!(0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::hbtc_type(arg0) == 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_original_ids<T0>()), 208);
        assert!(0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::payout_coin(arg0) == 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_original_ids<T1>()), 208);
        let v0 = 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::proposal_kind(arg2);
        let (v1, v2, v3) = 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::hbtc_swap_params(&v0);
        assert!(v2 == arg3, 206);
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pkg_begin_execute(arg0, arg2, arg6);
        let v4 = if (v1 == 0) {
            min_out(quote_to_priced(v3, arg5), tolerance_bps(gate_pyth_core(arg0, arg3, arg4, arg5), arg5))
        } else {
            min_out(priced_to_quote(v3, arg5), tolerance_bps(gate_pyth_core(arg0, arg3, arg4, arg5), arg5))
        };
        (v1, v3, v4)
    }

    public fun invert(arg0: u128) : u128 {
        assert!(arg0 > 0, 211);
        ((1000000000000 * 1000000000000 / (arg0 as u256)) as u128)
    }

    public fun min_out(arg0: u64, arg1: u64) : u64 {
        let v0 = if (arg1 >= 10000) {
            10000 - 1
        } else {
            arg1
        };
        let v1 = (((arg0 as u128) * ((10000 - v0) as u128) / (10000 as u128)) as u64);
        if (v1 == 0) {
            1
        } else {
            v1
        }
    }

    public fun observe<T0>(arg0: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::OperatorCap, arg1: &mut 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE, T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pkg_assert_version(arg1);
        assert_wired(arg1);
        observe_core(arg0, arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE, T0>>(arg2), pool_priced_price(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE, T0>(arg2), true), 0x2::clock::timestamp_ms(arg3), 0x2::tx_context::epoch(arg4));
    }

    public(friend) fun observe_core(arg0: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::OperatorCap, arg1: &mut 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk, arg2: 0x2::object::ID, arg3: u128, arg4: u64, arg5: u64) {
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pkg_assert_version(arg1);
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pkg_assert_operator(arg0, arg1);
        let v0 = 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pool_feed(arg1, arg2);
        assert_soo_pool(&v0);
        let v1 = 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::ref_gen(arg1);
        let v2 = TwapKey{pool_id: arg2};
        let v3 = if (!0x2::dynamic_field::exists<TwapKey>(0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::desk_uid(arg1), v2) || 0x2::dynamic_field::borrow<TwapKey, Twap>(0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::desk_uid(arg1), v2).gen != v1) {
            let v4 = 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::ref_band_clamp(arg1, arg3, arg5);
            let v5 = 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::desk_uid_mut(arg1);
            if (0x2::dynamic_field::exists<TwapKey>(v5, v2)) {
                0x2::dynamic_field::remove<TwapKey, Twap>(v5, v2);
            };
            let v6 = Twap{
                gen      : v1,
                first_ms : arg4,
                last_ms  : arg4,
                last_px  : v4,
                cum      : 0,
                wsum     : 0,
                samples  : 1,
            };
            0x2::dynamic_field::add<TwapKey, Twap>(v5, v2, v6);
            v4
        } else {
            let v7 = 0x2::dynamic_field::borrow<TwapKey, Twap>(0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::desk_uid(arg1), v2);
            let v8 = v7.last_ms;
            let v9 = v7.last_px;
            assert!(arg4 >= v8 + 600000, 213);
            let v10 = v9 * 100 / 10000;
            let v11 = if (arg3 > v9 + v10) {
                v9 + v10
            } else if (arg3 + v10 < v9) {
                v9 - v10
            } else {
                arg3
            };
            let v12 = 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::ref_band_clamp(arg1, v11, arg5);
            let v13 = arg4 - v8;
            let v14 = if (v13 > 21600000) {
                21600000
            } else {
                v13
            };
            let v15 = 0x2::dynamic_field::borrow_mut<TwapKey, Twap>(0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::desk_uid_mut(arg1), v2);
            v15.cum = v15.cum + (v15.last_px as u256) * (v14 as u256);
            v15.wsum = v15.wsum + v14;
            v15.last_ms = arg4;
            v15.last_px = v12;
            v15.samples = v15.samples + 1;
            v12
        };
        let v16 = 0x2::dynamic_field::borrow<TwapKey, Twap>(0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::desk_uid(arg1), v2);
        let v17 = v16.samples;
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pkg_mirror_twap(arg1, arg2, v16.gen, v16.cum, v16.wsum, v17);
        let v18 = TwapObserved{
            pool    : arg2,
            price   : v3,
            samples : v17,
        };
        0x2::event::emit<TwapObserved>(v18);
    }

    public fun op_add_liquidity<T0>(arg0: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::OperatorCap, arg1: &mut 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk, arg2: &mut 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Treasury, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE, T0>, arg5: u64, arg6: u64, arg7: u32, arg8: u32, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_wired(arg1);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE, T0>>(arg4);
        add_liq_pre<T0>(arg0, arg1, arg2, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE, T0>(arg4), arg5, arg10);
        let v1 = PositionKey{pool_id: v0};
        if (!0x2::dynamic_object_field::exists<PositionKey>(0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::desk_uid(arg1), v1)) {
            0x2::dynamic_object_field::add<PositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::desk_uid_mut(arg1), v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE, T0>(arg3, arg4, arg7, arg8, arg10));
        };
        let v2 = 0x2::dynamic_object_field::borrow_mut<PositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::desk_uid_mut(arg1), v1);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE, T0>(arg3, arg4, v2, arg5, true, arg9);
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE, T0>(&v3);
        let (v6, v7) = add_liq_settle<T0>(arg2, v0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v2), arg5, arg6, v4, v5);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE, T0>(arg3, arg4, v6, v7, v3);
    }

    fun op_checks<T0>(arg0: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::OperatorCap, arg1: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk, arg2: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Treasury) {
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pkg_assert_version(arg1);
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pkg_assert_operator(arg0, arg1);
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pkg_assert_pair(arg1, arg2);
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::assert_not_paused(arg2);
        assert!(0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::payout_coin(arg1) == 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_original_ids<T0>()), 208);
    }

    public fun op_collect_fees<T0>(arg0: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::OperatorCap, arg1: &mut 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk, arg2: &mut 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Treasury, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE, T0>) {
        assert_wired(arg1);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE, T0>>(arg4);
        fees_pre<T0>(arg0, arg1, arg2, v0);
        let v1 = PositionKey{pool_id: v0};
        assert!(0x2::dynamic_object_field::exists<PositionKey>(0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::desk_uid(arg1), v1), 209);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE, T0>(arg3, arg4, 0x2::dynamic_object_field::borrow<PositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::desk_uid(arg1), v1), true);
        fees_settle<T0>(arg2, v0, v2, v3);
    }

    public fun op_poke_reference<T0>(arg0: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::OperatorCap, arg1: &mut 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk, arg2: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Treasury, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE, T0>, arg4: &0x2::tx_context::TxContext) {
        assert_wired(arg1);
        poke_core(arg0, arg1, arg2, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE, T0>>(arg3), arg4);
    }

    public fun op_rebalance<T0>(arg0: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::OperatorCap, arg1: &mut 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk, arg2: &mut 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Treasury, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE, T0>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_wired(arg1);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE, T0>>(arg4);
        let v1 = PositionKey{pool_id: v0};
        assert!(0x2::dynamic_object_field::exists<PositionKey>(0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::desk_uid(arg1), v1), 209);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_position_amounts<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE, T0>(arg4, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x2::dynamic_object_field::borrow<PositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::desk_uid(arg1), v1)));
        let (v4, v5, v6, v7) = rebalance_pre<T0>(arg0, arg1, arg2, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE, T0>(arg4), v2, v3, arg6);
        if (v4 == 1) {
            let (v8, v9) = swap_b2a<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE, T0>(arg3, arg4, 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::take_bucket<T0>(arg2, 0, v5), v6, arg5);
            rebalance_finish<T0>(arg2, v0, v7, v4, v5, v8, v9);
        } else {
            let (v10, v11) = swap_a2b<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE, T0>(arg3, arg4, 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::take_soo_reserve(arg2, v5), v6, arg5);
            rebalance_finish<T0>(arg2, v0, v7, v4, v5, v11, v10);
        };
    }

    public fun op_remove_liquidity<T0>(arg0: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::OperatorCap, arg1: &mut 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk, arg2: &mut 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Treasury, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE, T0>, arg5: u128, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE, T0>>(arg4);
        remove_pre<T0>(arg0, arg1, arg2, v0);
        let v1 = PositionKey{pool_id: v0};
        assert!(0x2::dynamic_object_field::exists<PositionKey>(0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::desk_uid(arg1), v1), 209);
        let v2 = twap(arg1, v0);
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(0x2::dynamic_object_field::borrow<PositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::desk_uid(arg1), v1));
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE, T0>(arg3, arg4, 0x2::dynamic_object_field::borrow_mut<PositionKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::desk_uid_mut(arg1), v1), arg5, arg8);
        remove_settle<T0>(arg2, v0, arg5, v5, v6, v2, remove_floor_value(v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v3), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v4), arg5), arg6, arg7);
    }

    public fun outlet_wired_default() : bool {
        false
    }

    public(friend) fun poke_core(arg0: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::OperatorCap, arg1: &mut 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk, arg2: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Treasury, arg3: 0x2::object::ID, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pool_feed(arg1, arg3);
        assert_soo_pool(&v0);
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::poke_reference_logic(arg0, arg1, arg2, twap(arg1, arg3), arg4);
        let v1 = TwapKey{pool_id: arg3};
        let v2 = 0x2::dynamic_field::borrow_mut<TwapKey, Twap>(0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::desk_uid_mut(arg1), v1);
        v2.first_ms = v2.last_ms;
        v2.cum = 0;
        v2.wsum = 0;
        v2.samples = 1;
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pkg_mirror_twap(arg1, arg3, v2.gen, 0, 0, 1);
    }

    public fun pool_priced_price(arg0: u128, arg1: bool) : u128 {
        if (arg1) {
            price_from_sqrt(arg0)
        } else {
            invert(price_from_sqrt(arg0))
        }
    }

    fun pow10(arg0: u64) : u256 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun price_from_sqrt(arg0: u128) : u128 {
        let v0 = (arg0 as u256);
        ((v0 * v0 * 1000000000000 >> 128) as u128)
    }

    public fun priced_to_quote(arg0: u64, arg1: u128) : u64 {
        (((arg0 as u256) * (arg1 as u256) / 1000000000000) as u64)
    }

    public fun pyth_to_fixed(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::Price, arg1: u8, arg2: u8) : u128 {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_price(arg0);
        assert!(!0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v0), 202);
        let v1 = (0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v0) as u256);
        assert!(v1 > 0, 202);
        let v2 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_expo(arg0);
        let v3 = v1 * 1000000000000 * pow10((arg2 as u64));
        let v4 = v3;
        let v5 = pow10((arg1 as u64));
        let v6 = v5;
        if (0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v2)) {
            v6 = v5 * pow10(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&v2));
        } else {
            v4 = v3 * pow10(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v2));
        };
        ((v4 / v6) as u128)
    }

    public fun quote_to_priced(arg0: u64, arg1: u128) : u64 {
        (((arg0 as u256) * 1000000000000 / (arg1 as u256)) as u64)
    }

    public fun read_pyth(arg0: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::PoolFeed, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : u128 {
        let (v0, _, v2, v3, v4, _) = 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pool_feed_parts(arg0);
        let v6 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_info_from_price_info_object(arg1);
        let v7 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_identifier(&v6);
        assert!(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_identifier::get_bytes(&v7) == v0, 201);
        let v8 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::get_price_no_older_than(arg1, arg2, v4);
        pyth_to_fixed(&v8, v2, v3)
    }

    public(friend) fun rebalance_finish<T0>(arg0: &mut 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Treasury, arg1: 0x2::object::ID, arg2: u64, arg3: u8, arg4: u64, arg5: 0x2::balance::Balance<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE>, arg6: 0x2::balance::Balance<T0>) {
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::put_soo_reserve(arg0, arg5);
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::put_bucket<T0>(arg0, 0, arg6);
        let v0 = Rebalanced{
            pool            : arg1,
            usdc_bps_before : arg2,
            direction       : arg3,
            size            : arg4,
        };
        0x2::event::emit<Rebalanced>(v0);
    }

    public fun rebalance_plan(arg0: u64, arg1: u64, arg2: u128) : (u8, u64) {
        let v0 = usdc_share_bps(arg0, arg1, arg2);
        if (v0 + 382 < 6180) {
            (1, ((((arg0 as u256) * (arg2 as u256) / 1000000000000 + (arg1 as u256)) * (6180 as u256) / (10000 as u256) - (arg1 as u256)) as u64))
        } else if (v0 > 6180 + 382) {
            (2, (((arg1 as u256) - ((arg0 as u256) * (arg2 as u256) / 1000000000000 + (arg1 as u256)) * (6180 as u256) / (10000 as u256)) as u64))
        } else {
            (0, 0)
        }
    }

    public(friend) fun rebalance_pre<T0>(arg0: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::OperatorCap, arg1: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk, arg2: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Treasury, arg3: 0x2::object::ID, arg4: u128, arg5: u64, arg6: u64, arg7: &0x2::tx_context::TxContext) : (u8, u64, u64, u64) {
        op_checks<T0>(arg0, arg1, arg2);
        let v0 = 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::ref_price(arg1);
        let (v1, v2) = rebalance_plan(arg5, arg6, v0);
        assert!(v1 != 0, 204);
        let (v3, v4) = if (v1 == 1) {
            let v5 = 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::bucket_value<T0>(arg2, 0);
            let v6 = if (v2 < v5) {
                v2
            } else {
                v5
            };
            (v6, min_out(quote_to_priced(v6, v0), tolerance_bps(gate_soo_core(arg1, arg3, arg4, arg7), v0)))
        } else {
            let v7 = quote_to_priced(v2, v0);
            let v8 = 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::soostone_reserve_value(arg2);
            let v9 = if (v7 < v8) {
                v7
            } else {
                v8
            };
            (v9, min_out(priced_to_quote(v9, v0), tolerance_bps(gate_soo_core(arg1, arg3, arg4, arg7), v0)))
        };
        (v1, v3, v4, usdc_share_bps(arg5, arg6, v0))
    }

    public fun remove_floor_value(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : u256 {
        let (v0, v1) = amounts_at(arg1, arg2, sqrt_from_price(arg0), arg3);
        value_at(arg0, v0, v1) * (10000 - 200) / 10000
    }

    public(friend) fun remove_pre<T0>(arg0: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::OperatorCap, arg1: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk, arg2: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Treasury, arg3: 0x2::object::ID) {
        assert_wired(arg1);
        op_checks<T0>(arg0, arg1, arg2);
        let v0 = 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pool_feed(arg1, arg3);
        assert_soo_pool(&v0);
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::pkg_assert_pool_allowed(arg1, arg3);
    }

    public(friend) fun remove_settle<T0>(arg0: &mut 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Treasury, arg1: 0x2::object::ID, arg2: u128, arg3: 0x2::balance::Balance<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE>, arg4: 0x2::balance::Balance<T0>, arg5: u128, arg6: u256, arg7: u64, arg8: u64) {
        assert!(arg7 > 0 || arg8 > 0, 214);
        assert!(0x2::balance::value<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE>(&arg3) >= arg7 && 0x2::balance::value<T0>(&arg4) >= arg8, 205);
        let v0 = value_at(arg5, arg7, arg8);
        let v1 = if (v0 > arg6) {
            v0
        } else {
            arg6
        };
        assert!(value_at(arg5, 0x2::balance::value<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE>(&arg3), 0x2::balance::value<T0>(&arg4)) >= v1, 215);
        let v2 = OutletRemoved{
            pool      : arg1,
            soo       : 0x2::balance::value<0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE>(&arg3),
            pay       : 0x2::balance::value<T0>(&arg4),
            liquidity : arg2,
        };
        0x2::event::emit<OutletRemoved>(v2);
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::put_soo_reserve(arg0, arg3);
        0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::put_bucket<T0>(arg0, 0, arg4);
    }

    public fun sqrt_from_price(arg0: u128) : u128 {
        let v0 = ((arg0 as u256) << 128) / 1000000000000;
        if (v0 == 0) {
            return 0
        };
        let v1 = (v0 + 1) / 2;
        while (v1 < v0) {
            let v2 = v1 + v0 / v1;
            v1 = v2 / 2;
        };
        (v0 as u128)
    }

    fun swap_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::balance::value<T0>(&arg2), 4295048016, arg4);
        let v3 = v2;
        let (v4, v5, v6) = swap_settle<T0, T1>(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), true, arg2, v0, v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v4, 0x2::balance::zero<T1>(), v3);
        (v5, v6)
    }

    fun swap_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(&arg2), 79226673515401279992447579055, arg4);
        let v3 = v2;
        let (v4, v5, v6) = swap_settle<T1, T0>(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), false, arg2, v1, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v4, v3);
        (v5, v6)
    }

    public(friend) fun swap_settle<T0, T1>(arg0: 0x2::object::ID, arg1: bool, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: u64, arg6: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        assert!(v0 > 0, 211);
        assert!(arg5 <= v0, 210);
        0x2::balance::join<T0>(&mut arg2, arg3);
        assert!(0x2::balance::value<T1>(&arg4) >= arg6, 205);
        let v1 = OutletSwap{
            pool       : arg0,
            a2b        : arg1,
            amount_in  : arg5,
            amount_out : 0x2::balance::value<T1>(&arg4),
            min_out    : arg6,
        };
        0x2::event::emit<OutletSwap>(v1);
        (0x2::balance::split<T0>(&mut arg2, arg5), arg4, arg2)
    }

    public fun tolerance_bps(arg0: u128, arg1: u128) : u64 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        30 + ((v0 * (10000 as u128) / arg1) as u64)
    }

    public fun twap(arg0: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk, arg1: 0x2::object::ID) : u128 {
        let v0 = TwapKey{pool_id: arg1};
        assert!(0x2::dynamic_field::exists<TwapKey>(0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::desk_uid(arg0), v0), 212);
        let v1 = 0x2::dynamic_field::borrow<TwapKey, Twap>(0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::desk_uid(arg0), v0);
        assert!(v1.gen == 0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::ref_gen(arg0), 212);
        assert!(v1.samples >= 3, 212);
        assert!(v1.wsum >= 3600000, 212);
        ((v1.cum / (v1.wsum as u256)) as u128)
    }

    public fun twap_last_px(arg0: &0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::Desk, arg1: 0x2::object::ID) : u128 {
        let v0 = TwapKey{pool_id: arg1};
        0x2::dynamic_field::borrow<TwapKey, Twap>(0x46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::desk_uid(arg0), v0).last_px
    }

    public fun usdc_share_bps(arg0: u64, arg1: u64, arg2: u128) : u64 {
        let v0 = (arg0 as u256) * (arg2 as u256) / 1000000000000 + (arg1 as u256);
        if (v0 == 0) {
            return 6180
        };
        (((arg1 as u256) * (10000 as u256) / v0) as u64)
    }

    public fun value_at(arg0: u128, arg1: u64, arg2: u64) : u256 {
        (arg2 as u256) + (arg1 as u256) * (arg0 as u256) / 1000000000000
    }

    // decompiled from Move bytecode v7
}

