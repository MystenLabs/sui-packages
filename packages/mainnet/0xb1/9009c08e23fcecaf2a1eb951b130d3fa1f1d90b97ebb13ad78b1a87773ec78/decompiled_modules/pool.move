module 0xb19009c08e23fcecaf2a1eb951b130d3fa1f1d90b97ebb13ad78b1a87773ec78::pool {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OracleCap has store, key {
        id: 0x2::object::UID,
    }

    struct BettingPool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_volume: u64,
        total_bets: u64,
        predictions: 0x2::table::Table<0x2::object::ID, Prediction>,
        paused: bool,
        fee_bps: u64,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_collected: u64,
        total_withdrawn: u64,
    }

    struct Prediction has drop, store {
        external_id: 0x1::string::String,
        timeframe: 0x1::string::String,
        direction: u8,
        confidence: u8,
        price_at_prediction: u64,
        target_price: u64,
        created_at: u64,
        resolves_at: u64,
        resolved: bool,
        actual_direction: u8,
        actual_price: u64,
        agree_volume: u64,
        disagree_volume: u64,
    }

    struct Bet has store, key {
        id: 0x2::object::UID,
        bettor: address,
        prediction_id: 0x2::object::ID,
        external_prediction_id: 0x1::string::String,
        position: bool,
        amount: u64,
        user_tier: u8,
        created_at: u64,
        resolved: bool,
        won: bool,
        payout: u64,
        fee_paid: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
    }

    struct PredictionCreated has copy, drop {
        prediction_id: 0x2::object::ID,
        external_id: 0x1::string::String,
        timeframe: 0x1::string::String,
        direction: u8,
        resolves_at: u64,
    }

    struct BetPlaced has copy, drop {
        bet_id: 0x2::object::ID,
        prediction_id: 0x2::object::ID,
        bettor: address,
        position: bool,
        amount: u64,
    }

    struct BetResolved has copy, drop {
        bet_id: 0x2::object::ID,
        bettor: address,
        won: bool,
        payout: u64,
        fee_paid: u64,
    }

    struct PredictionResolved has copy, drop {
        prediction_id: 0x2::object::ID,
        actual_direction: u8,
        actual_price: u64,
    }

    struct TreasuryWithdrawal has copy, drop {
        amount: u64,
        recipient: address,
    }

    public entry fun create_prediction(arg0: &OracleCap, arg1: &mut BettingPool, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 8);
        let v0 = Prediction{
            external_id         : 0x1::string::utf8(arg2),
            timeframe           : 0x1::string::utf8(arg3),
            direction           : arg4,
            confidence          : arg5,
            price_at_prediction : arg6,
            target_price        : arg7,
            created_at          : 0x2::clock::timestamp_ms(arg9),
            resolves_at         : arg8,
            resolved            : false,
            actual_direction    : 0,
            actual_price        : 0,
            agree_volume        : 0,
            disagree_volume     : 0,
        };
        let v1 = 0x2::object::new(arg10);
        let v2 = 0x2::object::uid_to_inner(&v1);
        0x2::object::delete(v1);
        let v3 = PredictionCreated{
            prediction_id : v2,
            external_id   : 0x1::string::utf8(arg2),
            timeframe     : 0x1::string::utf8(arg3),
            direction     : arg4,
            resolves_at   : arg8,
        };
        0x2::event::emit<PredictionCreated>(v3);
        0x2::table::add<0x2::object::ID, Prediction>(&mut arg1.predictions, v2, v0);
    }

    public entry fun emergency_withdraw(arg0: &AdminCap, arg1: &mut BettingPool, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.paused = true;
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v0), arg3), arg2);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = OracleCap{id: 0x2::object::new(arg0)};
        let v2 = BettingPool{
            id           : 0x2::object::new(arg0),
            balance      : 0x2::balance::zero<0x2::sui::SUI>(),
            total_volume : 0,
            total_bets   : 0,
            predictions  : 0x2::table::new<0x2::object::ID, Prediction>(arg0),
            paused       : false,
            fee_bps      : 250,
        };
        let v3 = Treasury{
            id              : 0x2::object::new(arg0),
            balance         : 0x2::balance::zero<0x2::sui::SUI>(),
            total_collected : 0,
            total_withdrawn : 0,
        };
        let v4 = PoolCreated{
            pool_id     : 0x2::object::id<BettingPool>(&v2),
            treasury_id : 0x2::object::id<Treasury>(&v3),
        };
        0x2::event::emit<PoolCreated>(v4);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<OracleCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<BettingPool>(v2);
        0x2::transfer::share_object<Treasury>(v3);
    }

    public entry fun place_bet(arg0: &mut BettingPool, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: bool, arg4: u8, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 8);
        assert!(0x2::table::contains<0x2::object::ID, Prediction>(&arg0.predictions, arg1), 4);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Prediction>(&mut arg0.predictions, arg1);
        assert!(!v0.resolved, 5);
        assert!(0x2::clock::timestamp_ms(arg6) < v0.resolves_at, 5);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        assert!(v1 >= 100000000, 2);
        let v2 = if (arg4 == 2) {
            1000000000000
        } else if (arg4 == 1) {
            100000000000
        } else {
            10000000000
        };
        assert!(v1 <= v2, 3);
        if (arg3) {
            v0.agree_volume = v0.agree_volume + v1;
        } else {
            v0.disagree_volume = v0.disagree_volume + v1;
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg5));
        arg0.total_volume = arg0.total_volume + v1;
        arg0.total_bets = arg0.total_bets + 1;
        let v3 = Bet{
            id                     : 0x2::object::new(arg7),
            bettor                 : 0x2::tx_context::sender(arg7),
            prediction_id          : arg1,
            external_prediction_id : 0x1::string::utf8(arg2),
            position               : arg3,
            amount                 : v1,
            user_tier              : arg4,
            created_at             : 0x2::clock::timestamp_ms(arg6),
            resolved               : false,
            won                    : false,
            payout                 : 0,
            fee_paid               : 0,
        };
        let v4 = BetPlaced{
            bet_id        : 0x2::object::id<Bet>(&v3),
            prediction_id : arg1,
            bettor        : 0x2::tx_context::sender(arg7),
            position      : arg3,
            amount        : v1,
        };
        0x2::event::emit<BetPlaced>(v4);
        0x2::transfer::transfer<Bet>(v3, 0x2::tx_context::sender(arg7));
    }

    public fun pool_stats(arg0: &BettingPool) : (u64, u64, u64, bool, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.balance), arg0.total_volume, arg0.total_bets, arg0.paused, arg0.fee_bps)
    }

    public fun prediction_exists(arg0: &BettingPool, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, Prediction>(&arg0.predictions, arg1)
    }

    public entry fun resolve_bet(arg0: &OracleCap, arg1: &mut BettingPool, arg2: &mut Treasury, arg3: Bet, arg4: &mut 0x2::tx_context::TxContext) {
        let Bet {
            id                     : v0,
            bettor                 : v1,
            prediction_id          : v2,
            external_prediction_id : _,
            position               : v4,
            amount                 : v5,
            user_tier              : _,
            created_at             : _,
            resolved               : v8,
            won                    : _,
            payout                 : _,
            fee_paid               : _,
        } = arg3;
        let v12 = v0;
        assert!(!v8, 7);
        assert!(0x2::table::contains<0x2::object::ID, Prediction>(&arg1.predictions, v2), 4);
        let v13 = 0x2::table::borrow<0x2::object::ID, Prediction>(&arg1.predictions, v2);
        assert!(v13.resolved, 6);
        let v14 = v13.direction == v13.actual_direction;
        let v15 = v4 && v14 || !v4 && !v14;
        let (v16, v17) = if (v15) {
            let v18 = v5 * 2;
            let v19 = v18 * arg1.fee_bps / 10000;
            let v20 = v18 - v19;
            0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v19));
            arg2.total_collected = arg2.total_collected + v19;
            assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.balance) >= v20, 9);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v20), arg4), v1);
            (v20, v19)
        } else {
            (0, 0)
        };
        let v21 = BetResolved{
            bet_id   : 0x2::object::uid_to_inner(&v12),
            bettor   : v1,
            won      : v15,
            payout   : v16,
            fee_paid : v17,
        };
        0x2::event::emit<BetResolved>(v21);
        0x2::object::delete(v12);
    }

    public entry fun resolve_prediction(arg0: &OracleCap, arg1: &mut BettingPool, arg2: 0x2::object::ID, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock) {
        assert!(0x2::table::contains<0x2::object::ID, Prediction>(&arg1.predictions, arg2), 4);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Prediction>(&mut arg1.predictions, arg2);
        assert!(!v0.resolved, 7);
        v0.resolved = true;
        v0.actual_direction = arg3;
        v0.actual_price = arg4;
        let v1 = PredictionResolved{
            prediction_id    : arg2,
            actual_direction : arg3,
            actual_price     : arg4,
        };
        0x2::event::emit<PredictionResolved>(v1);
    }

    public entry fun set_fee(arg0: &AdminCap, arg1: &mut BettingPool, arg2: u64) {
        assert!(arg2 <= 1000, 4);
        arg1.fee_bps = arg2;
    }

    public entry fun set_paused(arg0: &AdminCap, arg1: &mut BettingPool, arg2: bool) {
        arg1.paused = arg2;
    }

    public fun treasury_stats(arg0: &Treasury) : (u64, u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.balance), arg0.total_collected, arg0.total_withdrawn)
    }

    public entry fun withdraw_treasury(arg0: &AdminCap, arg1: &mut Treasury, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.balance) >= arg2, 9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, arg2), arg4), arg3);
        arg1.total_withdrawn = arg1.total_withdrawn + arg2;
        let v0 = TreasuryWithdrawal{
            amount    : arg2,
            recipient : arg3,
        };
        0x2::event::emit<TreasuryWithdrawal>(v0);
    }

    // decompiled from Move bytecode v6
}

