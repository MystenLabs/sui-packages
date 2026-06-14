module 0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::blackjack_game {
    struct BLACKJACK_GAME has drop {
        dummy_field: bool,
    }

    struct Game<phantom T0> has key {
        id: 0x2::object::UID,
        player: address,
        bet: u64,
        round: 0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::lifecycle::Round,
        pot: 0x2::balance::Balance<T0>,
        player_cards: vector<u8>,
        dealer_up: u8,
        dealer_hole: vector<u8>,
        dealer_extras: vector<u8>,
        status: u8,
        doubled: bool,
    }

    struct HistoricalGame has key {
        id: 0x2::object::UID,
        player: address,
        bet: u64,
        outcome: u8,
        doubled: bool,
        payout: u64,
        player_cards: vector<u8>,
        dealer_cards: vector<u8>,
    }

    struct BlackjackHandStarted has copy, drop, store {
        game_id: 0x2::object::ID,
        player: address,
        bet: u64,
        player_cards: vector<u8>,
        dealer_up: u8,
        natural_blackjack: bool,
    }

    struct BlackjackCardDealt has copy, drop, store {
        game_id: 0x2::object::ID,
        player: address,
        seat: vector<u8>,
        card: u8,
        running_total: u8,
    }

    struct BlackjackHandSettled has copy, drop, store {
        game_id: 0x2::object::ID,
        player: address,
        outcome: u8,
        payout: u64,
        player_cards: vector<u8>,
        dealer_cards: vector<u8>,
    }

    fun assert_player_turn<T0>(arg0: &Game<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.player == 0x2::tx_context::sender(arg1), 1003);
        assert!(arg0.status == 1, 1004);
    }

    public fun bet<T0>(arg0: &Game<T0>) : u64 {
        arg0.bet
    }

    fun build_dealer_vec(arg0: u8, arg1: &vector<u8>, arg2: &vector<u8>) : vector<u8> {
        let v0 = b"";
        0x1::vector::push_back<u8>(&mut v0, arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg1)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg1, v1));
            v1 = v1 + 1;
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(arg2)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg2, v2));
            v2 = v2 + 1;
        };
        v0
    }

    fun compose_dealer<T0>(arg0: &Game<T0>) : vector<u8> {
        let v0 = b"";
        0x1::vector::push_back<u8>(&mut v0, arg0.dealer_up);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0.dealer_hole)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0.dealer_hole, v1));
            v1 = v1 + 1;
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&arg0.dealer_extras)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0.dealer_extras, v2));
            v2 = v2 + 1;
        };
        v0
    }

    fun compute_payout(arg0: u8, arg1: u64, arg2: bool) : u64 {
        if (arg0 == 0) {
            return if (arg2) {
                arg1 * 2
            } else {
                arg1
            }
        };
        if (arg0 == 2) {
            return arg1 + arg1 * 3 / 2
        };
        if (arg0 == 1) {
            return arg1 * 2
        };
        if (arg0 == 3) {
            return arg1 * 4
        };
        0
    }

    public fun dealer_extras<T0>(arg0: &Game<T0>) : &vector<u8> {
        &arg0.dealer_extras
    }

    public fun dealer_hole<T0>(arg0: &Game<T0>) : &vector<u8> {
        &arg0.dealer_hole
    }

    public fun dealer_up<T0>(arg0: &Game<T0>) : u8 {
        arg0.dealer_up
    }

    entry fun double_down<T0>(arg0: &mut 0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::vault::Vault<T0>, arg1: &0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::registry::GameRegistration, arg2: &0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::house_lp::HouseLP<T0>, arg3: Game<T0>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        assert_player_turn<T0>(&arg3, arg6);
        assert!(0x1::vector::length<u8>(&arg3.player_cards) == 2, 1006);
        assert!(!arg3.doubled, 1006);
        assert!(0x2::coin::value<T0>(&arg4) == arg3.bet, 1002);
        0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::lifecycle::add_to_pot<T0>(&mut arg3.pot, arg4);
        arg3.doubled = true;
        0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::lifecycle::bump_reservation_with_lp<T0>(arg0, arg1, arg2, &mut arg3.round, arg3.bet * 3 / 2);
        let v0 = 0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::randomness::new_generator(arg5, arg6);
        let v1 = used_cards<T0>(&arg3);
        let v2 = 0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::blackjack_deck::draw_fresh(&mut v0, &v1);
        0x1::vector::push_back<u8>(&mut arg3.player_cards, v2);
        let (v3, _) = 0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::blackjack_cards::hand_total(&arg3.player_cards);
        let v5 = BlackjackCardDealt{
            game_id       : 0x2::object::uid_to_inner(&arg3.id),
            player        : arg3.player,
            seat          : b"player",
            card          : v2,
            running_total : v3,
        };
        0x2::event::emit<BlackjackCardDealt>(v5);
        let v6 = &mut arg3;
        let v7 = &mut v0;
        settle_and_freeze<T0>(arg3, arg0, arg1, play_dealer<T0>(v6, v7), arg6);
    }

    public fun doubled<T0>(arg0: &Game<T0>) : bool {
        arg0.doubled
    }

    public fun game_type_id() : u64 {
        1
    }

    entry fun hit<T0>(arg0: &mut 0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::vault::Vault<T0>, arg1: &0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::registry::GameRegistration, arg2: Game<T0>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert_player_turn<T0>(&arg2, arg4);
        let v0 = 0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::randomness::new_generator(arg3, arg4);
        let v1 = used_cards<T0>(&arg2);
        let v2 = 0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::blackjack_deck::draw_fresh(&mut v0, &v1);
        0x1::vector::push_back<u8>(&mut arg2.player_cards, v2);
        let (v3, _) = 0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::blackjack_cards::hand_total(&arg2.player_cards);
        let v5 = BlackjackCardDealt{
            game_id       : 0x2::object::uid_to_inner(&arg2.id),
            player        : arg2.player,
            seat          : b"player",
            card          : v2,
            running_total : v3,
        };
        0x2::event::emit<BlackjackCardDealt>(v5);
        if (0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::blackjack_cards::is_bust(&arg2.player_cards)) {
            settle_and_freeze<T0>(arg2, arg0, arg1, 5, arg4);
        } else {
            0x2::transfer::transfer<Game<T0>>(arg2, 0x2::tx_context::sender(arg4));
        };
    }

    fun init(arg0: BLACKJACK_GAME, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::registry::GameRegistration>(0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::registry::register_game<BLACKJACK_GAME>(arg0, 1, b"blackjack", 9950, 4000000000000, arg1));
    }

    public fun outcome_dealer_win() : u8 {
        4
    }

    public fun outcome_player_blackjack() : u8 {
        2
    }

    public fun outcome_player_bust() : u8 {
        5
    }

    public fun outcome_player_double_win() : u8 {
        3
    }

    public fun outcome_player_win() : u8 {
        1
    }

    public fun outcome_push() : u8 {
        0
    }

    fun play_dealer<T0>(arg0: &mut Game<T0>, arg1: &mut 0x2::random::RandomGenerator) : u8 {
        if (0x1::vector::length<u8>(&arg0.dealer_hole) == 0) {
            let v0 = used_cards<T0>(arg0);
            let v1 = 0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::blackjack_deck::draw_fresh(arg1, &v0);
            0x1::vector::push_back<u8>(&mut arg0.dealer_hole, v1);
            let v2 = BlackjackCardDealt{
                game_id       : 0x2::object::uid_to_inner(&arg0.id),
                player        : arg0.player,
                seat          : b"dealer",
                card          : v1,
                running_total : 0,
            };
            0x2::event::emit<BlackjackCardDealt>(v2);
        };
        loop {
            let v3 = compose_dealer<T0>(arg0);
            if (!0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::blackjack_cards::dealer_should_hit(&v3)) {
                break
            };
            let v4 = used_cards<T0>(arg0);
            let v5 = 0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::blackjack_deck::draw_fresh(arg1, &v4);
            0x1::vector::push_back<u8>(&mut arg0.dealer_extras, v5);
            let v6 = BlackjackCardDealt{
                game_id       : 0x2::object::uid_to_inner(&arg0.id),
                player        : arg0.player,
                seat          : b"dealer",
                card          : v5,
                running_total : 0,
            };
            0x2::event::emit<BlackjackCardDealt>(v6);
        };
        let v7 = &arg0.player_cards;
        let v8 = compose_dealer<T0>(arg0);
        let (v9, _) = 0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::blackjack_cards::hand_total(v7);
        let (v11, _) = 0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::blackjack_cards::hand_total(&v8);
        if (0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::blackjack_cards::is_bust(v7)) {
            5
        } else if (0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::blackjack_cards::is_bust(&v8)) {
            if (arg0.doubled) {
                3
            } else {
                1
            }
        } else if (v9 > v11) {
            if (arg0.doubled) {
                3
            } else {
                1
            }
        } else if (v9 == v11) {
            0
        } else {
            4
        }
    }

    public fun player<T0>(arg0: &Game<T0>) : address {
        arg0.player
    }

    public fun player_cards<T0>(arg0: &Game<T0>) : &vector<u8> {
        &arg0.player_cards
    }

    fun settle_and_freeze<T0>(arg0: Game<T0>, arg1: &mut 0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::vault::Vault<T0>, arg2: &0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::registry::GameRegistration, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let Game {
            id            : v0,
            player        : v1,
            bet           : v2,
            round         : v3,
            pot           : v4,
            player_cards  : v5,
            dealer_up     : v6,
            dealer_hole   : v7,
            dealer_extras : v8,
            status        : _,
            doubled       : v10,
        } = arg0;
        let v11 = v8;
        let v12 = v7;
        let v13 = v0;
        let v14 = build_dealer_vec(v6, &v12, &v11);
        let v15 = compute_payout(arg3, v2, v10);
        0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::lifecycle::settle_round<T0>(arg1, arg2, v3, v4, v15, arg4);
        let v16 = BlackjackHandSettled{
            game_id      : 0x2::object::uid_to_inner(&v13),
            player       : v1,
            outcome      : arg3,
            payout       : v15,
            player_cards : v5,
            dealer_cards : v14,
        };
        0x2::event::emit<BlackjackHandSettled>(v16);
        0x2::object::delete(v13);
        let v17 = HistoricalGame{
            id           : 0x2::object::new(arg4),
            player       : v1,
            bet          : v2,
            outcome      : arg3,
            doubled      : v10,
            payout       : v15,
            player_cards : v5,
            dealer_cards : v14,
        };
        0x2::transfer::freeze_object<HistoricalGame>(v17);
    }

    entry fun stand<T0>(arg0: &mut 0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::vault::Vault<T0>, arg1: &0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::registry::GameRegistration, arg2: Game<T0>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert_player_turn<T0>(&arg2, arg4);
        let v0 = 0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::randomness::new_generator(arg3, arg4);
        let v1 = &mut arg2;
        let v2 = &mut v0;
        settle_and_freeze<T0>(arg2, arg0, arg1, play_dealer<T0>(v1, v2), arg4);
    }

    entry fun start_game<T0>(arg0: &mut 0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::vault::Vault<T0>, arg1: &0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::registry::GameRegistration, arg2: &0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::house_lp::HouseLP<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 1001);
        assert!(0x2::coin::value<T0>(&arg3) == arg4, 1002);
        let v0 = 0x2::tx_context::sender(arg6);
        let (v1, v2) = 0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::lifecycle::open_round_with_lp<T0>(arg0, arg1, arg2, arg3, arg4 * 5 / 2, v0, arg6);
        let v3 = 0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::randomness::new_generator(arg5, arg6);
        let v4 = b"";
        let v5 = 0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::blackjack_deck::draw_fresh(&mut v3, &v4);
        0x1::vector::push_back<u8>(&mut v4, v5);
        let v6 = 0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::blackjack_deck::draw_fresh(&mut v3, &v4);
        0x1::vector::push_back<u8>(&mut v4, v6);
        let v7 = 0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::blackjack_deck::draw_fresh(&mut v3, &v4);
        0x1::vector::push_back<u8>(&mut v4, v7);
        let v8 = b"";
        0x1::vector::push_back<u8>(&mut v8, v5);
        0x1::vector::push_back<u8>(&mut v8, v7);
        let v9 = 0x2::object::new(arg6);
        let v10 = Game<T0>{
            id            : v9,
            player        : v0,
            bet           : arg4,
            round         : v1,
            pot           : v2,
            player_cards  : v8,
            dealer_up     : v6,
            dealer_hole   : b"",
            dealer_extras : b"",
            status        : 1,
            doubled       : false,
        };
        let v11 = 0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::blackjack_cards::is_blackjack(&v10.player_cards);
        let v12 = BlackjackHandStarted{
            game_id           : 0x2::object::uid_to_inner(&v9),
            player            : v0,
            bet               : arg4,
            player_cards      : v10.player_cards,
            dealer_up         : v6,
            natural_blackjack : v11,
        };
        0x2::event::emit<BlackjackHandStarted>(v12);
        if (v11) {
            0x1::vector::push_back<u8>(&mut v10.dealer_hole, 0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::blackjack_deck::draw_fresh(&mut v3, &v4));
            let v13 = compose_dealer<T0>(&v10);
            let v14 = if (0x5d5466cbd76b137e6f883ad027fb374d0fe0101ba020a162bbf1487195577753::blackjack_cards::is_blackjack(&v13)) {
                0
            } else {
                2
            };
            settle_and_freeze<T0>(v10, arg0, arg1, v14, arg6);
        } else {
            0x2::transfer::transfer<Game<T0>>(v10, v0);
        };
    }

    public fun status<T0>(arg0: &Game<T0>) : u8 {
        arg0.status
    }

    public fun status_player_turn() : u8 {
        1
    }

    fun used_cards<T0>(arg0: &Game<T0>) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0.player_cards)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0.player_cards, v1));
            v1 = v1 + 1;
        };
        0x1::vector::push_back<u8>(&mut v0, arg0.dealer_up);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&arg0.dealer_hole)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0.dealer_hole, v2));
            v2 = v2 + 1;
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(&arg0.dealer_extras)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0.dealer_extras, v3));
            v3 = v3 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

