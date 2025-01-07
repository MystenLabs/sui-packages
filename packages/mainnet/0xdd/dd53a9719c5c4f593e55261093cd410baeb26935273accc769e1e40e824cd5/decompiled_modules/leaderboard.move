module 0xdddd53a9719c5c4f593e55261093cd410baeb26935273accc769e1e40e824cd5::leaderboard {
    struct SprintLeaderboard has store, key {
        id: 0x2::object::UID,
        max_leaderboard_game_count: u64,
        top_games: vector<TopSprintGame>,
        max_duration: u64,
    }

    struct TopSprintGame has copy, drop, store {
        game_id: 0x2::object::ID,
        leader_address: address,
        start_time: u64,
        duration: u64,
    }

    fun add_top_game_sorted(arg0: &mut SprintLeaderboard, arg1: TopSprintGame) {
        let v0 = arg0.top_games;
        let v1 = 0;
        while (v1 < 0x1::vector::length<TopSprintGame>(&v0)) {
            if (arg1.game_id == 0x1::vector::borrow<TopSprintGame>(&v0, v1).game_id) {
                0x1::vector::swap_remove<TopSprintGame>(&mut v0, v1);
                break
            };
            v1 = v1 + 1;
        };
        0x1::vector::push_back<TopSprintGame>(&mut v0, arg1);
        let v2 = v0;
        v0 = merge_sort_top_games(v2);
        let v3 = 0x1::vector::length<TopSprintGame>(&v0);
        let v4 = v3;
        if (v3 > arg0.max_leaderboard_game_count) {
            0x1::vector::pop_back<TopSprintGame>(&mut v0);
            v4 = v3 - 1;
        };
        if (v4 >= arg0.max_leaderboard_game_count) {
            arg0.max_duration = 0x1::vector::borrow<TopSprintGame>(&v0, v4 - 1).duration;
        };
        arg0.top_games = v0;
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SprintLeaderboard{
            id                         : 0x2::object::new(arg0),
            max_leaderboard_game_count : 50,
            top_games                  : 0x1::vector::empty<TopSprintGame>(),
            max_duration               : 1000000,
        };
        0x2::transfer::share_object<SprintLeaderboard>(v0);
    }

    public fun game_count(arg0: &SprintLeaderboard) : u64 {
        0x1::vector::length<TopSprintGame>(&arg0.top_games)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        create(arg0);
    }

    public fun max_duration(arg0: &SprintLeaderboard) : &u64 {
        &arg0.max_duration
    }

    public(friend) fun merge(arg0: vector<TopSprintGame>, arg1: vector<TopSprintGame>) : vector<TopSprintGame> {
        0x1::vector::reverse<TopSprintGame>(&mut arg0);
        0x1::vector::reverse<TopSprintGame>(&mut arg1);
        let v0 = 0x1::vector::empty<TopSprintGame>();
        while (!0x1::vector::is_empty<TopSprintGame>(&arg0) && !0x1::vector::is_empty<TopSprintGame>(&arg1)) {
            let v1 = 0x1::vector::borrow<TopSprintGame>(&arg0, 0x1::vector::length<TopSprintGame>(&arg0) - 1);
            let v2 = 0x1::vector::borrow<TopSprintGame>(&arg1, 0x1::vector::length<TopSprintGame>(&arg1) - 1);
            if (v1.duration < v2.duration) {
                0x1::vector::push_back<TopSprintGame>(&mut v0, 0x1::vector::pop_back<TopSprintGame>(&mut arg0));
                continue
            };
            if (v1.duration > v2.duration) {
                0x1::vector::push_back<TopSprintGame>(&mut v0, 0x1::vector::pop_back<TopSprintGame>(&mut arg1));
                continue
            };
            if (v1.duration < v2.duration) {
                0x1::vector::push_back<TopSprintGame>(&mut v0, 0x1::vector::pop_back<TopSprintGame>(&mut arg0));
                continue
            };
            0x1::vector::push_back<TopSprintGame>(&mut v0, 0x1::vector::pop_back<TopSprintGame>(&mut arg1));
        };
        0x1::vector::reverse<TopSprintGame>(&mut arg0);
        0x1::vector::reverse<TopSprintGame>(&mut arg1);
        0x1::vector::append<TopSprintGame>(&mut v0, arg0);
        0x1::vector::append<TopSprintGame>(&mut v0, arg1);
        v0
    }

    public(friend) fun merge_sort_top_games(arg0: vector<TopSprintGame>) : vector<TopSprintGame> {
        let v0 = 0x1::vector::length<TopSprintGame>(&arg0);
        if (v0 == 1) {
            return arg0
        };
        let v1 = 0x1::vector::empty<TopSprintGame>();
        let v2 = 0;
        while (v2 < v0 / 2) {
            0x1::vector::push_back<TopSprintGame>(&mut v1, 0x1::vector::pop_back<TopSprintGame>(&mut arg0));
            v2 = v2 + 1;
        };
        merge(merge_sort_top_games(arg0), merge_sort_top_games(v1))
    }

    public entry fun submit_game(arg0: &mut 0xdddd53a9719c5c4f593e55261093cd410baeb26935273accc769e1e40e824cd5::sprint_game::SprintGame, arg1: &mut SprintLeaderboard) {
        assert!(*0xdddd53a9719c5c4f593e55261093cd410baeb26935273accc769e1e40e824cd5::sprint_game::duration(arg0) <= arg1.max_duration, 1);
        let v0 = TopSprintGame{
            game_id        : 0xdddd53a9719c5c4f593e55261093cd410baeb26935273accc769e1e40e824cd5::sprint_game::id(arg0),
            leader_address : *0xdddd53a9719c5c4f593e55261093cd410baeb26935273accc769e1e40e824cd5::sprint_game::player(arg0),
            start_time     : *0xdddd53a9719c5c4f593e55261093cd410baeb26935273accc769e1e40e824cd5::sprint_game::start_time(arg0),
            duration       : *0xdddd53a9719c5c4f593e55261093cd410baeb26935273accc769e1e40e824cd5::sprint_game::duration(arg0),
        };
        add_top_game_sorted(arg1, v0);
    }

    public fun top_game_at(arg0: &SprintLeaderboard, arg1: u64) : &TopSprintGame {
        0x1::vector::borrow<TopSprintGame>(&arg0.top_games, arg1)
    }

    public fun top_game_at_has_id(arg0: &SprintLeaderboard, arg1: u64, arg2: 0x2::object::ID) : bool {
        top_game_at(arg0, arg1).game_id == arg2
    }

    public fun top_game_duration(arg0: &TopSprintGame) : &u64 {
        &arg0.duration
    }

    public fun top_game_game_id(arg0: &TopSprintGame) : 0x2::object::ID {
        arg0.game_id
    }

    public fun top_games(arg0: &SprintLeaderboard) : &vector<TopSprintGame> {
        &arg0.top_games
    }

    // decompiled from Move bytecode v6
}

