module 0x831608ea29f35dbcc61dddfeb5927fd2798d418adeb12ea1d75d708a2f93df75::blackjack {
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
        status: u64,
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

    fun split<T0>(arg0: &mut Game<T0>, arg1: u64) {
        let v0 = 0x1::vector::borrow_mut<Hand>(&mut arg0.hands, arg1);
        let v1 = b"";
        let v2 = &mut v1;
        let v3 = &mut arg0.current_deck;
        deal_cards(v2, v3, 2);
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

    public fun admin_claim_funds<T0>(arg0: &mut BlackjackConfig, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_mut_blackjack_table<T0>(arg0, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.balance, 0x2::balance::value<T0>(&v0.balance)), arg3), 0x2::tx_context::sender(arg3));
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
        if (0x1::vector::contains<u8>(arg0, &v0)) {
            true
        } else if (0x1::vector::contains<u8>(arg0, &v1)) {
            true
        } else if (0x1::vector::contains<u8>(arg0, &v2)) {
            true
        } else {
            0x1::vector::contains<u8>(arg0, &v3)
        }
    }

    fun contains_tens(arg0: &vector<u8>) : bool {
        let v0 = 9;
        let v1 = 22;
        let v2 = 35;
        let v3 = 48;
        if (0x1::vector::contains<u8>(arg0, &v0)) {
            true
        } else if (0x1::vector::contains<u8>(arg0, &v1)) {
            true
        } else if (0x1::vector::contains<u8>(arg0, &v2)) {
            true
        } else {
            0x1::vector::contains<u8>(arg0, &v3)
        }
    }

    fun create_blackjack_hands_to_emit(arg0: Hand) : 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::BlackjackHand {
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
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::blackjack_hand(v0, v1, v2, v3, v4, v5, v6, v7)
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

    fun deal_cards(arg0: &mut vector<u8>, arg1: &mut vector<u8>, arg2: u8) {
        let v0 = 0;
        while (v0 < arg2) {
            0x1::vector::push_back<u8>(arg0, get_next_random_card(arg1));
            v0 = v0 + 1;
        };
    }

    public fun dealer_cards<T0>(arg0: &Game<T0>) : vector<u8> {
        arg0.dealer_cards
    }

    fun dealer_move<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &mut BlackjackTable<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x1::option::borrow_mut<Game<T0>>(&mut arg1.current_game);
        let v2 = v1.status;
        if (0x1::vector::length<u8>(&v1.dealer_cards) != 0) {
            let v3 = if (v2 == 101) {
                true
            } else if (v2 == 102) {
                true
            } else if (v2 == 105) {
                true
            } else if (v2 == 104) {
                true
            } else {
                v2 == 103
            };
            assert!(v3, 0);
        } else {
            assert!(v2 == 0, 0);
        };
        let v4 = Blackjack{dummy_field: false};
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::assert_within_risk<T0, Blackjack>(arg0, v4, v1.risk, arg2);
        let v5 = 0x2::object::uid_to_inner(&arg1.id);
        let v6 = arg1.round_number;
        let v7 = player_hands<T0>(v1);
        if (0x1::vector::length<Hand>(&v7) == 0 && 0x1::vector::length<u8>(&v1.dealer_cards) == 0) {
            assert!(v2 == 0, 14);
            first_deal<T0>(arg1, arg2);
            let v8 = 0x1::option::borrow_mut<Game<T0>>(&mut arg1.current_game);
            let v9 = MoveCompleted{
                table_id     : v5,
                round_number : v6,
                player_hands : player_hands<T0>(v8),
                dealer_cards : dealer_cards<T0>(v8),
            };
            0x2::event::emit<MoveCompleted>(v9);
        } else {
            let v10 = player_hands<T0>(v1);
            let (v11, v12) = get_current_hand_and_status(&v10);
            if (v11 != 200) {
                if (v12 == 101) {
                    assert!(v2 == 101, 15);
                    hit<T0>(v1, v11, 100, arg2);
                } else if (v12 == 103) {
                    assert!(v2 == 103, 16);
                    hit<T0>(v1, v11, 103, arg2);
                } else if (v12 == 104) {
                    assert!(v2 == 104, 17);
                    split<T0>(v1, v11);
                };
            };
            let v13 = 0x1::option::borrow<Game<T0>>(&arg1.current_game);
            let v14 = MoveCompleted{
                table_id     : v5,
                round_number : v6,
                player_hands : player_hands<T0>(v13),
                dealer_cards : dealer_cards<T0>(v13),
            };
            0x2::event::emit<MoveCompleted>(v14);
        };
        let v15 = player_hands<T0>(0x1::option::borrow<Game<T0>>(&arg1.current_game));
        let (v16, _) = get_current_hand_and_status(&v15);
        if (v16 == 200) {
            dealer_turn<T0>(arg1, arg2);
            let v18 = 0x1::option::borrow_mut<Game<T0>>(&mut arg1.current_game);
            if (get_card_sum(&v18.dealer_cards) <= 21) {
                settle_all_hands<T0>(v18);
            };
            let v19 = 0x1::option::extract<Game<T0>>(&mut arg1.current_game);
            assert_all_hands_settled<T0>(&v19);
            let Game {
                bet_size     : _,
                risk         : _,
                current_deck : _,
                dealer_cards : v23,
                start_epoch  : _,
                hands        : v25,
                status       : _,
                origin       : v27,
            } = v19;
            let v28 = v25;
            let v29 = &v28;
            let v30 = 0x1::vector::empty<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::BlackjackHand>();
            let v31 = 0;
            while (v31 < 0x1::vector::length<Hand>(v29)) {
                0x1::vector::push_back<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::BlackjackHand>(&mut v30, create_blackjack_hands_to_emit(*0x1::vector::borrow<Hand>(v29, v31)));
                v31 = v31 + 1;
            };
            let v32 = &v28;
            let v33 = vector[];
            let v34 = 0;
            while (v34 < 0x1::vector::length<Hand>(v32)) {
                0x1::vector::push_back<u64>(&mut v33, hand_bet_size(0x1::vector::borrow<Hand>(v32, v34)));
                v34 = v34 + 1;
            };
            let v35 = &v28;
            let v36 = vector[];
            let v37 = 0;
            while (v37 < 0x1::vector::length<Hand>(v35)) {
                0x1::vector::push_back<u64>(&mut v36, hand_bet_returned(0x1::vector::borrow<Hand>(v35, v37)));
                v37 = v37 + 1;
            };
            let v38 = 0;
            0x1::vector::reverse<u64>(&mut v33);
            while (!0x1::vector::is_empty<u64>(&v33)) {
                v38 = v38 + 0x1::vector::pop_back<u64>(&mut v33);
            };
            0x1::vector::destroy_empty<u64>(v33);
            let v39 = 0;
            0x1::vector::reverse<u64>(&mut v36);
            while (!0x1::vector::is_empty<u64>(&v36)) {
                v39 = v39 + 0x1::vector::pop_back<u64>(&mut v36);
            };
            0x1::vector::destroy_empty<u64>(v36);
            payout<T0>(arg0, arg1, v38, v39, arg2);
            0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::emit_blackjack_game_result<T0, Blackjack>(arg0, v5, v6, v38, v39, v30, v23, v0, v27);
        };
    }

    fun dealer_turn<T0>(arg0: &mut BlackjackTable<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::borrow_mut<Game<T0>>(&mut arg0.current_game);
        let v1 = get_card_sum(&v0.dealer_cards);
        while (is_soft_17(&v0.dealer_cards, v1) || v1 < 17) {
            let v2 = &mut v0.dealer_cards;
            let v3 = &mut v0.current_deck;
            deal_cards(v2, v3, 1);
            v1 = get_card_sum(&v0.dealer_cards);
        };
        if (v1 > 21) {
            0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::create_and_transfer_gas_obj(0x1::bcs::to_bytes<Game<T0>>(v0), arg1);
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

    fun first_deal<T0>(arg0: &mut BlackjackTable<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::borrow_mut<Game<T0>>(&mut arg0.current_game);
        let v1 = &mut v0.dealer_cards;
        let v2 = &mut v0.current_deck;
        deal_cards(v1, v2, 1);
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
        hit<T0>(v0, 0, 100, arg1);
        hit<T0>(v0, 0, 100, arg1);
        let v5 = 0x1::option::borrow_mut<Game<T0>>(&mut arg0.current_game);
        let v6 = 0x1::vector::borrow_mut<Hand>(&mut v5.hands, 0);
        let v7 = player_cards(v6);
        if (get_card_sum(&v7) == 21) {
            0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::create_and_transfer_gas_obj(0x1::bcs::to_bytes<Hand>(v6), arg1);
            v6.is_natural_blackjack = true;
            let v8 = v5.dealer_cards;
            if (contains_aces(&v8) || contains_tens(&v8)) {
                let v9 = &mut v5.dealer_cards;
                let v10 = &mut v5.current_deck;
                deal_cards(v9, v10, 1);
            } else {
                0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::create_and_transfer_gas_obj(0x1::bcs::to_bytes<Hand>(v6), arg1);
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

    fun get_next_random_card(arg0: &mut vector<u8>) : u8 {
        0x1::vector::pop_back<u8>(arg0)
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

    fun hit<T0>(arg0: &mut Game<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<Hand>(&mut arg0.hands, arg1);
        if (arg2 == 103) {
            v0.is_doubled = true;
            v0.bet_size = v0.bet_size + arg0.bet_size;
            v0.status = 102;
        };
        if (arg2 == 100) {
            v0.status = 100;
        };
        let v1 = &mut v0.cards;
        let v2 = &mut arg0.current_deck;
        deal_cards(v1, v2, 1);
        v0.current_sum = get_card_sum(&v0.cards);
        if (v0.current_sum >= 21) {
            v0.status = 102;
            if (v0.current_sum > 21) {
                tally_hand(v0, &arg0.dealer_cards);
            };
        } else {
            0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::create_and_transfer_gas_obj(0x1::bcs::to_bytes<Game<T0>>(arg0), arg3);
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

    entry fun init_game<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &mut BlackjackConfig, arg2: &0x2::random::Random, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::house_exists<T0>(arg0), 7);
        assert_valid_version(arg1);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::random_compute(arg2, arg5);
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = v0 * 3 / 2;
        let v2 = Blackjack{dummy_field: false};
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::assert_within_risk<T0, Blackjack>(arg0, v2, v1, arg5);
        let v3 = 0x2::tx_context::sender(arg5);
        if (!table_exists<T0>(arg1, v3)) {
            create_blackjack_table<T0>(arg1, arg5);
        };
        let v4 = borrow_mut_blackjack_table<T0>(arg1, v3);
        assert!(0x1::option::is_none<Game<T0>>(&v4.current_game), 9);
        v4.round_number = v4.round_number + 1;
        0x2::balance::join<T0>(&mut v4.balance, 0x2::coin::into_balance<T0>(arg3));
        let v5 = setup_game<T0>(v0, v1, arg4, arg5);
        let v6 = NewGame<T0>{
            table_id     : 0x2::object::id<BlackjackTable<T0>>(v4),
            round_number : v4.round_number,
            player       : v3,
            bet_size     : v0,
        };
        0x2::event::emit<NewGame<T0>>(v6);
        let v7 = 0x2::random::new_generator(arg2, arg5);
        0x2::random::shuffle<u8>(&mut v7, &mut v5.current_deck);
        v4.current_game = 0x1::option::some<Game<T0>>(v5);
    }

    fun is_soft_17(arg0: &vector<u8>, arg1: u8) : bool {
        if (contains_aces(arg0)) {
            if (arg1 == 17) {
                0x1::vector::length<u8>(arg0) == 2
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun package_version() : u64 {
        1
    }

    fun payout<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &mut BlackjackTable<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Blackjack{dummy_field: false};
        if (arg3 >= arg2) {
            if (arg3 > arg2) {
                0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::create_and_transfer_gas_obj(0x1::bcs::to_bytes<BlackjackTable<T0>>(arg1), arg4);
                let v1 = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::take_with_fee_reimbursement<T0, Blackjack>(arg0, v0, arg3 - arg2, arg4);
                0x2::coin::join<T0>(&mut v1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance)), arg4));
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, arg1.creator);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance)), arg4), arg1.creator);
            };
        } else {
            0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::put_with_fee<T0, Blackjack>(arg0, v0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2 - arg3), arg4));
            if (0x2::balance::value<T0>(&arg1.balance) != 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance)), arg4), arg1.creator);
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

    entry fun player_move_request<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &mut BlackjackConfig, arg2: &0x2::random::Random, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg4 == 101) {
            true
        } else if (arg4 == 102) {
            true
        } else if (arg4 == 105) {
            true
        } else if (arg4 == 104) {
            true
        } else {
            arg4 == 103
        };
        assert!(v0, 0);
        assert!(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::house_exists<T0>(arg0), 7);
        assert_valid_version(arg1);
        let v1 = borrow_mut_blackjack_table<T0>(arg1, 0x2::tx_context::sender(arg5));
        let v2 = 0x1::option::borrow_mut<Game<T0>>(&mut v1.current_game);
        let v3 = player_hands<T0>(v2);
        let (v4, v5) = get_current_hand_and_status(&v3);
        assert!(v4 != 200, 3);
        assert!(v5 == 100, 2);
        let v6 = player_hands<T0>(v2);
        let v7 = 0x1::vector::borrow<Hand>(&v6, v4);
        if (arg4 == 104 || arg4 == 103) {
            assert!(0x2::coin::value<T0>(&arg3) == v7.bet_size, 4);
            0x2::balance::join<T0>(&mut v1.balance, 0x2::coin::into_balance<T0>(arg3));
        } else {
            0x2::coin::destroy_zero<T0>(arg3);
        };
        if (arg4 == 105) {
            assert!(0x1::vector::length<Hand>(&v6) == 1, 13);
            assert!(0x1::vector::length<u8>(&v7.cards) == 2, 13);
            let v8 = dealer_cards<T0>(v2);
            assert!(0x1::vector::length<u8>(&v8) == 1, 13);
            assert!(!contains_aces(&v8), 13);
            surrender<T0>(arg0, v1, arg5);
            return
        };
        if (arg4 == 104) {
            let v9 = player_hands<T0>(v2);
            assert!(0x1::vector::length<Hand>(&v9) <= 4, 1);
            assert!(0x1::vector::length<u8>(&v7.cards) == 2, 5);
            let v10 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v10, *0x1::vector::borrow<u8>(&v7.cards, 0));
            let v11 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v11, *0x1::vector::borrow<u8>(&v7.cards, 1));
            assert!(get_card_sum(&v10) == get_card_sum(&v11), 5);
        };
        if (arg4 == 103) {
            assert!(0x1::vector::length<u8>(&v7.cards) == 2, 6);
        };
        if (arg4 == 104 || arg4 == 103) {
            let v12 = if (contains_aces(&v7.cards) || contains_tens(&v7.cards)) {
                v7.bet_size * 3 / 2
            } else {
                v7.bet_size
            };
            v2.risk = v2.risk + v12;
            let v13 = Blackjack{dummy_field: false};
            0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::assert_within_risk<T0, Blackjack>(arg0, v13, v2.risk, arg5);
        };
        let v14 = MoveRequested{
            table_id                : 0x2::object::uid_to_inner(&v1.id),
            round_number            : v1.round_number,
            current_player_hand_sum : v7.current_sum,
            move_type               : arg4,
        };
        0x2::event::emit<MoveRequested>(v14);
        let v15 = 0x2::random::new_generator(arg2, arg5);
        0x2::random::shuffle<u8>(&mut v15, &mut v2.current_deck);
        v2.status = arg4;
        0x1::vector::borrow_mut<Hand>(player_hands_mut<T0>(v2), v4).status = arg4;
    }

    public fun process_player_move<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &mut BlackjackConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_mut_blackjack_table<T0>(arg1, arg2);
        dealer_move<T0>(arg0, v0, arg3);
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
            status       : 0,
            origin       : arg2,
        }
    }

    fun surrender<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &mut BlackjackTable<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let Game {
            bet_size     : v0,
            risk         : _,
            current_deck : _,
            dealer_cards : v3,
            start_epoch  : _,
            hands        : v5,
            status       : _,
            origin       : v7,
        } = 0x1::option::extract<Game<T0>>(&mut arg1.current_game);
        let v8 = v5;
        let v9 = &v8;
        let v10 = 0x1::vector::empty<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::BlackjackHand>();
        let v11 = 0;
        while (v11 < 0x1::vector::length<Hand>(v9)) {
            0x1::vector::push_back<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::game_structs::BlackjackHand>(&mut v10, create_blackjack_hands_to_emit(*0x1::vector::borrow<Hand>(v9, v11)));
            v11 = v11 + 1;
        };
        let v12 = v0 / 2;
        payout<T0>(arg0, arg1, v0, v12, arg2);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::emit_blackjack_game_result<T0, Blackjack>(arg0, 0x2::object::uid_to_inner(&arg1.id), arg1.round_number, v0, v12, v10, v3, 0x2::tx_context::sender(arg2), v7);
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

