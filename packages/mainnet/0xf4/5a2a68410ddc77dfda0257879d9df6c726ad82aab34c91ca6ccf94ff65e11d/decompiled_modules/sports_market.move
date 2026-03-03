module 0xf45a2a68410ddc77dfda0257879d9df6c726ad82aab34c91ca6ccf94ff65e11d::sports_market {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        market_count: u64,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        recipient: address,
    }

    struct SportsMarket has store, key {
        id: 0x2::object::UID,
        game_id: vector<u8>,
        league: vector<u8>,
        home_team: vector<u8>,
        away_team: vector<u8>,
        question: vector<u8>,
        created_at_ms: u64,
        starts_at_ms: u64,
        closes_at_ms: u64,
        virtual_yes: u64,
        virtual_no: u64,
        k_scaled: u64,
        yes_shares_sold: u64,
        no_shares_sold: u64,
        usdc_pool: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        outcome: u8,
        resolved_at_ms: u64,
        treasury_id: 0x2::object::ID,
    }

    struct Position has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        side: u8,
        shares: u64,
        avg_cost_usdc: u64,
    }

    struct MarketCreated has copy, drop {
        market_id: 0x2::object::ID,
        game_id: vector<u8>,
        league: vector<u8>,
        home_team: vector<u8>,
        away_team: vector<u8>,
        question: vector<u8>,
        starts_at_ms: u64,
        closes_at_ms: u64,
        initial_yes_price_bps: u64,
        timestamp_ms: u64,
    }

    struct SharesBought has copy, drop {
        market_id: 0x2::object::ID,
        buyer: address,
        side: u8,
        shares: u64,
        usdc_spent: u64,
        yes_price_bps: u64,
        no_price_bps: u64,
        timestamp_ms: u64,
    }

    struct SharesSold has copy, drop {
        market_id: 0x2::object::ID,
        seller: address,
        side: u8,
        shares: u64,
        usdc_received: u64,
        yes_price_bps: u64,
        no_price_bps: u64,
        timestamp_ms: u64,
    }

    struct MarketResolved has copy, drop {
        market_id: 0x2::object::ID,
        outcome: u8,
        yes_shares: u64,
        no_shares: u64,
        pool_usdc: u64,
        admin_fee: u64,
        timestamp_ms: u64,
    }

    struct MarketCancelled has copy, drop {
        market_id: 0x2::object::ID,
        reason: vector<u8>,
        timestamp_ms: u64,
    }

    struct WinningsClaimed has copy, drop {
        market_id: 0x2::object::ID,
        claimer: address,
        shares: u64,
        payout: u64,
        timestamp_ms: u64,
    }

    struct RefundClaimed has copy, drop {
        market_id: 0x2::object::ID,
        claimer: address,
        side: u8,
        shares: u64,
        refund_usdc: u64,
        timestamp_ms: u64,
    }

    struct TreasuryWithdrawn has copy, drop {
        recipient: address,
        amount: u64,
        timestamp_ms: u64,
    }

    public entry fun buy_no(arg0: &mut SportsMarket, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        buy_shares(arg0, 2, arg1, arg2, arg3, arg4);
    }

    fun buy_shares(arg0: &mut SportsMarket, arg1: u8, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg0.outcome == 0, 3004);
        assert!(v0 < arg0.closes_at_ms, 3002);
        let v1 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg2);
        assert!(v1 >= 10000, 3007);
        let v2 = if (arg1 == 1) {
            let v3 = arg0.virtual_no + v1;
            let v4 = div_scaled(arg0.k_scaled, v3);
            assert!(arg0.virtual_yes > v4, 3012);
            let v5 = arg0.virtual_yes - v4;
            arg0.virtual_yes = v4;
            arg0.virtual_no = v3;
            arg0.yes_shares_sold = arg0.yes_shares_sold + v5;
            v5
        } else {
            let v6 = arg0.virtual_yes + v1;
            let v7 = div_scaled(arg0.k_scaled, v6);
            assert!(arg0.virtual_no > v7, 3012);
            let v8 = arg0.virtual_no - v7;
            arg0.virtual_yes = v6;
            arg0.virtual_no = v7;
            arg0.no_shares_sold = arg0.no_shares_sold + v8;
            v8
        };
        assert!(v2 >= arg3, 3011);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_pool, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2));
        let v9 = 0x2::tx_context::sender(arg5);
        let (v10, v11) = current_prices(arg0);
        let v12 = SharesBought{
            market_id     : 0x2::object::uid_to_inner(&arg0.id),
            buyer         : v9,
            side          : arg1,
            shares        : v2,
            usdc_spent    : v1,
            yes_price_bps : v10,
            no_price_bps  : v11,
            timestamp_ms  : v0,
        };
        0x2::event::emit<SharesBought>(v12);
        let v13 = Position{
            id            : 0x2::object::new(arg5),
            market_id     : 0x2::object::uid_to_inner(&arg0.id),
            side          : arg1,
            shares        : v2,
            avg_cost_usdc : v1,
        };
        0x2::transfer::transfer<Position>(v13, v9);
    }

    public entry fun buy_yes(arg0: &mut SportsMarket, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        buy_shares(arg0, 1, arg1, arg2, arg3, arg4);
    }

    public entry fun cancel_market(arg0: &AdminCap, arg1: &mut SportsMarket, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.outcome == 0, 3004);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg1.outcome = 3;
        arg1.resolved_at_ms = v0;
        let v1 = MarketCancelled{
            market_id    : 0x2::object::uid_to_inner(&arg1.id),
            reason       : copy_bytes(&arg2),
            timestamp_ms : v0,
        };
        0x2::event::emit<MarketCancelled>(v1);
    }

    public entry fun claim_winnings(arg0: &mut SportsMarket, arg1: Position, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.outcome != 0, 3005);
        let Position {
            id            : v0,
            market_id     : v1,
            side          : v2,
            shares        : v3,
            avg_cost_usdc : _,
        } = arg1;
        assert!(v1 == 0x2::object::uid_to_inner(&arg0.id), 3009);
        let v5 = 0x2::tx_context::sender(arg3);
        if (arg0.outcome == 3) {
            let v6 = estimate_void_refund(arg0, v3);
            assert!(v6 > 0, 3007);
            assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.usdc_pool) >= v6, 3012);
            let v7 = RefundClaimed{
                market_id    : 0x2::object::uid_to_inner(&arg0.id),
                claimer      : v5,
                side         : v2,
                shares       : v3,
                refund_usdc  : v6,
                timestamp_ms : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<RefundClaimed>(v7);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_pool, v6), arg3), v5);
            0x2::object::delete(v0);
            return
        };
        let v8 = if (arg0.outcome == 1) {
            1
        } else {
            2
        };
        assert!(v2 == v8, 3016);
        let v9 = if (v8 == 1) {
            arg0.yes_shares_sold
        } else {
            arg0.no_shares_sold
        };
        assert!(v9 > 0, 3012);
        let v10 = mul_div_safe(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.usdc_pool), v3, v9);
        assert!(v10 > 0, 3007);
        let v11 = WinningsClaimed{
            market_id    : 0x2::object::uid_to_inner(&arg0.id),
            claimer      : v5,
            shares       : v3,
            payout       : v10,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<WinningsClaimed>(v11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_pool, v10), arg3), v5);
        0x2::object::delete(v0);
    }

    public entry fun close_empty_position(arg0: Position, arg1: &mut 0x2::tx_context::TxContext) {
        let Position {
            id            : v0,
            market_id     : _,
            side          : _,
            shares        : v3,
            avg_cost_usdc : _,
        } = arg0;
        assert!(v3 == 0, 3010);
        0x2::object::delete(v0);
    }

    fun copy_bytes(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun create_sports_market(arg0: &AdminCap, arg1: &mut Registry, arg2: &Treasury, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: u64, arg10: u64, arg11: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg12);
        assert!(arg9 > v0, 3002);
        assert!(arg10 >= 100 && arg10 <= 9900, 3008);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg11) >= 100000 * 2, 3013);
        let v1 = 100 * 1000000;
        let v2 = arg10 * v1 / 10000;
        let v3 = v1 - v2;
        let v4 = SportsMarket{
            id              : 0x2::object::new(arg13),
            game_id         : arg3,
            league          : arg4,
            home_team       : arg5,
            away_team       : arg6,
            question        : arg7,
            created_at_ms   : v0,
            starts_at_ms    : arg8,
            closes_at_ms    : arg9,
            virtual_yes     : v3,
            virtual_no      : v2,
            k_scaled        : mul128_scaled(v3, v2),
            yes_shares_sold : 0,
            no_shares_sold  : 0,
            usdc_pool       : 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg11),
            outcome         : 0,
            resolved_at_ms  : 0,
            treasury_id     : 0x2::object::uid_to_inner(&arg2.id),
        };
        let v5 = MarketCreated{
            market_id             : 0x2::object::uid_to_inner(&v4.id),
            game_id               : copy_bytes(&arg3),
            league                : copy_bytes(&arg4),
            home_team             : copy_bytes(&arg5),
            away_team             : copy_bytes(&arg6),
            question              : copy_bytes(&arg7),
            starts_at_ms          : arg8,
            closes_at_ms          : arg9,
            initial_yes_price_bps : arg10,
            timestamp_ms          : v0,
        };
        0x2::event::emit<MarketCreated>(v5);
        arg1.market_count = arg1.market_count + 1;
        0x2::transfer::share_object<SportsMarket>(v4);
    }

    fun current_prices(arg0: &SportsMarket) : (u64, u64) {
        let v0 = arg0.virtual_yes + arg0.virtual_no;
        if (v0 == 0) {
            return (5000, 5000)
        };
        let v1 = (((arg0.virtual_no as u128) * 10000 / (v0 as u128)) as u64);
        (v1, 10000 - v1)
    }

    fun div_scaled(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (1000000 as u128) / (arg1 as u128)) as u64)
    }

    fun estimate_void_refund(arg0: &SportsMarket, arg1: u64) : u64 {
        let v0 = arg0.yes_shares_sold + arg0.no_shares_sold;
        if (v0 == 0) {
            return 0
        };
        mul_div_safe(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.usdc_pool), arg1, v0)
    }

    public fun get_closes_at(arg0: &SportsMarket) : u64 {
        arg0.closes_at_ms
    }

    public fun get_outcome(arg0: &SportsMarket) : u8 {
        arg0.outcome
    }

    public fun get_pool_usdc(arg0: &SportsMarket) : u64 {
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.usdc_pool)
    }

    public fun get_prices(arg0: &SportsMarket) : (u64, u64) {
        current_prices(arg0)
    }

    public fun get_shares_sold(arg0: &SportsMarket) : (u64, u64) {
        (arg0.yes_shares_sold, arg0.no_shares_sold)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Registry{
            id           : 0x2::object::new(arg0),
            market_count : 0,
        };
        0x2::transfer::share_object<Registry>(v1);
        let v2 = Treasury{
            id        : 0x2::object::new(arg0),
            balance   : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            recipient : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Treasury>(v2);
    }

    public fun market_id(arg0: &SportsMarket) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun mul128_scaled(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (1000000 as u128)) as u64)
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    fun mul_div_safe(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun quote_buy_no(arg0: &SportsMarket, arg1: u64) : u64 {
        let v0 = div_scaled(arg0.k_scaled, arg0.virtual_yes + arg1);
        if (arg0.virtual_no > v0) {
            arg0.virtual_no - v0
        } else {
            0
        }
    }

    public fun quote_buy_yes(arg0: &SportsMarket, arg1: u64) : u64 {
        let v0 = div_scaled(arg0.k_scaled, arg0.virtual_no + arg1);
        if (arg0.virtual_yes > v0) {
            arg0.virtual_yes - v0
        } else {
            0
        }
    }

    public fun quote_sell_no(arg0: &SportsMarket, arg1: u64) : u64 {
        let v0 = div_scaled(arg0.k_scaled, arg0.virtual_no + arg1);
        if (arg0.virtual_yes > v0) {
            arg0.virtual_yes - v0
        } else {
            0
        }
    }

    public fun quote_sell_yes(arg0: &SportsMarket, arg1: u64) : u64 {
        let v0 = div_scaled(arg0.k_scaled, arg0.virtual_yes + arg1);
        if (arg0.virtual_no > v0) {
            arg0.virtual_no - v0
        } else {
            0
        }
    }

    public entry fun resolve_market(arg0: &AdminCap, arg1: &mut SportsMarket, arg2: &mut Treasury, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.outcome == 0, 3004);
        let v0 = if (arg3 == 1) {
            true
        } else if (arg3 == 2) {
            true
        } else {
            arg3 == 3
        };
        assert!(v0, 3008);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(v1 >= arg1.closes_at_ms, 3003);
        let v2 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1.usdc_pool);
        let v3 = if (arg3 != 3) {
            let v4 = mul_div(v2, 100, 10000);
            if (v4 > 0) {
                0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg2.balance, 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.usdc_pool, v4));
            };
            v4
        } else {
            0
        };
        arg1.outcome = arg3;
        arg1.resolved_at_ms = v1;
        let v5 = MarketResolved{
            market_id    : 0x2::object::uid_to_inner(&arg1.id),
            outcome      : arg3,
            yes_shares   : arg1.yes_shares_sold,
            no_shares    : arg1.no_shares_sold,
            pool_usdc    : v2,
            admin_fee    : v3,
            timestamp_ms : v1,
        };
        0x2::event::emit<MarketResolved>(v5);
    }

    public entry fun sell_no(arg0: &mut SportsMarket, arg1: &mut Position, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        sell_shares(arg0, arg1, 2, arg2, arg3, arg4, arg5);
    }

    fun sell_shares(arg0: &mut SportsMarket, arg1: &mut Position, arg2: u8, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg0.outcome == 0, 3004);
        assert!(v0 < arg0.closes_at_ms, 3002);
        assert!(arg1.market_id == 0x2::object::uid_to_inner(&arg0.id), 3009);
        assert!(arg1.side == arg2, 3016);
        assert!(arg3 > 0 && arg3 <= arg1.shares, 3010);
        let v1 = if (arg2 == 1) {
            let v2 = arg0.virtual_yes + arg3;
            let v3 = div_scaled(arg0.k_scaled, v2);
            assert!(arg0.virtual_no > v3, 3012);
            arg0.virtual_yes = v2;
            arg0.virtual_no = v3;
            arg0.yes_shares_sold = arg0.yes_shares_sold - arg3;
            arg0.virtual_no - v3
        } else {
            let v4 = arg0.virtual_no + arg3;
            let v5 = div_scaled(arg0.k_scaled, v4);
            assert!(arg0.virtual_yes > v5, 3012);
            arg0.virtual_yes = v5;
            arg0.virtual_no = v4;
            arg0.no_shares_sold = arg0.no_shares_sold - arg3;
            arg0.virtual_yes - v5
        };
        assert!(v1 >= arg4, 3011);
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.usdc_pool) >= v1, 3012);
        arg1.shares = arg1.shares - arg3;
        let v6 = 0x2::tx_context::sender(arg6);
        let (v7, v8) = current_prices(arg0);
        let v9 = SharesSold{
            market_id     : 0x2::object::uid_to_inner(&arg0.id),
            seller        : v6,
            side          : arg2,
            shares        : arg3,
            usdc_received : v1,
            yes_price_bps : v7,
            no_price_bps  : v8,
            timestamp_ms  : v0,
        };
        0x2::event::emit<SharesSold>(v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_pool, v1), arg6), v6);
    }

    public entry fun sell_yes(arg0: &mut SportsMarket, arg1: &mut Position, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        sell_shares(arg0, arg1, 1, arg2, arg3, arg4, arg5);
    }

    public entry fun set_treasury_recipient(arg0: &AdminCap, arg1: &mut Treasury, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.recipient = arg2;
    }

    public entry fun withdraw_fees(arg0: &AdminCap, arg1: &mut Treasury, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1.balance);
        assert!(v0 > 0, 3007);
        let v1 = TreasuryWithdrawn{
            recipient    : arg1.recipient,
            amount       : v0,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TreasuryWithdrawn>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.balance, v0), arg3), arg1.recipient);
    }

    // decompiled from Move bytecode v6
}

