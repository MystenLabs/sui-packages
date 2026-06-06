module 0xad471473d17d0a80b37df9347c0fcd7f8a67623f969628851881506e7e76652e::pundit {
    struct OracleCap has store, key {
        id: 0x2::object::UID,
    }

    struct Stats has copy, drop, store {
        made: u64,
        resolved: u64,
        correct: u64,
    }

    struct Board has key {
        id: 0x2::object::UID,
        results: 0x2::table::Table<0x1::string::String, u8>,
        stats: 0x2::table::Table<address, Stats>,
        total_predictions: u64,
        total_pundits: u64,
    }

    struct Prediction has store, key {
        id: 0x2::object::UID,
        predictor: address,
        match_id: 0x1::string::String,
        outcome: u8,
        subject: 0x1::string::String,
        blob_id: 0x1::string::String,
        created_at_ms: u64,
        settled: bool,
        correct: bool,
    }

    struct PredictionMade has copy, drop {
        prediction_id: 0x2::object::ID,
        predictor: address,
        match_id: 0x1::string::String,
        outcome: u8,
        subject: 0x1::string::String,
        blob_id: 0x1::string::String,
        created_at_ms: u64,
    }

    struct ResultSet has copy, drop {
        match_id: 0x1::string::String,
        result: u8,
    }

    struct PredictionSettled has copy, drop {
        prediction_id: 0x2::object::ID,
        predictor: address,
        match_id: 0x1::string::String,
        outcome: u8,
        result: u8,
        correct: bool,
    }

    fun bump_made(arg0: &mut Board, arg1: address) {
        if (0x2::table::contains<address, Stats>(&arg0.stats, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, Stats>(&mut arg0.stats, arg1);
            v0.made = v0.made + 1;
        } else {
            let v1 = Stats{
                made     : 1,
                resolved : 0,
                correct  : 0,
            };
            0x2::table::add<address, Stats>(&mut arg0.stats, arg1, v1);
            arg0.total_pundits = arg0.total_pundits + 1;
        };
    }

    public fun has_result(arg0: &Board, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, u8>(&arg0.results, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OracleCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Board{
            id                : 0x2::object::new(arg0),
            results           : 0x2::table::new<0x1::string::String, u8>(arg0),
            stats             : 0x2::table::new<address, Stats>(arg0),
            total_predictions : 0,
            total_pundits     : 0,
        };
        0x2::transfer::share_object<Board>(v1);
    }

    public fun is_correct(arg0: &Prediction) : bool {
        arg0.correct
    }

    public fun is_settled(arg0: &Prediction) : bool {
        arg0.settled
    }

    public fun make_prediction(arg0: &mut Board, arg1: 0x1::string::String, arg2: u8, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg5);
        bump_made(arg0, v0);
        arg0.total_predictions = arg0.total_predictions + 1;
        let v2 = Prediction{
            id            : 0x2::object::new(arg5),
            predictor     : v0,
            match_id      : arg1,
            outcome       : arg2,
            subject       : arg3,
            blob_id       : arg4,
            created_at_ms : v1,
            settled       : false,
            correct       : false,
        };
        let v3 = PredictionMade{
            prediction_id : 0x2::object::id<Prediction>(&v2),
            predictor     : v0,
            match_id      : v2.match_id,
            outcome       : arg2,
            subject       : v2.subject,
            blob_id       : v2.blob_id,
            created_at_ms : v1,
        };
        0x2::event::emit<PredictionMade>(v3);
        0x2::transfer::public_transfer<Prediction>(v2, v0);
    }

    public fun result_of(arg0: &Board, arg1: 0x1::string::String) : u8 {
        *0x2::table::borrow<0x1::string::String, u8>(&arg0.results, arg1)
    }

    public fun set_result(arg0: &OracleCap, arg1: &mut Board, arg2: 0x1::string::String, arg3: u8) {
        if (0x2::table::contains<0x1::string::String, u8>(&arg1.results, arg2)) {
            *0x2::table::borrow_mut<0x1::string::String, u8>(&mut arg1.results, arg2) = arg3;
        } else {
            0x2::table::add<0x1::string::String, u8>(&mut arg1.results, arg2, arg3);
        };
        let v0 = ResultSet{
            match_id : arg2,
            result   : arg3,
        };
        0x2::event::emit<ResultSet>(v0);
    }

    public fun settle(arg0: &mut Board, arg1: &mut Prediction) {
        assert!(!arg1.settled, 2);
        assert!(0x2::table::contains<0x1::string::String, u8>(&arg0.results, arg1.match_id), 1);
        let v0 = *0x2::table::borrow<0x1::string::String, u8>(&arg0.results, arg1.match_id);
        let v1 = arg1.outcome == v0;
        arg1.settled = true;
        arg1.correct = v1;
        let v2 = 0x2::table::borrow_mut<address, Stats>(&mut arg0.stats, arg1.predictor);
        v2.resolved = v2.resolved + 1;
        if (v1) {
            v2.correct = v2.correct + 1;
        };
        let v3 = PredictionSettled{
            prediction_id : 0x2::object::id<Prediction>(arg1),
            predictor     : arg1.predictor,
            match_id      : arg1.match_id,
            outcome       : arg1.outcome,
            result        : v0,
            correct       : v1,
        };
        0x2::event::emit<PredictionSettled>(v3);
    }

    public fun stats_of(arg0: &Board, arg1: address) : (u64, u64, u64) {
        if (0x2::table::contains<address, Stats>(&arg0.stats, arg1)) {
            let v3 = 0x2::table::borrow<address, Stats>(&arg0.stats, arg1);
            (v3.made, v3.resolved, v3.correct)
        } else {
            (0, 0, 0)
        }
    }

    public fun total_predictions(arg0: &Board) : u64 {
        arg0.total_predictions
    }

    public fun total_pundits(arg0: &Board) : u64 {
        arg0.total_pundits
    }

    // decompiled from Move bytecode v7
}

