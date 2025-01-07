module 0x1eec93f137f760b5428966571b6c5c109eed4328ece8d86b05ba8294fa390ddb::game_2048 {
    struct Tile has copy, drop, store {
        key: u64,
        i: u64,
        j: u64,
        value: u64,
        overlaid: bool,
    }

    struct Game2048 has store, key {
        id: 0x2::object::UID,
        tiles: 0x2::vec_map::VecMap<u64, Tile>,
        isgameOver: bool,
        won: bool,
        score: u64,
    }

    struct TopTiles has copy, drop {
        tiles: vector<0x1::option::Option<Tile>>,
        toDelete: vector<u64>,
    }

    struct ScoreEvent has copy, drop {
        addScore: u64,
        totalScore: u64,
    }

    struct UpdateEvent has copy, drop {
        tiles: 0x2::vec_map::VecMap<u64, Tile>,
    }

    struct GameOverEvent has copy, drop {
        result: u8,
        msg: 0x1::string::String,
    }

    struct MaxMergeEvent has copy, drop {
        maxMerge: u64,
    }

    struct WinEvent has copy, drop {
        gameOverFlag: bool,
    }

    struct StateChanged has copy, drop {
        stateChanged: vector<u64>,
    }

    fun convert_weather_to_seed(arg0: u32, arg1: u32) : u32 {
        arg0 * arg1
    }

    public fun create_tiles_panel(arg0: &mut 0x2::tx_context::TxContext, arg1: &0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::WeatherOracle) : Game2048 {
        let v0 = Game2048{
            id         : 0x2::object::new(arg0),
            tiles      : 0x2::vec_map::empty<u64, Tile>(),
            isgameOver : false,
            won        : false,
            score      : 0,
        };
        let v1 = &mut v0;
        generateTile(v1, arg1);
        let v2 = &mut v0;
        generateTile(v2, arg1);
        v0
    }

    public fun generateTile(arg0: &mut Game2048, arg1: &0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::WeatherOracle) : bool {
        let v0 = 0x2::vec_set::empty<u64>();
        let v1 = 0;
        while (v1 < 16) {
            0x2::vec_set::insert<u64>(&mut v0, v1);
            v1 = v1 + 1;
        };
        let v2 = 0x2::vec_map::keys<u64, Tile>(&arg0.tiles);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&v2)) {
            let v4 = 0x2::vec_map::get<u64, Tile>(&arg0.tiles, 0x1::vector::borrow<u64>(&v2, v3));
            if (v4.overlaid) {
                v3 = v3 + 1;
                continue
            };
            let v5 = v4.i * 4 + v4.j;
            0x2::vec_set::remove<u64>(&mut v0, &v5);
            v3 = v3 + 1;
        };
        let v6 = 0x1::vector::borrow<u64>(0x2::vec_set::keys<u64>(&v0), get_random(arg1) % 0x2::vec_set::size<u64>(&v0));
        let v7 = if (get_random(arg1) % 6 > 2) {
            4
        } else {
            2
        };
        let v8 = 0x2::vec_map::keys<u64, Tile>(&arg0.tiles);
        let v9 = 0x1::vector::length<u64>(&v8);
        let v10 = 0;
        if (v9 > 0) {
            v10 = *0x1::vector::borrow<u64>(&v8, v9 - 1) + 1;
        };
        let v11 = Tile{
            key      : v10,
            i        : ((*v6 / 4) as u64),
            j        : ((*v6 % 4) as u64),
            value    : v7,
            overlaid : false,
        };
        0x2::vec_map::insert<u64, Tile>(&mut arg0.tiles, v10, v11);
        if (0x2::vec_set::size<u64>(&v0) == 1) {
            return judge(&arg0.tiles)
        };
        false
    }

    fun generate_random(arg0: u64) : u64 {
        (arg0 * 73 + 41) % 100
    }

    fun get_random(arg0: &0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::WeatherOracle) : u64 {
        let v0 = 2988507;
        let v1 = 2290956;
        generate_random((convert_weather_to_seed(0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::city_weather_oracle_temp(arg0, v0) + 0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::city_weather_oracle_temp(arg0, v1), 0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::city_weather_oracle_pressure(arg0, v0) + 0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::city_weather_oracle_pressure(arg0, v1)) as u64))
    }

    public fun get_score(arg0: &Game2048) : u64 {
        arg0.score
    }

    public fun get_state(arg0: &Game2048) : vector<u64> {
        if (!arg0.isgameOver) {
            let v0 = 0x1::vector::empty<u64>();
            while (0x1::vector::length<u64>(&v0) < 16) {
                0x1::vector::push_back<u64>(&mut v0, 0);
            };
            let v1 = 0x2::vec_map::keys<u64, Tile>(&arg0.tiles);
            let v2 = 0;
            while (v2 < 0x1::vector::length<u64>(&v1)) {
                let v3 = 0x2::vec_map::get<u64, Tile>(&arg0.tiles, 0x1::vector::borrow<u64>(&v1, v2));
                0x1::vector::push_back<u64>(&mut v0, log2(v3.value));
                0x1::vector::swap_remove<u64>(&mut v0, v3.i * 4 + v3.j);
                v2 = v2 + 1;
            };
            return v0
        };
        0x1::vector::empty<u64>()
    }

    public fun get_tiles(arg0: &Game2048) : &0x2::vec_map::VecMap<u64, Tile> {
        &arg0.tiles
    }

    public fun get_top_tiles(arg0: &0x2::vec_map::VecMap<u64, Tile>) : TopTiles {
        let v0 = 0x1::vector::empty<0x1::option::Option<Tile>>();
        let v1 = 0;
        while (v1 < 16) {
            0x1::vector::push_back<0x1::option::Option<Tile>>(&mut v0, 0x1::option::none<Tile>());
            v1 = v1 + 1;
        };
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0;
        let v4 = 0x2::vec_map::keys<u64, Tile>(arg0);
        while (v3 < 0x1::vector::length<u64>(&v4)) {
            let v5 = 0x2::vec_map::get<u64, Tile>(arg0, 0x1::vector::borrow<u64>(&v4, v3));
            if (!v5.overlaid) {
                0x1::vector::push_back<0x1::option::Option<Tile>>(&mut v0, 0x1::option::some<Tile>(*v5));
                0x1::vector::swap_remove<0x1::option::Option<Tile>>(&mut v0, v5.i * 4 + v5.j);
            } else {
                0x1::vector::push_back<u64>(&mut v2, v5.key);
            };
            v3 = v3 + 1;
        };
        TopTiles{
            tiles    : v0,
            toDelete : v2,
        }
    }

    public fun judge(arg0: &0x2::vec_map::VecMap<u64, Tile>) : bool {
        let v0 = get_top_tiles(arg0);
        let v1 = true;
        let v2 = 0;
        while (v1 && v2 < 4) {
            let v3 = 0;
            while (v1 && v3 < 4) {
                let v4 = 0x1::vector::borrow<0x1::option::Option<Tile>>(&v0.tiles, v2 * 4 + v3);
                if (0x1::option::is_none<Tile>(v4)) {
                    v1 = false;
                } else if (v2 % 4 < 3) {
                    let v5 = 0x1::vector::borrow<0x1::option::Option<Tile>>(&v0.tiles, (v2 + 1) * 4 + v3);
                    if (0x1::option::is_none<Tile>(v5) || 0x1::option::borrow<Tile>(v4).value == 0x1::option::borrow<Tile>(v5).value) {
                        v1 = false;
                    };
                };
                if (v3 % 4 < 3 && 0x1::option::is_some<Tile>(v4)) {
                    let v6 = 0x1::vector::borrow<0x1::option::Option<Tile>>(&v0.tiles, v2 * 4 + v3 + 1);
                    if (0x1::option::is_none<Tile>(v6) || 0x1::option::borrow<Tile>(v4).value == 0x1::option::borrow<Tile>(v6).value) {
                        v1 = false;
                    };
                };
                v3 = v3 + 1;
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun log2(arg0: u64) : u64 {
        let v0 = 0;
        while (arg0 > 1) {
            arg0 = arg0 / 2;
            v0 = v0 + 1;
        };
        v0
    }

    public entry fun move_tile(arg0: &mut Game2048, arg1: &0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::WeatherOracle, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.isgameOver, 1);
        assert!(!arg0.won, 2);
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        if (arg2 == 0) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            0x1::vector::push_back<u64>(&mut v0, 4);
            0x1::vector::push_back<u64>(&mut v0, 8);
            0x1::vector::push_back<u64>(&mut v0, 12);
            0x1::vector::push_back<u64>(&mut v1, 100);
            0x1::vector::push_back<u64>(&mut v1, 101);
            0x1::vector::push_back<u64>(&mut v1, 102);
            0x1::vector::push_back<u64>(&mut v1, 103);
        } else if (arg2 == 1) {
            0x1::vector::push_back<u64>(&mut v0, 12);
            0x1::vector::push_back<u64>(&mut v0, 13);
            0x1::vector::push_back<u64>(&mut v0, 14);
            0x1::vector::push_back<u64>(&mut v0, 15);
            0x1::vector::push_back<u64>(&mut v1, 100);
            0x1::vector::push_back<u64>(&mut v1, 96);
            0x1::vector::push_back<u64>(&mut v1, 92);
            0x1::vector::push_back<u64>(&mut v1, 88);
        } else if (arg2 == 2) {
            0x1::vector::push_back<u64>(&mut v0, 3);
            0x1::vector::push_back<u64>(&mut v0, 7);
            0x1::vector::push_back<u64>(&mut v0, 11);
            0x1::vector::push_back<u64>(&mut v0, 15);
            0x1::vector::push_back<u64>(&mut v1, 100);
            0x1::vector::push_back<u64>(&mut v1, 99);
            0x1::vector::push_back<u64>(&mut v1, 98);
            0x1::vector::push_back<u64>(&mut v1, 97);
        } else if (arg2 == 3) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            0x1::vector::push_back<u64>(&mut v0, 1);
            0x1::vector::push_back<u64>(&mut v0, 2);
            0x1::vector::push_back<u64>(&mut v0, 3);
            0x1::vector::push_back<u64>(&mut v1, 100);
            0x1::vector::push_back<u64>(&mut v1, 104);
            0x1::vector::push_back<u64>(&mut v1, 108);
            0x1::vector::push_back<u64>(&mut v1, 112);
        };
        let v2 = get_top_tiles(&arg0.tiles);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&v2.toDelete)) {
            let (_, _) = 0x2::vec_map::remove<u64, Tile>(&mut arg0.tiles, 0x1::vector::borrow<u64>(&v2.toDelete, v3));
            v3 = v3 + 1;
        };
        let v6 = false;
        let v7 = false;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0;
        while (v10 < 4) {
            let v11 = 0x1::vector::borrow<u64>(&v0, v10);
            let v12 = 0x1::option::none<Tile>();
            let v13 = 0;
            let v14 = 0;
            while (v14 < 4) {
                let v15 = 0x1::vector::borrow_mut<0x1::option::Option<Tile>>(&mut v2.tiles, *v11 + *0x1::vector::borrow<u64>(&v1, v14) - 100);
                if (0x1::option::is_some<Tile>(v15)) {
                    let v16 = 0x1::option::borrow_mut<Tile>(v15);
                    let v17 = 0x2::vec_map::get_mut<u64, Tile>(&mut arg0.tiles, &v16.key);
                    if (0x1::option::is_some<Tile>(&v12)) {
                        let v18 = 0x1::option::borrow_mut<Tile>(&mut v12);
                        if (v16.value == v18.value) {
                            v18.value = v17.value * 2;
                            v17.overlaid = true;
                            if (v18.value == 2048) {
                                if (!arg0.won) {
                                    arg0.won = true;
                                    v7 = true;
                                };
                            };
                            v17.i = v18.i;
                            v17.j = v18.j;
                            0x2::vec_map::get_mut<u64, Tile>(&mut arg0.tiles, &v18.key).value = v18.value;
                            v8 = v8 + v18.value;
                            v6 = true;
                            v9 = 0x2::math::max(v9, v18.value);
                            0x1::option::destroy_some<Tile>(v12);
                        } else {
                            let v19 = *v11 + *0x1::vector::borrow<u64>(&v1, v13) - 100;
                            if (v16.i * 4 + v16.j != v19) {
                                v16.i = v19 / 4;
                                v16.j = v19 % 4;
                                v17.i = v16.i;
                                v17.j = v16.j;
                                v6 = true;
                            };
                            0x1::option::swap_or_fill<Tile>(&mut v12, *v16);
                            v13 = v13 + 1;
                        };
                    } else {
                        let v20 = *v11 + *0x1::vector::borrow<u64>(&v1, v13) - 100;
                        if (v16.i * 4 + v16.j != v20) {
                            v16.i = v20 / 4;
                            v16.j = v20 % 4;
                            v17.i = v16.i;
                            v17.j = v16.j;
                            v6 = true;
                        };
                        0x1::option::swap_or_fill<Tile>(&mut v12, *v16);
                        v13 = v13 + 1;
                    };
                };
                v14 = v14 + 1;
            };
            v10 = v10 + 1;
        };
        let v21 = false;
        if (v6) {
            v21 = generateTile(arg0, arg1);
            let v22 = UpdateEvent{tiles: arg0.tiles};
            0x2::event::emit<UpdateEvent>(v22);
        };
        if (v8 > 0) {
            arg0.score = v8 + arg0.score;
            let v23 = ScoreEvent{
                addScore   : v8,
                totalScore : arg0.score,
            };
            0x2::event::emit<ScoreEvent>(v23);
        };
        if (v9 > 0) {
            let v24 = MaxMergeEvent{maxMerge: v9};
            0x2::event::emit<MaxMergeEvent>(v24);
        };
        if (v21) {
            arg0.isgameOver = v21;
            let v25 = GameOverEvent{
                result : 1,
                msg    : 0x1::string::utf8(b"Game Over!"),
            };
            0x2::event::emit<GameOverEvent>(v25);
        };
        if (v7) {
            let v26 = WinEvent{gameOverFlag: v21};
            0x2::event::emit<WinEvent>(v26);
        };
        if (v6) {
            let v27 = StateChanged{stateChanged: get_state(arg0)};
            0x2::event::emit<StateChanged>(v27);
        };
    }

    public entry fun new_game(arg0: &0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::WeatherOracle, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_tiles_panel(arg1, arg0);
        0x2::transfer::public_transfer<Game2048>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

