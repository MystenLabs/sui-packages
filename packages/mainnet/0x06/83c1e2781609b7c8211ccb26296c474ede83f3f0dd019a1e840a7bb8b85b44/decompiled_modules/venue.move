module 0x683c1e2781609b7c8211ccb26296c474ede83f3f0dd019a1e840a7bb8b85b44::venue {
    struct Venue<phantom T0> has store {
        account: 0x2::object::ID,
        account_num: u64,
        cap: 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>,
        market: 0x2::object::ID,
        base_oracle: 0x2::object::ID,
        collateral_oracle: 0x2::object::ID,
        long: bool,
        leverage_bps: u64,
        collateral_unit: u64,
    }

    struct Snapshot has copy, drop {
        free: u64,
        equity: u64,
        notional: u64,
        size: u64,
        long: bool,
        mmr_bps: u64,
        paused: bool,
        underwater: bool,
    }

    public fun account_id<T0>(arg0: &Venue<T0>) : 0x2::object::ID {
        arg0.account
    }

    public(friend) fun allocate<T0>(arg0: &Venue<T0>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: u64) {
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>>(arg2) == arg0.account, 600);
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(arg1) == arg0.market, 601);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::allocate_collateral<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, &arg0.cap, arg2, arg3);
    }

    fun check_objects<T0>(arg0: &Venue<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage) {
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>>(arg2) == arg0.account, 600);
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(arg1) == arg0.market, 601);
        assert!(0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg3) == arg0.base_oracle && 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg4) == arg0.collateral_oracle, 602);
    }

    public(friend) fun close_at_settlement<T0>(arg0: &Venue<T0>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>) : u64 {
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>>(arg2) == arg0.account, 600);
        assert!(is_settled<T0>(arg0, arg1), 607);
        if (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T0>(arg1, arg0.account_num)) {
            let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(arg1, arg0.account_num);
            let (v1, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v0);
            if (v1 != 0 || 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v0) != 0) {
                let v3 = vector[];
                0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::close_position_at_settlement_prices<T0>(arg1, arg2, &v3);
            };
        };
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::collateral_balance<T0>(arg2)
    }

    public(friend) fun deallocate<T0>(arg0: &Venue<T0>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: u64, arg6: &0x2::clock::Clock) : u64 {
        check_objects<T0>(arg0, arg1, arg2, arg3, arg4);
        if (arg5 == 0 || !0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T0>(arg1, arg0.account_num)) {
            return 0
        };
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::collateral_to_deallocate_for_margin_ratio<T0>(arg1, arg0.account_num, arg3, arg4, arg6, 0x1::option::none<u256>());
        let v1 = if (arg5 < v0) {
            arg5
        } else {
            v0
        };
        if (v1 == 0) {
            return 0
        };
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::deallocate_collateral<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, &arg0.cap, arg2, arg3, arg4, v1, arg6)
    }

    public(friend) fun deposit<T0>(arg0: &Venue<T0>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: 0x2::coin::Coin<T0>) {
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>>(arg1) == arg0.account, 600);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::deposit_collateral<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, &arg0.cap, arg2, arg3);
    }

    public(friend) fun is_settled<T0>(arg0: &Venue<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>) : bool {
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(arg1) == arg0.market, 601);
        let (v0, _, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::settlement_valuation_prices<T0>(arg1);
        v0
    }

    public fun is_underwater(arg0: &Snapshot) : bool {
        arg0.underwater
    }

    public fun leverage_bps<T0>(arg0: &Venue<T0>) : u64 {
        arg0.leverage_bps
    }

    public fun market_id<T0>(arg0: &Venue<T0>) : 0x2::object::ID {
        arg0.market
    }

    public(friend) fun new<T0>(arg0: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: bool, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : Venue<T0> {
        let (v0, _, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::settlement_valuation_prices<T0>(arg1);
        assert!(!v0, 608);
        let v3 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg1);
        assert!(0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::storage_id(arg2) == 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::base_storage_id(v3), 602);
        assert!(0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::storage_id(arg3) == 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::collateral_storage_id(v3), 602);
        assert!(arg5 >= 10000 && arg5 <= ((1000000000000000000 * 10000 / 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::margin_ratio_initial(v3)) as u64), 604);
        let (v4, v5, v6) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::create_account<T0>(arg0, arg7);
        let v7 = v6;
        let v8 = v4;
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::create_market_position<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, &v7, &v8);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::set_position_initial_margin_ratio<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, &v7, &v8, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::margin_ratio_initial(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg1)));
        let v9 = Venue<T0>{
            account           : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>>(&v8),
            account_num       : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(&v8),
            cap               : v7,
            market            : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(arg1),
            base_oracle       : 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg2),
            collateral_oracle : 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg3),
            long              : arg4,
            leverage_bps      : arg5,
            collateral_unit   : arg6,
        };
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::consume_policy_and_share_account<T0>(v8, v5);
        v9
    }

    fun oracle_price(arg0: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg1: u16, arg2: u64, arg3: &0x2::clock::Clock) : u256 {
        let (v0, v1) = 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed::price_and_timestamp_ms(0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::price_feed(arg0, arg1));
        assert!(v1 + arg2 >= 0x2::clock::timestamp_ms(arg3), 603);
        (v0 as u256)
    }

    public fun oracles<T0>(arg0: &Venue<T0>) : (0x2::object::ID, 0x2::object::ID) {
        (arg0.base_oracle, arg0.collateral_oracle)
    }

    public(friend) fun settle_funding<T0>(arg0: &Venue<T0>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg3: &0x2::clock::Clock) {
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(arg1) == arg0.market, 601);
        assert!(0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg2) == arg0.collateral_oracle, 602);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::settle_position_funding<T0>(arg1, arg2, arg0.account_num, arg3);
    }

    public fun side_long<T0>(arg0: &Venue<T0>) : bool {
        arg0.long
    }

    public(friend) fun size_for<T0>(arg0: &Venue<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) : u64 {
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg1);
        let v1 = (arg4 as u256) * oracle_price(arg3, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::collateral_source_id(v0), arg5, arg6) / (arg0.collateral_unit as u256) * 1000000000 / oracle_price(arg2, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::base_source_id(v0), arg5, arg6);
        ((v1 - v1 % (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(v0) as u256)) as u64)
    }

    public(friend) fun snapshot<T0>(arg0: &Venue<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: u64, arg6: &0x2::clock::Clock) : Snapshot {
        check_objects<T0>(arg0, arg1, arg2, arg3, arg4);
        assert!(!is_settled<T0>(arg0, arg1), 608);
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg1);
        let v1 = oracle_price(arg3, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::base_source_id(v0), arg5, arg6);
        let v2 = oracle_price(arg4, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::collateral_source_id(v0), arg5, arg6);
        let v3 = ((0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::margin_ratio_maintenance(v0) * 10000 / 1000000000000000000) as u64);
        let v4 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::is_market_paused<T0>(arg1) || 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::is_market_cancel_only<T0>(arg1);
        if (!0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T0>(arg1, arg0.account_num)) {
            return Snapshot{
                free       : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::collateral_balance<T0>(arg2),
                equity     : 0,
                notional   : 0,
                size       : 0,
                long       : arg0.long,
                mmr_bps    : v3,
                paused     : v4,
                underwater : false,
            }
        };
        let v5 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(arg1, arg0.account_num);
        let (v6, v7) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::cum_funding_rates(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_state<T0>(arg1));
        let (v8, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::compute_margin_with_fundings(v5, v2, v1, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::margin_ratio_maintenance(v0), v6, v7, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::collateral_haircut(v0));
        let v10 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v8);
        let v11 = if (v10) {
            0
        } else {
            usd_to_units(v8, v2, arg0.collateral_unit)
        };
        let (v12, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v5);
        let v14 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v12);
        let v15 = v14 == 0 && arg0.long || !0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v12);
        Snapshot{
            free       : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::collateral_balance<T0>(arg2),
            equity     : v11,
            notional   : usd_to_units(v14 * v1 / 1000000000000000000, v2, arg0.collateral_unit),
            size       : ((v14 * 1000000000 / 1000000000000000000) as u64),
            long       : v15,
            mmr_bps    : v3,
            paused     : v4,
            underwater : v10,
        }
    }

    public fun snapshot_parts(arg0: &Snapshot) : (u64, u64, u64, u64, bool, u64, bool) {
        (arg0.free, arg0.equity, arg0.notional, arg0.size, arg0.long, arg0.mmr_bps, arg0.paused)
    }

    public(friend) fun trade<T0>(arg0: &Venue<T0>, arg1: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, u64) {
        check_objects<T0>(arg0, &arg1, arg2, arg3, arg4);
        assert!(!0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::is_market_paused<T0>(&arg1) && !0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::is_market_cancel_only<T0>(&arg1), 605);
        assert!(arg7 > 0 && arg7 <= 100, 606);
        let v0 = arg5 && !arg0.long || arg0.long;
        let v1 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(&arg1);
        let v2 = (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::tick_size(v1) as u256);
        let v3 = if (v0) {
            (((oracle_price(arg3, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::base_source_id(v1), arg8, arg9) * (10000 - (arg7 as u256)) / 10000 * 1000000000 / 1000000000000000000 + v2 - 1) / v2 * v2) as u64)
        } else {
            ((oracle_price(arg3, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::base_source_id(v1), arg8, arg9) * (10000 + (arg7 as u256)) / 10000 * 1000000000 / 1000000000000000000 / v2 * v2) as u64)
        };
        let v4 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::margin_ratio_initial(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(&arg1));
        if (0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::initial_margin_ratio(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(&arg1, arg0.account_num)) != v4) {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::set_position_initial_margin_ratio<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&mut arg1, &arg0.cap, arg2, v4);
        };
        let v5 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::start_session<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, &arg0.cap, arg2, arg3, arg4, 0x1::option::none<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::IntegratorInfo>(), arg9, arg10);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_limit_order<T0>(&mut v5, v0, arg6, v3, 3, 0x1::option::none<u64>(), !arg5, 0x1::option::none<u64>());
        let (v6, v7) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::end_session<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(v5, &arg0.cap, arg2, true, false);
        let v8 = v7;
        let v9 = if (v0) {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::base_filled_ask(&v8)
        } else {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::base_filled_bid(&v8)
        };
        (v6, ((v9 * 1000000000 / 1000000000000000000) as u64))
    }

    fun usd_to_units(arg0: u256, arg1: u256, arg2: u64) : u64 {
        ((arg0 * (arg2 as u256) / arg1) as u64)
    }

    public(friend) fun withdraw<T0>(arg0: &Venue<T0>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>>(arg1) == arg0.account, 600);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::withdraw_collateral<T0>(arg1, &arg0.cap, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v7
}

