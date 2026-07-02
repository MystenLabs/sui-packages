module 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::blackjack_game {
    struct BLACKJACK_GAME has drop {
        dummy_field: bool,
    }

    struct Hand has drop, store {
        cards: vector<u8>,
        bet: u64,
        doubled: bool,
        done: bool,
    }

    struct Game<phantom T0> has key {
        id: 0x2::object::UID,
        player: address,
        session: address,
        base_bet: u64,
        round: 0x1::option::Option<0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::lifecycle::Round>,
        pot: 0x1::option::Option<0x2::balance::Balance<T0>>,
        hands: vector<Hand>,
        active: u64,
        dealer_up: u8,
        dealer_hole: vector<u8>,
        dealer_extras: vector<u8>,
        insurance_bet: u64,
        insurance_available: bool,
        status: u8,
        opened_at_ms: u64,
    }

    struct HistoricalGame has key {
        id: 0x2::object::UID,
        player: address,
        base_bet: u64,
        num_hands: u8,
        insurance_bet: u64,
        insurance_won: bool,
        total_staked: u64,
        total_payout: u64,
        dealer_cards: vector<u8>,
        hand_cards: vector<vector<u8>>,
        hand_bets: vector<u64>,
        hand_doubled: vector<bool>,
        hand_outcomes: vector<u8>,
    }

    struct BlackjackHandStarted has copy, drop, store {
        game_id: 0x2::object::ID,
        player: address,
        bet: u64,
        player_cards: vector<u8>,
        dealer_up: u8,
        natural_blackjack: bool,
        insurance_offered: bool,
    }

    struct BlackjackCardDealt has copy, drop, store {
        game_id: 0x2::object::ID,
        player: address,
        seat: vector<u8>,
        hand_index: u8,
        card: u8,
        running_total: u8,
    }

    struct BlackjackHandSplit has copy, drop, store {
        game_id: 0x2::object::ID,
        player: address,
        num_hands: u8,
    }

    struct BlackjackInsurance has copy, drop, store {
        game_id: 0x2::object::ID,
        player: address,
        insurance_bet: u64,
        taken: bool,
    }

    struct BlackjackSurrender has copy, drop, store {
        game_id: 0x2::object::ID,
        player: address,
        returned: u64,
    }

    struct BlackjackHandSettled has copy, drop, store {
        game_id: 0x2::object::ID,
        player: address,
        num_hands: u8,
        total_payout: u64,
        dealer_cards: vector<u8>,
        insurance_bet: u64,
        insurance_won: bool,
    }

    public fun active<T0>(arg0: &Game<T0>) : u64 {
        arg0.active
    }

    fun advance_active<T0>(arg0: &mut Game<T0>) {
        while (arg0.active < 0x1::vector::length<Hand>(&arg0.hands) && 0x1::vector::borrow<Hand>(&arg0.hands, arg0.active).done) {
            arg0.active = arg0.active + 1;
        };
    }

    fun any_live<T0>(arg0: &Game<T0>) : bool {
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<Hand>(&arg0.hands)) {
            if (!0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::blackjack_cards::is_bust(&0x1::vector::borrow<Hand>(&arg0.hands, v0).cards)) {
                v1 = true;
            };
            v0 = v0 + 1;
        };
        v1
    }

    fun assert_player_turn<T0>(arg0: &Game<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.player || arg0.session != @0x0 && v0 == arg0.session, 1003);
        assert!(arg0.status == 1, 1004);
        assert!(arg0.active < 0x1::vector::length<Hand>(&arg0.hands), 1004);
    }

    public fun base_bet<T0>(arg0: &Game<T0>) : u64 {
        arg0.base_bet
    }

    fun build_dealer_vec(arg0: u8, arg1: &vector<u8>, arg2: &vector<u8>) : vector<u8> {
        let v0 = b"";
        0x1::vector::push_back<u8>(&mut v0, arg0);
        let v1 = &mut v0;
        push_all(v1, arg1);
        let v2 = &mut v0;
        push_all(v2, arg2);
        v0
    }

    fun clone_u8(arg0: &vector<u8>) : vector<u8> {
        let v0 = b"";
        let v1 = &mut v0;
        push_all(v1, arg0);
        v0
    }

    fun compose_dealer<T0>(arg0: &Game<T0>) : vector<u8> {
        build_dealer_vec(arg0.dealer_up, &arg0.dealer_hole, &arg0.dealer_extras)
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

    entry fun destroy_settled<T0>(arg0: Game<T0>) {
        assert!(arg0.status == 2, 1004);
        destroy_shell<T0>(arg0);
    }

    fun destroy_shell<T0>(arg0: Game<T0>) {
        let Game {
            id                  : v0,
            player              : _,
            session             : _,
            base_bet            : _,
            round               : v4,
            pot                 : v5,
            hands               : _,
            active              : _,
            dealer_up           : _,
            dealer_hole         : _,
            dealer_extras       : _,
            insurance_bet       : _,
            insurance_available : _,
            status              : _,
            opened_at_ms        : _,
        } = arg0;
        0x1::option::destroy_none<0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::lifecycle::Round>(v4);
        0x1::option::destroy_none<0x2::balance::Balance<T0>>(v5);
        0x2::object::delete(v0);
    }

    fun do_insurance<T0>(arg0: &mut 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::vault::Vault<T0>, arg1: &0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::registry::GameRegistration, arg2: &0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::house_lp::HouseLP<T0>, arg3: &mut Game<T0>, arg4: 0x2::coin::Coin<T0>) {
        assert!(arg3.insurance_available, 1009);
        assert!(arg3.insurance_bet == 0, 1009);
        let v0 = 0x2::coin::value<T0>(&arg4);
        assert!(v0 > 0 && v0 <= arg3.base_bet / 2, 1010);
        0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::lifecycle::bump_reservation_with_lp<T0>(arg0, arg1, arg2, 0x1::option::borrow_mut<0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::lifecycle::Round>(&mut arg3.round), v0 * 3);
        0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::lifecycle::add_to_pot<T0>(0x1::option::borrow_mut<0x2::balance::Balance<T0>>(&mut arg3.pot), arg4);
        arg3.insurance_bet = v0;
        arg3.insurance_available = false;
        let v1 = BlackjackInsurance{
            game_id       : 0x2::object::uid_to_inner(&arg3.id),
            player        : arg3.player,
            insurance_bet : v0,
            taken         : true,
        };
        0x2::event::emit<BlackjackInsurance>(v1);
    }

    fun do_split<T0>(arg0: &mut 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::vault::Vault<T0>, arg1: &0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::registry::GameRegistration, arg2: &0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::house_lp::HouseLP<T0>, arg3: &mut Game<T0>, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::random::RandomGenerator) {
        let v0 = arg3.active;
        let v1 = 0x1::vector::borrow<Hand>(&arg3.hands, v0);
        assert!(0x1::vector::length<u8>(&v1.cards) == 2, 1006);
        assert!(!v1.doubled && !v1.done, 1006);
        let v2 = *0x1::vector::borrow<u8>(&v1.cards, 0);
        let v3 = *0x1::vector::borrow<u8>(&v1.cards, 1);
        let v4 = v1.bet;
        assert!(0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::blackjack_cards::rank_value(v2) == 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::blackjack_cards::rank_value(v3), 1007);
        assert!(0x1::vector::length<Hand>(&arg3.hands) < 4, 1008);
        assert!(0x2::coin::value<T0>(&arg4) == v4, 1002);
        0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::lifecycle::bump_reservation_with_lp<T0>(arg0, arg1, arg2, 0x1::option::borrow_mut<0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::lifecycle::Round>(&mut arg3.round), v4 * 4);
        0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::lifecycle::add_to_pot<T0>(0x1::option::borrow_mut<0x2::balance::Balance<T0>>(&mut arg3.pot), arg4);
        let v5 = used_cards<T0>(arg3);
        let v6 = 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::blackjack_deck::draw_fresh(arg5, &v5);
        0x1::vector::push_back<u8>(&mut v5, v6);
        let v7 = 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::blackjack_deck::draw_fresh(arg5, &v5);
        let v8 = b"";
        0x1::vector::push_back<u8>(&mut v8, v2);
        0x1::vector::push_back<u8>(&mut v8, v6);
        0x1::vector::borrow_mut<Hand>(&mut arg3.hands, v0).cards = v8;
        let v9 = b"";
        0x1::vector::push_back<u8>(&mut v9, v3);
        0x1::vector::push_back<u8>(&mut v9, v7);
        let v10 = Hand{
            cards   : v9,
            bet     : v4,
            doubled : false,
            done    : false,
        };
        if (0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::blackjack_cards::rank_idx(v2) == 0) {
            0x1::vector::borrow_mut<Hand>(&mut arg3.hands, v0).done = true;
            v10.done = true;
        } else {
            if (hand_is_21(&0x1::vector::borrow<Hand>(&arg3.hands, v0).cards)) {
                0x1::vector::borrow_mut<Hand>(&mut arg3.hands, v0).done = true;
            };
            if (hand_is_21(&v10.cards)) {
                v10.done = true;
            };
        };
        0x1::vector::push_back<Hand>(&mut arg3.hands, v10);
        let v11 = 0x2::object::uid_to_inner(&arg3.id);
        let (v12, _) = 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::blackjack_cards::hand_total(&0x1::vector::borrow<Hand>(&arg3.hands, v0).cards);
        let v14 = BlackjackCardDealt{
            game_id       : v11,
            player        : arg3.player,
            seat          : b"player",
            hand_index    : (v0 as u8),
            card          : v6,
            running_total : v12,
        };
        0x2::event::emit<BlackjackCardDealt>(v14);
        let v15 = 0x1::vector::length<Hand>(&arg3.hands) - 1;
        let (v16, _) = 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::blackjack_cards::hand_total(&0x1::vector::borrow<Hand>(&arg3.hands, v15).cards);
        let v18 = BlackjackCardDealt{
            game_id       : v11,
            player        : arg3.player,
            seat          : b"player",
            hand_index    : (v15 as u8),
            card          : v7,
            running_total : v16,
        };
        0x2::event::emit<BlackjackCardDealt>(v18);
        let v19 = BlackjackHandSplit{
            game_id   : v11,
            player    : arg3.player,
            num_hands : (0x1::vector::length<Hand>(&arg3.hands) as u8),
        };
        0x2::event::emit<BlackjackHandSplit>(v19);
    }

    entry fun double_down<T0>(arg0: &mut 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::vault::Vault<T0>, arg1: &0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::registry::GameRegistration, arg2: &mut Game<T0>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert_player_turn<T0>(arg2, arg5);
        arg2.insurance_available = false;
        let v0 = arg2.active;
        let v1 = 0x1::vector::borrow<Hand>(&arg2.hands, v0);
        assert!(0x1::vector::length<u8>(&v1.cards) == 2, 1006);
        assert!(!v1.doubled && !v1.done, 1006);
        assert!(0x2::coin::value<T0>(&arg3) == v1.bet, 1002);
        0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::lifecycle::add_to_pot<T0>(0x1::option::borrow_mut<0x2::balance::Balance<T0>>(&mut arg2.pot), arg3);
        let v2 = 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::randomness::new_generator(arg4, arg5);
        let v3 = used_cards<T0>(arg2);
        let v4 = 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::blackjack_deck::draw_fresh(&mut v2, &v3);
        let v5 = 0x1::vector::borrow_mut<Hand>(&mut arg2.hands, v0);
        v5.doubled = true;
        0x1::vector::push_back<u8>(&mut v5.cards, v4);
        v5.done = true;
        let (v6, _) = 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::blackjack_cards::hand_total(&0x1::vector::borrow<Hand>(&arg2.hands, v0).cards);
        let v8 = BlackjackCardDealt{
            game_id       : 0x2::object::uid_to_inner(&arg2.id),
            player        : arg2.player,
            seat          : b"player",
            hand_index    : (v0 as u8),
            card          : v4,
            running_total : v6,
        };
        0x2::event::emit<BlackjackCardDealt>(v8);
        let v9 = &mut v2;
        finish_turn<T0>(arg2, arg0, arg1, v9, arg5);
    }

    fun finish_turn<T0>(arg0: &mut Game<T0>, arg1: &mut 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::vault::Vault<T0>, arg2: &0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::registry::GameRegistration, arg3: &mut 0x2::random::RandomGenerator, arg4: &mut 0x2::tx_context::TxContext) {
        advance_active<T0>(arg0);
        if (arg0.active >= 0x1::vector::length<Hand>(&arg0.hands)) {
            let v0 = any_live<T0>(arg0);
            play_dealer<T0>(arg0, arg3, v0);
            settle_in_place<T0>(arg0, arg1, arg2, arg4);
        };
    }

    entry fun force_settle_stale<T0>(arg0: &mut 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::vault::Vault<T0>, arg1: &0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::registry::GameRegistration, arg2: &mut Game<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 1, 1004);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg2.opened_at_ms + 3600000, 1012);
        let v0 = 0x1::vector::length<Hand>(&arg2.hands);
        let v1 = 0;
        while (v1 < v0) {
            0x1::vector::borrow_mut<Hand>(&mut arg2.hands, v1).done = true;
            v1 = v1 + 1;
        };
        arg2.active = v0;
        let v2 = 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::randomness::new_generator(arg4, arg5);
        let v3 = any_live<T0>(arg2);
        let v4 = &mut v2;
        play_dealer<T0>(arg2, v4, v3);
        settle_in_place<T0>(arg2, arg0, arg1, arg5);
    }

    public fun game_type_id() : u64 {
        1
    }

    public fun hand_bet<T0>(arg0: &Game<T0>, arg1: u64) : u64 {
        0x1::vector::borrow<Hand>(&arg0.hands, arg1).bet
    }

    public fun hand_cards<T0>(arg0: &Game<T0>, arg1: u64) : &vector<u8> {
        &0x1::vector::borrow<Hand>(&arg0.hands, arg1).cards
    }

    public fun hand_done<T0>(arg0: &Game<T0>, arg1: u64) : bool {
        0x1::vector::borrow<Hand>(&arg0.hands, arg1).done
    }

    public fun hand_doubled<T0>(arg0: &Game<T0>, arg1: u64) : bool {
        0x1::vector::borrow<Hand>(&arg0.hands, arg1).doubled
    }

    fun hand_is_21(arg0: &vector<u8>) : bool {
        let (v0, _) = 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::blackjack_cards::hand_total(arg0);
        v0 == 21
    }

    entry fun hit<T0>(arg0: &mut 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::vault::Vault<T0>, arg1: &0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::registry::GameRegistration, arg2: &mut Game<T0>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert_player_turn<T0>(arg2, arg4);
        arg2.insurance_available = false;
        let v0 = 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::randomness::new_generator(arg3, arg4);
        let v1 = arg2.active;
        let v2 = used_cards<T0>(arg2);
        let v3 = 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::blackjack_deck::draw_fresh(&mut v0, &v2);
        let v4 = 0x1::vector::borrow_mut<Hand>(&mut arg2.hands, v1);
        0x1::vector::push_back<u8>(&mut v4.cards, v3);
        if (0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::blackjack_cards::is_bust(&v4.cards) || hand_is_21(&v4.cards)) {
            v4.done = true;
        };
        let (v5, _) = 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::blackjack_cards::hand_total(&0x1::vector::borrow<Hand>(&arg2.hands, v1).cards);
        let v7 = BlackjackCardDealt{
            game_id       : 0x2::object::uid_to_inner(&arg2.id),
            player        : arg2.player,
            seat          : b"player",
            hand_index    : (v1 as u8),
            card          : v3,
            running_total : v5,
        };
        0x2::event::emit<BlackjackCardDealt>(v7);
        let v8 = &mut v0;
        finish_turn<T0>(arg2, arg0, arg1, v8, arg4);
    }

    fun init(arg0: BLACKJACK_GAME, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::registry::GameRegistration>(0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::registry::register_game<BLACKJACK_GAME>(arg0, 1, b"blackjack", 9950, 4000000000000, arg1));
    }

    entry fun insurance<T0>(arg0: &mut 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::vault::Vault<T0>, arg1: &0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::registry::GameRegistration, arg2: &0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::house_lp::HouseLP<T0>, arg3: &mut Game<T0>, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        assert_player_turn<T0>(arg3, arg5);
        do_insurance<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun insurance_available<T0>(arg0: &Game<T0>) : bool {
        arg0.insurance_available
    }

    public fun insurance_bet<T0>(arg0: &Game<T0>) : u64 {
        arg0.insurance_bet
    }

    public fun max_hands() : u64 {
        4
    }

    public fun num_hands<T0>(arg0: &Game<T0>) : u64 {
        0x1::vector::length<Hand>(&arg0.hands)
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

    public fun outcome_player_win() : u8 {
        1
    }

    public fun outcome_push() : u8 {
        0
    }

    public fun outcome_surrender() : u8 {
        6
    }

    public fun payout_mult_per_hand() : u64 {
        4
    }

    fun play_dealer<T0>(arg0: &mut Game<T0>, arg1: &mut 0x2::random::RandomGenerator, arg2: bool) {
        if (0x1::vector::length<u8>(&arg0.dealer_hole) == 0) {
            let v0 = used_cards<T0>(arg0);
            let v1 = 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::blackjack_deck::draw_fresh(arg1, &v0);
            0x1::vector::push_back<u8>(&mut arg0.dealer_hole, v1);
            let v2 = BlackjackCardDealt{
                game_id       : 0x2::object::uid_to_inner(&arg0.id),
                player        : arg0.player,
                seat          : b"dealer",
                hand_index    : 0,
                card          : v1,
                running_total : 0,
            };
            0x2::event::emit<BlackjackCardDealt>(v2);
        };
        if (arg2) {
            loop {
                let v3 = compose_dealer<T0>(arg0);
                if (!0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::blackjack_cards::dealer_should_hit(&v3)) {
                    break
                };
                let v4 = used_cards<T0>(arg0);
                let v5 = 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::blackjack_deck::draw_fresh(arg1, &v4);
                0x1::vector::push_back<u8>(&mut arg0.dealer_extras, v5);
                let v6 = BlackjackCardDealt{
                    game_id       : 0x2::object::uid_to_inner(&arg0.id),
                    player        : arg0.player,
                    seat          : b"dealer",
                    hand_index    : 0,
                    card          : v5,
                    running_total : 0,
                };
                0x2::event::emit<BlackjackCardDealt>(v6);
            };
        };
    }

    public fun player<T0>(arg0: &Game<T0>) : address {
        arg0.player
    }

    fun push_all(arg0: &mut vector<u8>, arg1: &vector<u8>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg1)) {
            0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(arg1, v0));
            v0 = v0 + 1;
        };
    }

    fun settle_in_place<T0>(arg0: &mut Game<T0>, arg1: &mut 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::vault::Vault<T0>, arg2: &0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::registry::GameRegistration, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.player;
        let v1 = arg0.insurance_bet;
        let v2 = &arg0.hands;
        let v3 = build_dealer_vec(arg0.dealer_up, &arg0.dealer_hole, &arg0.dealer_extras);
        let (v4, _) = 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::blackjack_cards::hand_total(&v3);
        let v6 = 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::blackjack_cards::is_blackjack(&v3);
        let v7 = 0x1::vector::length<Hand>(v2);
        let v8 = 0;
        let v9 = 0;
        let v10 = vector[];
        let v11 = vector[];
        let v12 = vector[];
        let v13 = b"";
        let v14 = 0;
        while (v14 < v7) {
            let v15 = 0x1::vector::borrow<Hand>(v2, v14);
            let v16 = if (v15.doubled) {
                v15.bet * 2
            } else {
                v15.bet
            };
            let (v17, _) = 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::blackjack_cards::hand_total(&v15.cards);
            let v19 = v7 == 1 && 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::blackjack_cards::is_blackjack(&v15.cards);
            let (v20, v21) = if (0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::blackjack_cards::is_bust(&v15.cards)) {
                (5, 0)
            } else if (v19) {
                if (v6) {
                    (0, v16)
                } else {
                    (2, v15.bet + v15.bet * 3 / 2)
                }
            } else if (v6) {
                (4, 0)
            } else {
                let (v22, v23) = if (0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::blackjack_cards::is_bust(&v3)) {
                    (v16 * 2, 1)
                } else {
                    let (v24, v25) = if (v17 > v4) {
                        (1, v16 * 2)
                    } else if (v17 == v4) {
                        (0, v16)
                    } else {
                        (4, 0)
                    };
                    (v25, v24)
                };
                (v23, v22)
            };
            v8 = v8 + v21;
            v9 = v9 + v16;
            0x1::vector::push_back<vector<u8>>(&mut v10, clone_u8(&v15.cards));
            0x1::vector::push_back<u64>(&mut v11, v15.bet);
            0x1::vector::push_back<bool>(&mut v12, v15.doubled);
            0x1::vector::push_back<u8>(&mut v13, v20);
            v14 = v14 + 1;
        };
        let v26 = v6 && v1 > 0;
        if (v26) {
            v8 = v8 + v1 * 3;
        };
        if (v1 > 0) {
            v9 = v9 + v1;
        };
        0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::lifecycle::settle_round<T0>(arg1, arg2, 0x1::option::extract<0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::lifecycle::Round>(&mut arg0.round), 0x1::option::extract<0x2::balance::Balance<T0>>(&mut arg0.pot), v8, arg3);
        arg0.status = 2;
        let v27 = BlackjackHandSettled{
            game_id       : 0x2::object::uid_to_inner(&arg0.id),
            player        : v0,
            num_hands     : (v7 as u8),
            total_payout  : v8,
            dealer_cards  : clone_u8(&v3),
            insurance_bet : v1,
            insurance_won : v26,
        };
        0x2::event::emit<BlackjackHandSettled>(v27);
        let v28 = HistoricalGame{
            id            : 0x2::object::new(arg3),
            player        : v0,
            base_bet      : arg0.base_bet,
            num_hands     : (v7 as u8),
            insurance_bet : v1,
            insurance_won : v26,
            total_staked  : v9,
            total_payout  : v8,
            dealer_cards  : v3,
            hand_cards    : v10,
            hand_bets     : v11,
            hand_doubled  : v12,
            hand_outcomes : v13,
        };
        0x2::transfer::freeze_object<HistoricalGame>(v28);
    }

    fun settle_surrender<T0>(arg0: &mut Game<T0>, arg1: &mut 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::vault::Vault<T0>, arg2: &0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::registry::GameRegistration, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.player;
        let v1 = arg0.base_bet;
        let v2 = v1 / 2;
        let v3 = build_dealer_vec(arg0.dealer_up, &arg0.dealer_hole, &arg0.dealer_extras);
        let v4 = vector[];
        0x1::vector::push_back<vector<u8>>(&mut v4, clone_u8(&0x1::vector::borrow<Hand>(&arg0.hands, 0).cards));
        let v5 = vector[];
        0x1::vector::push_back<u64>(&mut v5, v1);
        let v6 = vector[];
        0x1::vector::push_back<bool>(&mut v6, false);
        let v7 = b"";
        0x1::vector::push_back<u8>(&mut v7, 6);
        let v8 = 0x2::object::uid_to_inner(&arg0.id);
        0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::lifecycle::settle_round<T0>(arg1, arg2, 0x1::option::extract<0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::lifecycle::Round>(&mut arg0.round), 0x1::option::extract<0x2::balance::Balance<T0>>(&mut arg0.pot), v2, arg3);
        arg0.status = 2;
        let v9 = BlackjackSurrender{
            game_id  : v8,
            player   : v0,
            returned : v2,
        };
        0x2::event::emit<BlackjackSurrender>(v9);
        let v10 = BlackjackHandSettled{
            game_id       : v8,
            player        : v0,
            num_hands     : 1,
            total_payout  : v2,
            dealer_cards  : clone_u8(&v3),
            insurance_bet : 0,
            insurance_won : false,
        };
        0x2::event::emit<BlackjackHandSettled>(v10);
        let v11 = HistoricalGame{
            id            : 0x2::object::new(arg3),
            player        : v0,
            base_bet      : v1,
            num_hands     : 1,
            insurance_bet : 0,
            insurance_won : false,
            total_staked  : v1,
            total_payout  : v2,
            dealer_cards  : v3,
            hand_cards    : v4,
            hand_bets     : v5,
            hand_doubled  : v6,
            hand_outcomes : v7,
        };
        0x2::transfer::freeze_object<HistoricalGame>(v11);
    }

    entry fun split<T0>(arg0: &mut 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::vault::Vault<T0>, arg1: &0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::registry::GameRegistration, arg2: &0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::house_lp::HouseLP<T0>, arg3: &mut Game<T0>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        assert_player_turn<T0>(arg3, arg6);
        arg3.insurance_available = false;
        let v0 = 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::randomness::new_generator(arg5, arg6);
        let v1 = &mut v0;
        do_split<T0>(arg0, arg1, arg2, arg3, arg4, v1);
        let v2 = &mut v0;
        finish_turn<T0>(arg3, arg0, arg1, v2, arg6);
    }

    entry fun stand<T0>(arg0: &mut 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::vault::Vault<T0>, arg1: &0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::registry::GameRegistration, arg2: &mut Game<T0>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert_player_turn<T0>(arg2, arg4);
        arg2.insurance_available = false;
        let v0 = 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::randomness::new_generator(arg3, arg4);
        0x1::vector::borrow_mut<Hand>(&mut arg2.hands, arg2.active).done = true;
        let v1 = &mut v0;
        finish_turn<T0>(arg2, arg0, arg1, v1, arg4);
    }

    entry fun start_game<T0>(arg0: &mut 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::vault::Vault<T0>, arg1: &0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::registry::GameRegistration, arg2: &0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::house_lp::HouseLP<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: address, arg6: &0x2::clock::Clock, arg7: &0x2::random::Random, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 1001);
        assert!(0x2::coin::value<T0>(&arg3) == arg4, 1002);
        let v0 = 0x2::tx_context::sender(arg8);
        let (v1, v2) = 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::lifecycle::open_round_with_lp<T0>(arg0, arg1, arg2, arg3, arg4 * 4, v0, arg8);
        let v3 = 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::randomness::new_generator(arg7, arg8);
        let v4 = b"";
        let v5 = 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::blackjack_deck::draw_fresh(&mut v3, &v4);
        0x1::vector::push_back<u8>(&mut v4, v5);
        let v6 = 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::blackjack_deck::draw_fresh(&mut v3, &v4);
        0x1::vector::push_back<u8>(&mut v4, v6);
        let v7 = b"";
        0x1::vector::push_back<u8>(&mut v7, v5);
        0x1::vector::push_back<u8>(&mut v7, 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::blackjack_deck::draw_fresh(&mut v3, &v4));
        let v8 = Hand{
            cards   : v7,
            bet     : arg4,
            doubled : false,
            done    : false,
        };
        let v9 = 0x1::vector::empty<Hand>();
        0x1::vector::push_back<Hand>(&mut v9, v8);
        let v10 = 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::blackjack_cards::rank_idx(v6) == 0;
        let v11 = 0x2::object::new(arg8);
        let v12 = Game<T0>{
            id                  : v11,
            player              : v0,
            session             : arg5,
            base_bet            : arg4,
            round               : 0x1::option::some<0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::lifecycle::Round>(v1),
            pot                 : 0x1::option::some<0x2::balance::Balance<T0>>(v2),
            hands               : v9,
            active              : 0,
            dealer_up           : v6,
            dealer_hole         : b"",
            dealer_extras       : b"",
            insurance_bet       : 0,
            insurance_available : v10,
            status              : 1,
            opened_at_ms        : 0x2::clock::timestamp_ms(arg6),
        };
        let v13 = 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::blackjack_cards::is_blackjack(&0x1::vector::borrow<Hand>(&v12.hands, 0).cards);
        let v14 = BlackjackHandStarted{
            game_id           : 0x2::object::uid_to_inner(&v11),
            player            : v0,
            bet               : arg4,
            player_cards      : clone_u8(&0x1::vector::borrow<Hand>(&v12.hands, 0).cards),
            dealer_up         : v6,
            natural_blackjack : v13,
            insurance_offered : v10,
        };
        0x2::event::emit<BlackjackHandStarted>(v14);
        if (v13) {
            0x1::vector::borrow_mut<Hand>(&mut v12.hands, 0).done = true;
            let v15 = &mut v12;
            let v16 = &mut v3;
            play_dealer<T0>(v15, v16, false);
            let v17 = &mut v12;
            settle_in_place<T0>(v17, arg0, arg1, arg8);
            destroy_shell<T0>(v12);
        } else {
            0x2::transfer::share_object<Game<T0>>(v12);
        };
    }

    public fun status<T0>(arg0: &Game<T0>) : u8 {
        arg0.status
    }

    public fun status_player_turn() : u8 {
        1
    }

    entry fun surrender<T0>(arg0: &mut 0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::vault::Vault<T0>, arg1: &0xc07cbfc09907f5aa716dc6ff1abecfe21ac914649701ab4d061cabbe9d401123::registry::GameRegistration, arg2: &mut Game<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_player_turn<T0>(arg2, arg3);
        assert!(0x1::vector::length<Hand>(&arg2.hands) == 1, 1011);
        let v0 = 0x1::vector::borrow<Hand>(&arg2.hands, 0);
        assert!(0x1::vector::length<u8>(&v0.cards) == 2 && !v0.doubled, 1011);
        settle_surrender<T0>(arg2, arg0, arg1, arg3);
    }

    fun used_cards<T0>(arg0: &Game<T0>) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 0x1::vector::length<Hand>(&arg0.hands)) {
            let v2 = 0x1::vector::borrow<Hand>(&arg0.hands, v1);
            let v3 = 0;
            while (v3 < 0x1::vector::length<u8>(&v2.cards)) {
                0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v2.cards, v3));
                v3 = v3 + 1;
            };
            v1 = v1 + 1;
        };
        0x1::vector::push_back<u8>(&mut v0, arg0.dealer_up);
        let v4 = &mut v0;
        push_all(v4, &arg0.dealer_hole);
        let v5 = &mut v0;
        push_all(v5, &arg0.dealer_extras);
        v0
    }

    // decompiled from Move bytecode v7
}

