module 0x5e1a0390e0c057dab7b9cab54e4184391b7700802bc6b3200e5fde77373ff1e3::game_room {
    struct GameRoom has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        game_id: 0x1::string::String,
        entry_fee: u64,
        currency: 0x1::string::String,
        max_players: u64,
        current_players: u64,
        is_private: bool,
        room_code: 0x1::string::String,
        is_sponsored: bool,
        sponsor_amount: u64,
        winner_split_rule: 0x1::string::String,
        status: 0x1::string::String,
        start_time: u64,
        end_time: u64,
        total_prize_pool: u64,
        platform_fee_collected: u64,
        created_at: u64,
        updated_at: u64,
        creator: address,
        participants: vector<address>,
        min_players_to_start: u64,
        actual_start_time: u64,
        actual_end_time: u64,
    }

    struct GameRoomParticipant has store, key {
        id: 0x2::object::UID,
        player_id: address,
        room_id: address,
        score: u64,
        wallet_address: address,
        entry_fee_paid: u64,
        entry_fee_transaction_id: 0x2::object::UID,
        payout_transaction_id: 0x2::object::UID,
        payout_amount: u64,
        joined_at: u64,
        is_active: bool,
        left_at: u64,
        is_winner: bool,
        earnings: u64,
    }

    struct RoomManagerCap has store, key {
        id: 0x2::object::UID,
    }

    struct RoomCreated has copy, drop {
        room_id: address,
        creator: address,
        name: 0x1::string::String,
        entry_fee: u64,
        max_players: u64,
        is_sponsored: bool,
        is_private: bool,
    }

    struct PlayerJoined has copy, drop {
        room_id: address,
        player: address,
        entry_fee_paid: u64,
    }

    struct PlayerLeft has copy, drop {
        room_id: address,
        player: address,
        refund_amount: u64,
    }

    struct RoomStarted has copy, drop {
        room_id: address,
        start_time: u64,
        player_count: u64,
    }

    struct GameCompleted has copy, drop {
        room_id: address,
        winners: vector<address>,
        total_prize_pool: u64,
        platform_fee: u64,
    }

    struct RoomCancelled has copy, drop {
        room_id: address,
        creator: address,
        refund_amount: u64,
    }

    struct GameRoomStore has store, key {
        id: 0x2::object::UID,
        room_manager_cap: RoomManagerCap,
        rooms: 0x2::table::Table<address, GameRoom>,
        participants: 0x2::table::Table<address, GameRoomParticipant>,
        room_counter: u64,
        usdc_treasury: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
    }

    public fun cancel_room(arg0: &mut GameRoomStore, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        let v0 = 0x2::table::borrow_mut<address, GameRoom>(&mut arg0.rooms, arg1);
        assert!(v0.creator == 0x2::tx_context::sender(arg3), 4);
        let v1 = b"waiting";
        assert!(0x1::string::as_bytes(&v0.status) == &v1, 5);
        v0.status = 0x1::string::utf8(b"cancelled");
        v0.updated_at = 0x2::clock::timestamp_ms(arg2);
        let v2 = if (v0.is_sponsored) {
            v0.total_prize_pool
        } else {
            v0.entry_fee * 0x1::vector::length<address>(&v0.participants)
        };
        let v3 = &mut arg0.usdc_treasury;
        let v4 = if (v0.is_sponsored) {
            0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v3, v0.total_prize_pool, arg3)
        } else {
            let v5 = 0;
            while (v5 < 0x1::vector::length<address>(&v0.participants)) {
                let v6 = *0x1::vector::borrow<address>(&v0.participants, v5);
                if (v6 != v0.creator) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v3, v0.entry_fee, arg3), v6);
                };
                v5 = v5 + 1;
            };
            0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v3, v0.entry_fee, arg3)
        };
        v0.total_prize_pool = 0;
        let v7 = RoomCancelled{
            room_id       : arg1,
            creator       : 0x2::tx_context::sender(arg3),
            refund_amount : v2,
        };
        0x2::event::emit<RoomCancelled>(v7);
        v4
    }

    public fun complete_game(arg0: &mut GameRoomStore, arg1: address, arg2: vector<address>, arg3: vector<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<address, GameRoom>(&mut arg0.rooms, arg1);
        let v1 = b"ongoing";
        assert!(0x1::string::as_bytes(&v0.status) == &v1, 6);
        assert!(v0.current_players >= v0.min_players_to_start, 10);
        assert!(0x1::vector::length<address>(&arg2) > 0, 11);
        assert!(0x1::vector::length<address>(&arg2) <= v0.current_players, 11);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        v0.status = 0x1::string::utf8(b"completed");
        v0.actual_end_time = v2;
        v0.updated_at = v2;
        let v3 = v0.total_prize_pool * 7 / 100;
        v0.platform_fee_collected = v3;
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_treasury, v3, arg5), @0x32572830354edf43effe74bb5f67e3fa6aa99bbc0133b9152fce5e30f45ca841);
        };
        let v4 = v0.total_prize_pool - v3;
        let v5 = 0x1::vector::length<address>(&arg2);
        let v6 = 0x1::string::as_bytes(&v0.winner_split_rule);
        let v7 = b"winner_takes_all";
        if (v6 == &v7) {
            assert!(v5 == 1, 11);
        } else {
            let v8 = b"top_2";
            if (v6 == &v8) {
                assert!(v5 == 2, 11);
            } else {
                let v9 = b"top_3";
                if (v6 == &v9) {
                    assert!(v5 == 3, 11);
                } else {
                    let v10 = b"top_4";
                    if (v6 == &v10) {
                        assert!(v5 == 4, 11);
                    } else {
                        let v11 = b"top_5";
                        if (v6 == &v11) {
                            assert!(v5 == 5, 11);
                        } else {
                            let v12 = b"top_10";
                            if (v6 == &v12) {
                                assert!(v5 == 10, 11);
                            };
                        };
                    };
                };
            };
        };
        let v13 = 0;
        let v14 = 0;
        while (v13 < v5) {
            let v15 = b"winner_takes_all";
            let v16 = if (v6 == &v15) {
                if (v13 == 0) {
                    v4
                } else {
                    0
                }
            } else {
                let v17 = b"top_2";
                if (v6 == &v17) {
                    if (v13 == 0) {
                        v4 * 60 / 100
                    } else {
                        0
                    }
                } else {
                    let v18 = b"top_3";
                    if (v6 == &v18) {
                        if (v13 == 0) {
                            v4 * 50 / 100
                        } else if (v13 == 1) {
                            v4 * 30 / 100
                        } else {
                            0
                        }
                    } else {
                        let v19 = b"top_4";
                        if (v6 == &v19) {
                            if (v13 == 0) {
                                v4 * 40 / 100
                            } else if (v13 == 1) {
                                v4 * 30 / 100
                            } else if (v13 == 2) {
                                v4 * 20 / 100
                            } else {
                                0
                            }
                        } else {
                            v4 / v5
                        }
                    }
                }
            };
            let v20 = v14 + v16;
            v14 = v20;
            let v21 = if (v13 == v5 - 1) {
                v4 - v20 - v16
            } else {
                v16
            };
            let v22 = *0x1::vector::borrow<address>(&arg2, v13);
            if (0x2::table::contains<address, GameRoomParticipant>(&arg0.participants, v22)) {
                let v23 = 0x2::table::borrow_mut<address, GameRoomParticipant>(&mut arg0.participants, v22);
                v23.is_winner = true;
                v23.earnings = v21;
                v23.score = *0x1::vector::borrow<u64>(&arg3, v13);
            };
            if (v21 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_treasury, v21, arg5), v22);
            };
            v13 = v13 + 1;
        };
        v0.total_prize_pool = 0;
        let v24 = GameCompleted{
            room_id          : arg1,
            winners          : arg2,
            total_prize_pool : v0.total_prize_pool,
            platform_fee     : v3,
        };
        0x2::event::emit<GameCompleted>(v24);
    }

    public fun create_room_with_usdc(arg0: &mut GameRoomStore, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: u64, arg6: bool, arg7: 0x1::string::String, arg8: bool, arg9: u64, arg10: 0x1::string::String, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext, arg15: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) : (address, 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        let v0 = 0x2::clock::timestamp_ms(arg13);
        let v1 = 0x2::tx_context::sender(arg14);
        let v2 = b"USDC";
        assert!(0x1::string::as_bytes(&arg4) == &v2, 3);
        if (arg8) {
            assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg15) >= arg9, 13);
        } else {
            assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg15) >= arg3, 3);
        };
        let v3 = if (arg8) {
            arg9
        } else {
            arg3
        };
        let v4 = GameRoom{
            id                     : 0x2::object::new(arg14),
            name                   : arg1,
            game_id                : arg2,
            entry_fee              : arg3,
            currency               : arg4,
            max_players            : arg5,
            current_players        : 1,
            is_private             : arg6,
            room_code              : arg7,
            is_sponsored           : arg8,
            sponsor_amount         : arg9,
            winner_split_rule      : arg10,
            status                 : 0x1::string::utf8(b"waiting"),
            start_time             : arg11,
            end_time               : arg12,
            total_prize_pool       : v3,
            platform_fee_collected : 0,
            created_at             : v0,
            updated_at             : v0,
            creator                : v1,
            participants           : 0x1::vector::singleton<address>(v1),
            min_players_to_start   : 1,
            actual_start_time      : 0,
            actual_end_time        : 0,
        };
        let v5 = 0x2::object::uid_to_address(&v4.id);
        let v6 = GameRoomParticipant{
            id                       : 0x2::object::new(arg14),
            player_id                : v1,
            room_id                  : v5,
            score                    : 0,
            wallet_address           : v1,
            entry_fee_paid           : arg3,
            entry_fee_transaction_id : 0x2::object::new(arg14),
            payout_transaction_id    : 0x2::object::new(arg14),
            payout_amount            : 0,
            joined_at                : v0,
            is_active                : true,
            left_at                  : 0,
            is_winner                : false,
            earnings                 : 0,
        };
        0x2::table::add<address, GameRoom>(&mut arg0.rooms, v5, v4);
        0x2::table::add<address, GameRoomParticipant>(&mut arg0.participants, v1, v6);
        arg0.room_counter = arg0.room_counter + 1;
        let v7 = if (!arg8) {
            if (0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg15) > arg3) {
                0x2::coin::put<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_treasury, 0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg15, arg3, arg14));
                arg15
            } else {
                0x2::coin::put<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_treasury, arg15);
                0x2::coin::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg14)
            }
        } else if (0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg15) > arg9) {
            0x2::coin::put<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_treasury, 0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg15, arg9, arg14));
            arg15
        } else {
            0x2::coin::put<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_treasury, arg15);
            0x2::coin::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg14)
        };
        let v8 = RoomCreated{
            room_id      : v5,
            creator      : v1,
            name         : 0x1::string::utf8(b"waiting"),
            entry_fee    : arg3,
            max_players  : arg5,
            is_sponsored : arg8,
            is_private   : arg6,
        };
        0x2::event::emit<RoomCreated>(v8);
        (v5, v7)
    }

    public fun fetch_room(arg0: &GameRoomStore, arg1: address) : &GameRoom {
        assert!(0x2::table::contains<address, GameRoom>(&arg0.rooms, arg1), 2);
        0x2::table::borrow<address, GameRoom>(&arg0.rooms, arg1)
    }

    public fun get_game_room_rules(arg0: &GameRoomStore, arg1: address) : (&0x1::string::String, &0x1::string::String, u64, u64, &0x1::string::String) {
        let v0 = 0x2::table::borrow<address, GameRoom>(&arg0.rooms, arg1);
        (&v0.winner_split_rule, &v0.currency, v0.entry_fee, v0.max_players, &v0.status)
    }

    public fun get_participant_details(arg0: &GameRoomStore, arg1: address) : &GameRoomParticipant {
        assert!(0x2::table::contains<address, GameRoomParticipant>(&arg0.participants, arg1), 9);
        0x2::table::borrow<address, GameRoomParticipant>(&arg0.participants, arg1)
    }

    public fun get_room_details(arg0: &GameRoomStore, arg1: address) : &GameRoom {
        0x2::table::borrow<address, GameRoom>(&arg0.rooms, arg1)
    }

    public fun get_room_participants(arg0: &GameRoomStore, arg1: address) : &vector<address> {
        &0x2::table::borrow<address, GameRoom>(&arg0.rooms, arg1).participants
    }

    public fun get_total_rooms(arg0: &GameRoomStore) : u64 {
        arg0.room_counter
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RoomManagerCap{id: 0x2::object::new(arg0)};
        let v1 = GameRoomStore{
            id               : 0x2::object::new(arg0),
            room_manager_cap : v0,
            rooms            : 0x2::table::new<address, GameRoom>(arg0),
            participants     : 0x2::table::new<address, GameRoomParticipant>(arg0),
            room_counter     : 0,
            usdc_treasury    : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
        };
        0x2::transfer::share_object<GameRoomStore>(v1);
    }

    public fun is_player_in_room(arg0: &GameRoomStore, arg1: address, arg2: address) : bool {
        let v0 = 0x2::table::borrow<address, GameRoom>(&arg0.rooms, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&v0.participants)) {
            if (0x1::vector::borrow<address>(&v0.participants, v1) == &arg2) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    public fun join_room(arg0: &mut GameRoomStore, arg1: address, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (address, 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        let v0 = 0x2::table::borrow_mut<address, GameRoom>(&mut arg0.rooms, arg1);
        if (v0.is_private) {
            assert!(0x1::string::as_bytes(&v0.room_code) == 0x1::string::as_bytes(&arg2), 12);
        };
        assert!(v0.current_players < v0.max_players, 1);
        let v1 = b"cancelled";
        let v2 = b"completed";
        assert!(0x1::string::as_bytes(&v0.status) != &v1, 7);
        assert!(0x1::string::as_bytes(&v0.status) != &v2, 8);
        if (!v0.is_sponsored) {
            assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg3) >= v0.entry_fee, 3);
        };
        let v3 = 0x2::clock::timestamp_ms(arg4);
        let v4 = 0x2::tx_context::sender(arg5);
        let v5 = if (v0.is_sponsored) {
            0
        } else {
            v0.entry_fee
        };
        let v6 = GameRoomParticipant{
            id                       : 0x2::object::new(arg5),
            player_id                : v4,
            room_id                  : arg1,
            score                    : 0,
            wallet_address           : v4,
            entry_fee_paid           : v5,
            entry_fee_transaction_id : 0x2::object::new(arg5),
            payout_transaction_id    : 0x2::object::new(arg5),
            payout_amount            : 0,
            joined_at                : v3,
            is_active                : true,
            left_at                  : 0,
            is_winner                : false,
            earnings                 : 0,
        };
        0x1::vector::push_back<address>(&mut v0.participants, v4);
        v0.current_players = v0.current_players + 1;
        v0.updated_at = v3;
        0x2::table::add<address, GameRoomParticipant>(&mut arg0.participants, v4, v6);
        let v7 = if (!v0.is_sponsored) {
            let v7 = if (0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg3) > v0.entry_fee) {
                0x2::coin::put<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_treasury, 0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg3, v0.entry_fee, arg5));
                arg3
            } else {
                0x2::coin::put<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_treasury, arg3);
                0x2::coin::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg5)
            };
            v0.total_prize_pool = v0.total_prize_pool + v0.entry_fee;
            v7
        } else {
            arg3
        };
        let v8 = if (v0.is_sponsored) {
            0
        } else {
            v0.entry_fee
        };
        let v9 = PlayerJoined{
            room_id        : arg1,
            player         : v4,
            entry_fee_paid : v8,
        };
        0x2::event::emit<PlayerJoined>(v9);
        (0x2::object::uid_to_address(&v6.id), v7)
    }

    public fun leave_room(arg0: &mut GameRoomStore, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<address, GameRoom>(&mut arg0.rooms, arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = b"waiting";
        assert!(0x1::string::as_bytes(&v0.status) == &v2, 5);
        let v3 = 0;
        let v4 = false;
        while (v3 < 0x1::vector::length<address>(&v0.participants) && !v4) {
            if (0x1::vector::borrow<address>(&v0.participants, v3) == &v1) {
                0x1::vector::remove<address>(&mut v0.participants, v3);
                v4 = true;
                continue
            };
            v3 = v3 + 1;
        };
        assert!(v4, 9);
        v0.current_players = v0.current_players - 1;
        v0.updated_at = 0x2::clock::timestamp_ms(arg2);
        let v5 = 0x2::table::borrow_mut<address, GameRoomParticipant>(&mut arg0.participants, v1);
        v5.is_active = false;
        v5.left_at = 0x2::clock::timestamp_ms(arg2);
        let v6 = if (v0.is_sponsored) {
            0
        } else {
            v0.entry_fee
        };
        if (v6 > 0) {
            v0.total_prize_pool = v0.total_prize_pool - v6;
        };
        let v7 = PlayerLeft{
            room_id       : arg1,
            player        : v1,
            refund_amount : v6,
        };
        0x2::event::emit<PlayerLeft>(v7);
    }

    public fun room_exists(arg0: &GameRoomStore, arg1: address) : bool {
        0x2::table::contains<address, GameRoom>(&arg0.rooms, arg1)
    }

    public fun start_game(arg0: &mut GameRoomStore, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<address, GameRoom>(&mut arg0.rooms, arg1);
        assert!(v0.creator == 0x2::tx_context::sender(arg3), 4);
        let v1 = b"waiting";
        assert!(0x1::string::as_bytes(&v0.status) == &v1, 5);
        assert!(v0.current_players >= v0.min_players_to_start, 10);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        v0.status = 0x1::string::utf8(b"ongoing");
        v0.actual_start_time = v2;
        v0.updated_at = v2;
        let v3 = RoomStarted{
            room_id      : arg1,
            start_time   : v2,
            player_count : v0.current_players,
        };
        0x2::event::emit<RoomStarted>(v3);
    }

    // decompiled from Move bytecode v6
}

