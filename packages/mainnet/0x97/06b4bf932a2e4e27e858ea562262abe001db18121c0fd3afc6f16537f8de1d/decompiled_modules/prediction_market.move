module 0x9706b4bf932a2e4e27e858ea562262abe001db18121c0fd3afc6f16537f8de1d::prediction_market {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PredictionMarket has key {
        id: 0x2::object::UID,
        match_id: vector<u8>,
        home_team: 0x1::string::String,
        away_team: 0x1::string::String,
        kickoff_ms: u64,
        home_odds_wad: u64,
        away_odds_wad: u64,
        result: u8,
        blob_id: vector<u8>,
    }

    struct MarketCreated has copy, drop {
        market_id: 0x2::object::ID,
        match_id: vector<u8>,
        home_team: 0x1::string::String,
        away_team: 0x1::string::String,
        kickoff_ms: u64,
        home_odds_wad: u64,
        away_odds_wad: u64,
    }

    struct OddsUpdated has copy, drop {
        market_id: 0x2::object::ID,
        home_odds_wad: u64,
        away_odds_wad: u64,
    }

    struct MarketResolved has copy, drop {
        market_id: 0x2::object::ID,
        match_id: vector<u8>,
        result: u8,
    }

    public fun away_team(arg0: &PredictionMarket) : &0x1::string::String {
        &arg0.away_team
    }

    public entry fun create_market(arg0: &AdminCap, arg1: vector<u8>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 > 0 && arg5 < 1000000000, 2);
        assert!(arg6 > 0 && arg6 < 1000000000, 2);
        let v0 = PredictionMarket{
            id            : 0x2::object::new(arg8),
            match_id      : arg1,
            home_team     : arg2,
            away_team     : arg3,
            kickoff_ms    : arg4,
            home_odds_wad : arg5,
            away_odds_wad : arg6,
            result        : 0,
            blob_id       : arg7,
        };
        let v1 = MarketCreated{
            market_id     : 0x2::object::id<PredictionMarket>(&v0),
            match_id      : v0.match_id,
            home_team     : v0.home_team,
            away_team     : v0.away_team,
            kickoff_ms    : v0.kickoff_ms,
            home_odds_wad : v0.home_odds_wad,
            away_odds_wad : v0.away_odds_wad,
        };
        0x2::event::emit<MarketCreated>(v1);
        0x2::transfer::share_object<PredictionMarket>(v0);
    }

    public fun home_team(arg0: &PredictionMarket) : &0x1::string::String {
        &arg0.home_team
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_resolved(arg0: &PredictionMarket) : bool {
        arg0.result != 0
    }

    public fun is_unresolved(arg0: &PredictionMarket) : bool {
        arg0.result == 0
    }

    public fun kickoff_ms(arg0: &PredictionMarket) : u64 {
        arg0.kickoff_ms
    }

    public fun outcome_away() : u8 {
        2
    }

    public fun outcome_home() : u8 {
        1
    }

    public fun price_of(arg0: &PredictionMarket, arg1: u8) : u64 {
        assert!(arg1 == 1 || arg1 == 2, 3);
        if (arg1 == 1) {
            arg0.home_odds_wad
        } else {
            arg0.away_odds_wad
        }
    }

    public entry fun resolve_market(arg0: &AdminCap, arg1: &mut PredictionMarket, arg2: u8) {
        assert!(arg1.result == 0, 0);
        assert!(arg2 >= 1 && arg2 <= 3, 1);
        arg1.result = arg2;
        let v0 = MarketResolved{
            market_id : 0x2::object::id<PredictionMarket>(arg1),
            match_id  : arg1.match_id,
            result    : arg2,
        };
        0x2::event::emit<MarketResolved>(v0);
    }

    public fun result(arg0: &PredictionMarket) : u8 {
        arg0.result
    }

    public entry fun update_odds(arg0: &AdminCap, arg1: &mut PredictionMarket, arg2: u64, arg3: u64) {
        assert!(arg1.result == 0, 0);
        assert!(arg2 > 0 && arg2 < 1000000000, 2);
        assert!(arg3 > 0 && arg3 < 1000000000, 2);
        arg1.home_odds_wad = arg2;
        arg1.away_odds_wad = arg3;
        let v0 = OddsUpdated{
            market_id     : 0x2::object::id<PredictionMarket>(arg1),
            home_odds_wad : arg2,
            away_odds_wad : arg3,
        };
        0x2::event::emit<OddsUpdated>(v0);
    }

    public fun wad() : u64 {
        1000000000
    }

    // decompiled from Move bytecode v7
}

