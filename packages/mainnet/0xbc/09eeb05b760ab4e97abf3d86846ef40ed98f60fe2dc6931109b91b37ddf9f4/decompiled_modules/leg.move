module 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::leg {
    struct Leg<phantom T0> has store {
        vault: 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::custody::Vault<T0>,
        market: 0x2::object::ID,
        long: bool,
        target_bps: u64,
        min_bps: u64,
        max_bps: u64,
        weight_bps: u64,
        basis: u64,
    }

    struct Closed<phantom T0> {
        funds: 0x2::coin::Coin<T0>,
        delivered: u128,
        requested: u128,
    }

    public(friend) fun account_id<T0>(arg0: &Leg<T0>) : 0x2::object::ID {
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::custody::account_id<T0>(&arg0.vault)
    }

    public(friend) fun market<T0>(arg0: &Leg<T0>) : 0x2::object::ID {
        arg0.market
    }

    public(friend) fun new<T0>(arg0: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg1: 0x2::object::ID, arg2: bool, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : Leg<T0> {
        let v0 = if (arg3 >= 10000) {
            if (arg4 > 0) {
                arg4 <= 10000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        let (v1, v2) = band(arg3);
        Leg<T0>{
            vault      : 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::custody::new<T0>(arg0, arg1, arg5),
            market     : arg1,
            long       : arg2,
            target_bps : arg3,
            min_bps    : v1,
            max_bps    : v2,
            weight_bps : arg4,
            basis      : 0,
        }
    }

    public(friend) fun add_cash<T0>(arg0: &mut Leg<T0>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: 0x2::coin::Coin<T0>) {
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::custody::deposit<T0>(&arg0.vault, arg1, arg2, arg3);
        arg0.basis = arg0.basis + 0x2::coin::value<T0>(&arg3);
    }

    fun assert_execution(arg0: u64, arg1: u64, arg2: u256, arg3: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::Prices, arg4: u64) {
        if (arg1 >= arg0 || arg2 == 0) {
            return
        };
        assert!((0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::lev_math::collateral_usd_e6(arg0 - arg1, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::collateral_price(arg3), 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::collateral_scaling(arg3), true) as u128) * (10000 as u128) <= (0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::lev_math::notional_usd_e6(arg2, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::mark(arg3)) as u128) * (arg4 as u128), 4);
    }

    public(friend) fun band(arg0: u64) : (u64, u64) {
        (0x1::u64::max(10000, arg0 - arg0 / 10), arg0 + arg0 * 12 / 100)
    }

    public(friend) fun band_of<T0>(arg0: &Leg<T0>) : (u64, u64) {
        (arg0.min_bps, arg0.max_bps)
    }

    fun base<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: bool) : u256 {
        if (!0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T0>(arg0, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg1))) {
            return 0
        };
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(arg0, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg1));
        let (v1, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v0);
        if (arg2) {
            assert!(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::is_long_or_flat(v0), 2);
            v1
        } else {
            assert!(v1 == 0 || 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v1), 2);
            0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v1)
        }
    }

    public(friend) fun basis<T0>(arg0: &Leg<T0>) : u64 {
        arg0.basis
    }

    fun below_min_order<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: u64, arg2: u256) : bool {
        (arg1 as u256) * 1000000000 * arg2 / 1000000000000000000 < 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::min_order_usd_value(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg0))
    }

    public(friend) fun check<T0>(arg0: &Leg<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>) {
        assert!(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::custody::account_id<T0>(&arg0.vault) == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>>(arg1) && 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(arg2) == arg0.market, 1);
    }

    public(friend) fun close_share<T0>(arg0: &mut Leg<T0>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::Prices, arg7: u128, arg8: u128, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, Closed<T0>) {
        check<T0>(arg0, arg1, &arg2);
        assert!(arg7 > 0 && arg7 <= arg8, 3);
        let v0 = nav<T0>(arg0, arg1, &arg2, arg6);
        let v1 = base<T0>(&arg2, arg1, arg0.long);
        let v2 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(&arg2));
        let v3 = ((v1 / 1000000000) as u64);
        let v4 = if (v3 < v2) {
            0
        } else {
            closing_size(v3, arg7, arg8, v2)
        };
        if (v4 > 0) {
            let v5 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::lev_math::limit_price(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::mark(arg6), arg9, !arg0.long, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::tick_size(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(&arg2)));
            let v6 = arg2;
            arg2 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::custody::trade_limit<T0>(&arg0.vault, arg1, v6, arg4, arg5, arg0.long, v4, v5, true, arg10, arg11);
        };
        let v7 = v1 - base<T0>(&arg2, arg1, arg0.long);
        let v8 = if (v1 == 0 || v7 == (v4 as u256) * 1000000000) {
            arg7
        } else {
            0x1::u128::min(((v7 * (arg8 as u256) / v1) as u128), arg7)
        };
        if (v8 == 0) {
            let v9 = Closed<T0>{
                funds     : 0x2::coin::zero<T0>(arg11),
                delivered : 0,
                requested : arg8,
            };
            return (arg2, v9)
        };
        if (arg7 == arg8 && v8 == arg7) {
            0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::custody::release_margin<T0>(&arg0.vault, arg1, &mut arg2, arg4, arg5, arg10);
        };
        let v10 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::lev_math::share_payout((((v0 as u256) * (v8 as u256) / (arg8 as u256)) as u64), v0, nav<T0>(arg0, arg1, &arg2, arg6), v1 * (v8 as u256) / (arg8 as u256), v7);
        if (v10 > 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::custody::balance<T0>(&arg0.vault, arg1)) {
            0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::custody::release_to_floor<T0>(&arg0.vault, arg1, &mut arg2, arg4, arg5, ratio_bps<T0>(arg0), arg10);
        };
        let v11 = 0x1::u64::min(v10, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::custody::balance<T0>(&arg0.vault, arg1));
        let v12 = if (v11 > 0) {
            0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::custody::withdraw<T0>(&arg0.vault, arg1, arg3, v11, arg11)
        } else {
            0x2::coin::zero<T0>(arg11)
        };
        arg0.basis = arg0.basis - 0x1::u64::min((((arg0.basis as u256) * (v8 as u256) / (arg8 as u256)) as u64), arg0.basis);
        let v13 = Closed<T0>{
            funds     : v12,
            delivered : v8,
            requested : arg8,
        };
        (arg2, v13)
    }

    fun closing_size(arg0: u64, arg1: u128, arg2: u128, arg3: u64) : u64 {
        let v0 = (arg2 as u256) * (arg3 as u256);
        ((0x1::u256::min(((arg0 as u256) * (arg1 as u256) + v0 - 1) / v0, ((arg0 / arg3) as u256)) * (arg3 as u256)) as u64)
    }

    public(friend) fun destroy<T0>(arg0: Leg<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>) {
        let Leg {
            vault      : v0,
            market     : _,
            long       : _,
            target_bps : _,
            min_bps    : _,
            max_bps    : _,
            weight_bps : _,
            basis      : _,
        } = arg0;
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::custody::destroy_empty<T0>(v0, arg1);
    }

    fun ensure_ratio<T0>(arg0: &Leg<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>) {
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::custody::configure_margin<T0>(&arg0.vault, arg1, arg2, 0x1::u64::max(ratio_bps<T0>(arg0), 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::custody::venue_floor_bps<T0>(arg2)));
    }

    public(friend) fun exposure<T0>(arg0: &Leg<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg3: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::Prices) : (u64, u64, u64) {
        let v0 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::lev_math::collateral_usd_e6(nav<T0>(arg0, arg1, arg2, arg3), 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::collateral_price(arg3), 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::collateral_scaling(arg3), false);
        let v1 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::lev_math::notional_usd_e6(base<T0>(arg2, arg1, arg0.long), 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::mark(arg3));
        (v0, v1, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::lev_math::leverage_bps(v1, v0))
    }

    fun fresh(arg0: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg1: u16, arg2: u64, arg3: &0x2::clock::Clock) : bool {
        if (!0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::contains(arg0, arg1)) {
            return false
        };
        0x2::clock::timestamp_ms(arg3) <= 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed::timestamp_ms(0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::price_feed(arg0, arg1)) + arg2
    }

    public(friend) fun is_flat<T0>(arg0: &Leg<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>) : bool {
        ((base<T0>(arg2, arg1, arg0.long) / 1000000000) as u64) < 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg2))
    }

    public(friend) fun keep_basis<T0>(arg0: &mut Leg<T0>, arg1: u64) {
        arg0.basis = arg0.basis + arg1;
    }

    public(friend) fun long<T0>(arg0: &Leg<T0>) : bool {
        arg0.long
    }

    public(friend) fun nav<T0>(arg0: &Leg<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg3: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::Prices) : u64 {
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::total<T0>(&arg0.vault, arg1, arg2, arg3, 0)
    }

    public(friend) fun open<T0>(arg0: &mut Leg<T0>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::Prices, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, 0x2::coin::Coin<T0>) {
        check<T0>(arg0, arg1, &arg2);
        let v0 = 0x2::coin::value<T0>(&arg7);
        if (v0 == 0) {
            return (arg2, arg7)
        };
        let v1 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::mark(arg6);
        let v2 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::lev_math::order_size(0x1::u64::min(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::lev_math::target_notional(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::lev_math::collateral_usd_e6(v0, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::collateral_price(arg6), 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::collateral_scaling(arg6), false), arg0.target_bps), arg8), v1, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(&arg2)));
        if (v2 == 0 || below_min_order<T0>(&arg2, v2, v1)) {
            return (arg2, arg7)
        };
        let v3 = &mut arg2;
        ensure_ratio<T0>(arg0, arg1, v3);
        let v4 = base<T0>(&arg2, arg1, arg0.long);
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::custody::deposit<T0>(&arg0.vault, arg1, arg3, 0x2::coin::split<T0>(&mut arg7, v0, arg11));
        let v5 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::lev_math::limit_price(v1, arg9, arg0.long, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::tick_size(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(&arg2)));
        let v6 = arg2;
        arg2 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::custody::trade_limit<T0>(&arg0.vault, arg1, v6, arg4, arg5, !arg0.long, v2, v5, false, arg10, arg11);
        let v7 = 0x1::u64::min(v0 - 0x1::u64::min(v0, usd_to_raw(((((0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::lev_math::notional_usd_e6(base<T0>(&arg2, arg1, arg0.long) - v4, v1) as u128) * (10000 as u128) + (arg0.target_bps as u128) - 1) / (arg0.target_bps as u128)) as u64), arg6, true)), 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::custody::balance<T0>(&arg0.vault, arg1));
        if (v7 > 0) {
            0x2::coin::join<T0>(&mut arg7, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::custody::withdraw<T0>(&arg0.vault, arg1, arg3, v7, arg11));
        };
        arg0.basis = arg0.basis + v0 - v7;
        (arg2, arg7)
    }

    public(friend) fun prices<T0>(arg0: &Leg<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x2::clock::Clock) : 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::Prices {
        check<T0>(arg0, arg1, arg2);
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::settle<T0>(&arg0.vault, arg1, arg2, arg3, arg4, arg5);
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::oracle_prices<T0>(arg2, arg3, arg4, arg5)
    }

    public(friend) fun profit<T0>(arg0: &Leg<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg3: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::Prices) : u64 {
        let v0 = nav<T0>(arg0, arg1, arg2, arg3);
        if (v0 > arg0.basis) {
            v0 - arg0.basis
        } else {
            0
        }
    }

    fun ratio_bps<T0>(arg0: &Leg<T0>) : u64 {
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::lev_math::position_ratio_bps(arg0.max_bps + arg0.max_bps - arg0.target_bps)
    }

    public(friend) fun rebalance<T0>(arg0: &Leg<T0>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::Prices, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0> {
        check<T0>(arg0, arg1, &arg2);
        let (v0, v1, _) = exposure<T0>(arg0, arg1, &arg2, arg5);
        let v3 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::lev_math::target_notional(v0, arg0.target_bps);
        let v4 = v3 > v1;
        let v5 = 0x1::u64::min(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::lev_math::distance(v3, v1), arg7);
        let v6 = v5;
        if (v4) {
            v6 = 0x1::u64::min(v5, arg6);
        };
        let v7 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(&arg2));
        let v8 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::mark(arg5);
        let v9 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::lev_math::order_size(v6, v8, v7);
        let v10 = v9;
        if (!v4) {
            v10 = 0x1::u64::min(v9, ((base<T0>(&arg2, arg1, arg0.long) / 1000000000) as u64) / v7 * v7);
        } else if (v9 > 0 && below_min_order<T0>(&arg2, v9, v8)) {
            v10 = 0;
        };
        if (v10 == 0) {
            return arg2
        };
        if (v4) {
            let v11 = &mut arg2;
            ensure_ratio<T0>(arg0, arg1, v11);
        };
        let v12 = nav<T0>(arg0, arg1, &arg2, arg5);
        let v13 = base<T0>(&arg2, arg1, arg0.long);
        let v14 = v4 && !arg0.long || arg0.long;
        let v15 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::lev_math::limit_price(v8, arg8, !v14, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::tick_size(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(&arg2)));
        let v16 = arg2;
        arg2 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::custody::trade_limit<T0>(&arg0.vault, arg1, v16, arg3, arg4, v14, v10, v15, !v4, arg9, arg10);
        let v17 = base<T0>(&arg2, arg1, arg0.long);
        let v18 = if (v17 > v13) {
            v17 - v13
        } else {
            v13 - v17
        };
        assert_execution(v12, nav<T0>(arg0, arg1, &arg2, arg5), v18, arg5, arg8);
        arg2
    }

    public(friend) fun restore_margin<T0>(arg0: &Leg<T0>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x2::clock::Clock) : u64 {
        check<T0>(arg0, arg1, arg2);
        if (!0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T0>(arg2, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg1))) {
            return 0
        };
        let v0 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::prices<T0>(arg2, arg3, arg4, arg5);
        let v1 = 0x1::u64::min(0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::margin_shortfall<T0>(arg1, arg2, &v0, ratio_bps<T0>(arg0)), 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::custody::balance<T0>(&arg0.vault, arg1));
        if (v1 > 0) {
            0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::custody::allocate_margin<T0>(&arg0.vault, arg1, arg2, v1);
        };
        v1
    }

    public(friend) fun room_usd_e6<T0>(arg0: &Leg<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg3: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::Prices, arg4: u64) : u64 {
        let v0 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::lev_math::notional_usd_e6(base<T0>(arg2, arg1, arg0.long), 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::mark(arg3));
        let v1 = if (arg4 == 0) {
            18446744073709551615
        } else if (arg4 > v0) {
            arg4 - v0
        } else {
            0
        };
        0x1::u64::min(v1, venue_room_usd_e6<T0>(arg0, arg1, arg2, arg3))
    }

    public(friend) fun set_target<T0>(arg0: &mut Leg<T0>, arg1: u64, arg2: u64) {
        let v0 = if (arg1 >= 10000) {
            if (arg2 > 0) {
                arg2 <= 10000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        let (v1, v2) = band(arg1);
        arg0.target_bps = arg1;
        arg0.min_bps = v1;
        arg0.max_bps = v2;
        arg0.weight_bps = arg2;
    }

    public(friend) fun take_cash<T0>(arg0: &mut Leg<T0>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::u64::min(arg3, 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::custody::balance<T0>(&arg0.vault, arg1));
        if (v0 == 0) {
            return 0x2::coin::zero<T0>(arg4)
        };
        arg0.basis = arg0.basis - 0x1::u64::min(v0, arg0.basis);
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::custody::withdraw<T0>(&arg0.vault, arg1, arg2, v0, arg4)
    }

    public(friend) fun target_bps<T0>(arg0: &Leg<T0>) : u64 {
        arg0.target_bps
    }

    public(friend) fun tradable<T0>(arg0: &Leg<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x2::clock::Clock) : bool {
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(arg1) == arg0.market, 1);
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg1);
        assert!(0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::storage_id(arg2) == 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::base_storage_id(v0) && 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::storage_id(arg3) == 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::collateral_storage_id(v0), 1);
        if (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_pause_mode<T0>(arg1) != 0 || 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::is_frozen<T0>(arg1)) {
            return false
        };
        fresh(arg2, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::base_source_id(v0), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::base_pfs_tolerance(v0), arg4) && fresh(arg3, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::collateral_source_id(v0), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::collateral_pfs_tolerance(v0), arg4)
    }

    public(friend) fun unpack<T0>(arg0: Closed<T0>) : (0x2::coin::Coin<T0>, u128, u128) {
        let Closed {
            funds     : v0,
            delivered : v1,
            requested : v2,
        } = arg0;
        (v0, v1, v2)
    }

    fun usd_to_raw(arg0: u64, arg1: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::Prices, arg2: bool) : u64 {
        let v0 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::collateral_price(arg1);
        let v1 = if (arg2) {
            ((arg0 as u256) * 1000000000000000000 / 1000000 * 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::collateral_scaling(arg1) + v0 - 1) / v0
        } else {
            (arg0 as u256) * 1000000000000000000 / 1000000 * 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::collateral_scaling(arg1) / v0
        };
        (v1 as u64)
    }

    fun venue_room_usd_e6<T0>(arg0: &Leg<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg3: &0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::Prices) : u64 {
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg2);
        let (v1, v2) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::max_open_interest_position_params(v0);
        let v3 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::max_open_interest(v0);
        let v4 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::open_interest(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_state<T0>(arg2));
        let v5 = base<T0>(arg2, arg1, arg0.long);
        let v6 = 1000000000000000000;
        let v7 = if (v2 > v6) {
            v6
        } else {
            v2
        };
        let v8 = if (v3 > v4) {
            v3 - v4
        } else {
            0
        };
        let v9 = v4 / v6 * v7 + v4 % v6 * v7 / v6;
        let v10 = if (v9 > v5) {
            v9 - v5
        } else {
            0
        };
        let v11 = if (v1 > v4) {
            v1 - v4
        } else {
            0
        };
        let v12 = if (v11 > v10) {
            v11
        } else {
            v10
        };
        let v13 = if (v8 < v12) {
            v8
        } else {
            v12
        };
        let v14 = 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::valuation::mark(arg3);
        0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::lev_math::notional_usd_e6(0x1::u256::min(v13 - v13 / 100, 18446744073709551615000000000000000000000000000000 / v14), v14)
    }

    public(friend) fun weight_bps<T0>(arg0: &Leg<T0>) : u64 {
        arg0.weight_bps
    }

    // decompiled from Move bytecode v7
}

