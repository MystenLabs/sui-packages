module 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::leaderboard {
    struct AddScore<phantom T0, phantom T1> has copy, drop {
        user: address,
        points: u64,
    }

    struct Leaderboard has key {
        id: 0x2::object::UID,
        is_ended: bool,
        total_scores: u64,
        score_map: 0x2::table::Table<address, ScoreInfo>,
        top_leaders: vector<address>,
        top_scores: vector<u64>,
    }

    struct ScoreInfo has store {
        points: u64,
        total_games: u64,
    }

    struct GameConfig has copy, drop, store {
        volume_multiplier: u64,
    }

    struct PointsConfigCap has store, key {
        id: 0x2::object::UID,
    }

    struct ConfigKey has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        game_type: 0x1::type_name::TypeName,
    }

    public fun add_game_config<T0, T1: drop>(arg0: &PointsConfigCap, arg1: &mut Leaderboard, arg2: u64) {
        let v0 = ConfigKey{
            coin_type : 0x1::type_name::get<T0>(),
            game_type : 0x1::type_name::get<T1>(),
        };
        assert!(!0x2::dynamic_field::exists_<ConfigKey>(&arg1.id, v0), 0);
        let v1 = GameConfig{volume_multiplier: arg2};
        0x2::dynamic_field::add<ConfigKey, GameConfig>(&mut arg1.id, v0, v1);
    }

    public(friend) fun add_score<T0, T1: drop>(arg0: &mut Leaderboard, arg1: &0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::receipt::GameReceipt<T0, T1>, arg2: address) {
        let v0 = ConfigKey{
            coin_type : 0x1::type_name::get<T0>(),
            game_type : 0x1::type_name::get<T1>(),
        };
        let v1 = *0x2::dynamic_field::borrow<ConfigKey, GameConfig>(&arg0.id, v0);
        let v2 = 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::receipt::game_receipt_bet_size<T0, T1>(arg1) * v1.volume_multiplier;
        let v3 = &mut arg0.score_map;
        if (!0x2::table::contains<address, ScoreInfo>(v3, arg2)) {
            let v4 = ScoreInfo{
                points      : 0,
                total_games : 0,
            };
            0x2::table::add<address, ScoreInfo>(v3, arg2, v4);
        };
        let v5 = 0x2::table::borrow_mut<address, ScoreInfo>(v3, arg2);
        v5.points = v5.points + v2;
        v5.total_games = v5.total_games + 1;
        let v6 = AddScore<T0, T1>{
            user   : arg2,
            points : v2,
        };
        0x2::event::emit<AddScore<T0, T1>>(v6);
        let (v7, v8) = 0x1::vector::index_of<address>(&arg0.top_leaders, &arg2);
        if (v7) {
            *0x1::vector::borrow_mut<u64>(&mut arg0.top_scores, v8) = v5.points;
            return
        };
        let (v9, v10) = get_min_score_and_index(&arg0.top_scores);
        if (v5.points > v9) {
            0x1::vector::remove<address>(&mut arg0.top_leaders, v10);
            0x1::vector::remove<u64>(&mut arg0.top_scores, v10);
            0x1::vector::push_back<address>(&mut arg0.top_leaders, arg2);
            0x1::vector::push_back<u64>(&mut arg0.top_scores, v5.points);
        };
    }

    public fun create_leaderboard(arg0: &PointsConfigCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = vector[];
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 10) {
            0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg1));
            0x1::vector::push_back<u64>(&mut v1, 0);
            v2 = v2 + 1;
        };
        let v3 = Leaderboard{
            id           : 0x2::object::new(arg1),
            is_ended     : false,
            total_scores : 0,
            score_map    : 0x2::table::new<address, ScoreInfo>(arg1),
            top_leaders  : v0,
            top_scores   : v1,
        };
        0x2::transfer::share_object<Leaderboard>(v3);
    }

    fun get_min_score_and_index(arg0: &vector<u64>) : (u64, u64) {
        let v0 = 18446744073709551615;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            let v2 = 0x1::vector::borrow<u64>(arg0, v1);
            if (*v2 < v0) {
                v0 = *v2;
            };
            v1 = v1 + 1;
        };
        (v0, 0)
    }

    public fun get_user_score(arg0: &Leaderboard, arg1: address) : u64 {
        if (0x2::table::contains<address, ScoreInfo>(&arg0.score_map, arg1)) {
            0x2::table::borrow<address, ScoreInfo>(&arg0.score_map, arg1).points
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PointsConfigCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<PointsConfigCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun top_leaders(arg0: &Leaderboard) : vector<address> {
        arg0.top_leaders
    }

    public fun top_scores(arg0: &Leaderboard) : vector<u64> {
        arg0.top_scores
    }

    public fun update_game_config<T0, T1: drop>(arg0: &PointsConfigCap, arg1: &mut Leaderboard, arg2: 0x1::option::Option<u64>) {
        let v0 = ConfigKey{
            coin_type : 0x1::type_name::get<T0>(),
            game_type : 0x1::type_name::get<T1>(),
        };
        assert!(0x2::dynamic_field::exists_<ConfigKey>(&arg1.id, v0), 1);
        let v1 = 0x2::dynamic_field::borrow_mut<ConfigKey, GameConfig>(&mut arg1.id, v0);
        if (0x1::option::is_some<u64>(&arg2)) {
            v1.volume_multiplier = 0x1::option::destroy_some<u64>(arg2);
        };
    }

    // decompiled from Move bytecode v6
}

