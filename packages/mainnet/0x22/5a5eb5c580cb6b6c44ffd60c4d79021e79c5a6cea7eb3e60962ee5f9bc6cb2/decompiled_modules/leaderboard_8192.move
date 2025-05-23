module 0x72f9c76421170b5a797432ba9e1b3b2e2b7cf6faa26eb955396c773af2479e1e::leaderboard_8192 {
    struct Leaderboard8192 has store, key {
        id: 0x2::object::UID,
        max_leaderboard_game_count: u64,
        top_games: vector<TopGame8192>,
        min_tile: u64,
        min_score: u64,
    }

    struct TopGame8192 has copy, drop, store {
        game_id: 0x2::object::ID,
        leader_address: address,
        top_tile: u64,
        score: u64,
    }

    fun add_top_game_sorted(arg0: &mut Leaderboard8192, arg1: TopGame8192) {
        let v0 = arg0.top_games;
        let v1 = 0;
        while (v1 < 0x1::vector::length<TopGame8192>(&v0)) {
            if (arg1.game_id == 0x1::vector::borrow<TopGame8192>(&v0, v1).game_id) {
                0x1::vector::swap_remove<TopGame8192>(&mut v0, v1);
                break
            };
            v1 = v1 + 1;
        };
        0x1::vector::push_back<TopGame8192>(&mut v0, arg1);
        let v2 = v0;
        v0 = merge_sort_top_games(v2);
        let v3 = 0x1::vector::length<TopGame8192>(&v0);
        let v4 = v3;
        if (v3 > arg0.max_leaderboard_game_count) {
            0x1::vector::pop_back<TopGame8192>(&mut v0);
            v4 = v3 - 1;
        };
        if (v4 >= arg0.max_leaderboard_game_count) {
            let v5 = 0x1::vector::borrow<TopGame8192>(&v0, v4 - 1);
            arg0.min_tile = v5.top_tile;
            arg0.min_score = v5.score;
        };
        arg0.top_games = v0;
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Leaderboard8192{
            id                         : 0x2::object::new(arg0),
            max_leaderboard_game_count : 50,
            top_games                  : 0x1::vector::empty<TopGame8192>(),
            min_tile                   : 0,
            min_score                  : 0,
        };
        0x2::transfer::share_object<Leaderboard8192>(v0);
    }

    public fun game_count(arg0: &Leaderboard8192) : u64 {
        0x1::vector::length<TopGame8192>(&arg0.top_games)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        create(arg0);
    }

    public(friend) fun merge(arg0: vector<TopGame8192>, arg1: vector<TopGame8192>) : vector<TopGame8192> {
        0x1::vector::reverse<TopGame8192>(&mut arg0);
        0x1::vector::reverse<TopGame8192>(&mut arg1);
        let v0 = 0x1::vector::empty<TopGame8192>();
        while (!0x1::vector::is_empty<TopGame8192>(&arg0) && !0x1::vector::is_empty<TopGame8192>(&arg1)) {
            let v1 = 0x1::vector::borrow<TopGame8192>(&arg0, 0x1::vector::length<TopGame8192>(&arg0) - 1);
            let v2 = 0x1::vector::borrow<TopGame8192>(&arg1, 0x1::vector::length<TopGame8192>(&arg1) - 1);
            if (v1.top_tile > v2.top_tile) {
                0x1::vector::push_back<TopGame8192>(&mut v0, 0x1::vector::pop_back<TopGame8192>(&mut arg0));
                continue
            };
            if (v1.top_tile < v2.top_tile) {
                0x1::vector::push_back<TopGame8192>(&mut v0, 0x1::vector::pop_back<TopGame8192>(&mut arg1));
                continue
            };
            if (v1.score > v2.score) {
                0x1::vector::push_back<TopGame8192>(&mut v0, 0x1::vector::pop_back<TopGame8192>(&mut arg0));
                continue
            };
            0x1::vector::push_back<TopGame8192>(&mut v0, 0x1::vector::pop_back<TopGame8192>(&mut arg1));
        };
        0x1::vector::reverse<TopGame8192>(&mut arg0);
        0x1::vector::reverse<TopGame8192>(&mut arg1);
        0x1::vector::append<TopGame8192>(&mut v0, arg0);
        0x1::vector::append<TopGame8192>(&mut v0, arg1);
        v0
    }

    public(friend) fun merge_sort_top_games(arg0: vector<TopGame8192>) : vector<TopGame8192> {
        let v0 = 0x1::vector::length<TopGame8192>(&arg0);
        if (v0 == 1) {
            return arg0
        };
        let v1 = 0x1::vector::empty<TopGame8192>();
        let v2 = 0;
        while (v2 < v0 / 2) {
            0x1::vector::push_back<TopGame8192>(&mut v1, 0x1::vector::pop_back<TopGame8192>(&mut arg0));
            v2 = v2 + 1;
        };
        merge(merge_sort_top_games(arg0), merge_sort_top_games(v1))
    }

    public fun min_score(arg0: &Leaderboard8192) : &u64 {
        &arg0.min_score
    }

    public fun min_tile(arg0: &Leaderboard8192) : &u64 {
        &arg0.min_tile
    }

    public entry fun submit_game(arg0: &mut 0x72f9c76421170b5a797432ba9e1b3b2e2b7cf6faa26eb955396c773af2479e1e::game_8192::Game8192, arg1: &mut Leaderboard8192) {
        assert!(*0x72f9c76421170b5a797432ba9e1b3b2e2b7cf6faa26eb955396c773af2479e1e::game_8192::top_tile(arg0) >= arg1.min_tile, 1);
        assert!(*0x72f9c76421170b5a797432ba9e1b3b2e2b7cf6faa26eb955396c773af2479e1e::game_8192::score(arg0) > arg1.min_score, 2);
        let v0 = TopGame8192{
            game_id        : 0x72f9c76421170b5a797432ba9e1b3b2e2b7cf6faa26eb955396c773af2479e1e::game_8192::id(arg0),
            leader_address : *0x72f9c76421170b5a797432ba9e1b3b2e2b7cf6faa26eb955396c773af2479e1e::game_8192::player(arg0),
            top_tile       : *0x72f9c76421170b5a797432ba9e1b3b2e2b7cf6faa26eb955396c773af2479e1e::game_8192::top_tile(arg0),
            score          : *0x72f9c76421170b5a797432ba9e1b3b2e2b7cf6faa26eb955396c773af2479e1e::game_8192::score(arg0),
        };
        add_top_game_sorted(arg1, v0);
    }

    public fun top_game_at(arg0: &Leaderboard8192, arg1: u64) : &TopGame8192 {
        0x1::vector::borrow<TopGame8192>(&arg0.top_games, arg1)
    }

    public fun top_game_at_has_id(arg0: &Leaderboard8192, arg1: u64, arg2: 0x2::object::ID) : bool {
        top_game_at(arg0, arg1).game_id == arg2
    }

    public fun top_game_game_id(arg0: &TopGame8192) : 0x2::object::ID {
        arg0.game_id
    }

    public fun top_game_score(arg0: &TopGame8192) : &u64 {
        &arg0.score
    }

    public fun top_game_top_tile(arg0: &TopGame8192) : &u64 {
        &arg0.top_tile
    }

    public fun top_games(arg0: &Leaderboard8192) : &vector<TopGame8192> {
        &arg0.top_games
    }

    // decompiled from Move bytecode v6
}

