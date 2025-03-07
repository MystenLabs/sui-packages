module 0x154ef998f0708d2fded69507259875c155c427da1d82e0905569679a4d432c49::blackjack {
    struct NewGame<phantom T0> has copy, drop {
        table_id: 0x2::object::ID,
        round_number: u64,
        player: address,
        bet_size: u64,
    }

    struct MoveRequested has copy, drop {
        table_id: 0x2::object::ID,
        round_number: u64,
        current_player_hand_sum: u8,
        move_type: u64,
    }

    struct MoveCompleted has copy, drop {
        table_id: 0x2::object::ID,
        round_number: u64,
        player_hands: vector<Hand>,
        dealer_cards: vector<u8>,
    }

    struct Blackjack has copy, drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct BlackjackConfig has key {
        id: 0x2::object::UID,
        version_set: 0x2::vec_set::VecSet<u64>,
    }

    struct Hand has copy, drop, store {
        cards: vector<u8>,
        status: u64,
        current_sum: u8,
        bet_size: u64,
        is_natural_blackjack: bool,
        is_doubled: bool,
        is_settled: bool,
        bet_returned: u64,
    }

    struct Game<phantom T0> has drop, store {
        bet_size: u64,
        risk: u64,
        current_deck: vector<u8>,
        dealer_cards: vector<u8>,
        start_epoch: u64,
        hands: vector<Hand>,
        origin: 0x1::string::String,
    }

    struct BlackjackTable<phantom T0> has store, key {
        id: 0x2::object::UID,
        creator: address,
        balance: 0x2::balance::Balance<T0>,
        current_game: 0x1::option::Option<Game<T0>>,
        round_number: u64,
    }

    struct BlackjackTag<phantom T0> has copy, drop, store {
        creator: address,
    }

    fun split<T0>(arg0: &mut Game<T0>, arg1: &0x2::random::Random, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<Hand>(&mut arg0.hands, arg2);
        let v1 = b"";
        let v2 = &mut v1;
        let v3 = &mut arg0.current_deck;
        deal_cards(arg1, v2, v3, 2, arg3);
        0x1::vector::push_back<u8>(&mut v0.cards, 0x1::vector::pop_back<u8>(&mut v1));
        v0.current_sum = get_card_sum(&v0.cards);
        v0.status = 100;
        let v4 = 0x1::vector::empty<u8>();
        let v5 = &mut v4;
        0x1::vector::push_back<u8>(v5, 0x1::vector::pop_back<u8>(&mut v0.cards));
        0x1::vector::push_back<u8>(v5, 0x1::vector::pop_back<u8>(&mut v1));
        let v6 = Hand{
            cards                : v4,
            status               : 100,
            current_sum          : get_card_sum(&v4),
            bet_size             : arg0.bet_size,
            is_natural_blackjack : false,
            is_doubled           : false,
            is_settled           : false,
            bet_returned         : 0,
        };
        if (contains_aces(&v0.cards)) {
            v0.status = 102;
            v6.status = 102;
        };
        0x1::vector::push_back<Hand>(&mut arg0.hands, v6);
    }

    public fun assert_all_hands_settled<T0>(arg0: &Game<T0>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Hand>(&arg0.hands)) {
            assert!(0x1::vector::borrow<Hand>(&arg0.hands, v0).is_settled, 12);
            v0 = v0 + 1;
        };
    }

    fun assert_valid_version(arg0: &BlackjackConfig) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &v0), 10);
    }

    public fun bet_size<T0>(arg0: &Game<T0>) : u64 {
        arg0.bet_size
    }

    public fun borrow_blackjack_table<T0>(arg0: &BlackjackConfig, arg1: address) : &BlackjackTable<T0> {
        let v0 = BlackjackTag<T0>{creator: arg1};
        0x2::dynamic_object_field::borrow<BlackjackTag<T0>, BlackjackTable<T0>>(&arg0.id, v0)
    }

    public fun borrow_game<T0>(arg0: &BlackjackConfig, arg1: address) : &Game<T0> {
        let v0 = BlackjackTag<T0>{creator: arg1};
        0x1::option::borrow<Game<T0>>(&0x2::dynamic_object_field::borrow<BlackjackTag<T0>, BlackjackTable<T0>>(&arg0.id, v0).current_game)
    }

    public fun borrow_game_mut<T0>(arg0: &mut BlackjackConfig, arg1: address) : &mut Game<T0> {
        let v0 = BlackjackTag<T0>{creator: arg1};
        0x1::option::borrow_mut<Game<T0>>(&mut 0x2::dynamic_object_field::borrow_mut<BlackjackTag<T0>, BlackjackTable<T0>>(&mut arg0.id, v0).current_game)
    }

    public fun borrow_mut_blackjack_table<T0>(arg0: &mut BlackjackConfig, arg1: address) : &mut BlackjackTable<T0> {
        let v0 = BlackjackTag<T0>{creator: arg1};
        0x2::dynamic_object_field::borrow_mut<BlackjackTag<T0>, BlackjackTable<T0>>(&mut arg0.id, v0)
    }

    fun contains_aces(arg0: &vector<u8>) : bool {
        let v0 = 0;
        let v1 = 13;
        let v2 = 26;
        let v3 = 39;
        0x1::vector::contains<u8>(arg0, &v0) || 0x1::vector::contains<u8>(arg0, &v1) || 0x1::vector::contains<u8>(arg0, &v2) || 0x1::vector::contains<u8>(arg0, &v3)
    }

    fun contains_tens(arg0: &vector<u8>) : bool {
        let v0 = 9;
        let v1 = 22;
        let v2 = 35;
        let v3 = 48;
        0x1::vector::contains<u8>(arg0, &v0) || 0x1::vector::contains<u8>(arg0, &v1) || 0x1::vector::contains<u8>(arg0, &v2) || 0x1::vector::contains<u8>(arg0, &v3)
    }

    fun create_blackjack_hands_to_emit(arg0: Hand) : 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::game_structs::BlackjackHand {
        let Hand {
            cards                : v0,
            status               : v1,
            current_sum          : v2,
            bet_size             : v3,
            is_natural_blackjack : v4,
            is_doubled           : v5,
            is_settled           : v6,
            bet_returned         : v7,
        } = arg0;
        0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::game_structs::blackjack_hand(v0, v1, v2, v3, v4, v5, v6, v7)
    }

    public fun create_blackjack_table<T0>(arg0: &mut BlackjackConfig, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_valid_version(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!table_exists<T0>(arg0, v0), 8);
        let v1 = 0x2::object::new(arg1);
        let v2 = BlackjackTable<T0>{
            id           : v1,
            creator      : v0,
            balance      : 0x2::balance::zero<T0>(),
            current_game : 0x1::option::none<Game<T0>>(),
            round_number : 0,
        };
        let v3 = BlackjackTag<T0>{creator: v0};
        0x2::dynamic_object_field::add<BlackjackTag<T0>, BlackjackTable<T0>>(&mut arg0.id, v3, v2);
        0x2::object::uid_to_inner(&v1)
    }

    public fun current_deck<T0>(arg0: &Game<T0>) : vector<u8> {
        arg0.current_deck
    }

    fun deal_cards(arg0: &0x2::random::Random, arg1: &mut vector<u8>, arg2: &mut vector<u8>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg3) {
            0x1::vector::push_back<u8>(arg1, get_next_random_card(arg0, arg2, arg4));
            v0 = v0 + 1;
        };
    }

    public fun dealer_cards<T0>(arg0: &Game<T0>) : vector<u8> {
        arg0.dealer_cards
    }

    entry fun dealer_move<T0>(arg0: &mut 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::Unihouse, arg1: &mut BlackjackConfig, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::house_exists<T0>(arg0), 7);
        assert_valid_version(arg1);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = borrow_mut_blackjack_table<T0>(arg1, v0);
        let v2 = 0x1::option::borrow_mut<Game<T0>>(&mut v1.current_game);
        let v3 = Blackjack{dummy_field: false};
        0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::assert_within_risk<T0, Blackjack>(arg0, v3, v2.risk, arg3);
        let v4 = 0x2::object::uid_to_inner(&v1.id);
        let v5 = v1.round_number;
        let v6 = player_hands<T0>(v2);
        if (0x1::vector::length<Hand>(&v6) == 0 && 0x1::vector::length<u8>(&v2.dealer_cards) == 0) {
            first_deal<T0>(v1, arg2, arg3);
            let v7 = 0x1::option::borrow_mut<Game<T0>>(&mut v1.current_game);
            let v8 = MoveCompleted{
                table_id     : v4,
                round_number : v5,
                player_hands : player_hands<T0>(v7),
                dealer_cards : dealer_cards<T0>(v7),
            };
            0x2::event::emit<MoveCompleted>(v8);
        } else {
            let v9 = player_hands<T0>(v2);
            let (v10, v11) = get_current_hand_and_status(&v9);
            if (v10 != 200) {
                if (v11 == 101) {
                    hit<T0>(v2, arg2, v10, 100, arg3);
                } else if (v11 == 103) {
                    hit<T0>(v2, arg2, v10, 103, arg3);
                } else if (v11 == 104) {
                    split<T0>(v2, arg2, v10, arg3);
                };
            };
            let v12 = 0x1::option::borrow<Game<T0>>(&v1.current_game);
            let v13 = MoveCompleted{
                table_id     : v4,
                round_number : v5,
                player_hands : player_hands<T0>(v12),
                dealer_cards : dealer_cards<T0>(v12),
            };
            0x2::event::emit<MoveCompleted>(v13);
        };
        let v14 = player_hands<T0>(0x1::option::borrow<Game<T0>>(&v1.current_game));
        let (v15, _) = get_current_hand_and_status(&v14);
        if (v15 == 200) {
            dealer_turn<T0>(v1, arg2, arg3);
            let v17 = 0x1::option::borrow_mut<Game<T0>>(&mut v1.current_game);
            if (get_card_sum(&v17.dealer_cards) <= 21) {
                settle_all_hands<T0>(v17);
            };
            let v18 = borrow_mut_blackjack_table<T0>(arg1, v0);
            let v19 = 0x1::option::extract<Game<T0>>(&mut v18.current_game);
            assert_all_hands_settled<T0>(&v19);
            let Game {
                bet_size     : _,
                risk         : _,
                current_deck : _,
                dealer_cards : v23,
                start_epoch  : _,
                hands        : v25,
                origin       : v26,
            } = v19;
            let v27 = v25;
            let v28 = &v27;
            let v29 = 0x1::vector::empty<0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::game_structs::BlackjackHand>();
            let v30 = 0;
            while (v30 < 0x1::vector::length<Hand>(v28)) {
                0x1::vector::push_back<0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::game_structs::BlackjackHand>(&mut v29, create_blackjack_hands_to_emit(*0x1::vector::borrow<Hand>(v28, v30)));
                v30 = v30 + 1;
            };
            let v31 = &v27;
            let v32 = vector[];
            let v33 = 0;
            while (v33 < 0x1::vector::length<Hand>(v31)) {
                0x1::vector::push_back<u64>(&mut v32, hand_bet_size(0x1::vector::borrow<Hand>(v31, v33)));
                v33 = v33 + 1;
            };
            let v34 = &v27;
            let v35 = vector[];
            let v36 = 0;
            while (v36 < 0x1::vector::length<Hand>(v34)) {
                0x1::vector::push_back<u64>(&mut v35, hand_bet_returned(0x1::vector::borrow<Hand>(v34, v36)));
                v36 = v36 + 1;
            };
            let v37 = 0;
            0x1::vector::reverse<u64>(&mut v32);
            while (!0x1::vector::is_empty<u64>(&v32)) {
                v37 = v37 + 0x1::vector::pop_back<u64>(&mut v32);
            };
            0x1::vector::destroy_empty<u64>(v32);
            let v38 = 0;
            0x1::vector::reverse<u64>(&mut v35);
            while (!0x1::vector::is_empty<u64>(&v35)) {
                v38 = v38 + 0x1::vector::pop_back<u64>(&mut v35);
            };
            0x1::vector::destroy_empty<u64>(v35);
            payout<T0>(arg0, v18, v37, v38, arg3);
            0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::emit_blackjack_game_result<T0, Blackjack>(arg0, v4, v5, v37, v38, v29, v23, v0, v26);
        };
    }

    entry fun dealer_move_0<T0>(arg0: &mut 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::Unihouse, arg1: &mut BlackjackConfig, arg2: &0x2::random::Random, arg3: &0xee0150555a187970285efd82153b0fc87ed0fb53844a3001f4dff3a5e73d70af::pond::SuilendPond<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg5: &0x2::clock::Clock, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::house_exists<T0>(arg0), 7);
        assert_valid_version(arg1);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = borrow_mut_blackjack_table<T0>(arg1, v0);
        let v2 = 0x1::option::borrow_mut<Game<T0>>(&mut v1.current_game);
        let v3 = Blackjack{dummy_field: false};
        0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::assert_within_risk<T0, Blackjack>(arg0, v3, v2.risk, arg8);
        let v4 = 0x2::object::uid_to_inner(&v1.id);
        let v5 = v1.round_number;
        let v6 = player_hands<T0>(v2);
        if (0x1::vector::length<Hand>(&v6) == 0 && 0x1::vector::length<u8>(&v2.dealer_cards) == 0) {
            first_deal<T0>(v1, arg2, arg8);
            let v7 = 0x1::option::borrow_mut<Game<T0>>(&mut v1.current_game);
            let v8 = MoveCompleted{
                table_id     : v4,
                round_number : v5,
                player_hands : player_hands<T0>(v7),
                dealer_cards : dealer_cards<T0>(v7),
            };
            0x2::event::emit<MoveCompleted>(v8);
        } else {
            let v9 = player_hands<T0>(v2);
            let (v10, v11) = get_current_hand_and_status(&v9);
            if (v10 != 200) {
                if (v11 == 101) {
                    hit<T0>(v2, arg2, v10, 100, arg8);
                } else if (v11 == 103) {
                    hit<T0>(v2, arg2, v10, 103, arg8);
                } else if (v11 == 104) {
                    split<T0>(v2, arg2, v10, arg8);
                };
            };
            let v12 = 0x1::option::borrow<Game<T0>>(&v1.current_game);
            let v13 = MoveCompleted{
                table_id     : v4,
                round_number : v5,
                player_hands : player_hands<T0>(v12),
                dealer_cards : dealer_cards<T0>(v12),
            };
            0x2::event::emit<MoveCompleted>(v13);
        };
        let v14 = player_hands<T0>(0x1::option::borrow<Game<T0>>(&v1.current_game));
        let (v15, _) = get_current_hand_and_status(&v14);
        if (v15 == 200) {
            dealer_turn<T0>(v1, arg2, arg8);
            let v17 = 0x1::option::borrow_mut<Game<T0>>(&mut v1.current_game);
            if (get_card_sum(&v17.dealer_cards) <= 21) {
                settle_all_hands<T0>(v17);
            };
            let v18 = borrow_mut_blackjack_table<T0>(arg1, v0);
            let v19 = 0x1::option::extract<Game<T0>>(&mut v18.current_game);
            assert_all_hands_settled<T0>(&v19);
            let Game {
                bet_size     : _,
                risk         : _,
                current_deck : _,
                dealer_cards : v23,
                start_epoch  : _,
                hands        : v25,
                origin       : v26,
            } = v19;
            let v27 = v25;
            let v28 = &v27;
            let v29 = 0x1::vector::empty<0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::game_structs::BlackjackHand>();
            let v30 = 0;
            while (v30 < 0x1::vector::length<Hand>(v28)) {
                0x1::vector::push_back<0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::game_structs::BlackjackHand>(&mut v29, create_blackjack_hands_to_emit(*0x1::vector::borrow<Hand>(v28, v30)));
                v30 = v30 + 1;
            };
            let v31 = &v27;
            let v32 = vector[];
            let v33 = 0;
            while (v33 < 0x1::vector::length<Hand>(v31)) {
                0x1::vector::push_back<u64>(&mut v32, hand_bet_size(0x1::vector::borrow<Hand>(v31, v33)));
                v33 = v33 + 1;
            };
            let v34 = &v27;
            let v35 = vector[];
            let v36 = 0;
            while (v36 < 0x1::vector::length<Hand>(v34)) {
                0x1::vector::push_back<u64>(&mut v35, hand_bet_returned(0x1::vector::borrow<Hand>(v34, v36)));
                v36 = v36 + 1;
            };
            let v37 = 0;
            0x1::vector::reverse<u64>(&mut v32);
            while (!0x1::vector::is_empty<u64>(&v32)) {
                v37 = v37 + 0x1::vector::pop_back<u64>(&mut v32);
            };
            0x1::vector::destroy_empty<u64>(v32);
            let v38 = 0;
            0x1::vector::reverse<u64>(&mut v35);
            while (!0x1::vector::is_empty<u64>(&v35)) {
                v38 = v38 + 0x1::vector::pop_back<u64>(&mut v35);
            };
            0x1::vector::destroy_empty<u64>(v35);
            payout_0<T0>(arg0, v18, v37, v38, arg3, arg4, arg5, arg6, arg7, arg8);
            0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::emit_blackjack_game_result<T0, Blackjack>(arg0, v4, v5, v37, v38, v29, v23, v0, v26);
        };
    }

    fun dealer_turn<T0>(arg0: &mut BlackjackTable<T0>, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::borrow_mut<Game<T0>>(&mut arg0.current_game);
        let v1 = get_card_sum(&v0.dealer_cards);
        while (is_soft_17(&v0.dealer_cards, v1) || v1 < 17) {
            let v2 = &mut v0.dealer_cards;
            let v3 = &mut v0.current_deck;
            deal_cards(arg1, v2, v3, 1, arg2);
            v1 = get_card_sum(&v0.dealer_cards);
        };
        if (v1 > 21) {
            let v4 = 0;
            let v5 = dealer_cards<T0>(v0);
            let v6 = &v5;
            while (v4 < 0x1::vector::length<Hand>(&v0.hands)) {
                let v7 = 0x1::vector::borrow_mut<Hand>(&mut v0.hands, v4);
                if (!v7.is_settled) {
                    tally_hand(v7, v6);
                };
                v4 = v4 + 1;
            };
        };
    }

    fun first_deal<T0>(arg0: &mut BlackjackTable<T0>, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::borrow_mut<Game<T0>>(&mut arg0.current_game);
        let v1 = &mut v0.dealer_cards;
        let v2 = &mut v0.current_deck;
        deal_cards(arg1, v1, v2, 1, arg2);
        let v3 = Hand{
            cards                : b"",
            status               : 100,
            current_sum          : 0,
            bet_size             : v0.bet_size,
            is_natural_blackjack : false,
            is_doubled           : false,
            is_settled           : false,
            bet_returned         : 0,
        };
        let v4 = player_hands_mut<T0>(v0);
        0x1::vector::push_back<Hand>(v4, v3);
        hit<T0>(v0, arg1, 0, 100, arg2);
        hit<T0>(v0, arg1, 0, 100, arg2);
        let v5 = 0x1::option::borrow_mut<Game<T0>>(&mut arg0.current_game);
        let v6 = 0x1::vector::borrow_mut<Hand>(&mut v5.hands, 0);
        let v7 = player_cards(v6);
        if (get_card_sum(&v7) == 21) {
            v6.is_natural_blackjack = true;
            let v8 = v5.dealer_cards;
            if (contains_aces(&v8) || contains_tens(&v8)) {
                let v9 = &mut v5.dealer_cards;
                let v10 = &mut v5.current_deck;
                deal_cards(arg1, v9, v10, 1, arg2);
            };
            tally_hand(v6, &v5.dealer_cards);
        } else {
            v5.risk = v5.bet_size;
        };
    }

    public fun game_exists<T0>(arg0: &BlackjackConfig, arg1: address) : bool {
        let v0 = BlackjackTag<T0>{creator: arg1};
        0x1::option::is_some<Game<T0>>(&0x2::dynamic_object_field::borrow<BlackjackTag<T0>, BlackjackTable<T0>>(&arg0.id, v0).current_game)
    }

    public fun get_card_sum(arg0: &vector<u8>) : u8 {
        let v0 = 0;
        let v1 = 0;
        let v2 = false;
        while (v1 < (0x1::vector::length<u8>(arg0) as u8)) {
            let v3 = *0x1::vector::borrow<u8>(arg0, (v1 as u64)) % 13 + 1;
            let v4 = v3;
            if (v3 == 1) {
                v2 = true;
            };
            if (v3 > 10) {
                v4 = 10;
            };
            v0 = v0 + v4;
            v1 = v1 + 1;
        };
        if (v2 && v0 + 10 <= 21) {
            v0 = v0 + 10;
        };
        v0
    }

    fun get_current_hand_and_status(arg0: &vector<Hand>) : (u64, u64) {
        let v0 = 0;
        assert!(0x1::vector::length<Hand>(arg0) < 5, 1);
        while (v0 < 0x1::vector::length<Hand>(arg0)) {
            let v1 = 0x1::vector::borrow<Hand>(arg0, v0);
            if (v1.status != 102 && v1.status != 106) {
                return (v0, v1.status)
            };
            v0 = v0 + 1;
        };
        (200, 106)
    }

    fun get_next_random_card(arg0: &0x2::random::Random, arg1: &mut vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = 0x2::random::new_generator(arg0, arg2);
        0x1::vector::remove<u8>(arg1, 0x2::random::generate_u64_in_range(&mut v0, 0, 0x1::vector::length<u8>(arg1) - 1))
    }

    public fun hand_bet_returned(arg0: &Hand) : u64 {
        arg0.bet_returned
    }

    public fun hand_bet_size(arg0: &Hand) : u64 {
        arg0.bet_size
    }

    public fun hand_status(arg0: &Hand) : u64 {
        arg0.status
    }

    fun hit<T0>(arg0: &mut Game<T0>, arg1: &0x2::random::Random, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<Hand>(&mut arg0.hands, arg2);
        if (arg3 == 103) {
            v0.is_doubled = true;
            v0.bet_size = v0.bet_size + arg0.bet_size;
            v0.status = 102;
        };
        if (arg3 == 100) {
            v0.status = 100;
        };
        let v1 = &mut v0.cards;
        let v2 = &mut arg0.current_deck;
        deal_cards(arg1, v1, v2, 1, arg4);
        v0.current_sum = get_card_sum(&v0.cards);
        if (v0.current_sum >= 21) {
            v0.status = 102;
            if (v0.current_sum > 21) {
                tally_hand(v0, &arg0.dealer_cards);
            };
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = BlackjackConfig{
            id          : 0x2::object::new(arg0),
            version_set : 0x2::vec_set::singleton<u64>(1),
        };
        0x2::transfer::share_object<BlackjackConfig>(v1);
    }

    public fun init_game<T0>(arg0: &mut 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::Unihouse, arg1: &mut BlackjackConfig, arg2: 0x2::coin::Coin<T0>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::house_exists<T0>(arg0), 7);
        assert_valid_version(arg1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = v0 * 3 / 2;
        let v2 = Blackjack{dummy_field: false};
        0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::assert_within_risk<T0, Blackjack>(arg0, v2, v1, arg4);
        let v3 = 0x2::tx_context::sender(arg4);
        if (!table_exists<T0>(arg1, v3)) {
            create_blackjack_table<T0>(arg1, arg4);
        };
        let v4 = borrow_mut_blackjack_table<T0>(arg1, v3);
        assert!(0x1::option::is_none<Game<T0>>(&v4.current_game), 9);
        v4.round_number = v4.round_number + 1;
        0x2::balance::join<T0>(&mut v4.balance, 0x2::coin::into_balance<T0>(arg2));
        let v5 = NewGame<T0>{
            table_id     : 0x2::object::id<BlackjackTable<T0>>(v4),
            round_number : v4.round_number,
            player       : v3,
            bet_size     : v0,
        };
        0x2::event::emit<NewGame<T0>>(v5);
        v4.current_game = 0x1::option::some<Game<T0>>(setup_game<T0>(v0, v1, arg3, arg4));
    }

    fun is_soft_17(arg0: &vector<u8>, arg1: u8) : bool {
        contains_aces(arg0) && arg1 == 17 && 0x1::vector::length<u8>(arg0) == 2
    }

    public fun package_version() : u64 {
        1
    }

    fun payout<T0>(arg0: &mut 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::Unihouse, arg1: &mut BlackjackTable<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Blackjack{dummy_field: false};
        if (arg3 >= arg2) {
            if (arg3 > arg2) {
                let v1 = 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::take_with_fee_reimbursement<T0, Blackjack>(arg0, v0, arg3 - arg2, arg4);
                0x2::coin::join<T0>(&mut v1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance)), arg4));
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, arg1.creator);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance)), arg4), arg1.creator);
            };
        } else {
            0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::put_with_fee<T0, Blackjack>(arg0, v0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2 - arg3), arg4));
            if (0x2::balance::value<T0>(&arg1.balance) != 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance)), arg4), arg1.creator);
            };
        };
        assert!(0x2::balance::value<T0>(&arg1.balance) == 0, 11);
    }

    fun payout_0<T0>(arg0: &mut 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::Unihouse, arg1: &mut BlackjackTable<T0>, arg2: u64, arg3: u64, arg4: &0xee0150555a187970285efd82153b0fc87ed0fb53844a3001f4dff3a5e73d70af::pond::SuilendPond<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: &0x2::clock::Clock, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        if (!0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::pipe_exists<T0, 0xee0150555a187970285efd82153b0fc87ed0fb53844a3001f4dff3a5e73d70af::pond::SUILEND_POND>(arg0)) {
            payout<T0>(arg0, arg1, arg2, arg3, arg9);
            return
        };
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, arg8, arg6, arg7);
        let v0 = Blackjack{dummy_field: false};
        if (arg3 >= arg2) {
            if (arg3 > arg2) {
                let v1 = arg3 - arg2;
                let (v2, v3) = 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::house::pool_changes(v1);
                let v4 = 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::house::pool_balance<T0>(0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::borrow_house<T0>(arg0));
                if (v2 > v4) {
                    0xee0150555a187970285efd82153b0fc87ed0fb53844a3001f4dff3a5e73d70af::pond::withdraw<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, Blackjack>(arg4, arg0, v2 - v4, false, v0, arg5, arg6, arg8, arg9);
                };
                let v5 = 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::house::house_balance<T0>(0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::borrow_house<T0>(arg0));
                if (v3 > v5) {
                    0xee0150555a187970285efd82153b0fc87ed0fb53844a3001f4dff3a5e73d70af::pond::withdraw<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, Blackjack>(arg4, arg0, v3 - v5, true, v0, arg5, arg6, arg8, arg9);
                };
                let v6 = 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::take_with_fee_reimbursement<T0, Blackjack>(arg0, v0, v1, arg9);
                0x2::coin::join<T0>(&mut v6, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance)), arg9));
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, arg1.creator);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance)), arg9), arg1.creator);
            };
        } else {
            let v7 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2 - arg3), arg9);
            let (v8, v9) = 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::house::pool_changes(0x2::coin::value<T0>(&v7));
            0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::put_with_fee<T0, Blackjack>(arg0, v0, v7);
            0xee0150555a187970285efd82153b0fc87ed0fb53844a3001f4dff3a5e73d70af::pond::deposit<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, Blackjack>(arg4, arg0, v8, false, v0, arg5, arg6, arg8, arg9);
            0xee0150555a187970285efd82153b0fc87ed0fb53844a3001f4dff3a5e73d70af::pond::deposit<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, Blackjack>(arg4, arg0, v9, true, v0, arg5, arg6, arg8, arg9);
            if (0x2::balance::value<T0>(&arg1.balance) != 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance)), arg9), arg1.creator);
            };
        };
        assert!(0x2::balance::value<T0>(&arg1.balance) == 0, 11);
    }

    public fun player_cards(arg0: &Hand) : vector<u8> {
        arg0.cards
    }

    public fun player_hands<T0>(arg0: &Game<T0>) : vector<Hand> {
        arg0.hands
    }

    public fun player_hands_mut<T0>(arg0: &mut Game<T0>) : &mut vector<Hand> {
        &mut arg0.hands
    }

    public fun player_move<T0>(arg0: &mut 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::Unihouse, arg1: &mut BlackjackConfig, arg2: u64, arg3: 0x1::option::Option<0x2::coin::Coin<T0>>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(101 <= arg2 && arg2 <= 105, 0);
        assert!(0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::house_exists<T0>(arg0), 7);
        assert_valid_version(arg1);
        let v0 = borrow_mut_blackjack_table<T0>(arg1, 0x2::tx_context::sender(arg4));
        let v1 = 0x1::option::borrow_mut<Game<T0>>(&mut v0.current_game);
        let v2 = player_hands<T0>(v1);
        let (v3, v4) = get_current_hand_and_status(&v2);
        assert!(v3 != 200, 3);
        assert!(v4 == 100, 2);
        let v5 = player_hands<T0>(v1);
        let v6 = 0x1::vector::borrow<Hand>(&v5, v3);
        if (arg2 == 105) {
            assert!(0x1::vector::length<Hand>(&v5) == 1, 13);
            assert!(0x1::vector::length<u8>(&v6.cards) == 2, 13);
            let v7 = dealer_cards<T0>(v1);
            assert!(0x1::vector::length<u8>(&v7) == 1, 13);
            assert!(!contains_aces(&v7), 13);
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg3);
            surrender<T0>(arg0, v0, arg4);
            return
        };
        if (arg2 == 104) {
            let v8 = player_hands<T0>(v1);
            assert!(0x1::vector::length<Hand>(&v8) <= 4, 1);
            assert!(0x1::vector::length<u8>(&v6.cards) == 2, 5);
            let v9 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v9, *0x1::vector::borrow<u8>(&v6.cards, 0));
            let v10 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v10, *0x1::vector::borrow<u8>(&v6.cards, 1));
            assert!(get_card_sum(&v9) == get_card_sum(&v10), 5);
        };
        if (arg2 == 103) {
            assert!(0x1::vector::length<u8>(&v6.cards) == 2, 6);
        };
        if (arg2 == 104 || arg2 == 103) {
            let v11 = if (contains_aces(&v6.cards) || contains_tens(&v6.cards)) {
                v6.bet_size * 3 / 2
            } else {
                v6.bet_size
            };
            v1.risk = v1.risk + v11;
            let v12 = Blackjack{dummy_field: false};
            0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::assert_within_risk<T0, Blackjack>(arg0, v12, v1.risk, arg4);
            assert!(0x1::option::is_some<0x2::coin::Coin<T0>>(&arg3), 4);
            let v13 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut arg3);
            assert!(0x2::coin::value<T0>(&v13) == v6.bet_size, 4);
            0x2::balance::join<T0>(&mut v0.balance, 0x2::coin::into_balance<T0>(v13));
        };
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg3);
        let v14 = MoveRequested{
            table_id                : 0x2::object::uid_to_inner(&v0.id),
            round_number            : v0.round_number,
            current_player_hand_sum : v6.current_sum,
            move_type               : arg2,
        };
        0x2::event::emit<MoveRequested>(v14);
        0x1::vector::borrow_mut<Hand>(player_hands_mut<T0>(v1), v3).status = arg2;
    }

    public fun player_move_0<T0>(arg0: &mut 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::Unihouse, arg1: &mut BlackjackConfig, arg2: u64, arg3: 0x1::option::Option<0x2::coin::Coin<T0>>, arg4: &0xee0150555a187970285efd82153b0fc87ed0fb53844a3001f4dff3a5e73d70af::pond::SuilendPond<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: &0x2::clock::Clock, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(101 <= arg2 && arg2 <= 105, 0);
        assert!(0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::house_exists<T0>(arg0), 7);
        assert_valid_version(arg1);
        let v0 = borrow_mut_blackjack_table<T0>(arg1, 0x2::tx_context::sender(arg9));
        let v1 = 0x1::option::borrow_mut<Game<T0>>(&mut v0.current_game);
        let v2 = player_hands<T0>(v1);
        let (v3, v4) = get_current_hand_and_status(&v2);
        assert!(v3 != 200, 3);
        assert!(v4 == 100, 2);
        let v5 = player_hands<T0>(v1);
        let v6 = 0x1::vector::borrow<Hand>(&v5, v3);
        if (arg2 == 105) {
            assert!(0x1::vector::length<Hand>(&v5) == 1, 13);
            assert!(0x1::vector::length<u8>(&v6.cards) == 2, 13);
            let v7 = dealer_cards<T0>(v1);
            assert!(0x1::vector::length<u8>(&v7) == 1, 13);
            assert!(!contains_aces(&v7), 13);
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg3);
            surrender_0<T0>(arg0, v0, arg4, arg5, arg6, arg7, arg8, arg9);
            return
        };
        if (arg2 == 104) {
            let v8 = player_hands<T0>(v1);
            assert!(0x1::vector::length<Hand>(&v8) <= 4, 1);
            assert!(0x1::vector::length<u8>(&v6.cards) == 2, 5);
            let v9 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v9, *0x1::vector::borrow<u8>(&v6.cards, 0));
            let v10 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v10, *0x1::vector::borrow<u8>(&v6.cards, 1));
            assert!(get_card_sum(&v9) == get_card_sum(&v10), 5);
        };
        if (arg2 == 103) {
            assert!(0x1::vector::length<u8>(&v6.cards) == 2, 6);
        };
        if (arg2 == 104 || arg2 == 103) {
            let v11 = if (contains_aces(&v6.cards) || contains_tens(&v6.cards)) {
                v6.bet_size * 3 / 2
            } else {
                v6.bet_size
            };
            v1.risk = v1.risk + v11;
            let v12 = Blackjack{dummy_field: false};
            0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::assert_within_risk<T0, Blackjack>(arg0, v12, v1.risk, arg9);
            assert!(0x1::option::is_some<0x2::coin::Coin<T0>>(&arg3), 4);
            let v13 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut arg3);
            assert!(0x2::coin::value<T0>(&v13) == v6.bet_size, 4);
            0x2::balance::join<T0>(&mut v0.balance, 0x2::coin::into_balance<T0>(v13));
        };
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg3);
        let v14 = MoveRequested{
            table_id                : 0x2::object::uid_to_inner(&v0.id),
            round_number            : v0.round_number,
            current_player_hand_sum : v6.current_sum,
            move_type               : arg2,
        };
        0x2::event::emit<MoveRequested>(v14);
        0x1::vector::borrow_mut<Hand>(player_hands_mut<T0>(v1), v3).status = arg2;
    }

    fun settle_all_hands<T0>(arg0: &mut Game<T0>) {
        let v0 = &arg0.dealer_cards;
        let v1 = 0;
        loop {
            let v2 = player_hands<T0>(arg0);
            if (v1 < 0x1::vector::length<Hand>(&v2)) {
                let v3 = 0x1::vector::borrow_mut<Hand>(&mut arg0.hands, v1);
                if (v3.status == 102) {
                    tally_hand(v3, v0);
                };
                v1 = v1 + 1;
            } else {
                break
            };
        };
    }

    fun setup_game<T0>(arg0: u64, arg1: u64, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) : Game<T0> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 52) {
            0x1::vector::push_back<u8>(&mut v0, v1);
            v1 = v1 + 1;
        };
        Game<T0>{
            bet_size     : arg0,
            risk         : arg1,
            current_deck : v0,
            dealer_cards : b"",
            start_epoch  : 0x2::tx_context::epoch(arg3),
            hands        : 0x1::vector::empty<Hand>(),
            origin       : arg2,
        }
    }

    fun surrender<T0>(arg0: &mut 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::Unihouse, arg1: &mut BlackjackTable<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let Game {
            bet_size     : v0,
            risk         : _,
            current_deck : _,
            dealer_cards : v3,
            start_epoch  : _,
            hands        : v5,
            origin       : v6,
        } = 0x1::option::extract<Game<T0>>(&mut arg1.current_game);
        let v7 = v5;
        let v8 = &v7;
        let v9 = 0x1::vector::empty<0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::game_structs::BlackjackHand>();
        let v10 = 0;
        while (v10 < 0x1::vector::length<Hand>(v8)) {
            0x1::vector::push_back<0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::game_structs::BlackjackHand>(&mut v9, create_blackjack_hands_to_emit(*0x1::vector::borrow<Hand>(v8, v10)));
            v10 = v10 + 1;
        };
        let v11 = v0 / 2;
        payout<T0>(arg0, arg1, v0, v11, arg2);
        0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::emit_blackjack_game_result<T0, Blackjack>(arg0, 0x2::object::uid_to_inner(&arg1.id), arg1.round_number, v0, v11, v9, v3, 0x2::tx_context::sender(arg2), v6);
    }

    fun surrender_0<T0>(arg0: &mut 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::Unihouse, arg1: &mut BlackjackTable<T0>, arg2: &0xee0150555a187970285efd82153b0fc87ed0fb53844a3001f4dff3a5e73d70af::pond::SuilendPond<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: &0x2::clock::Clock, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let Game {
            bet_size     : v0,
            risk         : _,
            current_deck : _,
            dealer_cards : v3,
            start_epoch  : _,
            hands        : v5,
            origin       : v6,
        } = 0x1::option::extract<Game<T0>>(&mut arg1.current_game);
        let v7 = v5;
        let v8 = &v7;
        let v9 = 0x1::vector::empty<0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::game_structs::BlackjackHand>();
        let v10 = 0;
        while (v10 < 0x1::vector::length<Hand>(v8)) {
            0x1::vector::push_back<0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::game_structs::BlackjackHand>(&mut v9, create_blackjack_hands_to_emit(*0x1::vector::borrow<Hand>(v8, v10)));
            v10 = v10 + 1;
        };
        let v11 = v0 / 2;
        payout_0<T0>(arg0, arg1, v0, v11, arg2, arg3, arg4, arg5, arg6, arg7);
        0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::emit_blackjack_game_result<T0, Blackjack>(arg0, 0x2::object::uid_to_inner(&arg1.id), arg1.round_number, v0, v11, v9, v3, 0x2::tx_context::sender(arg7), v6);
    }

    public fun table_exists<T0>(arg0: &BlackjackConfig, arg1: address) : bool {
        let v0 = BlackjackTag<T0>{creator: arg1};
        0x2::dynamic_object_field::exists_<BlackjackTag<T0>>(&arg0.id, v0)
    }

    fun tally_hand(arg0: &mut Hand, arg1: &vector<u8>) {
        arg0.status = 106;
        arg0.is_settled = true;
        let v0 = player_cards(arg0);
        let v1 = get_card_sum(&v0);
        let v2 = get_card_sum(arg1);
        if (v1 > 21 || v1 < v2 && v2 <= 21) {
            return
        };
        if (v1 > v2 && v1 <= 21 || v1 <= 21 && v2 > 21) {
            if (arg0.is_natural_blackjack) {
                arg0.bet_returned = arg0.bet_size * 5 / 2;
            } else {
                arg0.bet_returned = arg0.bet_size * 2;
            };
        } else {
            arg0.bet_returned = arg0.bet_size;
        };
    }

    // decompiled from Move bytecode v6
}

