module 0xae61457d9c887b0c6c30890636f80f73dca075ea92e2ec15696a5b13796f7e72::shizuku_score {
    struct Leaderboard has store, key {
        id: 0x2::object::UID,
        scores: 0x2::table::Table<u64, ScoreRecord>,
    }

    struct ScoreRecord has copy, drop, store {
        player: address,
        date: u64,
        score: u64,
    }

    public fun get_all_scores(arg0: &Leaderboard) : 0x2::vec_set::VecSet<ScoreRecord> {
        let v0 = 0x2::vec_set::empty<ScoreRecord>();
        let v1 = 1;
        while (v1 <= 0x2::table::length<u64, ScoreRecord>(&arg0.scores)) {
            0x2::vec_set::insert<ScoreRecord>(&mut v0, *0x2::table::borrow<u64, ScoreRecord>(&arg0.scores, v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Leaderboard{
            id     : 0x2::object::new(arg0),
            scores : 0x2::table::new<u64, ScoreRecord>(arg0),
        };
        0x2::transfer::share_object<Leaderboard>(v0);
    }

    public fun save_score(arg0: &mut Leaderboard, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ScoreRecord{
            player : 0x2::tx_context::sender(arg3),
            date   : 0x2::clock::timestamp_ms(arg2),
            score  : arg1,
        };
        0x2::table::add<u64, ScoreRecord>(&mut arg0.scores, 0x2::table::length<u64, ScoreRecord>(&arg0.scores) + 1, v0);
    }

    // decompiled from Move bytecode v6
}

