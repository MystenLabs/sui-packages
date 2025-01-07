module 0xbdec0470a0b3c4a1cd3d2ac3b7eb10af57db23e2dffcdf001f1f04f6eb79e065::single_deck_blackjack {
    struct NewGame<phantom T0> has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        bet_size: u64,
    }

    struct GameOutcome<phantom T0> has copy, drop, store {
        game_id: 0x2::object::ID,
        player: address,
        bet_size: u64,
        player_hands: vector<Hand>,
        dealer_cards: vector<u8>,
        player_won: u64,
        player_lost: u64,
    }

    struct MoveRequested has copy, drop {
        game_id: 0x2::object::ID,
        current_player_hand_sum: u8,
        move_type: u64,
    }

    struct MoveCompleted has copy, drop {
        game_id: 0x2::object::ID,
        player_hands: vector<Hand>,
        dealer_cards: vector<u8>,
    }

    struct SingleDeckBlackjack has copy, drop, store {
        dummy_field: bool,
    }

    struct Verifier has key {
        id: 0x2::object::UID,
        pub_key: vector<u8>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct PlayerData has copy, drop, store {
        id: address,
        hands: vector<Hand>,
        winnings: u64,
        losings: u64,
    }

    struct Hand has copy, drop, store {
        cards: vector<u8>,
        status: u64,
        current_sum: u8,
        bet_size: u64,
        is_natural_blackjack: bool,
        is_doubled: bool,
        is_settled: bool,
    }

    struct Game<phantom T0> has store, key {
        id: 0x2::object::UID,
        verifier_pub_key: vector<u8>,
        bet_size: u64,
        seed: vector<u8>,
        current_deck: vector<u8>,
        dealer_cards: vector<u8>,
        current_rnd_round: u8,
        start_epoch: u64,
        stake: 0x2::coin::Coin<T0>,
        player_data: PlayerData,
    }

    fun split<T0>(arg0: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg1: &mut Game<T0>, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<Hand>(&arg1.player_data.hands);
        let v1 = 0x1::vector::borrow_mut<Hand>(&mut arg1.player_data.hands, arg2);
        let v2 = b"";
        let v3 = &mut v2;
        let v4 = &mut arg1.current_deck;
        let v5 = deal_cards(arg3, v3, v4, arg1.current_rnd_round, 2, arg4);
        arg1.current_rnd_round = v5;
        0x1::vector::push_back<u8>(&mut v1.cards, 0x1::vector::pop_back<u8>(&mut v2));
        v1.current_sum = get_card_sum(&v1.cards);
        v1.status = 100;
        let v6 = 0x1::vector::empty<u8>();
        let v7 = &mut v6;
        0x1::vector::push_back<u8>(v7, 0x1::vector::pop_back<u8>(&mut v1.cards));
        0x1::vector::push_back<u8>(v7, 0x1::vector::pop_back<u8>(&mut v2));
        let v8 = Hand{
            cards                : v6,
            status               : 100,
            current_sum          : get_card_sum(&v6),
            bet_size             : arg1.bet_size,
            is_natural_blackjack : false,
            is_doubled           : false,
            is_settled           : false,
        };
        if (contains_aces(&v1.cards)) {
            v1.status = 105;
            v8.status = 105;
        };
        if (v1.current_sum == 21) {
            v1.status = 105;
            v1.is_natural_blackjack = true;
            v1.is_settled = true;
            handle_player_win<T0>(arg0, arg1, arg2, arg4);
        };
        0x1::vector::push_back<Hand>(&mut arg1.player_data.hands, v8);
        if (v8.current_sum == 21) {
            v8.status = 105;
            v8.is_natural_blackjack = true;
            v8.is_settled = true;
            handle_player_win<T0>(arg0, arg1, v0, arg4);
        };
    }

    public fun bet_size<T0>(arg0: &Game<T0>) : u64 {
        arg0.bet_size
    }

    public fun borrow_game<T0>(arg0: &mut Verifier, arg1: 0x2::object::ID) : &Game<T0> {
        assert!(game_exists<T0>(arg0, arg1), 7);
        0x2::dynamic_object_field::borrow<0x2::object::ID, Game<T0>>(&arg0.id, arg1)
    }

    public fun borrow_game_mut<T0>(arg0: &mut Verifier, arg1: 0x2::object::ID) : &mut Game<T0> {
        assert!(game_exists<T0>(arg0, arg1), 7);
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Game<T0>>(&mut arg0.id, arg1)
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

    public entry fun create_verifier(arg0: &AdminCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Verifier{
            id      : 0x2::object::new(arg2),
            pub_key : arg1,
        };
        0x2::transfer::share_object<Verifier>(v0);
    }

    public fun current_deck<T0>(arg0: &Game<T0>) : vector<u8> {
        arg0.current_deck
    }

    public fun current_rnd_round<T0>(arg0: &Game<T0>) : u8 {
        arg0.current_rnd_round
    }

    fun deal_cards(arg0: vector<u8>, arg1: &mut vector<u8>, arg2: &mut vector<u8>, arg3: u8, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = 0;
        while (v0 < arg4) {
            0x1::vector::push_back<u8>(arg1, get_next_random_card(arg0, arg2, arg3, arg5));
            arg3 = arg3 + 1;
            v0 = v0 + 1;
        };
        arg3
    }

    public fun dealer_cards<T0>(arg0: &Game<T0>) : vector<u8> {
        arg0.dealer_cards
    }

    public fun dealer_move<T0>(arg0: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg1: &mut Verifier, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(game_exists<T0>(arg1, arg2), 7);
        let v0 = pub_key(arg1);
        let v1 = borrow_game_mut<T0>(arg1, arg2);
        let v2 = 0x2::object::uid_to_bytes(&v1.id);
        0x1::vector::append<u8>(&mut v2, v1.seed);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg3, &v0, &v2), 8);
        let v3 = player_hands<T0>(v1);
        if (0x1::vector::length<Hand>(&v3) == 0 && 0x1::vector::length<u8>(&v1.dealer_cards) == 0) {
            first_deal<T0>(arg0, v1, arg3, arg4);
            let v4 = MoveCompleted{
                game_id      : arg2,
                player_hands : player_hands<T0>(v1),
                dealer_cards : dealer_cards<T0>(v1),
            };
            0x2::event::emit<MoveCompleted>(v4);
        } else {
            let v5 = player_hands<T0>(v1);
            let (v6, v7) = get_current_hand_and_status(&v5);
            if (v6 != 200) {
                if (v7 == 101) {
                    hit<T0>(arg0, v1, v6, 100, arg3, arg4);
                } else if (v7 == 103) {
                    hit<T0>(arg0, v1, v6, 103, arg3, arg4);
                } else if (v7 == 104) {
                    split<T0>(arg0, v1, v6, arg3, arg4);
                };
            };
            let v8 = MoveCompleted{
                game_id      : arg2,
                player_hands : player_hands<T0>(v1),
                dealer_cards : dealer_cards<T0>(v1),
            };
            0x2::event::emit<MoveCompleted>(v8);
        };
        let v9 = player_hands<T0>(v1);
        let (v10, _) = get_current_hand_and_status(&v9);
        if (v10 == 200) {
            dealer_turn<T0>(arg0, v1, arg3, arg4);
            if (get_card_sum(&v1.dealer_cards) <= 21) {
                settle_all_hands<T0>(arg0, v1, arg4);
            };
            let Game {
                id                : v12,
                verifier_pub_key  : _,
                bet_size          : v14,
                seed              : _,
                current_deck      : _,
                dealer_cards      : v17,
                current_rnd_round : _,
                start_epoch       : _,
                stake             : v20,
                player_data       : v21,
            } = 0x2::dynamic_object_field::remove<0x2::object::ID, Game<T0>>(&mut arg1.id, arg2);
            let PlayerData {
                id       : v22,
                hands    : v23,
                winnings : v24,
                losings  : v25,
            } = v21;
            let v26 = GameOutcome<T0>{
                game_id      : arg2,
                player       : v22,
                bet_size     : v14,
                player_hands : v23,
                dealer_cards : v17,
                player_won   : v24,
                player_lost  : v25,
            };
            0x2::event::emit<GameOutcome<T0>>(v26);
            0x2::object::delete(v12);
            0x2::coin::destroy_zero<T0>(v20);
        };
    }

    fun dealer_turn<T0>(arg0: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg1: &mut Game<T0>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = get_card_sum(&arg1.dealer_cards);
        while (is_soft_17(&arg1.dealer_cards, v0) || v0 < 17) {
            let v1 = &mut arg1.dealer_cards;
            let v2 = &mut arg1.current_deck;
            let v3 = deal_cards(arg2, v1, v2, arg1.current_rnd_round, 1, arg3);
            arg1.current_rnd_round = v3;
            v0 = get_card_sum(&arg1.dealer_cards);
        };
        if (v0 > 21) {
            let v4 = 0;
            while (v4 < 0x1::vector::length<Hand>(&arg1.player_data.hands)) {
                let v5 = 0x1::vector::borrow_mut<Hand>(&mut arg1.player_data.hands, v4);
                if (!v5.is_settled) {
                    v5.status = 105;
                    v5.is_settled = true;
                    handle_player_win<T0>(arg0, arg1, v4, arg3);
                };
                v4 = v4 + 1;
            };
        };
    }

    fun first_deal<T0>(arg0: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg1: &mut Game<T0>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg1.dealer_cards;
        let v1 = &mut arg1.current_deck;
        let v2 = deal_cards(arg2, v0, v1, arg1.current_rnd_round, 1, arg3);
        arg1.current_rnd_round = v2;
        let v3 = Hand{
            cards                : b"",
            status               : 100,
            current_sum          : 0,
            bet_size             : arg1.bet_size,
            is_natural_blackjack : false,
            is_doubled           : false,
            is_settled           : false,
        };
        let v4 = player_hands_mut<T0>(arg1);
        0x1::vector::push_back<Hand>(v4, v3);
        hit<T0>(arg0, arg1, 0, 100, arg2, arg3);
        hit<T0>(arg0, arg1, 0, 100, arg2, arg3);
        let v5 = 0x1::vector::borrow_mut<Hand>(&mut arg1.player_data.hands, 0);
        let v6 = player_cards(v5);
        if (get_card_sum(&v6) == 21) {
            v5.status = 105;
            v5.is_natural_blackjack = true;
            v5.is_settled = true;
            let v7 = arg1.dealer_cards;
            if (contains_aces(&v7) || contains_tens(&v7)) {
                let v8 = &mut arg1.dealer_cards;
                let v9 = &mut arg1.current_deck;
                let v10 = deal_cards(arg2, v8, v9, arg1.current_rnd_round, 1, arg3);
                arg1.current_rnd_round = v10;
                if (get_card_sum(&arg1.dealer_cards) == 21) {
                    handle_tie<T0>(arg1, arg3);
                    return
                };
            };
            handle_player_win<T0>(arg0, arg1, 0, arg3);
        };
    }

    public fun game_exists<T0>(arg0: &Verifier, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Game<T0>>(&arg0.id, arg1)
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
        assert!(0x1::vector::length<Hand>(arg0) < 5, 3);
        while (v0 < 0x1::vector::length<Hand>(arg0)) {
            let v1 = 0x1::vector::borrow<Hand>(arg0, v0);
            if (v1.status != 102 && v1.status != 105) {
                return (v0, v1.status)
            };
            v0 = v0 + 1;
        };
        (200, 105)
    }

    fun get_next_random_card(arg0: vector<u8>, arg1: &mut vector<u8>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::object::uid_to_inner(&v0);
        0x1::vector::append<u8>(&mut arg0, 0x1::bcs::to_bytes<0x2::object::ID>(&v1));
        0x2::object::delete(v0);
        let v2 = hash_for_round(arg0, arg2);
        0x1::vector::remove<u8>(arg1, safe_selection(0x1::vector::length<u8>(arg1), &v2))
    }

    public fun hand_bet_size(arg0: &Hand) : u64 {
        arg0.bet_size
    }

    public fun hand_status(arg0: &Hand) : u64 {
        arg0.status
    }

    fun handle_house_win<T0>(arg0: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg1: &mut Game<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<Hand>(&mut arg1.player_data.hands, arg2).bet_size;
        arg1.player_data.losings = arg1.player_data.losings + v0;
        let v1 = SingleDeckBlackjack{dummy_field: false};
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::put<T0, SingleDeckBlackjack>(v1, arg0, 0x2::coin::split<T0>(&mut arg1.stake, v0, arg3));
    }

    fun handle_player_win<T0>(arg0: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg1: &mut Game<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow<Hand>(&arg1.player_data.hands, arg2);
        let v1 = v0.bet_size;
        let v2 = v1;
        if (v0.is_natural_blackjack) {
            v2 = v1 * 3 / 2;
        };
        arg1.player_data.winnings = arg1.player_data.winnings + v2;
        let v3 = SingleDeckBlackjack{dummy_field: false};
        let v4 = 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::take<T0, SingleDeckBlackjack>(v3, arg0, v2, arg3);
        0x2::coin::join<T0>(&mut v4, 0x2::coin::split<T0>(&mut arg1.stake, v0.bet_size, arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, arg1.player_data.id);
    }

    fun handle_tie<T0>(arg0: &mut Game<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.stake, 0x2::coin::value<T0>(&arg0.stake), arg1), arg0.player_data.id);
    }

    fun hash_for_round(arg0: vector<u8>, arg1: u8) : vector<u8> {
        let v0 = 0x2::hash::blake2b256(&arg0);
        let v1 = 0;
        while (v1 < arg1) {
            v0 = 0x2::hash::blake2b256(&arg0);
            v1 = v1 + 1;
        };
        v0
    }

    fun hit<T0>(arg0: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg1: &mut Game<T0>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<Hand>(&mut arg1.player_data.hands, arg2);
        if (arg3 == 103) {
            v0.is_doubled = true;
            v0.bet_size = v0.bet_size + arg1.bet_size;
            v0.status = 102;
        };
        if (arg3 == 100) {
            v0.status = 100;
        };
        let v1 = &mut v0.cards;
        let v2 = &mut arg1.current_deck;
        let v3 = deal_cards(arg4, v1, v2, arg1.current_rnd_round, 1, arg5);
        arg1.current_rnd_round = v3;
        v0.current_sum = get_card_sum(&v0.cards);
        if (v0.current_sum >= 21) {
            v0.status = 105;
            if (v0.current_sum > 21) {
                v0.is_settled = true;
                handle_house_win<T0>(arg0, arg1, arg2, arg5);
            };
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun init_game<T0>(arg0: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg1: &mut Verifier, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::receipt::GameReceipt<T0, SingleDeckBlackjack>) {
        assert!(arg2 >= 1000000000, 9);
        assert!(0x1::vector::length<u8>(&arg4) >= 32, 2);
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 >= 1000000000, 9);
        let v1 = setup_house<T0>(arg0, v0, arg5);
        (setup_game<T0>(arg1, arg2, arg3, arg4, arg5), v1)
    }

    fun is_soft_17(arg0: &vector<u8>, arg1: u8) : bool {
        contains_aces(arg0) && arg1 == 17 && 0x1::vector::length<u8>(arg0) == 2
    }

    public fun player_cards(arg0: &Hand) : vector<u8> {
        arg0.cards
    }

    public fun player_hands<T0>(arg0: &Game<T0>) : vector<Hand> {
        arg0.player_data.hands
    }

    public fun player_hands_mut<T0>(arg0: &mut Game<T0>) : &mut vector<Hand> {
        &mut arg0.player_data.hands
    }

    public fun player_losings<T0>(arg0: &Game<T0>) : u64 {
        arg0.player_data.losings
    }

    public fun player_move<T0>(arg0: &mut Verifier, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1::option::Option<0x2::coin::Coin<T0>>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(101 <= arg2 && arg2 <= 104, 0);
        let v0 = borrow_game_mut<T0>(arg0, arg1);
        assert!(v0.player_data.id == 0x2::tx_context::sender(arg4), 1);
        let v1 = player_hands<T0>(v0);
        let (v2, v3) = get_current_hand_and_status(&v1);
        assert!(v2 != 200, 5);
        assert!(v3 == 100, 4);
        let v4 = player_hands<T0>(v0);
        let v5 = 0x1::vector::borrow<Hand>(&v4, v2);
        if (arg2 == 104) {
            let v6 = player_hands<T0>(v0);
            assert!(0x1::vector::length<Hand>(&v6) <= 4, 3);
            assert!(0x1::vector::length<u8>(&v5.cards) == 2, 10);
            let v7 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v7, *0x1::vector::borrow<u8>(&v5.cards, 0));
            let v8 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v8, *0x1::vector::borrow<u8>(&v5.cards, 1));
            assert!(get_card_sum(&v7) == get_card_sum(&v8), 10);
        };
        if (arg2 == 103) {
            assert!(0x1::vector::length<u8>(&v5.cards) == 2, 11);
        };
        if (arg2 == 104 || arg2 == 103) {
            assert!(0x1::option::is_some<0x2::coin::Coin<T0>>(&arg3), 9);
            let v9 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut arg3);
            assert!(0x2::coin::value<T0>(&v9) == v0.bet_size, 9);
            0x2::coin::join<T0>(&mut v0.stake, v9);
        };
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg3);
        let v10 = MoveRequested{
            game_id                 : 0x2::object::id<Game<T0>>(v0),
            current_player_hand_sum : v5.current_sum,
            move_type               : arg2,
        };
        0x2::event::emit<MoveRequested>(v10);
        0x1::vector::borrow_mut<Hand>(player_hands_mut<T0>(v0), v2).status = arg2;
    }

    public fun player_winnings<T0>(arg0: &Game<T0>) : u64 {
        arg0.player_data.winnings
    }

    public fun pub_key(arg0: &Verifier) : vector<u8> {
        arg0.pub_key
    }

    public fun safe_selection(arg0: u64, arg1: &vector<u8>) : u64 {
        assert!(0x1::vector::length<u8>(arg1) >= 16, 6);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 16) {
            let v2 = v0 << 8;
            v0 = v2 + (*0x1::vector::borrow<u8>(arg1, v1) as u128);
            v1 = v1 + 1;
        };
        ((v0 % (arg0 as u128)) as u64)
    }

    fun settle_all_hands<T0>(arg0: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg1: &mut Game<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            let v1 = player_hands<T0>(arg1);
            if (v0 < 0x1::vector::length<Hand>(&v1)) {
                if (0x1::vector::borrow<Hand>(&arg1.player_data.hands, v0).status == 102) {
                    settle_hand<T0>(arg0, arg1, v0, arg2);
                };
                v0 = v0 + 1;
            } else {
                break
            };
        };
    }

    fun settle_hand<T0>(arg0: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg1: &mut Game<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<Hand>(&mut arg1.player_data.hands, arg2);
        v0.status = 105;
        v0.is_settled = true;
        let v1 = player_cards(v0);
        let v2 = get_card_sum(&v1);
        let v3 = get_card_sum(&arg1.dealer_cards);
        if (v2 == v3) {
            handle_tie<T0>(arg1, arg3);
        } else if (v2 < v3) {
            handle_house_win<T0>(arg0, arg1, arg2, arg3);
        } else {
            handle_player_win<T0>(arg0, arg1, arg2, arg3);
        };
    }

    fun setup_game<T0>(arg0: &mut Verifier, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 52) {
            0x1::vector::push_back<u8>(&mut v0, v1);
            v1 = v1 + 1;
        };
        let v2 = 0x2::object::new(arg4);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = 0x2::tx_context::sender(arg4);
        let v5 = PlayerData{
            id       : v4,
            hands    : 0x1::vector::empty<Hand>(),
            winnings : 0,
            losings  : 0,
        };
        let v6 = Game<T0>{
            id                : v2,
            verifier_pub_key  : pub_key(arg0),
            bet_size          : arg1,
            seed              : arg3,
            current_deck      : v0,
            dealer_cards      : b"",
            current_rnd_round : 0,
            start_epoch       : 0x2::tx_context::epoch(arg4),
            stake             : arg2,
            player_data       : v5,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Game<T0>>(&mut arg0.id, v3, v6);
        let v7 = NewGame<T0>{
            game_id  : v3,
            player   : v4,
            bet_size : arg1,
        };
        0x2::event::emit<NewGame<T0>>(v7);
        v3
    }

    fun setup_house<T0>(arg0: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg1: u64, arg2: &0x2::tx_context::TxContext) : 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::receipt::GameReceipt<T0, SingleDeckBlackjack> {
        let v0 = SingleDeckBlackjack{dummy_field: false};
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::add_volume<T0, SingleDeckBlackjack>(v0, arg0, arg1, arg2);
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::new_game_receipt<T0, SingleDeckBlackjack>(v0, arg0, arg1)
    }

    public entry fun update_pub_key(arg0: &AdminCap, arg1: &mut Verifier, arg2: vector<u8>) {
        arg1.pub_key = arg2;
    }

    // decompiled from Move bytecode v6
}

