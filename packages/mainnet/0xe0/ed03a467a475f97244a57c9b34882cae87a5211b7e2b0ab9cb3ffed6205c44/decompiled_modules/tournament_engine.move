module 0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::tournament_engine {
    struct MatchRecord has copy, drop, store {
        match_id: u64,
        home_team: vector<u8>,
        away_team: vector<u8>,
        home_score: u64,
        away_score: u64,
        stage: u8,
        timestamp: u64,
    }

    struct TournamentState has key {
        id: 0x2::object::UID,
        current_stage: u8,
        match_counter: u64,
        match_history: vector<MatchRecord>,
        eliminated_teams: 0x2::table::Table<vector<u8>, bool>,
        active: bool,
    }

    struct MatchRecorded has copy, drop {
        match_id: u64,
        stage: u8,
    }

    struct TeamEliminated has copy, drop {
        team: vector<u8>,
        at_stage: u8,
    }

    struct StageAdvanced has copy, drop {
        from: u8,
        to: u8,
    }

    struct TournamentEnded has copy, drop {
        champion_team: vector<u8>,
    }

    public fun advance_stage(arg0: &0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::player_card::AdminCap, arg1: &mut TournamentState) {
        assert!(arg1.active, 3);
        let v0 = arg1.current_stage + 1;
        assert!(v0 <= 5, 2);
        let v1 = StageAdvanced{
            from : arg1.current_stage,
            to   : v0,
        };
        0x2::event::emit<StageAdvanced>(v1);
        arg1.current_stage = v0;
        if (v0 == 5) {
            arg1.active = false;
        };
    }

    public fun batch_update_stats(arg0: &0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::player_card::AdminCap, arg1: &TournamentState, arg2: &mut 0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::player_card::PlayerCard, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::player_card::update_stats(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg1.current_stage);
    }

    public fun current_stage(arg0: &TournamentState) : u8 {
        arg0.current_stage
    }

    public fun declare_champion(arg0: &0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::player_card::AdminCap, arg1: &mut TournamentState, arg2: vector<u8>) {
        assert!(arg1.current_stage == 4, 2);
        arg1.current_stage = 5;
        arg1.active = false;
        let v0 = TournamentEnded{champion_team: arg2};
        0x2::event::emit<TournamentEnded>(v0);
    }

    public fun eliminate_team(arg0: &0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::player_card::AdminCap, arg1: &mut TournamentState, arg2: vector<u8>) {
        assert!(arg1.active, 3);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg1.eliminated_teams, arg2), 1);
        0x2::table::add<vector<u8>, bool>(&mut arg1.eliminated_teams, arg2, true);
        let v0 = TeamEliminated{
            team     : arg2,
            at_stage : arg1.current_stage,
        };
        0x2::event::emit<TeamEliminated>(v0);
    }

    public fun freeze_eliminated_card(arg0: &0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::player_card::AdminCap, arg1: &mut 0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::player_card::PlayerCard) {
        0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::player_card::freeze_card(arg0, arg1);
    }

    public fun get_match_history(arg0: &TournamentState) : &vector<MatchRecord> {
        &arg0.match_history
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TournamentState{
            id               : 0x2::object::new(arg0),
            current_stage    : 0,
            match_counter    : 0,
            match_history    : 0x1::vector::empty<MatchRecord>(),
            eliminated_teams : 0x2::table::new<vector<u8>, bool>(arg0),
            active           : true,
        };
        0x2::transfer::share_object<TournamentState>(v0);
    }

    public fun is_active(arg0: &TournamentState) : bool {
        arg0.active
    }

    public fun is_eliminated(arg0: &TournamentState, arg1: &vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.eliminated_teams, *arg1)
    }

    public fun match_away_score(arg0: &MatchRecord) : u64 {
        arg0.away_score
    }

    public fun match_away_team(arg0: &MatchRecord) : vector<u8> {
        arg0.away_team
    }

    public fun match_count(arg0: &TournamentState) : u64 {
        arg0.match_counter
    }

    public fun match_home_score(arg0: &MatchRecord) : u64 {
        arg0.home_score
    }

    public fun match_home_team(arg0: &MatchRecord) : vector<u8> {
        arg0.home_team
    }

    public fun match_stage(arg0: &MatchRecord) : u8 {
        arg0.stage
    }

    public fun match_timestamp(arg0: &MatchRecord) : u64 {
        arg0.timestamp
    }

    public fun record_match(arg0: &0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::player_card::AdminCap, arg1: &mut TournamentState, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        assert!(arg1.active, 3);
        let v0 = arg1.match_counter;
        arg1.match_counter = arg1.match_counter + 1;
        let v1 = MatchRecord{
            match_id   : v0,
            home_team  : arg2,
            away_team  : arg3,
            home_score : arg4,
            away_score : arg5,
            stage      : arg1.current_stage,
            timestamp  : 0x2::clock::timestamp_ms(arg6),
        };
        0x1::vector::push_back<MatchRecord>(&mut arg1.match_history, v1);
        let v2 = MatchRecorded{
            match_id : v0,
            stage    : arg1.current_stage,
        };
        0x2::event::emit<MatchRecorded>(v2);
    }

    // decompiled from Move bytecode v7
}

