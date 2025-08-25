module 0x6e51446bb0d7c9d9fa516f8a962ab8543412b1ef8375c3caad5e806f5d20a97b::game_room {
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
        participant_vector: vector<address>,
        participants: 0x2::table::Table<address, GameRoomParticipant>,
        min_players_to_start: u64,
        actual_start_time: u64,
        actual_end_time: u64,
    }

    struct GameRoomParticipant has store, key {
        id: 0x2::object::UID,
        player_id: address,
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
        room_counter: u64,
        usdc_treasury: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
    }

    public fun cancel_room(arg0: &mut GameRoomStore, arg1: address, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        let v0 = 0x2::table::borrow_mut<address, GameRoom>(&mut arg0.rooms, arg2);
        assert!(v0.creator == arg1, 4);
        let v1 = b"waiting";
        assert!(0x1::string::as_bytes(&v0.status) == &v1, 5);
        v0.status = 0x1::string::utf8(b"cancelled");
        v0.updated_at = 0x2::clock::timestamp_ms(arg3);
        let v2 = if (v0.is_sponsored) {
            v0.total_prize_pool
        } else {
            v0.entry_fee * v0.current_players
        };
        let v3 = &mut arg0.usdc_treasury;
        let v4 = if (v0.is_sponsored) {
            0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v3, v2, arg4)
        } else {
            let v5 = 0;
            while (v5 < 0x1::vector::length<address>(&v0.participant_vector)) {
                let v6 = *0x1::vector::borrow<address>(&v0.participant_vector, v5);
                if (v6 != v0.creator) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v3, v0.entry_fee, arg4), v6);
                };
                v5 = v5 + 1;
            };
            0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v3, v0.entry_fee, arg4)
        };
        v0.total_prize_pool = 0;
        let v7 = RoomCancelled{
            room_id       : arg2,
            creator       : 0x2::tx_context::sender(arg4),
            refund_amount : v2,
        };
        0x2::event::emit<RoomCancelled>(v7);
        v4
    }

    public fun complete_game(arg0: &mut GameRoomStore, arg1: address, arg2: vector<address>, arg3: vector<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<address, GameRoom>(&mut arg0.rooms, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        v0.status = 0x1::string::utf8(b"completed");
        v0.actual_end_time = v1;
        v0.updated_at = v1;
        let v2 = 0x1::vector::length<address>(&arg2);
        if (v2 == 0) {
            v0.platform_fee_collected = 0;
            v0.total_prize_pool = 0;
            let v3 = &v0.participant_vector;
            let v4 = 0;
            while (v4 < 0x1::vector::length<address>(v3)) {
                let v5 = *0x1::vector::borrow<address>(v3, v4);
                if (0x2::table::contains<address, GameRoomParticipant>(&v0.participants, v5)) {
                    let v6 = 0x2::table::borrow<address, GameRoomParticipant>(&v0.participants, v5);
                    if (v6.entry_fee_paid > 0) {
                        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_treasury, v6.entry_fee_paid, arg5), v5);
                    };
                };
                v4 = v4 + 1;
            };
            let v7 = GameCompleted{
                room_id          : arg1,
                winners          : arg2,
                total_prize_pool : 0,
                platform_fee     : 0,
            };
            0x2::event::emit<GameCompleted>(v7);
            return
        };
        assert!(v2 <= v0.current_players, 11);
        let v8 = v0.total_prize_pool * 7 / 100;
        v0.platform_fee_collected = v8;
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_treasury, v8, arg5), @0x32572830354edf43effe74bb5f67e3fa6aa99bbc0133b9152fce5e30f45ca841);
        };
        let v9 = v0.total_prize_pool - v8;
        let v10 = 0x1::string::as_bytes(&v0.winner_split_rule);
        let v11 = b"winner_takes_all";
        if (v10 == &v11) {
            assert!(v2 == 1, 11);
        } else {
            let v12 = b"top_2";
            if (v10 == &v12) {
                assert!(v2 == 2, 11);
            } else {
                let v13 = b"top_3";
                if (v10 == &v13) {
                    assert!(v2 == 3, 11);
                } else {
                    let v14 = b"top_4";
                    if (v10 == &v14) {
                        assert!(v2 == 4, 11);
                    } else {
                        let v15 = b"top_5";
                        if (v10 == &v15) {
                            assert!(v2 == 5, 11);
                        } else {
                            let v16 = b"top_10";
                            if (v10 == &v16) {
                                assert!(v2 == 10, 11);
                            };
                        };
                    };
                };
            };
        };
        let v17 = 0;
        let v18 = 0;
        while (v17 < v2) {
            let v19 = b"winner_takes_all";
            let v20 = if (v10 == &v19) {
                if (v17 == 0) {
                    v9
                } else {
                    0
                }
            } else {
                let v21 = b"top_2";
                if (v10 == &v21) {
                    if (v17 == 0) {
                        v9 * 60 / 100
                    } else {
                        0
                    }
                } else {
                    let v22 = b"top_3";
                    if (v10 == &v22) {
                        if (v17 == 0) {
                            v9 * 50 / 100
                        } else if (v17 == 1) {
                            v9 * 30 / 100
                        } else {
                            0
                        }
                    } else {
                        let v23 = b"top_4";
                        if (v10 == &v23) {
                            if (v17 == 0) {
                                v9 * 40 / 100
                            } else if (v17 == 1) {
                                v9 * 30 / 100
                            } else if (v17 == 2) {
                                v9 * 20 / 100
                            } else {
                                0
                            }
                        } else {
                            let v24 = b"top_5";
                            if (v10 == &v24) {
                                if (v17 == 0) {
                                    v9 * 30 / 100
                                } else if (v17 == 1) {
                                    v9 * 25 / 100
                                } else if (v17 == 2) {
                                    v9 * 20 / 100
                                } else if (v17 == 3) {
                                    v9 * 15 / 100
                                } else {
                                    0
                                }
                            } else if (v17 == 0) {
                                v9 * 20 / 100
                            } else if (v17 == 1) {
                                v9 * 15 / 100
                            } else if (v17 == 2) {
                                v9 * 12 / 100
                            } else if (v17 == 3) {
                                v9 * 10 / 100
                            } else if (v17 == 4 || v17 == 5) {
                                v9 * 8 / 100
                            } else {
                                let v25 = if (v17 == 6) {
                                    true
                                } else if (v17 == 7) {
                                    true
                                } else {
                                    v17 == 8
                                };
                                if (v25) {
                                    v9 * 7 / 100
                                } else {
                                    0
                                }
                            }
                        }
                    }
                }
            };
            let v26 = v18 + v20;
            v18 = v26;
            let v27 = if (v17 == v2 - 1) {
                v9 - v26 - v20
            } else {
                v20
            };
            let v28 = *0x1::vector::borrow<address>(&arg2, v17);
            if (0x2::table::contains<address, GameRoomParticipant>(&v0.participants, v28)) {
                let v29 = 0x2::table::borrow_mut<address, GameRoomParticipant>(&mut v0.participants, v28);
                v29.is_winner = true;
                v29.earnings = v27;
                v29.score = *0x1::vector::borrow<u64>(&arg3, v17);
            };
            if (v27 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_treasury, v27, arg5), v28);
            };
            v17 = v17 + 1;
        };
        v0.total_prize_pool = 0;
        let v30 = GameCompleted{
            room_id          : arg1,
            winners          : arg2,
            total_prize_pool : v0.total_prize_pool,
            platform_fee     : v8,
        };
        0x2::event::emit<GameCompleted>(v30);
    }

    public fun create_room_with_usdc(arg0: &mut GameRoomStore, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: u64, arg6: bool, arg7: 0x1::string::String, arg8: bool, arg9: u64, arg10: 0x1::string::String, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg15: &mut 0x2::tx_context::TxContext) : (address, 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        let v0 = 0x2::clock::timestamp_ms(arg13);
        let v1 = 0x2::tx_context::sender(arg15);
        let v2 = b"USDC";
        assert!(0x1::string::as_bytes(&arg4) == &v2, 3);
        if (arg8) {
            assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg14) >= arg9, 13);
        } else {
            assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg14) >= arg3, 3);
        };
        let v3 = if (arg8) {
            arg9
        } else {
            arg3
        };
        let v4 = GameRoomParticipant{
            id                       : 0x2::object::new(arg15),
            player_id                : v1,
            score                    : 0,
            wallet_address           : v1,
            entry_fee_paid           : arg3,
            entry_fee_transaction_id : 0x2::object::new(arg15),
            payout_transaction_id    : 0x2::object::new(arg15),
            payout_amount            : 0,
            joined_at                : v0,
            is_active                : true,
            left_at                  : 0,
            is_winner                : false,
            earnings                 : 0,
        };
        let v5 = 0x2::table::new<address, GameRoomParticipant>(arg15);
        0x2::table::add<address, GameRoomParticipant>(&mut v5, v1, v4);
        let v6 = 0x1::string::utf8(0x1::string::into_bytes(arg1));
        let v7 = GameRoom{
            id                     : 0x2::object::new(arg15),
            name                   : 0x1::string::utf8(0x1::string::into_bytes(v6)),
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
            participant_vector     : 0x1::vector::singleton<address>(v1),
            participants           : v5,
            min_players_to_start   : 1,
            actual_start_time      : 0,
            actual_end_time        : 0,
        };
        let v8 = 0x2::object::uid_to_address(&v7.id);
        0x2::table::add<address, GameRoom>(&mut arg0.rooms, v8, v7);
        arg0.room_counter = arg0.room_counter + 1;
        let v9 = if (!arg8) {
            if (0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg14) > arg3) {
                0x2::coin::put<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_treasury, 0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg14, arg3, arg15));
                arg14
            } else {
                0x2::coin::put<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_treasury, arg14);
                0x2::coin::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg15)
            }
        } else if (0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg14) > arg9) {
            0x2::coin::put<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_treasury, 0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg14, arg9, arg15));
            arg14
        } else {
            0x2::coin::put<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_treasury, arg14);
            0x2::coin::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg15)
        };
        let v10 = RoomCreated{
            room_id      : v8,
            creator      : v1,
            name         : v6,
            entry_fee    : arg3,
            max_players  : arg5,
            is_sponsored : arg8,
            is_private   : arg6,
        };
        0x2::event::emit<RoomCreated>(v10);
        (v8, v9)
    }

    public fun fetch_room(arg0: &GameRoomStore, arg1: address) : &GameRoom {
        assert!(0x2::table::contains<address, GameRoom>(&arg0.rooms, arg1), 2);
        0x2::table::borrow<address, GameRoom>(&arg0.rooms, arg1)
    }

    public fun get_game_room_rules(arg0: &GameRoomStore, arg1: address) : (&0x1::string::String, &0x1::string::String, u64, u64, &0x1::string::String) {
        let v0 = 0x2::table::borrow<address, GameRoom>(&arg0.rooms, arg1);
        (&v0.winner_split_rule, &v0.currency, v0.entry_fee, v0.max_players, &v0.status)
    }

    public fun get_participant_details(arg0: &GameRoomStore, arg1: address, arg2: address) : &GameRoomParticipant {
        let v0 = 0x2::table::borrow<address, GameRoom>(&arg0.rooms, arg1);
        assert!(0x2::table::contains<address, GameRoomParticipant>(&v0.participants, arg2), 9);
        0x2::table::borrow<address, GameRoomParticipant>(&v0.participants, arg2)
    }

    public fun get_room_details(arg0: &GameRoomStore, arg1: address) : &GameRoom {
        0x2::table::borrow<address, GameRoom>(&arg0.rooms, arg1)
    }

    public fun get_room_participants(arg0: &GameRoomStore, arg1: address) : &0x2::table::Table<address, GameRoomParticipant> {
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
            room_counter     : 0,
            usdc_treasury    : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
        };
        0x2::transfer::share_object<GameRoomStore>(v1);
    }

    public fun is_player_in_room(arg0: &GameRoomStore, arg1: address, arg2: address) : bool {
        let v0 = 0x2::table::borrow<address, GameRoom>(&arg0.rooms, arg1);
        if (!0x2::table::contains<address, GameRoomParticipant>(&v0.participants, arg2)) {
            return false
        };
        0x2::table::borrow<address, GameRoomParticipant>(&v0.participants, arg2).is_active
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
        assert!(!0x2::table::contains<address, GameRoomParticipant>(&v0.participants, v4), 14);
        let v5 = if (v0.is_sponsored) {
            0
        } else {
            v0.entry_fee
        };
        let v6 = GameRoomParticipant{
            id                       : 0x2::object::new(arg5),
            player_id                : v4,
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
        v0.current_players = v0.current_players + 1;
        v0.updated_at = v3;
        0x1::vector::push_back<address>(&mut v0.participant_vector, v4);
        0x2::table::add<address, GameRoomParticipant>(&mut v0.participants, v4, v6);
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

    public fun leave_room(arg0: &mut GameRoomStore, arg1: address, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        let v0 = 0x2::table::borrow_mut<address, GameRoom>(&mut arg0.rooms, arg2);
        let v1 = b"waiting";
        assert!(0x1::string::as_bytes(&v0.status) == &v1, 5);
        let v2 = 0;
        let v3 = false;
        while (v2 < 0x1::vector::length<address>(&v0.participant_vector) && !v3) {
            if (0x1::vector::borrow<address>(&v0.participant_vector, v2) == &arg1) {
                0x1::vector::remove<address>(&mut v0.participant_vector, v2);
                v3 = true;
                continue
            };
            v2 = v2 + 1;
        };
        v0.current_players = v0.current_players - 1;
        v0.updated_at = 0x2::clock::timestamp_ms(arg3);
        let v4 = 0x2::table::borrow_mut<address, GameRoomParticipant>(&mut v0.participants, arg1);
        assert!(v4.is_active, 9);
        v4.is_active = false;
        v4.left_at = 0x2::clock::timestamp_ms(arg3);
        let v5 = if (v0.is_sponsored) {
            0
        } else {
            v0.entry_fee
        };
        if (v5 > 0) {
            v0.total_prize_pool = v0.total_prize_pool - v5;
        };
        let v6 = PlayerLeft{
            room_id       : arg2,
            player        : arg1,
            refund_amount : v5,
        };
        0x2::event::emit<PlayerLeft>(v6);
        0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_treasury, v5, arg4)
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

