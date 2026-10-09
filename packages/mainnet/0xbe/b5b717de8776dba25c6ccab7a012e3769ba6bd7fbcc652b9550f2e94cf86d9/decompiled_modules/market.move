module 0xbeb5b717de8776dba25c6ccab7a012e3769ba6bd7fbcc652b9550f2e94cf86d9::market {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Market<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T1>,
        feed_id: vector<u8>,
        collateral_decimals: u8,
        asset_decimals: u8,
        min_cr_bps: u64,
        liquidation_discount_bps: u64,
        mint_fee_bps: u64,
        max_price_age_secs: u64,
        max_conf_bps: u64,
        debt_ceiling: u64,
        total_debt: u64,
        bad_debt: u64,
        paused: bool,
        next_position_id: u64,
        positions: 0x2::table::Table<u64, Position<T0>>,
        fees: 0x2::balance::Balance<T0>,
        redeem_fee_bps: u64,
        min_debt: u64,
        head: 0x1::option::Option<u64>,
        tail: 0x1::option::Option<u64>,
        sorted: 0x2::table::Table<u64, Node>,
        version: u64,
    }

    struct Node has drop, store {
        prev: 0x1::option::Option<u64>,
        next: 0x1::option::Option<u64>,
    }

    struct Position<phantom T0> has store {
        collateral: 0x2::balance::Balance<T0>,
        debt: u64,
    }

    struct PositionCap has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        position_id: u64,
    }

    struct IndexFeedKey has copy, drop, store {
        dummy_field: bool,
    }

    struct IndexFeed has copy, drop, store {
        venue: 0x2::object::ID,
    }

    struct MarketCreated has copy, drop {
        market_id: 0x2::object::ID,
        feed_id: vector<u8>,
    }

    struct IndexFeedChanged has copy, drop {
        market_id: 0x2::object::ID,
        venue: 0x1::option::Option<0x2::object::ID>,
    }

    struct Migrated has copy, drop {
        market_id: 0x2::object::ID,
        from: u64,
        to: u64,
    }

    struct PositionOpened has copy, drop {
        market_id: 0x2::object::ID,
        position_id: u64,
        owner: address,
        collateral: u64,
    }

    struct CollateralChanged has copy, drop {
        market_id: 0x2::object::ID,
        position_id: u64,
        collateral: u64,
    }

    struct Minted has copy, drop {
        market_id: 0x2::object::ID,
        position_id: u64,
        amount: u64,
        fee: u64,
        price: u256,
        collateral: u64,
        debt: u64,
    }

    struct Burned has copy, drop {
        market_id: 0x2::object::ID,
        position_id: u64,
        amount: u64,
        debt: u64,
    }

    struct Liquidated has copy, drop {
        market_id: 0x2::object::ID,
        position_id: u64,
        repaid: u64,
        collateral_seized: u64,
        bad_debt: u64,
        price: u256,
        collateral: u64,
        debt: u64,
    }

    struct Redeemed has copy, drop {
        market_id: 0x2::object::ID,
        position_id: u64,
        amount: u64,
        collateral_taken: u64,
        price: u256,
        collateral: u64,
        debt: u64,
    }

    struct Redemption has copy, drop {
        market_id: 0x2::object::ID,
        redeemer: address,
        amount: u64,
        collateral_out: u64,
        fee: u64,
        price: u256,
    }

    struct PositionClosed has copy, drop {
        market_id: 0x2::object::ID,
        position_id: u64,
    }

    public fun burn<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &PositionCap, arg2: 0x2::coin::Coin<T1>, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_version<T0, T1>(arg0);
        let v0 = 0x2::table::borrow_mut<u64, Position<T0>>(&mut arg0.positions, arg1.position_id);
        let v1 = 0x1::u64::min(0x2::coin::value<T1>(&arg2), v0.debt);
        assert!(v1 > 0, 7);
        v0.debt = v0.debt - v1;
        arg0.total_debt = arg0.total_debt - v1;
        0x2::coin::burn<T1>(&mut arg0.treasury_cap, 0x2::coin::split<T1>(&mut arg2, v1, arg4));
        let v2 = Burned{
            market_id   : check_cap<T0, T1>(arg0, arg1),
            position_id : arg1.position_id,
            amount      : v1,
            debt        : v0.debt,
        };
        0x2::event::emit<Burned>(v2);
        resort<T0, T1>(arg0, arg1.position_id, arg3);
        arg2
    }

    public fun mint<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &PositionCap, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_version<T0, T1>(arg0);
        let v0 = read_price<T0, T1>(arg0, arg4, arg5);
        mint_with_price<T0, T1>(arg0, arg1, arg2, arg3, &v0, arg6)
    }

    fun assert_version<T0, T1>(arg0: &Market<T0, T1>) {
        assert!(arg0.version == 1, 15);
    }

    public fun asset_to_collateral_down(arg0: u64, arg1: u256, arg2: u8, arg3: u8) : u256 {
        (arg0 as u256) * arg1 * pow10(arg2) / pow10(arg3) * 0xbeb5b717de8776dba25c6ccab7a012e3769ba6bd7fbcc652b9550f2e94cf86d9::oracle::price_scale()
    }

    public fun asset_to_collateral_up(arg0: u64, arg1: u256, arg2: u8, arg3: u8) : u256 {
        div_up((arg0 as u256) * arg1 * pow10(arg2), pow10(arg3) * 0xbeb5b717de8776dba25c6ccab7a012e3769ba6bd7fbcc652b9550f2e94cf86d9::oracle::price_scale())
    }

    public fun bad_debt<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.bad_debt
    }

    public fun cap_market_id(arg0: &PositionCap) : 0x2::object::ID {
        arg0.market_id
    }

    public fun cap_position_id(arg0: &PositionCap) : u64 {
        arg0.position_id
    }

    fun check_cap<T0, T1>(arg0: &Market<T0, T1>, arg1: &PositionCap) : 0x2::object::ID {
        let v0 = 0x2::object::id<Market<T0, T1>>(arg0);
        assert!(arg1.market_id == v0, 1);
        v0
    }

    fun check_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg1 < 5000, 8);
        assert!((arg0 as u256) > 10000 + (arg1 as u256) * 10000 / (10000 - (arg1 as u256)), 8);
        assert!(arg2 <= 1000, 8);
        assert!(arg3 > 0 && arg3 < 1000, 8);
    }

    public fun clear_index_feed<T0, T1>(arg0: &AdminCap, arg1: &mut Market<T0, T1>) {
        assert_version<T0, T1>(arg1);
        let v0 = IndexFeedKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<IndexFeedKey>(&arg1.id, v0), 14);
        let v1 = IndexFeedKey{dummy_field: false};
        0x2::dynamic_field::remove<IndexFeedKey, IndexFeed>(&mut arg1.id, v1);
        let v2 = IndexFeedChanged{
            market_id : 0x2::object::id<Market<T0, T1>>(arg1),
            venue     : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::event::emit<IndexFeedChanged>(v2);
    }

    public fun close_position<T0, T1>(arg0: &mut Market<T0, T1>, arg1: PositionCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0, T1>(arg0);
        let PositionCap {
            id          : v0,
            market_id   : _,
            position_id : v2,
        } = arg1;
        0x2::object::delete(v0);
        let Position {
            collateral : v3,
            debt       : v4,
        } = 0x2::table::remove<u64, Position<T0>>(&mut arg0.positions, v2);
        assert!(v4 == 0, 6);
        let v5 = PositionClosed{
            market_id   : check_cap<T0, T1>(arg0, &arg1),
            position_id : v2,
        };
        0x2::event::emit<PositionClosed>(v5);
        0x2::coin::from_balance<T0>(v3, arg2)
    }

    public fun collateral_to_asset_up(arg0: u256, arg1: u256, arg2: u8, arg3: u8) : u256 {
        div_up(arg0 * pow10(arg3) * 0xbeb5b717de8776dba25c6ccab7a012e3769ba6bd7fbcc652b9550f2e94cf86d9::oracle::price_scale(), arg1 * pow10(arg2))
    }

    public fun cover_bad_debt<T0, T1>(arg0: &mut Market<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_version<T0, T1>(arg0);
        let v0 = 0x1::u64::min(0x2::coin::value<T1>(&arg1), arg0.bad_debt);
        assert!(v0 > 0, 7);
        arg0.bad_debt = arg0.bad_debt - v0;
        0x2::coin::burn<T1>(&mut arg0.treasury_cap, 0x2::coin::split<T1>(&mut arg1, v0, arg2));
        arg1
    }

    public fun create_market<T0, T1>(arg0: &AdminCap, arg1: 0x2::coin::TreasuryCap<T1>, arg2: vector<u8>, arg3: u8, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::coin::total_supply<T1>(&arg1) == 0, 9);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 8);
        assert!(arg3 <= 18 && arg4 <= 18, 8);
        check_params(arg5, arg6, arg7, arg9);
        let v0 = Market<T0, T1>{
            id                       : 0x2::object::new(arg11),
            treasury_cap             : arg1,
            feed_id                  : arg2,
            collateral_decimals      : arg3,
            asset_decimals           : arg4,
            min_cr_bps               : arg5,
            liquidation_discount_bps : arg6,
            mint_fee_bps             : arg7,
            max_price_age_secs       : arg8,
            max_conf_bps             : arg9,
            debt_ceiling             : arg10,
            total_debt               : 0,
            bad_debt                 : 0,
            paused                   : false,
            next_position_id         : 0,
            positions                : 0x2::table::new<u64, Position<T0>>(arg11),
            fees                     : 0x2::balance::zero<T0>(),
            redeem_fee_bps           : 50,
            min_debt                 : 0,
            head                     : 0x1::option::none<u64>(),
            tail                     : 0x1::option::none<u64>(),
            sorted                   : 0x2::table::new<u64, Node>(arg11),
            version                  : 1,
        };
        let v1 = 0x2::object::id<Market<T0, T1>>(&v0);
        let v2 = MarketCreated{
            market_id : v1,
            feed_id   : v0.feed_id,
        };
        0x2::event::emit<MarketCreated>(v2);
        0x2::transfer::share_object<Market<T0, T1>>(v0);
        v1
    }

    public fun deposit<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &PositionCap, arg2: 0x2::coin::Coin<T0>, arg3: 0x1::option::Option<u64>) {
        assert_version<T0, T1>(arg0);
        assert!(0x2::coin::value<T0>(&arg2) > 0, 7);
        let v0 = 0x2::table::borrow_mut<u64, Position<T0>>(&mut arg0.positions, arg1.position_id);
        0x2::balance::join<T0>(&mut v0.collateral, 0x2::coin::into_balance<T0>(arg2));
        let v1 = CollateralChanged{
            market_id   : check_cap<T0, T1>(arg0, arg1),
            position_id : arg1.position_id,
            collateral  : 0x2::balance::value<T0>(&v0.collateral),
        };
        0x2::event::emit<CollateralChanged>(v1);
        resort<T0, T1>(arg0, arg1.position_id, arg3);
    }

    fun div_up(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0) {
            0
        } else {
            (arg0 - 1) / arg1 + 1
        }
    }

    fun do_withdraw<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &PositionCap, arg2: u64, arg3: u256, arg4: 0x1::option::Option<u64>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg2 > 0, 7);
        let v0 = 0x2::table::borrow_mut<u64, Position<T0>>(&mut arg0.positions, arg1.position_id);
        assert!(0x2::balance::value<T0>(&v0.collateral) >= arg2, 10);
        let v1 = 0x2::coin::take<T0>(&mut v0.collateral, arg2, arg5);
        if (v0.debt > 0) {
            assert!(!arg0.paused, 2);
            assert!(is_healthy(0x2::balance::value<T0>(&v0.collateral), v0.debt, arg3, arg0.collateral_decimals, arg0.asset_decimals, arg0.min_cr_bps), 3);
        };
        let v2 = CollateralChanged{
            market_id   : check_cap<T0, T1>(arg0, arg1),
            position_id : arg1.position_id,
            collateral  : 0x2::balance::value<T0>(&v0.collateral),
        };
        0x2::event::emit<CollateralChanged>(v2);
        resort<T0, T1>(arg0, arg1.position_id, arg4);
        v1
    }

    public fun feed_id<T0, T1>(arg0: &Market<T0, T1>) : vector<u8> {
        arg0.feed_id
    }

    public fun fees<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.fees)
    }

    public fun index_feed<T0, T1>(arg0: &Market<T0, T1>) : (bool, 0x2::object::ID) {
        let v0 = IndexFeedKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<IndexFeedKey>(&arg0.id, v0)) {
            return (false, 0x2::object::id<Market<T0, T1>>(arg0))
        };
        let v1 = IndexFeedKey{dummy_field: false};
        (true, 0x2::dynamic_field::borrow<IndexFeedKey, IndexFeed>(&arg0.id, v1).venue)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_healthy(arg0: u64, arg1: u64, arg2: u256, arg3: u8, arg4: u8, arg5: u64) : bool {
        if (arg1 == 0) {
            return true
        };
        (arg0 as u256) * 10000 >= asset_to_collateral_up(arg1, arg2, arg3, arg4) * (arg5 as u256)
    }

    public fun is_paused<T0, T1>(arg0: &Market<T0, T1>) : bool {
        arg0.paused
    }

    public fun liquidate<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T1>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_version<T0, T1>(arg0);
        let v0 = read_price<T0, T1>(arg0, arg3, arg4);
        liquidate_with_price<T0, T1>(arg0, arg1, arg2, &v0, arg5)
    }

    public fun liquidate_index<T0, T1, T2>(arg0: &mut Market<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_version<T0, T1>(arg0);
        let v0 = read_index<T0, T1, T2>(arg0, arg3, arg4, arg5);
        liquidate_with_price<T0, T1>(arg0, arg1, arg2, &v0, arg6)
    }

    public(friend) fun liquidate_with_price<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T1>, arg3: &0xbeb5b717de8776dba25c6ccab7a012e3769ba6bd7fbcc652b9550f2e94cf86d9::oracle::OraclePrice, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(!arg0.paused, 2);
        assert!(0x2::table::contains<u64, Position<T0>>(&arg0.positions, arg1), 11);
        let v0 = arg0.collateral_decimals;
        let v1 = arg0.asset_decimals;
        let v2 = (arg0.liquidation_discount_bps as u256);
        let v3 = 0xbeb5b717de8776dba25c6ccab7a012e3769ba6bd7fbcc652b9550f2e94cf86d9::oracle::price(arg3);
        let v4 = 0x2::table::borrow_mut<u64, Position<T0>>(&mut arg0.positions, arg1);
        assert!(v4.debt > 0, 5);
        assert!(!is_healthy(0x2::balance::value<T0>(&v4.collateral), v4.debt, 0xbeb5b717de8776dba25c6ccab7a012e3769ba6bd7fbcc652b9550f2e94cf86d9::oracle::price_low(arg3), v0, v1, arg0.min_cr_bps), 5);
        let v5 = (0x2::balance::value<T0>(&v4.collateral) as u256);
        let v6 = 0x1::u64::min(0x2::coin::value<T1>(&arg2), v4.debt);
        let v7 = v6;
        assert!(v6 > 0, 7);
        let v8 = asset_to_collateral_down(v6, v3, v0, v1) * 10000 / (10000 - v2);
        let v9 = v8;
        if (v8 > v5) {
            v9 = v5;
            let v10 = collateral_to_asset_up(v5 * (10000 - v2) / 10000, v3, v0, v1);
            if (v10 < (v6 as u256)) {
                v7 = (v10 as u64);
            };
        };
        v4.debt = v4.debt - v7;
        arg0.total_debt = arg0.total_debt - v7;
        let v11 = 0x2::coin::take<T0>(&mut v4.collateral, (v9 as u64), arg4);
        let v12 = 0;
        if (0x2::balance::value<T0>(&v4.collateral) == 0 && v4.debt > 0) {
            let v13 = v4.debt;
            v12 = v13;
            v4.debt = 0;
            arg0.total_debt = arg0.total_debt - v13;
            arg0.bad_debt = arg0.bad_debt + v13;
        };
        if (v7 > 0) {
            0x2::coin::burn<T1>(&mut arg0.treasury_cap, 0x2::coin::split<T1>(&mut arg2, v7, arg4));
        };
        let v14 = Liquidated{
            market_id         : 0x2::object::id<Market<T0, T1>>(arg0),
            position_id       : arg1,
            repaid            : v7,
            collateral_seized : (v9 as u64),
            bad_debt          : v12,
            price             : v3,
            collateral        : 0x2::balance::value<T0>(&v4.collateral),
            debt              : v4.debt,
        };
        0x2::event::emit<Liquidated>(v14);
        resort<T0, T1>(arg0, arg1, 0x1::option::none<u64>());
        (v11, arg2)
    }

    fun list_insert<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64, arg2: 0x1::option::Option<u64>) {
        let (v0, v1) = if (0x1::option::is_none<u64>(&arg2)) {
            let v1 = 0x1::option::none<u64>();
            let v0 = 0x1::option::none<u64>();
            (v0, v1)
        } else if (ratio_le<T0, T1>(arg0, *0x1::option::borrow<u64>(&arg2), arg1)) {
            let v1 = arg2;
            let v0 = 0x2::table::borrow<u64, Node>(&arg0.sorted, *0x1::option::borrow<u64>(&arg2)).next;
            while (0x1::option::is_some<u64>(&v0) && ratio_le<T0, T1>(arg0, *0x1::option::borrow<u64>(&v0), arg1)) {
                v1 = v0;
                let v2 = &0x2::table::borrow<u64, Node>(&arg0.sorted, *0x1::option::borrow<u64>(&v0)).next;
                v0 = *v2;
            };
            (v0, v1)
        } else {
            let v0 = arg2;
            let v1 = 0x2::table::borrow<u64, Node>(&arg0.sorted, *0x1::option::borrow<u64>(&arg2)).prev;
            while (0x1::option::is_some<u64>(&v1) && !ratio_le<T0, T1>(arg0, *0x1::option::borrow<u64>(&v1), arg1)) {
                v0 = v1;
                let v3 = &0x2::table::borrow<u64, Node>(&arg0.sorted, *0x1::option::borrow<u64>(&v1)).prev;
                v1 = *v3;
            };
            (v0, v1)
        };
        if (0x1::option::is_some<u64>(&v1)) {
            0x2::table::borrow_mut<u64, Node>(&mut arg0.sorted, *0x1::option::borrow<u64>(&v1)).next = 0x1::option::some<u64>(arg1);
        } else {
            arg0.head = 0x1::option::some<u64>(arg1);
        };
        if (0x1::option::is_some<u64>(&v0)) {
            0x2::table::borrow_mut<u64, Node>(&mut arg0.sorted, *0x1::option::borrow<u64>(&v0)).prev = 0x1::option::some<u64>(arg1);
        } else {
            arg0.tail = 0x1::option::some<u64>(arg1);
        };
        let v4 = Node{
            prev : v1,
            next : v0,
        };
        0x2::table::add<u64, Node>(&mut arg0.sorted, arg1, v4);
    }

    fun list_remove<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64) : (0x1::option::Option<u64>, 0x1::option::Option<u64>) {
        if (!0x2::table::contains<u64, Node>(&arg0.sorted, arg1)) {
            return (0x1::option::none<u64>(), 0x1::option::none<u64>())
        };
        let Node {
            prev : v0,
            next : v1,
        } = 0x2::table::remove<u64, Node>(&mut arg0.sorted, arg1);
        let v2 = v1;
        let v3 = v0;
        if (0x1::option::is_some<u64>(&v3)) {
            0x2::table::borrow_mut<u64, Node>(&mut arg0.sorted, *0x1::option::borrow<u64>(&v3)).next = v2;
        } else {
            arg0.head = v2;
        };
        if (0x1::option::is_some<u64>(&v2)) {
            0x2::table::borrow_mut<u64, Node>(&mut arg0.sorted, *0x1::option::borrow<u64>(&v2)).prev = v3;
        } else {
            arg0.tail = v3;
        };
        (v3, v2)
    }

    public fun migrate<T0, T1>(arg0: &AdminCap, arg1: &mut Market<T0, T1>) {
        assert!(arg1.version < 1, 15);
        let v0 = Migrated{
            market_id : 0x2::object::id<Market<T0, T1>>(arg1),
            from      : arg1.version,
            to        : 1,
        };
        0x2::event::emit<Migrated>(v0);
        arg1.version = 1;
    }

    public fun mint_index<T0, T1, T2>(arg0: &mut Market<T0, T1>, arg1: &PositionCap, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_version<T0, T1>(arg0);
        let v0 = read_index<T0, T1, T2>(arg0, arg4, arg5, arg6);
        mint_with_price<T0, T1>(arg0, arg1, arg2, arg3, &v0, arg7)
    }

    public(friend) fun mint_with_price<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &PositionCap, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: &0xbeb5b717de8776dba25c6ccab7a012e3769ba6bd7fbcc652b9550f2e94cf86d9::oracle::OraclePrice, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg2 > 0, 7);
        assert!(!arg0.paused, 2);
        assert!(arg0.total_debt <= arg0.debt_ceiling && arg2 <= arg0.debt_ceiling - arg0.total_debt, 4);
        let v0 = arg0.collateral_decimals;
        let v1 = arg0.asset_decimals;
        let v2 = 0x2::table::borrow_mut<u64, Position<T0>>(&mut arg0.positions, arg1.position_id);
        let v3 = div_up(asset_to_collateral_up(arg2, 0xbeb5b717de8776dba25c6ccab7a012e3769ba6bd7fbcc652b9550f2e94cf86d9::oracle::price(arg4), v0, v1) * (arg0.mint_fee_bps as u256), 10000);
        assert!(v3 <= (0x2::balance::value<T0>(&v2.collateral) as u256), 10);
        0x2::balance::join<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut v2.collateral, (v3 as u64)));
        v2.debt = v2.debt + arg2;
        assert!(v2.debt >= arg0.min_debt, 12);
        assert!(is_healthy(0x2::balance::value<T0>(&v2.collateral), v2.debt, 0xbeb5b717de8776dba25c6ccab7a012e3769ba6bd7fbcc652b9550f2e94cf86d9::oracle::price_high(arg4), v0, v1, arg0.min_cr_bps), 3);
        arg0.total_debt = arg0.total_debt + arg2;
        let v4 = Minted{
            market_id   : check_cap<T0, T1>(arg0, arg1),
            position_id : arg1.position_id,
            amount      : arg2,
            fee         : (v3 as u64),
            price       : 0xbeb5b717de8776dba25c6ccab7a012e3769ba6bd7fbcc652b9550f2e94cf86d9::oracle::price(arg4),
            collateral  : 0x2::balance::value<T0>(&v2.collateral),
            debt        : v2.debt,
        };
        0x2::event::emit<Minted>(v4);
        resort<T0, T1>(arg0, arg1.position_id, arg3);
        0x2::coin::mint<T1>(&mut arg0.treasury_cap, arg2, arg5)
    }

    public fun open_position<T0, T1>(arg0: &mut Market<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : PositionCap {
        assert_version<T0, T1>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 7);
        let v1 = arg0.next_position_id;
        arg0.next_position_id = v1 + 1;
        let v2 = Position<T0>{
            collateral : 0x2::coin::into_balance<T0>(arg1),
            debt       : 0,
        };
        0x2::table::add<u64, Position<T0>>(&mut arg0.positions, v1, v2);
        let v3 = 0x2::object::id<Market<T0, T1>>(arg0);
        let v4 = PositionOpened{
            market_id   : v3,
            position_id : v1,
            owner       : 0x2::tx_context::sender(arg2),
            collateral  : v0,
        };
        0x2::event::emit<PositionOpened>(v4);
        PositionCap{
            id          : 0x2::object::new(arg2),
            market_id   : v3,
            position_id : v1,
        }
    }

    public fun params<T0, T1>(arg0: &Market<T0, T1>) : (u64, u64, u64, u64, u64, u64) {
        (arg0.min_cr_bps, arg0.liquidation_discount_bps, arg0.mint_fee_bps, arg0.max_price_age_secs, arg0.max_conf_bps, arg0.debt_ceiling)
    }

    public fun position<T0, T1>(arg0: &Market<T0, T1>, arg1: u64) : (u64, u64) {
        let v0 = 0x2::table::borrow<u64, Position<T0>>(&arg0.positions, arg1);
        (0x2::balance::value<T0>(&v0.collateral), v0.debt)
    }

    public fun position_exists<T0, T1>(arg0: &Market<T0, T1>, arg1: u64) : bool {
        0x2::table::contains<u64, Position<T0>>(&arg0.positions, arg1)
    }

    fun pow10(arg0: u8) : u256 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    fun ratio_le<T0, T1>(arg0: &Market<T0, T1>, arg1: u64, arg2: u64) : bool {
        let v0 = 0x2::table::borrow<u64, Position<T0>>(&arg0.positions, arg1);
        let v1 = 0x2::table::borrow<u64, Position<T0>>(&arg0.positions, arg2);
        (0x2::balance::value<T0>(&v0.collateral) as u128) * (v1.debt as u128) <= (0x2::balance::value<T0>(&v1.collateral) as u128) * (v0.debt as u128)
    }

    fun read_index<T0, T1, T2>(arg0: &Market<T0, T1>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg3: &0x2::clock::Clock) : 0xbeb5b717de8776dba25c6ccab7a012e3769ba6bd7fbcc652b9550f2e94cf86d9::oracle::OraclePrice {
        let v0 = IndexFeedKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<IndexFeedKey>(&arg0.id, v0), 14);
        let v1 = IndexFeedKey{dummy_field: false};
        0xbeb5b717de8776dba25c6ccab7a012e3769ba6bd7fbcc652b9550f2e94cf86d9::index_oracle::read<T2>(arg1, arg2, arg3, 0x2::dynamic_field::borrow<IndexFeedKey, IndexFeed>(&arg0.id, v1).venue)
    }

    fun read_price<T0, T1>(arg0: &Market<T0, T1>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : 0xbeb5b717de8776dba25c6ccab7a012e3769ba6bd7fbcc652b9550f2e94cf86d9::oracle::OraclePrice {
        let v0 = IndexFeedKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<IndexFeedKey>(&arg0.id, v0), 14);
        0xbeb5b717de8776dba25c6ccab7a012e3769ba6bd7fbcc652b9550f2e94cf86d9::oracle::read(arg1, arg2, &arg0.feed_id, arg0.max_price_age_secs, arg0.max_conf_bps)
    }

    public fun redeem<T0, T1>(arg0: &mut Market<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_version<T0, T1>(arg0);
        let v0 = read_price<T0, T1>(arg0, arg4, arg5);
        redeem_with_price<T0, T1>(arg0, arg1, arg2, arg3, &v0, arg6)
    }

    public fun redeem_index<T0, T1, T2>(arg0: &mut Market<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_version<T0, T1>(arg0);
        let v0 = read_index<T0, T1, T2>(arg0, arg4, arg5, arg6);
        redeem_with_price<T0, T1>(arg0, arg1, arg2, arg3, &v0, arg7)
    }

    public(friend) fun redeem_with_price<T0, T1>(arg0: &mut Market<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: &0xbeb5b717de8776dba25c6ccab7a012e3769ba6bd7fbcc652b9550f2e94cf86d9::oracle::OraclePrice, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(!arg0.paused, 2);
        assert!(0x2::coin::value<T1>(&arg1) > 0 && arg2 > 0, 7);
        let v0 = 0x2::object::id<Market<T0, T1>>(arg0);
        let v1 = arg0.collateral_decimals;
        let v2 = arg0.asset_decimals;
        let v3 = arg0.min_debt;
        let v4 = 0xbeb5b717de8776dba25c6ccab7a012e3769ba6bd7fbcc652b9550f2e94cf86d9::oracle::price_low(arg4);
        let v5 = 0x2::coin::value<T1>(&arg1);
        let v6 = 0x2::balance::zero<T0>();
        let v7 = arg0.head;
        let v8 = 0;
        let v9 = 0x1::option::none<u64>();
        loop {
            let v10 = if (v5 > 0) {
                if (0x1::option::is_some<u64>(&v7)) {
                    v8 < arg2
                } else {
                    false
                }
            } else {
                false
            };
            if (v10) {
                let v11 = *0x1::option::borrow<u64>(&v7);
                v7 = 0x2::table::borrow<u64, Node>(&arg0.sorted, v11).next;
                v8 = v8 + 1;
                let v12 = 0x2::table::borrow_mut<u64, Position<T0>>(&mut arg0.positions, v11);
                if ((0x2::balance::value<T0>(&v12.collateral) as u256) < asset_to_collateral_up(v12.debt, v4, v1, v2)) {
                    continue
                };
                let v13 = 0x1::u64::min(v5, v12.debt);
                let v14 = v13;
                if (v13 < v12.debt && v12.debt - v13 < v3) {
                    if (v12.debt <= v3) {
                        break
                    };
                    v14 = v12.debt - v3;
                };
                let v15 = (asset_to_collateral_down(v14, v4, v1, v2) as u64);
                v12.debt = v12.debt - v14;
                0x2::balance::join<T0>(&mut v6, 0x2::balance::split<T0>(&mut v12.collateral, v15));
                v5 = v5 - v14;
                let v16 = v12.debt;
                let v17 = Redeemed{
                    market_id        : v0,
                    position_id      : v11,
                    amount           : v14,
                    collateral_taken : v15,
                    price            : v4,
                    collateral       : 0x2::balance::value<T0>(&v12.collateral),
                    debt             : v16,
                };
                0x2::event::emit<Redeemed>(v17);
                if (v16 == 0) {
                    let (_, _) = list_remove<T0, T1>(arg0, v11);
                } else {
                    v9 = 0x1::option::some<u64>(v11);
                    break
                };
            } else {
                break
            };
        };
        let v20 = 0x2::coin::value<T1>(&arg1) - v5;
        assert!(v20 > 0 && 0x2::balance::value<T0>(&v6) > 0, 13);
        arg0.total_debt = arg0.total_debt - v20;
        0x2::coin::burn<T1>(&mut arg0.treasury_cap, 0x2::coin::split<T1>(&mut arg1, v20, arg5));
        if (0x1::option::is_some<u64>(&v9)) {
            resort<T0, T1>(arg0, 0x1::option::destroy_some<u64>(v9), arg3);
        };
        let v21 = (div_up((0x2::balance::value<T0>(&v6) as u256) * (arg0.redeem_fee_bps as u256), 10000) as u64);
        0x2::balance::join<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut v6, v21));
        let v22 = Redemption{
            market_id      : v0,
            redeemer       : 0x2::tx_context::sender(arg5),
            amount         : v20,
            collateral_out : 0x2::balance::value<T0>(&v6),
            fee            : v21,
            price          : v4,
        };
        0x2::event::emit<Redemption>(v22);
        (0x2::coin::from_balance<T0>(v6, arg5), arg1)
    }

    public fun redemption_params<T0, T1>(arg0: &Market<T0, T1>) : (u64, u64) {
        (arg0.redeem_fee_bps, arg0.min_debt)
    }

    fun resort<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64, arg2: 0x1::option::Option<u64>) {
        let (v0, v1) = list_remove<T0, T1>(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        if (0x2::table::borrow<u64, Position<T0>>(&arg0.positions, arg1).debt == 0) {
            return
        };
        let v4 = if (0x1::option::is_some<u64>(&arg2) && 0x2::table::contains<u64, Node>(&arg0.sorted, *0x1::option::borrow<u64>(&arg2))) {
            arg2
        } else if (0x1::option::is_some<u64>(&v3)) {
            v3
        } else if (0x1::option::is_some<u64>(&v2)) {
            v2
        } else {
            arg0.head
        };
        list_insert<T0, T1>(arg0, arg1, v4);
    }

    public fun set_index_feed<T0, T1>(arg0: &AdminCap, arg1: &mut Market<T0, T1>, arg2: 0x2::object::ID) {
        assert_version<T0, T1>(arg1);
        let v0 = IndexFeedKey{dummy_field: false};
        if (0x2::dynamic_field::exists<IndexFeedKey>(&arg1.id, v0)) {
            let v1 = IndexFeedKey{dummy_field: false};
            0x2::dynamic_field::remove<IndexFeedKey, IndexFeed>(&mut arg1.id, v1);
        };
        let v2 = IndexFeedKey{dummy_field: false};
        let v3 = IndexFeed{venue: arg2};
        0x2::dynamic_field::add<IndexFeedKey, IndexFeed>(&mut arg1.id, v2, v3);
        let v4 = IndexFeedChanged{
            market_id : 0x2::object::id<Market<T0, T1>>(arg1),
            venue     : 0x1::option::some<0x2::object::ID>(arg2),
        };
        0x2::event::emit<IndexFeedChanged>(v4);
    }

    public fun set_params<T0, T1>(arg0: &AdminCap, arg1: &mut Market<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        assert_version<T0, T1>(arg1);
        check_params(arg2, arg3, arg4, arg6);
        arg1.min_cr_bps = arg2;
        arg1.liquidation_discount_bps = arg3;
        arg1.mint_fee_bps = arg4;
        arg1.max_price_age_secs = arg5;
        arg1.max_conf_bps = arg6;
        arg1.debt_ceiling = arg7;
    }

    public fun set_paused<T0, T1>(arg0: &AdminCap, arg1: &mut Market<T0, T1>, arg2: bool) {
        assert_version<T0, T1>(arg1);
        arg1.paused = arg2;
    }

    public fun set_redemption_params<T0, T1>(arg0: &AdminCap, arg1: &mut Market<T0, T1>, arg2: u64, arg3: u64) {
        assert_version<T0, T1>(arg1);
        assert!(arg2 <= 1000, 8);
        arg1.redeem_fee_bps = arg2;
        arg1.min_debt = arg3;
    }

    public fun sorted_contains<T0, T1>(arg0: &Market<T0, T1>, arg1: u64) : bool {
        0x2::table::contains<u64, Node>(&arg0.sorted, arg1)
    }

    public fun sorted_head<T0, T1>(arg0: &Market<T0, T1>) : 0x1::option::Option<u64> {
        arg0.head
    }

    public fun sorted_length<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        0x2::table::length<u64, Node>(&arg0.sorted)
    }

    public fun sorted_links<T0, T1>(arg0: &Market<T0, T1>, arg1: u64) : (0x1::option::Option<u64>, 0x1::option::Option<u64>) {
        let v0 = 0x2::table::borrow<u64, Node>(&arg0.sorted, arg1);
        (v0.prev, v0.next)
    }

    public fun sorted_tail<T0, T1>(arg0: &Market<T0, T1>) : 0x1::option::Option<u64> {
        arg0.tail
    }

    public fun total_debt<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.total_debt
    }

    public fun version<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.version
    }

    public fun withdraw<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &PositionCap, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0, T1>(arg0);
        check_cap<T0, T1>(arg0, arg1);
        if (0x2::table::borrow<u64, Position<T0>>(&arg0.positions, arg1.position_id).debt > 0) {
            let v1 = read_price<T0, T1>(arg0, arg4, arg5);
            do_withdraw<T0, T1>(arg0, arg1, arg2, 0xbeb5b717de8776dba25c6ccab7a012e3769ba6bd7fbcc652b9550f2e94cf86d9::oracle::price_high(&v1), arg3, arg6)
        } else {
            do_withdraw<T0, T1>(arg0, arg1, arg2, 0, arg3, arg6)
        }
    }

    public fun withdraw_fees<T0, T1>(arg0: &AdminCap, arg1: &mut Market<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0, T1>(arg1);
        0x2::coin::take<T0>(&mut arg1.fees, 0x2::balance::value<T0>(&arg1.fees), arg2)
    }

    public fun withdraw_index<T0, T1, T2>(arg0: &mut Market<T0, T1>, arg1: &PositionCap, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0, T1>(arg0);
        check_cap<T0, T1>(arg0, arg1);
        if (0x2::table::borrow<u64, Position<T0>>(&arg0.positions, arg1.position_id).debt > 0) {
            let v1 = read_index<T0, T1, T2>(arg0, arg4, arg5, arg6);
            do_withdraw<T0, T1>(arg0, arg1, arg2, 0xbeb5b717de8776dba25c6ccab7a012e3769ba6bd7fbcc652b9550f2e94cf86d9::oracle::price_high(&v1), arg3, arg7)
        } else {
            do_withdraw<T0, T1>(arg0, arg1, arg2, 0, arg3, arg7)
        }
    }

    public(friend) fun withdraw_with_price<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &PositionCap, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: &0xbeb5b717de8776dba25c6ccab7a012e3769ba6bd7fbcc652b9550f2e94cf86d9::oracle::OraclePrice, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        do_withdraw<T0, T1>(arg0, arg1, arg2, 0xbeb5b717de8776dba25c6ccab7a012e3769ba6bd7fbcc652b9550f2e94cf86d9::oracle::price_high(arg4), arg3, arg5)
    }

    // decompiled from Move bytecode v7
}

