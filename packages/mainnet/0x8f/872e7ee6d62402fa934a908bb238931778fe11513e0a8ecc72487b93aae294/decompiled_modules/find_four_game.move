module 0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::find_four_game {
    struct GameBoard has store, key {
        id: 0x2::object::UID,
        board: vector<vector<u64>>,
        current_player: u64,
        is_game_over: bool,
        p1: address,
        p2: address,
        gameType: u64,
        nonce: u64,
        winner: u64,
        winHandled: bool,
        version: u64,
    }

    struct GamesTracker has store, key {
        id: 0x2::object::UID,
        games: 0x2::table::Table<address, vector<address>>,
    }

    struct TimerRanOutEvent has copy, drop, store {
        game: address,
    }

    struct GameOverEvent has copy, drop, store {
        game: address,
    }

    public(friend) fun addGameToTracker(arg0: address, arg1: address, arg2: &mut GamesTracker) {
        if (!0x2::table::contains<address, vector<address>>(&arg2.games, arg0)) {
            0x2::table::add<address, vector<address>>(&mut arg2.games, arg0, 0x1::vector::empty<address>());
        };
        0x1::vector::push_back<address>(0x2::table::borrow_mut<address, vector<address>>(&mut arg2.games, arg0), arg1);
    }

    public(friend) fun ai_move(arg0: &mut GameBoard, arg1: u64) {
        check_version_GameBoard(arg0);
        assert!(!arg0.is_game_over, 0);
        assert!(arg0.current_player == 2, 9223372766999216127);
        drop_disc(arg0, arg1);
    }

    fun change_element(arg0: &mut vector<vector<u64>>, arg1: u64, arg2: u64, arg3: u64) {
        *0x1::vector::borrow_mut<u64>(0x1::vector::borrow_mut<vector<u64>>(arg0, arg1), arg2) = arg3;
    }

    fun check_for_win(arg0: &vector<vector<u64>>, arg1: u64) : bool {
        let v0 = 6;
        let v1 = 7;
        let v2 = 0;
        let v3;
        while (v2 < v0) {
            v3 = 0;
            while (v3 < v1 - 3) {
                let v4 = if (*0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(arg0, v2), v3) == arg1) {
                    if (*0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(arg0, v2), v3 + 1) == arg1) {
                        if (*0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(arg0, v2), v3 + 2) == arg1) {
                            *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(arg0, v2), v3 + 3) == arg1
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v4) {
                    return true
                };
                v3 = v3 + 1;
            };
            v2 = v2 + 1;
        };
        v3 = 0;
        while (v3 < v1) {
            v2 = 0;
            while (v2 < v0 - 3) {
                let v5 = if (*0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(arg0, v2), v3) == arg1) {
                    if (*0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(arg0, v2 + 1), v3) == arg1) {
                        if (*0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(arg0, v2 + 2), v3) == arg1) {
                            *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(arg0, v2 + 3), v3) == arg1
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v5) {
                    return true
                };
                v2 = v2 + 1;
            };
            v3 = v3 + 1;
        };
        v2 = 0;
        while (v2 < v0 - 3) {
            v3 = 0;
            while (v3 < v1 - 3) {
                let v6 = if (*0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(arg0, v2), v3) == arg1) {
                    if (*0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(arg0, v2 + 1), v3 + 1) == arg1) {
                        if (*0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(arg0, v2 + 2), v3 + 2) == arg1) {
                            *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(arg0, v2 + 3), v3 + 3) == arg1
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v6) {
                    return true
                };
                v3 = v3 + 1;
            };
            v2 = v2 + 1;
        };
        v2 = 3;
        while (v2 < v0) {
            v3 = 0;
            while (v3 < v1 - 3) {
                let v7 = if (*0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(arg0, v2), v3) == arg1) {
                    if (*0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(arg0, v2 - 1), v3 + 1) == arg1) {
                        if (*0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(arg0, v2 - 2), v3 + 2) == arg1) {
                            *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(arg0, v2 - 3), v3 + 3) == arg1
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v7) {
                    return true
                };
                v3 = v3 + 1;
            };
            v2 = v2 + 1;
        };
        false
    }

    public(friend) fun check_for_win_in_tests(arg0: &mut GameBoard, arg1: u64) : bool {
        check_version_GameBoard(arg0);
        check_for_win(&arg0.board, arg1)
    }

    fun check_version_GameBoard(arg0: &GameBoard) {
        assert!(arg0.version == 1, 1);
    }

    public(friend) fun create_empty_board() : vector<vector<u64>> {
        let v0 = 0x1::vector::empty<vector<u64>>();
        let v1 = 0;
        while (v1 < 6) {
            let v2 = 0x1::vector::empty<u64>();
            let v3 = 0;
            while (v3 < 7) {
                0x1::vector::push_back<u64>(&mut v2, 0);
                v3 = v3 + 1;
            };
            0x1::vector::push_back<vector<u64>>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    fun drop_disc(arg0: &mut GameBoard, arg1: u64) {
        check_version_GameBoard(arg0);
        assert!(arg1 < 7, 0);
        let v0 = b"jsjsjsj";
        0x1::debug::print<vector<u8>>(&v0);
        let v1 = 0;
        while (v1 < 6) {
            if (*0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&arg0.board, v1), arg1) == 0) {
                let v2 = &mut arg0.board;
                change_element(v2, v1, arg1, arg0.current_player);
                let v3 = b"jsj";
                0x1::debug::print<vector<u8>>(&v3);
                if (check_for_win(&arg0.board, arg0.current_player)) {
                    arg0.is_game_over = true;
                    arg0.winner = arg0.current_player;
                };
                if (arg0.current_player == 1) {
                    arg0.current_player = 2;
                } else {
                    arg0.current_player = 1;
                };
                return
            };
            v1 = v1 + 1;
        };
    }

    public(friend) fun getBoard(arg0: &GameBoard) : vector<vector<u64>> {
        check_version_GameBoard(arg0);
        arg0.board
    }

    public(friend) fun getGameId(arg0: &GameBoard) : address {
        check_version_GameBoard(arg0);
        0x2::object::uid_to_address(&arg0.id)
    }

    public(friend) fun getGameType(arg0: &GameBoard) : u64 {
        check_version_GameBoard(arg0);
        arg0.gameType
    }

    public(friend) fun getNonce(arg0: &GameBoard) : u64 {
        check_version_GameBoard(arg0);
        arg0.nonce
    }

    public(friend) fun getP1(arg0: &GameBoard) : address {
        check_version_GameBoard(arg0);
        arg0.p1
    }

    public(friend) fun getP2(arg0: &GameBoard) : address {
        check_version_GameBoard(arg0);
        arg0.p2
    }

    public(friend) fun getWinHandled(arg0: &GameBoard) : bool {
        check_version_GameBoard(arg0);
        arg0.winHandled
    }

    public(friend) fun getWinner(arg0: &GameBoard) : u64 {
        check_version_GameBoard(arg0);
        arg0.winner
    }

    public(friend) fun incrementGameNnce(arg0: &mut GameBoard) {
    }

    public(friend) fun initialize_game(arg0: address, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : address {
        let v0 = 0x2::object::new(arg3);
        let v1 = GameBoard{
            id             : v0,
            board          : create_empty_board(),
            current_player : 1,
            is_game_over   : false,
            p1             : arg0,
            p2             : arg1,
            gameType       : arg2,
            nonce          : 0,
            winner         : 0,
            winHandled     : false,
            version        : 1,
        };
        0x2::transfer::share_object<GameBoard>(v1);
        0x2::object::uid_to_address(&v0)
    }

    public(friend) fun isGameOver(arg0: &GameBoard) : bool {
        check_version_GameBoard(arg0);
        arg0.is_game_over
    }

    public entry fun migrate(arg0: &0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::FFIO::FindFourAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GamesTracker{
            id    : 0x2::object::new(arg1),
            games : 0x2::table::new<address, vector<address>>(arg1),
        };
        0x2::transfer::share_object<GamesTracker>(v0);
    }

    public(friend) fun player_move(arg0: &mut GameBoard, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        check_version_GameBoard(arg0);
        assert!(!arg0.is_game_over, 0);
        assert!(arg0.current_player == 1 && 0x2::tx_context::sender(arg2) == arg0.p1 || arg0.current_player == 2 && 0x2::tx_context::sender(arg2) == arg0.p2, 1);
        drop_disc(arg0, arg1);
    }

    public(friend) fun recordLatestMoveCol(arg0: &mut GameBoard, arg1: u64) {
        check_version_GameBoard(arg0);
        arg0.nonce = arg1;
    }

    public(friend) fun setWinHandled(arg0: &mut GameBoard, arg1: bool) {
        check_version_GameBoard(arg0);
        arg0.winHandled = arg1;
    }

    public fun timerWentOff(arg0: &0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::FFIO::FindFourAdminCap, arg1: &mut GameBoard) {
        check_version_GameBoard(arg1);
        arg1.is_game_over = true;
        if (arg1.current_player == 2) {
            arg1.winner = 1;
        } else {
            arg1.winner = 2;
        };
        let v0 = TimerRanOutEvent{game: getGameId(arg1)};
        0x2::event::emit<TimerRanOutEvent>(v0);
    }

    public entry fun update_version(arg0: &0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::FFIO::FindFourAdminCap, arg1: &mut GameBoard) {
        arg1.version = 1;
    }

    // decompiled from Move bytecode v6
}

