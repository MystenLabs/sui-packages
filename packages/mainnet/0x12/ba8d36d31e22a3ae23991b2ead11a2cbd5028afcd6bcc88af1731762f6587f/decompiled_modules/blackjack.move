module 0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::blackjack {
    struct HouseCap has key {
        id: 0x2::object::UID,
        privilege: u8,
        house_id: 0x2::object::ID,
    }

    struct HouseData<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        house: address,
        house_risk: u64,
        round: u64,
        min_bet: u64,
        max_bet: u64,
        seed: u256,
        pending: vector<0x2::object::ID>,
    }

    struct Bet<phantom T0> has store, key {
        id: 0x2::object::UID,
        bet_size: 0x2::balance::Balance<T0>,
        player: address,
    }

    struct Player<phantom T0> has store, key {
        id: 0x2::object::UID,
        bet_size_value: u64,
        double_down_bet: u64,
        insurance_bet: u64,
        seed: u256,
        score: u8,
        hand: vector<u8>,
        bets: 0x2::table_vec::TableVec<Bet<T0>>,
    }

    struct Game<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        start_time: u64,
        round: u64,
        stage: u8,
        total_risk: u64,
        dealer: Player<T0>,
        player: Player<T0>,
        split_player: Player<T0>,
    }

    public fun balance<T0>(arg0: &HouseData<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public entry fun split<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut HouseData<T0>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = arg1.seed;
        let v2 = 0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::math::unsafe_mul(v0, 1500000000);
        let v3 = arg1.house_risk + v2;
        assert!(v3 <= balance<T0>(arg1), 1);
        let v4 = 0x2::tx_context::sender(arg4);
        let v5 = borrow_game_mut<T0>(arg1, arg2);
        assert!(v5.owner == v4 && v5.stage == 1 && v5.player.bet_size_value == v0 && v5.player.double_down_bet == 0 && card_length(&v5.player.hand) == 2 && v5.split_player.bet_size_value == 0 && card_score(&v5.player.hand, 0) == card_score(&v5.player.hand, 1), 4);
        let v6 = Bet<T0>{
            id       : 0x2::object::new(arg4),
            bet_size : 0x2::coin::into_balance<T0>(arg0),
            player   : v4,
        };
        0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::events::emit_split_bet<T0>(arg2, v5.round, 0x2::balance::value<T0>(&v6.bet_size), v6.player);
        0x2::table_vec::push_back<Bet<T0>>(&mut v5.split_player.bets, v6);
        v5.split_player.bet_size_value = v0;
        0x1::vector::push_back<u8>(&mut v5.split_player.hand, 0x1::vector::pop_back<u8>(&mut v5.player.hand));
        let v7 = (0x2::clock::timestamp_ms(arg3) as u256);
        let v8 = &mut v1;
        let v9 = &mut v5.player;
        draw_card<T0>(v8, arg2, v5.round, v9, 1, v7);
        let v10 = &mut v1;
        let v11 = &mut v5.split_player;
        draw_card<T0>(v10, arg2, v5.round, v11, 2, v7);
        0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::events::emit_player_hand(arg2, v5.player.hand, v5.split_player.hand);
        v5.total_risk = v5.total_risk + v2;
        0x1::debug::print<Game<T0>>(v5);
        arg1.house_risk = v3;
        arg1.seed = v1;
    }

    public fun borrow_game<T0>(arg0: &HouseData<T0>, arg1: 0x2::object::ID) : &Game<T0> {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Game<T0>>(&arg0.id, arg1), 10);
        0x2::dynamic_object_field::borrow<0x2::object::ID, Game<T0>>(&arg0.id, arg1)
    }

    fun borrow_game_mut<T0>(arg0: &mut HouseData<T0>, arg1: 0x2::object::ID) : &mut Game<T0> {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Game<T0>>(&arg0.id, arg1), 10);
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Game<T0>>(&mut arg0.id, arg1)
    }

    fun calculate_payout<T0>(arg0: &Player<T0>, arg1: &Player<T0>, arg2: bool, arg3: bool) : (u64, bool) {
        let v0 = 0;
        let v1 = false;
        let v2 = player_has_bj<T0>(arg0) && !arg3;
        if (v2 || arg2) {
            if (v2 && arg2) {
                v1 = true;
            } else if (v2) {
                v0 = 0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::math::unsafe_mul(arg0.bet_size_value, 1500000000);
            };
        } else if (arg0.score > arg1.score || arg1.score > 21) {
            v0 = arg0.bet_size_value + arg0.double_down_bet;
        } else if (arg0.score == arg1.score) {
            v1 = true;
        };
        (v0, v1)
    }

    fun card_length(arg0: &vector<u8>) : u64 {
        0x1::vector::length<u8>(arg0)
    }

    fun card_number(arg0: &vector<u8>, arg1: u64) : u8 {
        *0x1::vector::borrow<u8>(arg0, arg1)
    }

    fun card_score(arg0: &vector<u8>, arg1: u64) : u8 {
        let v0 = x"0b02030405060708090a0a0a0a";
        *0x1::vector::borrow<u8>(&v0, card_score_index(arg0, arg1))
    }

    fun card_score_index(arg0: &vector<u8>, arg1: u64) : u64 {
        (card_number(arg0, arg1) as u64) % 13
    }

    fun conclude_game<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: &mut Game<T0>, arg2: &mut u256, arg3: u256, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        let v3 = 0;
        let v4 = draw_dealer_cards<T0>(arg1, arg2, arg3);
        let v5 = arg1.split_player.bet_size_value > 0;
        if (arg1.player.score <= 21) {
            let (v6, v7) = calculate_payout<T0>(&arg1.player, &arg1.dealer, v4, v5);
            v1 = v0 + v6;
            if (v6 > 0) {
                v2 = 2;
            } else if (v7) {
                v2 = 1;
            };
        };
        let (v8, v9) = get_coin<T0>(0x2::table_vec::pop_back<Bet<T0>>(&mut arg1.player.bets), arg4);
        let (v10, v11) = if (v5) {
            if (arg1.split_player.score <= 21) {
                let (v12, v13) = calculate_payout<T0>(&arg1.split_player, &arg1.dealer, v4, v5);
                v1 = v1 + v12;
                if (v12 > 0) {
                    v3 = 2;
                } else if (v13) {
                    v3 = 1;
                };
            };
            assert!(v1 <= 0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::math::unsafe_mul(arg1.player.bet_size_value, 3000000000), 9);
            let (v14, _) = get_coin<T0>(0x2::table_vec::pop_back<Bet<T0>>(&mut arg1.split_player.bets), arg4);
            payout_with_split<T0>(arg0, v8, v14, v9, v1, arg1.player.insurance_bet, v4, v2, v3, arg4)
        } else {
            assert!(v1 <= 0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::math::unsafe_mul(arg1.player.bet_size_value, 2000000000), 9);
            payout_without_split<T0>(arg0, v8, v9, v1, arg1.player.insurance_bet, v4, v2, arg4)
        };
        0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::events::emit_game_result(*0x2::object::uid_as_inner(&arg1.id), arg1.round, v9, v1 + v11, v10, arg1.player.score, arg1.split_player.score, arg1.dealer.score);
    }

    public entry fun create_house_cap(arg0: &HouseCap, arg1: u8, arg2: 0x2::object::ID, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.privilege == 0, 0);
        let v0 = HouseCap{
            id        : 0x2::object::new(arg4),
            privilege : arg1,
            house_id  : arg2,
        };
        0x2::transfer::transfer<HouseCap>(v0, arg3);
    }

    fun deal_cards<T0>(arg0: &mut u256, arg1: &mut Game<T0>, arg2: &0x2::clock::Clock) {
        let v0 = *0x2::object::uid_as_inner(&arg1.id);
        let v1 = (0x2::clock::timestamp_ms(arg2) as u256);
        let v2 = &mut arg1.player;
        draw_card<T0>(arg0, v0, arg1.round, v2, 1, v1);
        let v3 = &mut arg1.dealer;
        draw_card<T0>(arg0, v0, arg1.round, v3, 0, v1);
        let v4 = &mut arg1.player;
        draw_card<T0>(arg0, v0, arg1.round, v4, 1, v1);
    }

    fun delete_game<T0>(arg0: Game<T0>) {
        0x1::debug::print<Game<T0>>(&arg0);
        let Game {
            id           : v0,
            owner        : _,
            start_time   : _,
            round        : _,
            stage        : _,
            total_risk   : _,
            dealer       : v6,
            player       : v7,
            split_player : v8,
        } = arg0;
        0x2::object::delete(v0);
        delete_player<T0>(v6);
        delete_player<T0>(v7);
        delete_player<T0>(v8);
    }

    fun delete_player<T0>(arg0: Player<T0>) {
        let Player {
            id              : v0,
            bet_size_value  : _,
            double_down_bet : _,
            insurance_bet   : _,
            seed            : _,
            score           : _,
            hand            : v6,
            bets            : v7,
        } = arg0;
        let v8 = v6;
        0x2::object::delete(v0);
        while (card_length(&v8) > 0) {
            0x1::vector::pop_back<u8>(&mut v8);
        };
        0x1::vector::destroy_empty<u8>(v8);
        0x2::table_vec::destroy_empty<Bet<T0>>(v7);
    }

    public entry fun double_down<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut HouseData<T0>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = arg1.seed;
        assert!(arg1.house_risk + 0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::math::unsafe_mul(v0, 1500000000) <= balance<T0>(arg1), 1);
        let v2 = borrow_game_mut<T0>(arg1, arg2);
        assert!(v2.owner == 0x2::tx_context::sender(arg4) && v2.stage == 1 && v2.player.bet_size_value == v0 && v2.player.double_down_bet == 0 && v2.player.score != 21 && card_length(&v2.player.hand) == 2 && v2.split_player.bet_size_value == 0, 6);
        let v3 = 0x2::table_vec::borrow_mut<Bet<T0>>(&mut v2.player.bets, 0);
        let v4 = 0x2::coin::into_balance<T0>(arg0);
        0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::events::emit_double_down_bet<T0>(arg2, v2.round, 0x2::balance::value<T0>(&v4), v3.player);
        0x2::balance::join<T0>(&mut v3.bet_size, v4);
        v2.player.double_down_bet = v0;
        let v5 = &mut v1;
        let v6 = &mut v2.player;
        draw_card<T0>(v5, arg2, v2.round, v6, 1, (0x2::clock::timestamp_ms(arg3) as u256));
        next_stage<T0>(v2);
        assert!(v2.stage == 3, 2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.pending, arg2);
        arg1.seed = v1;
    }

    fun draw_card<T0>(arg0: &mut u256, arg1: 0x2::object::ID, arg2: u64, arg3: &mut Player<T0>, arg4: u8, arg5: u256) {
        let v0 = ((arg3.seed ^ *arg0) + arg5) % ((1 * 52) as u256);
        let v1 = 0x1::hash::sha2_256(0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::bcs::serialize<u256>(arg3.seed, v0, arg5));
        arg3.seed = 0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::bcs::deserialize(&v1);
        let v2 = 0x1::hash::sha2_256(0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::bcs::serialize<u256>(*arg0, v0, arg5));
        *arg0 = 0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::bcs::deserialize(&v2);
        0x1::vector::push_back<u8>(&mut arg3.hand, (v0 as u8));
        arg3.score = recalculate(&arg3.hand);
        let v3 = card_score(&arg3.hand, card_length(&arg3.hand) - 1);
        0x1::debug::print<u8>(&v3);
        0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::events::emit_card_drawn<T0>(arg1, arg2, arg4, (v0 as u8), arg3.score);
    }

    fun draw_dealer_cards<T0>(arg0: &mut Game<T0>, arg1: &mut u256, arg2: u256) : bool {
        if (arg0.player.score > 21 && arg0.split_player.bet_size_value == 0 || arg0.player.score > 21 && arg0.split_player.score > 21) {
            let v0 = &mut arg0.dealer;
            draw_card<T0>(arg1, *0x2::object::uid_as_inner(&arg0.id), arg0.round, v0, 0, arg2);
        } else {
            while (arg0.dealer.score < 17 || arg0.dealer.score == 17 && card_length(&arg0.dealer.hand) == 2 && (card_score(&arg0.dealer.hand, 0) == 11 || card_score(&arg0.dealer.hand, 1) == 11)) {
                let v1 = &mut arg0.dealer;
                draw_card<T0>(arg1, *0x2::object::uid_as_inner(&arg0.id), arg0.round, v1, 0, arg2);
            };
        };
        player_has_bj<T0>(&arg0.dealer)
    }

    public fun game_risk<T0>(arg0: &HouseData<T0>, arg1: 0x2::object::ID) : u64 {
        borrow_game<T0>(arg0, arg1).total_risk
    }

    fun get_coin<T0>(arg0: Bet<T0>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, address) {
        let Bet {
            id       : v0,
            bet_size : v1,
            player   : v2,
        } = arg0;
        let v3 = v1;
        0x2::balance::destroy_zero<T0>(v3);
        0x2::object::delete(v0);
        (0x2::coin::take<T0>(&mut v3, 0x2::balance::value<T0>(&v3), arg1), v2)
    }

    public entry fun hit<T0>(arg0: &HouseCap, arg1: &mut HouseData<T0>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_game_mgr<T0>(arg0, arg1), 0);
        let v0 = arg1.seed;
        let v1 = borrow_game_mut<T0>(arg1, arg2);
        assert!(v1.stage == 1 || v1.stage == 2, 2);
        let v2 = false;
        if (v1.split_player.bet_size_value > 0) {
            assert!(card_score(&v1.player.hand, 0) != 11, 5);
        };
        if (v1.stage == 1) {
            assert!(v1.player.score < 21, 2);
            let v3 = &mut v0;
            let v4 = &mut v1.player;
            draw_card<T0>(v3, arg2, v1.round, v4, 1, (0x2::clock::timestamp_ms(arg3) as u256));
            if (v1.player.score >= 21) {
                next_stage<T0>(v1);
                v2 = v1.stage == 3;
            };
        } else {
            assert!(v1.split_player.bet_size_value > 0, 4);
            assert!(v1.split_player.score < 21, 2);
            let v5 = &mut v0;
            let v6 = &mut v1.split_player;
            draw_card<T0>(v5, arg2, v1.round, v6, 2, (0x2::clock::timestamp_ms(arg3) as u256));
            if (v1.split_player.score >= 21) {
                next_stage<T0>(v1);
                v2 = v1.stage == 3;
            };
        };
        if (v2) {
            0x1::vector::push_back<0x2::object::ID>(&mut arg1.pending, arg2);
        };
        arg1.seed = v0;
    }

    public fun house_id<T0>(arg0: &HouseData<T0>) : 0x2::object::ID {
        *0x2::object::uid_as_inner(&arg0.id)
    }

    public fun house_pending_length<T0>(arg0: &HouseData<T0>) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.pending)
    }

    public fun house_risk<T0>(arg0: &HouseData<T0>) : u64 {
        arg0.house_risk
    }

    public fun id_is_zero(arg0: &0x2::object::ID) : bool {
        *arg0 == id_zero()
    }

    public fun id_zero() : 0x2::object::ID {
        0x2::object::id_from_address(@0x0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HouseCap{
            id        : 0x2::object::new(arg0),
            privilege : 0,
            house_id  : id_zero(),
        };
        0x2::transfer::transfer<HouseCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun initialize_house_data<T0>(arg0: &mut HouseCap, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.privilege == 0 || arg0.privilege == 1 && id_is_zero(&arg0.house_id), 0);
        let v0 = HouseData<T0>{
            id         : 0x2::object::new(arg3),
            balance    : 0x2::balance::zero<T0>(),
            house      : arg1,
            house_risk : 0,
            round      : 0,
            min_bet    : 1000000000,
            max_bet    : 50000000000,
            seed       : (0x2::clock::timestamp_ms(arg2) as u256),
            pending    : 0x1::vector::empty<0x2::object::ID>(),
        };
        if (arg0.privilege == 1) {
            arg0.house_id = house_id<T0>(&v0);
        };
        0x2::transfer::share_object<HouseData<T0>>(v0);
    }

    public entry fun insurance<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut HouseData<T0>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::math::unsafe_mul(v0, 2000000000);
        assert!(arg1.house_risk + v1 <= balance<T0>(arg1), 1);
        let v2 = borrow_game_mut<T0>(arg1, arg2);
        assert!(v2.owner == 0x2::tx_context::sender(arg3) && v2.stage == 1 && v2.player.bet_size_value == 0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::math::unsafe_mul(v0, 2000000000) && v2.player.double_down_bet == 0 && card_length(&v2.player.hand) == 2 && v2.split_player.bet_size_value == 0 && card_score(&v2.dealer.hand, 0) == 11, 7);
        let v3 = 0x2::table_vec::borrow_mut<Bet<T0>>(&mut v2.player.bets, 0);
        let v4 = 0x2::coin::into_balance<T0>(arg0);
        0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::events::emit_insurance_bet<T0>(arg2, v2.round, 0x2::balance::value<T0>(&v4), v3.player);
        0x2::balance::join<T0>(&mut v3.bet_size, v4);
        v2.player.insurance_bet = v0;
        v2.total_risk = v2.total_risk + v1;
        arg1.house_risk = arg1.house_risk + v1;
    }

    fun is_game_mgr<T0>(arg0: &HouseCap, arg1: &HouseData<T0>) : bool {
        arg0.privilege == 0 || arg0.privilege <= 2 && arg0.house_id == house_id<T0>(arg1)
    }

    fun is_house_mgr<T0>(arg0: &HouseCap, arg1: &HouseData<T0>) : bool {
        arg0.privilege == 0 || arg0.privilege == 1 && arg0.house_id == house_id<T0>(arg1)
    }

    public entry fun new_round<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut HouseData<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 >= arg1.min_bet && v0 <= arg1.max_bet, 3);
        let v1 = arg1.house_risk + 0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::math::unsafe_mul(v0, 1500000000);
        assert!(v1 <= balance<T0>(arg1), 1);
        arg1.house_risk = v1;
        let v2 = Bet<T0>{
            id       : 0x2::object::new(arg3),
            bet_size : 0x2::coin::into_balance<T0>(arg0),
            player   : 0x2::tx_context::sender(arg3),
        };
        0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::events::emit_place_bet<T0>(*0x2::object::uid_as_inner(&v2.id), 0x2::balance::value<T0>(&v2.bet_size), v2.player);
        let v3 = 0x2::clock::timestamp_ms(arg2);
        let v4 = (arg1.round as u256);
        let v5 = (v3 as u256);
        let v6 = 0x1::hash::sha2_256(0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::bcs::serialize<u256>(arg1.seed, v4, v5));
        let v7 = 0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::bcs::deserialize(&v6);
        let v8 = Player<T0>{
            id              : 0x2::object::new(arg3),
            bet_size_value  : 0,
            double_down_bet : 0,
            insurance_bet   : 0,
            seed            : v7,
            score           : 0,
            hand            : 0x1::vector::empty<u8>(),
            bets            : 0x2::table_vec::empty<Bet<T0>>(arg3),
        };
        let v9 = 0x1::hash::sha2_256(0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::bcs::serialize<u256>(v7, v4, v5));
        let v10 = 0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::bcs::deserialize(&v9);
        let v11 = Player<T0>{
            id              : 0x2::object::new(arg3),
            bet_size_value  : 0x2::balance::value<T0>(&v2.bet_size),
            double_down_bet : 0,
            insurance_bet   : 0,
            seed            : v10,
            score           : 0,
            hand            : 0x1::vector::empty<u8>(),
            bets            : 0x2::table_vec::empty<Bet<T0>>(arg3),
        };
        0x2::table_vec::push_back<Bet<T0>>(&mut v11.bets, v2);
        let v12 = 0x1::hash::sha2_256(0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::bcs::serialize<u256>(v10, v4, v5));
        let v13 = 0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::bcs::deserialize(&v12);
        let v14 = Player<T0>{
            id              : 0x2::object::new(arg3),
            bet_size_value  : 0,
            double_down_bet : 0,
            insurance_bet   : 0,
            seed            : v13,
            score           : 0,
            hand            : 0x1::vector::empty<u8>(),
            bets            : 0x2::table_vec::empty<Bet<T0>>(arg3),
        };
        arg1.seed = v13;
        arg1.round = arg1.round + 1;
        let v15 = Game<T0>{
            id           : 0x2::object::new(arg3),
            owner        : 0x2::tx_context::sender(arg3),
            start_time   : v3,
            round        : arg1.round,
            stage        : 0,
            total_risk   : v1,
            dealer       : v8,
            player       : v11,
            split_player : v14,
        };
        let v16 = *0x2::object::uid_as_inner(&v15.id);
        0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::events::emit_game_created<T0>(v16);
        let v17 = &mut arg1.seed;
        let v18 = &mut v15;
        deal_cards<T0>(v17, v18, arg2);
        0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::events::emit_player_hand(v16, v15.player.hand, 0x1::vector::empty<u8>());
        let v19 = &mut v15;
        next_stage<T0>(v19);
        0x1::debug::print<Game<T0>>(&v15);
        0x2::dynamic_object_field::add<0x2::object::ID, Game<T0>>(&mut arg1.id, v16, v15);
        v16
    }

    fun next_stage<T0>(arg0: &mut Game<T0>) {
        assert!(arg0.stage < 3, 2);
        arg0.stage = arg0.stage + 1;
        if (arg0.stage == 2 && arg0.split_player.bet_size_value == 0) {
            arg0.stage = arg0.stage + 1;
        };
        0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::events::emit_stage_changed(*0x2::object::uid_as_inner(&arg0.id), arg0.round, arg0.stage);
    }

    fun payout_with_split<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T0>, arg3: address, arg4: u64, arg5: u64, arg6: bool, arg7: u8, arg8: u8, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        if (arg5 > 0) {
            let v2 = 0x2::coin::split<T0>(&mut arg1, arg5, arg9);
            v0 = 0x2::coin::value<T0>(&v2);
            0x2::coin::put<T0>(arg0, v2);
            if (arg6) {
                v1 = 0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::math::unsafe_mul(arg5, 2000000000);
            };
        };
        if (arg4 > 0) {
            let v3 = 0x2::coin::take<T0>(arg0, arg4 + v1, arg9);
            if (arg7 > 0) {
                0x2::coin::join<T0>(&mut v3, arg1);
            } else {
                v0 = v0 + 0x2::coin::value<T0>(&arg1);
                0x2::coin::put<T0>(arg0, arg1);
            };
            if (arg8 > 0) {
                0x2::coin::join<T0>(&mut v3, arg2);
            } else {
                v0 = v0 + 0x2::coin::value<T0>(&arg2);
                0x2::coin::put<T0>(arg0, arg2);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, arg3);
        } else if (arg7 == 1) {
            if (v1 > 0) {
                0x2::coin::join<T0>(&mut arg1, 0x2::coin::take<T0>(arg0, v1, arg9));
            };
            if (arg8 == 1) {
                0x2::coin::join<T0>(&mut arg1, arg2);
            } else {
                v0 = v0 + 0x2::coin::value<T0>(&arg2);
                0x2::coin::put<T0>(arg0, arg2);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg3);
        } else if (arg8 == 1) {
            if (v1 > 0) {
                0x2::coin::join<T0>(&mut arg2, 0x2::coin::take<T0>(arg0, v1, arg9));
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg3);
            v0 = v0 + 0x2::coin::value<T0>(&arg1);
            0x2::coin::put<T0>(arg0, arg1);
        } else {
            if (v1 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(arg0, v1, arg9), arg3);
            };
            let v4 = v0 + 0x2::coin::value<T0>(&arg1);
            v0 = v4 + 0x2::coin::value<T0>(&arg2);
            0x2::coin::put<T0>(arg0, arg1);
            0x2::coin::put<T0>(arg0, arg2);
        };
        (v0, v1)
    }

    fun payout_without_split<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: u64, arg4: u64, arg5: bool, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        if (arg4 > 0) {
            let v2 = 0x2::coin::split<T0>(&mut arg1, arg4, arg7);
            v0 = 0x2::coin::value<T0>(&v2);
            0x2::coin::put<T0>(arg0, v2);
            if (arg5) {
                v1 = 0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::math::unsafe_mul(arg4, 2000000000);
            };
        };
        if (arg3 > 0) {
            let v3 = 0x2::coin::take<T0>(arg0, arg3 + v1, arg7);
            0x2::coin::join<T0>(&mut v3, arg1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, arg2);
        } else if (arg6 == 1) {
            if (v1 > 0) {
                0x2::coin::join<T0>(&mut arg1, 0x2::coin::take<T0>(arg0, v1, arg7));
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg2);
        } else {
            if (v1 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(arg0, v1, arg7), arg2);
            };
            v0 = v0 + 0x2::coin::value<T0>(&arg1);
            0x2::coin::put<T0>(arg0, arg1);
        };
        (v0, v1)
    }

    fun player_has_bj<T0>(arg0: &Player<T0>) : bool {
        arg0.score == 21 && card_length(&arg0.hand) == 2
    }

    fun recalculate(arg0: &vector<u8>) : u8 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < card_length(arg0)) {
            v0 = v0 + card_score(arg0, v2);
            if (card_score_index(arg0, v2) == 0) {
                v1 = v1 + 1;
            };
            v2 = v2 + 1;
        };
        while (v1 > 0 && v0 > 21) {
            v0 = v0 - 10;
            v1 = v1 - 1;
        };
        v0
    }

    fun reduce_risk(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    public entry fun set_house_max_bet<T0>(arg0: &HouseCap, arg1: &mut HouseData<T0>, arg2: u64) {
        assert!(is_house_mgr<T0>(arg0, arg1), 0);
        arg1.max_bet = arg2;
    }

    public entry fun set_house_min_bet<T0>(arg0: &HouseCap, arg1: &mut HouseData<T0>, arg2: u64) {
        assert!(is_house_mgr<T0>(arg0, arg1), 0);
        arg1.min_bet = arg2;
    }

    public entry fun settle<T0>(arg0: &HouseCap, arg1: &mut HouseData<T0>, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(is_game_mgr<T0>(arg0, arg1), 0);
        0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::drand_lib::verify_drand_signature(arg3, arg4, arg2);
        let v0 = 0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::drand_lib::derive_randomness(arg3);
        let v1 = 0x1::vector::length<0x2::object::ID>(&arg1.pending);
        let v2 = v1;
        if (v1 > arg5) {
            v2 = arg5;
        };
        let v3 = 0;
        while (v3 < v2) {
            let v4 = 0x2::dynamic_object_field::remove<0x2::object::ID, Game<T0>>(&mut arg1.id, 0x1::vector::pop_back<0x2::object::ID>(&mut arg1.pending));
            assert!(v4.stage == 3, 2);
            let v5 = &mut arg1.balance;
            let v6 = &mut v4;
            let v7 = &mut arg1.seed;
            conclude_game<T0>(v5, v6, v7, (0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::drand_lib::safe_selection(0x2::clock::timestamp_ms(arg6), &v0) as u256), arg7);
            delete_game<T0>(v4);
            arg1.house_risk = reduce_risk(arg1.house_risk, v4.total_risk);
            v3 = v3 + 1;
        };
    }

    public entry fun stand<T0>(arg0: &HouseCap, arg1: &mut HouseData<T0>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_game_mgr<T0>(arg0, arg1), 0);
        let v0 = borrow_game_mut<T0>(arg1, arg2);
        assert!(v0.stage == 1 || v0.stage == 2, 2);
        next_stage<T0>(v0);
        if (v0.stage == 3) {
            0x1::vector::push_back<0x2::object::ID>(&mut arg1.pending, arg2);
        };
    }

    public entry fun surrender<T0>(arg0: &mut HouseData<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_game_mut<T0>(arg0, arg1);
        assert!(v0.owner == 0x2::tx_context::sender(arg3) && v0.stage == 1 && v0.player.double_down_bet == 0 && v0.player.insurance_bet == 0 && card_length(&v0.player.hand) == 2 && v0.split_player.bet_size_value == 0, 8);
        let v1 = v0.total_risk;
        next_stage<T0>(v0);
        assert!(v0.stage == 3, 2);
        let v2 = 0x2::dynamic_object_field::remove<0x2::object::ID, Game<T0>>(&mut arg0.id, arg1);
        let v3 = &mut arg0.balance;
        let v4 = &mut v2;
        let v5 = &mut arg0.seed;
        surrender_game<T0>(v3, v4, v5, (0x2::clock::timestamp_ms(arg2) as u256), arg3);
        delete_game<T0>(v2);
        arg0.house_risk = reduce_risk(arg0.house_risk, v1);
    }

    fun surrender_game<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: &mut Game<T0>, arg2: &mut u256, arg3: u256, arg4: &mut 0x2::tx_context::TxContext) {
        draw_dealer_cards<T0>(arg1, arg2, arg3);
        let (v0, v1) = get_coin<T0>(0x2::table_vec::pop_back<Bet<T0>>(&mut arg1.player.bets), arg4);
        let v2 = v0;
        let v3 = 0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::math::unsafe_mul(arg1.player.bet_size_value, 500000000);
        let v4 = *0x2::object::uid_as_inner(&arg1.id);
        0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::events::emit_surrender<T0>(v4, arg1.round, v3, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v2, v3, arg4), v1);
        0x2::coin::put<T0>(arg0, v2);
        0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::events::emit_game_result(v4, arg1.round, v1, 0, 0x2::coin::value<T0>(&v2), arg1.player.score, arg1.split_player.score, arg1.dealer.score);
    }

    public entry fun top_up<T0>(arg0: &mut HouseData<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::events::emit_house_deposit<T0>(0x2::coin::value<T0>(&arg1), 0x2::tx_context::sender(arg2));
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun withdraw<T0>(arg0: &mut HouseData<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.house, 0);
        0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::events::emit_house_withdraw<T0>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, arg1, arg2), arg0.house);
    }

    // decompiled from Move bytecode v6
}

