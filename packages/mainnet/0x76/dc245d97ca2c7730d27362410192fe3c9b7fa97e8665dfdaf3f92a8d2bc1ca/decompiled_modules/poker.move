module 0x99d3caafe2e4a26d6f8da03773a672190c13da099c1715aac789254046db99f4::poker {
    struct PokerTable<phantom T0> has key {
        id: 0x2::object::UID,
        asset: u8,
        host: address,
        phase: u8,
        round: u64,
        action_seq: u64,
        street: u8,
        button_seat: u8,
        turn_seat: u8,
        turn_deadline_ms: u64,
        lobby_deadline_ms: u64,
        current_bet: u64,
        min_raise: u64,
        small_blind: u64,
        pot: 0x2::coin::Coin<T0>,
        deck: vector<u8>,
        community_cards: vector<u8>,
        seats: vector<PokerSeat<T0>>,
    }

    struct PokerSeat<phantom T0> has store {
        occupied: bool,
        ready: bool,
        player: address,
        stack: 0x2::coin::Coin<T0>,
        buy_in: u64,
        committed: u64,
        street_committed: u64,
        hole_cards: vector<u8>,
        status: u8,
        payout: u64,
        fee: u64,
        action_seq: u64,
    }

    struct PokerTableCreatedEvent has copy, drop {
        table_id: 0x2::object::ID,
        asset: u8,
        host: address,
    }

    struct PokerTableJoinedEvent has copy, drop {
        table_id: 0x2::object::ID,
        asset: u8,
        round: u64,
        seat: u8,
        player: address,
        buy_in: u64,
    }

    struct PokerTableStartedEvent has copy, drop {
        table_id: 0x2::object::ID,
        asset: u8,
        round: u64,
        seat_count: u8,
        button_seat: u8,
        small_blind: u64,
        big_blind: u64,
    }

    struct PokerActionEvent has copy, drop {
        table_id: 0x2::object::ID,
        asset: u8,
        round: u64,
        action_seq: u64,
        seat: u8,
        player: address,
        action: u8,
        amount: u64,
        street: u8,
        turn_seat: u8,
        turn_deadline_ms: u64,
    }

    struct PokerSettlementEvent has copy, drop {
        table_id: 0x2::object::ID,
        asset: u8,
        round: u64,
        seat: u8,
        player: address,
        hand_score: u64,
        payout: u64,
        fee: u64,
        folded: bool,
    }

    struct PokerTableCancelledEvent has copy, drop {
        table_id: 0x2::object::ID,
        asset: u8,
        host: address,
        round: u64,
    }

    fun act<T0>(arg0: &mut PokerTable<T0>, arg1: u8, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg0.phase == 1, 1);
        assert!(arg0.action_seq == arg3, 7);
        assert!(v0 < arg0.turn_deadline_ms, 8);
        let v1 = (arg0.turn_seat as u64);
        assert!(v1 < 0x1::vector::length<PokerSeat<T0>>(&arg0.seats), 4);
        let v2 = 0x1::vector::borrow<PokerSeat<T0>>(&arg0.seats, v1);
        let v3 = if (v2.occupied) {
            if (v2.player == 0x2::tx_context::sender(arg5)) {
                v2.status == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 6);
        let v4 = 0x1::vector::borrow<PokerSeat<T0>>(&arg0.seats, v1).street_committed;
        let v5 = 0x2::coin::value<T0>(&0x1::vector::borrow<PokerSeat<T0>>(&arg0.seats, v1).stack);
        let v6 = 0;
        if (arg1 == 3) {
            0x1::vector::borrow_mut<PokerSeat<T0>>(&mut arg0.seats, v1).status = 1;
        } else if (arg1 == 0) {
            assert!(v4 == arg0.current_bet, 9);
        } else if (arg1 == 1) {
            assert!(arg0.current_bet >= v4, 9);
            let v7 = arg0.current_bet - v4;
            assert!(v7 > 0, 9);
            let v8 = if (v5 < v7) {
                v5
            } else {
                v7
            };
            v6 = v8;
            commit_amount<T0>(arg0, v1, v8, arg5);
            if (v5 <= v7) {
                0x1::vector::borrow_mut<PokerSeat<T0>>(&mut arg0.seats, v1).status = 2;
            };
        } else {
            assert!(arg1 == 2, 9);
            assert!(arg2 >= arg0.current_bet + arg0.min_raise, 10);
            assert!(arg2 > v4 && arg2 - v4 <= v5, 10);
            let v9 = arg2 - v4;
            v6 = v9;
            commit_amount<T0>(arg0, v1, v9, arg5);
            arg0.min_raise = arg2 - arg0.current_bet;
            arg0.current_bet = arg2;
            if (0x2::coin::value<T0>(&0x1::vector::borrow<PokerSeat<T0>>(&arg0.seats, v1).stack) == 0) {
                0x1::vector::borrow_mut<PokerSeat<T0>>(&mut arg0.seats, v1).status = 2;
            };
        };
        arg0.action_seq = arg0.action_seq + 1;
        0x1::vector::borrow_mut<PokerSeat<T0>>(&mut arg0.seats, v1).action_seq = arg0.action_seq;
        let v10 = 0x1::vector::borrow<PokerSeat<T0>>(&arg0.seats, v1).player;
        let v11 = finish_action<T0>(arg0, v0, arg4, arg5);
        let v12 = PokerActionEvent{
            table_id         : 0x2::object::uid_to_inner(&arg0.id),
            asset            : arg0.asset,
            round            : arg0.round,
            action_seq       : arg0.action_seq,
            seat             : (v1 as u8),
            player           : v10,
            action           : arg1,
            amount           : v6,
            street           : arg0.street,
            turn_seat        : v11,
            turn_deadline_ms : arg0.turn_deadline_ms,
        };
        0x2::event::emit<PokerActionEvent>(v12);
    }

    fun active_count<T0>(arg0: &PokerTable<T0>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<PokerSeat<T0>>(&arg0.seats)) {
            if (0x1::vector::borrow<PokerSeat<T0>>(&arg0.seats, v1).status != 1) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun advance_street<T0>(arg0: &mut PokerTable<T0>) {
        let v0 = arg0.street + 1;
        arg0.street = v0;
        arg0.current_bet = 0;
        arg0.min_raise = 0;
        if (v0 == 1) {
            0x1::vector::push_back<u8>(&mut arg0.community_cards, 0x1::vector::pop_back<u8>(&mut arg0.deck));
            0x1::vector::push_back<u8>(&mut arg0.community_cards, 0x1::vector::pop_back<u8>(&mut arg0.deck));
            0x1::vector::push_back<u8>(&mut arg0.community_cards, 0x1::vector::pop_back<u8>(&mut arg0.deck));
        } else if (v0 == 2 || v0 == 3) {
            0x1::vector::push_back<u8>(&mut arg0.community_cards, 0x1::vector::pop_back<u8>(&mut arg0.deck));
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<PokerSeat<T0>>(&arg0.seats)) {
            0x1::vector::borrow_mut<PokerSeat<T0>>(&mut arg0.seats, v1).street_committed = 0;
            v1 = v1 + 1;
        };
    }

    fun all_in_count<T0>(arg0: &PokerTable<T0>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<PokerSeat<T0>>(&arg0.seats)) {
            if (0x1::vector::borrow<PokerSeat<T0>>(&arg0.seats, v1).status == 2) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun call_jason_poker(arg0: &mut PokerTable<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        act<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(arg0, 1, 0, arg2, arg1, arg3);
    }

    public entry fun call_sui_poker(arg0: &mut PokerTable<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        act<0x2::sui::SUI>(arg0, 1, 0, arg2, arg1, arg3);
    }

    public entry fun cancel_jason_poker_table(arg0: &mut PokerTable<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>, arg1: &mut 0x2::tx_context::TxContext) {
        cancel_table<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(arg0, arg1);
    }

    public entry fun cancel_sui_poker_table(arg0: &mut PokerTable<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        cancel_table<0x2::sui::SUI>(arg0, arg1);
    }

    fun cancel_table<T0>(arg0: &mut PokerTable<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.phase == 0, 0);
        assert!(v0 == arg0.host, 2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<PokerSeat<T0>>(&arg0.seats)) {
            let v2 = 0x1::vector::borrow_mut<PokerSeat<T0>>(&mut arg0.seats, v1);
            if (v2.occupied) {
                let v3 = 0x2::coin::value<T0>(&v2.stack);
                if (v3 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v2.stack, v3, arg1), v2.player);
                };
            };
            v1 = v1 + 1;
        };
        arg0.phase = 3;
        let v4 = PokerTableCancelledEvent{
            table_id : 0x2::object::uid_to_inner(&arg0.id),
            asset    : arg0.asset,
            host     : v0,
            round    : arg0.round,
        };
        0x2::event::emit<PokerTableCancelledEvent>(v4);
    }

    public entry fun check_jason_poker(arg0: &mut PokerTable<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        act<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(arg0, 0, 0, arg2, arg1, arg3);
    }

    public entry fun check_sui_poker(arg0: &mut PokerTable<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        act<0x2::sui::SUI>(arg0, 0, 0, arg2, arg1, arg3);
    }

    fun commit_amount<T0>(arg0: &mut PokerTable<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 > 0) {
            let v0 = 0x1::vector::borrow_mut<PokerSeat<T0>>(&mut arg0.seats, arg1);
            v0.committed = v0.committed + arg2;
            v0.street_committed = v0.street_committed + arg2;
            0x2::coin::join<T0>(&mut arg0.pot, 0x2::coin::split<T0>(&mut v0.stack, arg2, arg3));
        };
    }

    public entry fun create_jason_poker_table(arg0: 0x2::coin::Coin<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&arg0);
        assert!(v0 >= 10000000 && v0 <= 10000000000, 3);
        create_table<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(arg0, v0, 1, arg1, arg2);
    }

    public entry fun create_sui_poker_table(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 >= 10000000 && v0 <= 100000000000, 3);
        create_table<0x2::sui::SUI>(arg0, v0, 0, arg1, arg2);
    }

    fun create_table<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = PokerSeat<T0>{
            occupied         : true,
            ready            : false,
            player           : v0,
            stack            : arg0,
            buy_in           : arg1,
            committed        : 0,
            street_committed : 0,
            hole_cards       : 0x1::vector::empty<u8>(),
            status           : 0,
            payout           : 0,
            fee              : 0,
            action_seq       : 0,
        };
        let v2 = 0x1::vector::empty<PokerSeat<T0>>();
        0x1::vector::push_back<PokerSeat<T0>>(&mut v2, v1);
        let v3 = PokerTable<T0>{
            id                : 0x2::object::new(arg4),
            asset             : arg2,
            host              : v0,
            phase             : 0,
            round             : 0,
            action_seq        : 0,
            street            : 0,
            button_seat       : 0,
            turn_seat         : 255,
            turn_deadline_ms  : 0,
            lobby_deadline_ms : 0x2::clock::timestamp_ms(arg3) + 300000,
            current_bet       : 0,
            min_raise         : 0,
            small_blind       : 0,
            pot               : 0x2::coin::zero<T0>(arg4),
            deck              : 0x1::vector::empty<u8>(),
            community_cards   : 0x1::vector::empty<u8>(),
            seats             : v2,
        };
        let v4 = PokerTableCreatedEvent{
            table_id : 0x2::object::uid_to_inner(&v3.id),
            asset    : arg2,
            host     : v0,
        };
        0x2::event::emit<PokerTableCreatedEvent>(v4);
        0x2::transfer::share_object<PokerTable<T0>>(v3);
    }

    fun deal_hole_cards<T0>(arg0: &mut PokerTable<T0>) {
        let v0 = 0;
        while (v0 < 2) {
            let v1 = 0;
            while (v1 < 0x1::vector::length<PokerSeat<T0>>(&arg0.seats)) {
                0x1::vector::push_back<u8>(&mut 0x1::vector::borrow_mut<PokerSeat<T0>>(&mut arg0.seats, v1).hole_cards, 0x1::vector::pop_back<u8>(&mut arg0.deck));
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
    }

    fun finish_action<T0>(arg0: &mut PokerTable<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = active_count<T0>(arg0);
        if (v0 == 1) {
            settle_table<T0>(arg0, arg3);
            return 255
        };
        if (street_complete<T0>(arg0)) {
            if (arg0.street == 3 || all_in_count<T0>(arg0) == v0) {
                settle_table<T0>(arg0, arg3);
                return 255
            };
            advance_street<T0>(arg0);
        };
        let v1 = next_actionable<T0>(arg0, arg0.turn_seat);
        arg0.turn_seat = v1;
        arg0.turn_deadline_ms = arg1 + 60000;
        v1
    }

    fun five_card_score(arg0: &vector<u8>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, arg1);
        0x1::vector::push_back<u64>(v1, arg2);
        0x1::vector::push_back<u64>(v1, arg3);
        0x1::vector::push_back<u64>(v1, arg4);
        0x1::vector::push_back<u64>(v1, arg5);
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 0;
        while (v4 < 5) {
            let v5 = *0x1::vector::borrow<u8>(arg0, *0x1::vector::borrow<u64>(&v0, v4));
            0x1::vector::push_back<u8>(&mut v2, v5 % 13 + 2);
            0x1::vector::push_back<u8>(&mut v3, v5 / 13);
            v4 = v4 + 1;
        };
        let v6 = &mut v2;
        sort_desc(v6);
        let v7 = if (*0x1::vector::borrow<u8>(&v3, 0) == *0x1::vector::borrow<u8>(&v3, 1)) {
            if (*0x1::vector::borrow<u8>(&v3, 1) == *0x1::vector::borrow<u8>(&v3, 2)) {
                if (*0x1::vector::borrow<u8>(&v3, 2) == *0x1::vector::borrow<u8>(&v3, 3)) {
                    *0x1::vector::borrow<u8>(&v3, 3) == *0x1::vector::borrow<u8>(&v3, 4)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v8 = 0x1::vector::empty<u8>();
        let v9 = 0;
        while (v9 < 15) {
            0x1::vector::push_back<u8>(&mut v8, 0);
            v9 = v9 + 1;
        };
        v4 = 0;
        while (v4 < 5) {
            let v10 = (*0x1::vector::borrow<u8>(&v2, v4) as u64);
            *0x1::vector::borrow_mut<u8>(&mut v8, v10) = *0x1::vector::borrow<u8>(&v8, v10) + 1;
            v4 = v4 + 1;
        };
        let v11 = 0;
        let v12 = 0;
        let v13 = 0;
        let v14 = v13;
        let v15 = 0;
        v9 = 14;
        while (v9 >= 2) {
            let v16 = *0x1::vector::borrow<u8>(&v8, (v9 as u64));
            if (v16 == 4) {
                v11 = v9;
            };
            if (v16 == 3) {
                v12 = v9;
            };
            if (v16 == 2) {
                if (v13 == 0) {
                    v14 = v9;
                } else {
                    v15 = v9;
                };
            };
            if (v9 == 2) {
                break
            };
            v9 = v9 - 1;
        };
        let v17 = 0;
        let v18 = if (*0x1::vector::borrow<u8>(&v8, 14) > 0) {
            if (*0x1::vector::borrow<u8>(&v8, 5) > 0) {
                if (*0x1::vector::borrow<u8>(&v8, 4) > 0) {
                    if (*0x1::vector::borrow<u8>(&v8, 3) > 0) {
                        *0x1::vector::borrow<u8>(&v8, 2) > 0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v18) {
            v17 = 5;
        } else {
            let v19 = 14;
            while (v19 >= 6) {
                let v20 = if (*0x1::vector::borrow<u8>(&v8, (v19 as u64)) > 0) {
                    if (*0x1::vector::borrow<u8>(&v8, ((v19 - 1) as u64)) > 0) {
                        if (*0x1::vector::borrow<u8>(&v8, ((v19 - 2) as u64)) > 0) {
                            if (*0x1::vector::borrow<u8>(&v8, ((v19 - 3) as u64)) > 0) {
                                *0x1::vector::borrow<u8>(&v8, ((v19 - 4) as u64)) > 0
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v20) {
                    v17 = v19;
                    break
                };
                v19 = v19 - 1;
            };
        };
        if (v7 && v17 > 0) {
            return 8000000000000 + (v17 as u64)
        };
        if (v11 > 0) {
            return 7000000000000 + (v11 as u64) * 100 + low_kicker(&v2, v11)
        };
        if (v12 > 0 && (v14 > 0 || v15 > 0)) {
            let v21 = if (v14 == v12) {
                v15
            } else {
                v14
            };
            return 6000000000000 + (v12 as u64) * 100 + (v21 as u64)
        };
        if (v7) {
            return 5000000000000 + kicker_score(&v2)
        };
        if (v17 > 0) {
            return 4000000000000 + (v17 as u64)
        };
        if (v12 > 0) {
            return 3000000000000 + (v12 as u64) * 10000 + kicker_score_excluding(&v2, v12)
        };
        if (v14 > 0 && v15 > 0) {
            return 2000000000000 + (v14 as u64) * 100 + (v15 as u64) * 10 + low_kicker(&v2, v14)
        };
        if (v14 > 0) {
            return 1000000000000 + (v14 as u64) * 100000 + kicker_score_excluding(&v2, v14)
        };
        kicker_score(&v2)
    }

    public entry fun fold_jason_poker(arg0: &mut PokerTable<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        act<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(arg0, 3, 0, arg2, arg1, arg3);
    }

    public entry fun fold_sui_poker(arg0: &mut PokerTable<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        act<0x2::sui::SUI>(arg0, 3, 0, arg2, arg1, arg3);
    }

    fun high_card_score(arg0: &vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            let v2 = v0 * 15;
            v0 = v2 + ((*0x1::vector::borrow<u8>(arg0, v1) % 13 + 2) as u64);
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun join_jason_poker_table(arg0: &mut PokerTable<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>, arg1: 0x2::coin::Coin<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>, arg2: &mut 0x2::tx_context::TxContext) {
        join_table<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(arg0, arg1, 1, arg2);
    }

    public entry fun join_sui_poker_table(arg0: &mut PokerTable<0x2::sui::SUI>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        join_table<0x2::sui::SUI>(arg0, arg1, 0, arg2);
    }

    fun join_table<T0>(arg0: &mut PokerTable<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.phase == 0, 0);
        assert!(arg0.asset == arg2, 12);
        let v0 = 0x2::coin::value<T0>(&arg1);
        if (arg2 == 0) {
            assert!(v0 >= 10000000 && v0 <= 100000000000, 3);
        } else {
            assert!(v0 >= 10000000 && v0 <= 10000000000, 3);
        };
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x1::vector::length<PokerSeat<T0>>(&arg0.seats);
        assert!(v2 < 6, 4);
        let v3 = 0;
        while (v3 < v2) {
            assert!(0x1::vector::borrow<PokerSeat<T0>>(&arg0.seats, v3).player != v1, 4);
            v3 = v3 + 1;
        };
        let v4 = PokerSeat<T0>{
            occupied         : true,
            ready            : false,
            player           : v1,
            stack            : arg1,
            buy_in           : v0,
            committed        : 0,
            street_committed : 0,
            hole_cards       : 0x1::vector::empty<u8>(),
            status           : 0,
            payout           : 0,
            fee              : 0,
            action_seq       : 0,
        };
        0x1::vector::push_back<PokerSeat<T0>>(&mut arg0.seats, v4);
        let v5 = PokerTableJoinedEvent{
            table_id : 0x2::object::uid_to_inner(&arg0.id),
            asset    : arg2,
            round    : arg0.round,
            seat     : (v2 as u8),
            player   : v1,
            buy_in   : v0,
        };
        0x2::event::emit<PokerTableJoinedEvent>(v5);
    }

    fun kicker_score(arg0: &vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            let v2 = v0 * 15;
            v0 = v2 + (*0x1::vector::borrow<u8>(arg0, v1) as u64);
            v1 = v1 + 1;
        };
        v0
    }

    fun kicker_score_excluding(arg0: &vector<u8>, arg1: u8) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v1);
            if (v2 != arg1) {
                let v3 = v0 * 15;
                v0 = v3 + (v2 as u64);
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun low_kicker(arg0: &vector<u8>, arg1: u8) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            let v1 = *0x1::vector::borrow<u8>(arg0, v0);
            if (v1 != arg1) {
                return (v1 as u64)
            };
            v0 = v0 + 1;
        };
        0
    }

    fun next_actionable<T0>(arg0: &PokerTable<T0>, arg1: u8) : u8 {
        let v0 = (0x1::vector::length<PokerSeat<T0>>(&arg0.seats) as u8);
        let v1 = 1;
        while (v1 <= v0) {
            let v2 = ((arg1 as u64) + (v1 as u64)) % (v0 as u64);
            let v3 = 0x1::vector::borrow<PokerSeat<T0>>(&arg0.seats, v2);
            if (v3.occupied && v3.status == 0) {
                return (v2 as u8)
            };
            v1 = v1 + 1;
        };
        255
    }

    fun next_occupied<T0>(arg0: &PokerTable<T0>, arg1: u8) : u8 {
        let v0 = (0x1::vector::length<PokerSeat<T0>>(&arg0.seats) as u8);
        let v1 = 1;
        while (v1 <= v0) {
            let v2 = ((arg1 as u64) + (v1 as u64)) % (v0 as u64);
            if (0x1::vector::borrow<PokerSeat<T0>>(&arg0.seats, v2).occupied) {
                return (v2 as u8)
            };
            v1 = v1 + 1;
        };
        255
    }

    fun poker_score(arg0: &vector<u8>, arg1: &vector<u8>) : u64 {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg1)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg1, v1));
            v1 = v1 + 1;
        };
        if (0x1::vector::length<u8>(&v0) < 5) {
            return high_card_score(&v0)
        };
        let v2 = 0;
        let v3 = v2;
        let v4 = 0x1::vector::length<u8>(&v0);
        let v5 = 0;
        while (v5 + 4 < v4) {
            let v6 = v5 + 1;
            while (v6 + 3 < v4) {
                let v7 = v6 + 1;
                while (v7 + 2 < v4) {
                    let v8 = v7 + 1;
                    while (v8 + 1 < v4) {
                        let v9 = v8 + 1;
                        while (v9 < v4) {
                            let v10 = five_card_score(&v0, v5, v6, v7, v8, v9);
                            if (v10 > v2) {
                                v3 = v10;
                            };
                            v9 = v9 + 1;
                        };
                        v8 = v8 + 1;
                    };
                    v7 = v7 + 1;
                };
                v6 = v6 + 1;
            };
            v5 = v5 + 1;
        };
        v3
    }

    public entry fun raise_jason_poker(arg0: &mut PokerTable<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        act<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(arg0, 2, arg2, arg3, arg1, arg4);
    }

    public entry fun raise_sui_poker(arg0: &mut PokerTable<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        act<0x2::sui::SUI>(arg0, 2, arg2, arg3, arg1, arg4);
    }

    public entry fun set_jason_poker_ready(arg0: &mut PokerTable<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        set_ready<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(arg0, arg1, arg2);
    }

    fun set_ready<T0>(arg0: &mut PokerTable<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.phase == 0, 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<PokerSeat<T0>>(&arg0.seats)) {
            let v1 = 0x1::vector::borrow_mut<PokerSeat<T0>>(&mut arg0.seats, v0);
            if (v1.player == 0x2::tx_context::sender(arg2)) {
                v1.ready = arg1;
                return
            };
            v0 = v0 + 1;
        };
        abort 4
    }

    public entry fun set_sui_poker_ready(arg0: &mut PokerTable<0x2::sui::SUI>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        set_ready<0x2::sui::SUI>(arg0, arg1, arg2);
    }

    fun settle_table<T0>(arg0: &mut PokerTable<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<PokerSeat<T0>>(&arg0.seats)) {
            let v4 = 0x1::vector::borrow<PokerSeat<T0>>(&arg0.seats, v3);
            if (v4.occupied && v4.status != 1) {
                let v5 = poker_score(&v4.hole_cards, &arg0.community_cards);
                if (v5 > v0) {
                    v1 = v5;
                    v2 = 1;
                } else if (v5 == v0) {
                    v2 = v2 + 1;
                };
            };
            v3 = v3 + 1;
        };
        if (v2 == 0) {
            v2 = 1;
        };
        let v6 = 0x2::coin::value<T0>(&arg0.pot);
        let v7 = v6 * 250 / 10000;
        let v8 = v6 - v7;
        let v9 = v8 / v2;
        let v10 = 0;
        v3 = 0;
        while (v3 < 0x1::vector::length<PokerSeat<T0>>(&arg0.seats)) {
            let v11 = 0x1::vector::borrow<PokerSeat<T0>>(&arg0.seats, v3);
            let v12 = v11.player;
            let v13 = v11.status == 1;
            let v14 = if (v11.status == 1) {
                0
            } else {
                poker_score(&v11.hole_cards, &arg0.community_cards)
            };
            if (v11.occupied) {
                let v15 = if (!v13 && v14 == v1) {
                    let v16 = if (v10 == 0) {
                        v8 - v9 * v2
                    } else {
                        0
                    };
                    let v17 = v9 + v16;
                    v10 = v10 + 1;
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.pot, v17, arg1), v12);
                    v17
                } else {
                    0
                };
                let v18 = 0x1::vector::borrow_mut<PokerSeat<T0>>(&mut arg0.seats, v3);
                v18.status = 3;
                v18.payout = v15;
                let v19 = if (v3 == 0) {
                    v7
                } else {
                    0
                };
                v18.fee = v19;
                let v20 = 0x2::coin::value<T0>(&v18.stack);
                if (v20 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut 0x1::vector::borrow_mut<PokerSeat<T0>>(&mut arg0.seats, v3).stack, v20, arg1), v12);
                };
                let v21 = if (v3 == 0) {
                    v7
                } else {
                    0
                };
                let v22 = PokerSettlementEvent{
                    table_id   : 0x2::object::uid_to_inner(&arg0.id),
                    asset      : arg0.asset,
                    round      : arg0.round,
                    seat       : (v3 as u8),
                    player     : v12,
                    hand_score : v14,
                    payout     : v15,
                    fee        : v21,
                    folded     : v13,
                };
                0x2::event::emit<PokerSettlementEvent>(v22);
            };
            v3 = v3 + 1;
        };
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.pot, v7, arg1), @0xd2cebe8666352e1ddb3dc7f271340432c983fc81017b3d6f7873dd66881433a4);
        };
        arg0.phase = 2;
        arg0.turn_seat = 255;
        arg0.turn_deadline_ms = 0;
        arg0.current_bet = 0;
        arg0.min_raise = 0;
    }

    fun shuffled_deck(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 52) {
            0x1::vector::push_back<u8>(&mut v0, v1);
            v1 = v1 + 1;
        };
        let v2 = 0x2::random::new_generator(arg0, arg1);
        let v3 = 51;
        while (v3 > 0) {
            let v4 = 0x2::random::generate_u8_in_range(&mut v2, 0, v3);
            *0x1::vector::borrow_mut<u8>(&mut v0, (v3 as u64)) = *0x1::vector::borrow<u8>(&v0, (v4 as u64));
            *0x1::vector::borrow_mut<u8>(&mut v0, (v4 as u64)) = *0x1::vector::borrow<u8>(&v0, (v3 as u64));
            v3 = v3 - 1;
        };
        v0
    }

    fun sort_desc(arg0: &mut vector<u8>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            let v1 = v0 + 1;
            while (v1 < 0x1::vector::length<u8>(arg0)) {
                if (*0x1::vector::borrow<u8>(arg0, v1) > *0x1::vector::borrow<u8>(arg0, v0)) {
                    *0x1::vector::borrow_mut<u8>(arg0, v0) = *0x1::vector::borrow<u8>(arg0, v1);
                    *0x1::vector::borrow_mut<u8>(arg0, v1) = *0x1::vector::borrow<u8>(arg0, v0);
                };
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
    }

    public entry fun start_jason_poker_table(arg0: &mut PokerTable<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        start_table<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(arg0, arg1, arg2, arg3);
    }

    public entry fun start_sui_poker_table(arg0: &mut PokerTable<0x2::sui::SUI>, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        start_table<0x2::sui::SUI>(arg0, arg1, arg2, arg3);
    }

    fun start_table<T0>(arg0: &mut PokerTable<T0>, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.phase == 0, 0);
        assert!(0x2::tx_context::sender(arg3) == arg0.host, 2);
        let v0 = 0x1::vector::length<PokerSeat<T0>>(&arg0.seats);
        assert!(v0 >= 2, 11);
        let v1 = 0;
        while (v1 < v0) {
            assert!(0x1::vector::borrow<PokerSeat<T0>>(&arg0.seats, v1).ready, 5);
            v1 = v1 + 1;
        };
        let v2 = 0x1::vector::borrow<PokerSeat<T0>>(&arg0.seats, 0).buy_in;
        let v3 = 1;
        while (v3 < v0) {
            assert!(0x1::vector::borrow<PokerSeat<T0>>(&arg0.seats, v3).buy_in == v2, 3);
            v3 = v3 + 1;
        };
        let v4 = if (v2 / 100 > 0) {
            v2 / 100
        } else {
            1
        };
        let v5 = v4 * 2;
        assert!(v2 > v5, 3);
        arg0.small_blind = v4;
        arg0.min_raise = v5;
        arg0.current_bet = v5;
        arg0.button_seat = (arg0.button_seat + 1) % (v0 as u8);
        arg0.round = arg0.round + 1;
        arg0.action_seq = arg0.action_seq + 1;
        arg0.street = 0;
        arg0.community_cards = 0x1::vector::empty<u8>();
        let v6 = shuffled_deck(arg1, arg3);
        arg0.deck = v6;
        deal_hole_cards<T0>(arg0);
        let v7 = next_occupied<T0>(arg0, arg0.button_seat);
        let v8 = next_occupied<T0>(arg0, v7);
        commit_amount<T0>(arg0, (v7 as u64), v4, arg3);
        commit_amount<T0>(arg0, (v8 as u64), v5, arg3);
        arg0.phase = 1;
        arg0.turn_seat = next_actionable<T0>(arg0, v8);
        arg0.turn_deadline_ms = 0x2::clock::timestamp_ms(arg2) + 60000;
        let v9 = PokerTableStartedEvent{
            table_id    : 0x2::object::uid_to_inner(&arg0.id),
            asset       : arg0.asset,
            round       : arg0.round,
            seat_count  : (v0 as u8),
            button_seat : arg0.button_seat,
            small_blind : v4,
            big_blind   : v5,
        };
        0x2::event::emit<PokerTableStartedEvent>(v9);
    }

    fun street_complete<T0>(arg0: &PokerTable<T0>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PokerSeat<T0>>(&arg0.seats)) {
            let v1 = 0x1::vector::borrow<PokerSeat<T0>>(&arg0.seats, v0);
            let v2 = if (v1.occupied) {
                if (v1.status == 0) {
                    v1.street_committed != arg0.current_bet
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    fun timeout<T0>(arg0: &mut PokerTable<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg0.phase == 1, 1);
        assert!(v0 >= arg0.turn_deadline_ms, 8);
        assert!(arg0.action_seq == arg2, 7);
        let v1 = (arg0.turn_seat as u64);
        let v2 = 0x1::vector::borrow<PokerSeat<T0>>(&arg0.seats, v1).player;
        let v3 = 0x1::vector::borrow_mut<PokerSeat<T0>>(&mut arg0.seats, v1);
        assert!(v3.status == 0, 6);
        v3.status = 1;
        arg0.action_seq = arg0.action_seq + 1;
        let v4 = finish_action<T0>(arg0, v0, arg1, arg3);
        let v5 = PokerActionEvent{
            table_id         : 0x2::object::uid_to_inner(&arg0.id),
            asset            : arg0.asset,
            round            : arg0.round,
            action_seq       : arg0.action_seq,
            seat             : (v1 as u8),
            player           : v2,
            action           : 3,
            amount           : 0,
            street           : arg0.street,
            turn_seat        : v4,
            turn_deadline_ms : arg0.turn_deadline_ms,
        };
        0x2::event::emit<PokerActionEvent>(v5);
    }

    public entry fun timeout_jason_poker(arg0: &mut PokerTable<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        timeout<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(arg0, arg1, arg2, arg3);
    }

    public entry fun timeout_sui_poker(arg0: &mut PokerTable<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        timeout<0x2::sui::SUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

