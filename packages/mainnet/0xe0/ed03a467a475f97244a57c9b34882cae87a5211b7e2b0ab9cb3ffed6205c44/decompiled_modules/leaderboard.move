module 0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::leaderboard {
    struct LeaderboardEntry has copy, drop, store {
        card_id: 0x2::object::ID,
        player_id: u64,
        score: u64,
        goals: u64,
        stage_reached: u8,
        minted_at: u64,
    }

    struct Leaderboard has key {
        id: 0x2::object::UID,
        season: u64,
        entries: vector<LeaderboardEntry>,
    }

    struct ScoreUpdated has copy, drop {
        card_id: 0x2::object::ID,
        new_score: u64,
        rank: u64,
    }

    public fun add_card(arg0: &mut Leaderboard, arg1: &0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::player_card::PlayerCard) {
        let v0 = 0x2::object::id<0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::player_card::PlayerCard>(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<LeaderboardEntry>(&arg0.entries)) {
            assert!(0x1::vector::borrow<LeaderboardEntry>(&arg0.entries, v1).card_id != v0, 1);
            v1 = v1 + 1;
        };
        let v2 = &mut arg0.entries;
        let v3 = LeaderboardEntry{
            card_id       : v0,
            player_id     : 0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::player_card::player_id(arg1),
            score         : 0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::player_card::score(arg1),
            goals         : 0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::player_card::goals(arg1),
            stage_reached : 0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::player_card::stage_reached(arg1),
            minted_at     : 0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::player_card::minted_at(arg1),
        };
        insert_sorted(v2, v3);
    }

    public fun board_size(arg0: &Leaderboard) : u64 {
        0x1::vector::length<LeaderboardEntry>(&arg0.entries)
    }

    public fun create(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Leaderboard{
            id      : 0x2::object::new(arg1),
            season  : arg0,
            entries : 0x1::vector::empty<LeaderboardEntry>(),
        };
        0x2::transfer::share_object<Leaderboard>(v0);
    }

    public fun entry_card_id(arg0: &LeaderboardEntry) : 0x2::object::ID {
        arg0.card_id
    }

    public fun entry_goals(arg0: &LeaderboardEntry) : u64 {
        arg0.goals
    }

    public fun entry_player_id(arg0: &LeaderboardEntry) : u64 {
        arg0.player_id
    }

    public fun entry_score(arg0: &LeaderboardEntry) : u64 {
        arg0.score
    }

    public fun entry_stage(arg0: &LeaderboardEntry) : u8 {
        arg0.stage_reached
    }

    public fun get_top(arg0: &Leaderboard, arg1: u64) : vector<LeaderboardEntry> {
        let v0 = 0x1::vector::length<LeaderboardEntry>(&arg0.entries);
        let v1 = if (arg1 < v0) {
            arg1
        } else {
            v0
        };
        let v2 = 0x1::vector::empty<LeaderboardEntry>();
        let v3 = 0;
        while (v3 < v1) {
            0x1::vector::push_back<LeaderboardEntry>(&mut v2, *0x1::vector::borrow<LeaderboardEntry>(&arg0.entries, v3));
            v3 = v3 + 1;
        };
        v2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Leaderboard{
            id      : 0x2::object::new(arg0),
            season  : 1,
            entries : 0x1::vector::empty<LeaderboardEntry>(),
        };
        0x2::transfer::share_object<Leaderboard>(v0);
    }

    fun insert_sorted(arg0: &mut vector<LeaderboardEntry>, arg1: LeaderboardEntry) {
        let v0 = 0x1::vector::length<LeaderboardEntry>(arg0);
        0x1::vector::push_back<LeaderboardEntry>(arg0, arg1);
        while (v0 > 0) {
            let v1 = v0 - 1;
            if (ranks_higher(0x1::vector::borrow<LeaderboardEntry>(arg0, v0), 0x1::vector::borrow<LeaderboardEntry>(arg0, v1))) {
                0x1::vector::swap<LeaderboardEntry>(arg0, v0, v1);
                v0 = v1;
            } else {
                break
            };
        };
    }

    fun ranks_higher(arg0: &LeaderboardEntry, arg1: &LeaderboardEntry) : bool {
        if (arg0.score != arg1.score) {
            return arg0.score > arg1.score
        };
        if (arg0.goals != arg1.goals) {
            return arg0.goals > arg1.goals
        };
        if (arg0.stage_reached != arg1.stage_reached) {
            return arg0.stage_reached > arg1.stage_reached
        };
        arg0.minted_at < arg1.minted_at
    }

    public fun update_score(arg0: &mut Leaderboard, arg1: &0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::player_card::PlayerCard) {
        let v0 = 0x2::object::id<0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::player_card::PlayerCard>(arg1);
        let v1 = false;
        let v2 = 0;
        while (v2 < 0x1::vector::length<LeaderboardEntry>(&arg0.entries)) {
            if (0x1::vector::borrow<LeaderboardEntry>(&arg0.entries, v2).card_id == v0) {
                v1 = true;
                break
            };
            v2 = v2 + 1;
        };
        assert!(v1, 2);
        0x1::vector::swap_remove<LeaderboardEntry>(&mut arg0.entries, v2);
        let v3 = &mut arg0.entries;
        let v4 = LeaderboardEntry{
            card_id       : v0,
            player_id     : 0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::player_card::player_id(arg1),
            score         : 0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::player_card::score(arg1),
            goals         : 0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::player_card::goals(arg1),
            stage_reached : 0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::player_card::stage_reached(arg1),
            minted_at     : 0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::player_card::minted_at(arg1),
        };
        insert_sorted(v3, v4);
        let v5 = 0;
        let v6 = 0;
        while (v6 < 0x1::vector::length<LeaderboardEntry>(&arg0.entries)) {
            if (0x1::vector::borrow<LeaderboardEntry>(&arg0.entries, v6).card_id == v0) {
                v5 = v6;
                break
            };
            v6 = v6 + 1;
        };
        let v7 = ScoreUpdated{
            card_id   : v0,
            new_score : 0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::player_card::score(arg1),
            rank      : v5,
        };
        0x2::event::emit<ScoreUpdated>(v7);
    }

    // decompiled from Move bytecode v7
}

