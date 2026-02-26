module 0x92c0ea2498ff5d5da3bbcbd1f6cebbdbf2b4add35bb641df7ae1433d59d4fde6::single_player_blackjack {
    struct GameCreatedEvent has copy, drop {
        game_id: 0x2::object::ID,
    }

    struct GameOutcomeEvent has copy, drop {
        game_id: 0x2::object::ID,
        game_status: u8,
        winner_address: address,
        message: vector<u8>,
    }

    struct HitDoneEvent has copy, drop {
        game_id: 0x2::object::ID,
        current_player_hand_sum: u8,
        player_cards: vector<u8>,
    }

    struct HouseAdminCap has key {
        id: 0x2::object::UID,
    }

    struct RegistryAdminCap has key {
        id: 0x2::object::UID,
    }

    struct TokenRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        token_type_names: vector<vector<u8>>,
        min_stakes: vector<u64>,
    }

    struct HouseData<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        house: address,
        public_key: vector<u8>,
    }

    struct Game<phantom T0> has key {
        id: 0x2::object::UID,
        total_stake: 0x2::balance::Balance<T0>,
        player: address,
        player_cards: vector<u8>,
        player_sum: u8,
        dealer_cards: vector<u8>,
        dealer_sum: u8,
        status: u8,
        counter: u8,
        used_cards: vector<u8>,
    }

    struct HitRequest has store, key {
        id: 0x2::object::UID,
        game_id: 0x2::object::ID,
        current_player_sum: u8,
    }

    struct StandRequest has store, key {
        id: 0x2::object::UID,
        game_id: 0x2::object::ID,
        current_player_sum: u8,
    }

    public fun balance<T0>(arg0: &HouseData<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun dealer_cards<T0>(arg0: &Game<T0>) : vector<u8> {
        arg0.dealer_cards
    }

    public fun dealer_sum<T0>(arg0: &Game<T0>) : u8 {
        arg0.dealer_sum
    }

    public fun disable_token<T0>(arg0: &mut TokenRegistry, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 25);
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg0.token_type_names)) {
            if (*0x1::vector::borrow<vector<u8>>(&arg0.token_type_names, v0) == token_type_key<T0>()) {
                0x1::vector::remove<vector<u8>>(&mut arg0.token_type_names, v0);
                0x1::vector::remove<u64>(&mut arg0.min_stakes, v0);
                return
            };
            v0 = v0 + 1;
        };
    }

    public fun do_hit<T0>(arg0: &mut Game<T0>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : HitRequest {
        assert!(arg0.status == 0, 13);
        assert!(0x2::tx_context::sender(arg2) == arg0.player, 14);
        assert!(arg1 == arg0.player_sum, 18);
        assert!(arg1 != 21, 22);
        HitRequest{
            id                 : 0x2::object::new(arg2),
            game_id            : 0x2::object::id<Game<T0>>(arg0),
            current_player_sum : arg0.player_sum,
        }
    }

    public fun do_stand<T0>(arg0: &mut Game<T0>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : StandRequest {
        assert!(arg0.status == 0, 13);
        assert!(0x2::tx_context::sender(arg2) == arg0.player, 14);
        assert!(arg1 == arg0.player_sum, 19);
        StandRequest{
            id                 : 0x2::object::new(arg2),
            game_id            : 0x2::object::id<Game<T0>>(arg0),
            current_player_sum : arg0.player_sum,
        }
    }

    public fun enable_token<T0>(arg0: &mut TokenRegistry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 25);
        assert!(arg1 > 0, 26);
        let v0 = token_type_key<T0>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg0.token_type_names)) {
            if (*0x1::vector::borrow<vector<u8>>(&arg0.token_type_names, v1) == v0) {
                *0x1::vector::borrow_mut<u64>(&mut arg0.min_stakes, v1) = arg1;
                return
            };
            v1 = v1 + 1;
        };
        0x1::vector::push_back<vector<u8>>(&mut arg0.token_type_names, v0);
        0x1::vector::push_back<u64>(&mut arg0.min_stakes, arg1);
    }

    entry fun first_deal<T0>(arg0: &mut Game<T0>, arg1: &HouseData<T0>, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.house, 21);
        assert!(arg0.player_sum == 0, 15);
        let v0 = 0x2::random::new_generator(arg2, arg3);
        let v1 = &mut v0;
        let v2 = get_next_random_card<T0>(v1, arg0);
        0x1::vector::push_back<u8>(&mut arg0.player_cards, v2);
        let v3 = &mut v0;
        let v4 = get_next_random_card<T0>(v3, arg0);
        0x1::vector::push_back<u8>(&mut arg0.player_cards, v4);
        arg0.player_sum = get_card_sum(&arg0.player_cards);
        let v5 = &mut v0;
        let v6 = get_next_random_card<T0>(v5, arg0);
        0x1::vector::push_back<u8>(&mut arg0.dealer_cards, v6);
        arg0.dealer_sum = get_card_sum(&arg0.dealer_cards);
        if (arg0.player_sum == 21) {
            player_won_post_handling<T0>(arg0, b"BlackJack!!!", arg3);
        } else {
            arg0.counter = arg0.counter + 1;
        };
    }

    fun get_card_sum(arg0: &vector<u8>) : u8 {
        let v0 = 0;
        let v1 = false;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(arg0)) {
            let v3 = *0x1::vector::borrow<u8>(arg0, v2) % 13 + 1;
            let v4 = v3;
            if (v3 == 1) {
                v1 = true;
            };
            if (v3 > 10) {
                v4 = 10;
            };
            v0 = v0 + v4;
            v2 = v2 + 1;
        };
        if (v1 && v0 + 10 <= 21) {
            v0 = v0 + 10;
        };
        v0
    }

    fun get_min_stake_for_token<T0>(arg0: &TokenRegistry) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg0.token_type_names)) {
            if (*0x1::vector::borrow<vector<u8>>(&arg0.token_type_names, v0) == token_type_key<T0>()) {
                return *0x1::vector::borrow<u64>(&arg0.min_stakes, v0)
            };
            v0 = v0 + 1;
        };
        abort 24
    }

    fun get_next_random_card<T0>(arg0: &mut 0x2::random::RandomGenerator, arg1: &mut Game<T0>) : u8 {
        let v0 = 0;
        loop {
            let v1 = 0x2::random::generate_u8_in_range(arg0, 0, 51);
            let v2 = false;
            let v3 = &arg1.used_cards;
            let v4 = 0;
            while (v4 < 0x1::vector::length<u8>(v3)) {
                if (*0x1::vector::borrow<u8>(v3, v4) == v1) {
                    v2 = true;
                };
                v4 = v4 + 1;
            };
            if (!v2) {
                0x1::vector::push_back<u8>(&mut arg1.used_cards, v1);
                return v1
            };
            v0 = v0 + 1;
            if (v0 >= 100) {
                break
            };
        };
        abort 0
    }

    entry fun hit<T0>(arg0: &mut Game<T0>, arg1: &mut HouseData<T0>, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 13);
        assert!(0x2::tx_context::sender(arg3) == arg1.house, 21);
        assert!(arg0.player_sum != 21, 22);
        let v0 = 0x2::random::new_generator(arg2, arg3);
        let v1 = &mut v0;
        let v2 = get_next_random_card<T0>(v1, arg0);
        0x1::vector::push_back<u8>(&mut arg0.player_cards, v2);
        arg0.player_sum = get_card_sum(&arg0.player_cards);
        let v3 = HitDoneEvent{
            game_id                 : 0x2::object::uid_to_inner(&arg0.id),
            current_player_hand_sum : arg0.player_sum,
            player_cards            : arg0.player_cards,
        };
        0x2::event::emit<HitDoneEvent>(v3);
        if (arg0.player_sum > 21) {
            house_won_post_handling<T0>(arg0, arg1, arg3);
        } else {
            arg0.counter = arg0.counter + 1;
        };
    }

    public fun hit_request_current_player_sum(arg0: &HitRequest) : u8 {
        arg0.current_player_sum
    }

    public fun hit_request_game_id(arg0: &HitRequest) : 0x2::object::ID {
        arg0.game_id
    }

    public fun house<T0>(arg0: &HouseData<T0>) : address {
        arg0.house
    }

    fun house_won_post_handling<T0>(arg0: &mut Game<T0>, arg1: &mut HouseData<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.status = 2;
        let v0 = GameOutcomeEvent{
            game_id        : 0x2::object::uid_to_inner(&arg0.id),
            game_status    : arg0.status,
            winner_address : arg1.house,
            message        : b"Player busted",
        };
        0x2::event::emit<GameOutcomeEvent>(v0);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut arg0.total_stake, 0x2::balance::value<T0>(&arg0.total_stake), arg2)));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HouseAdminCap{id: 0x2::object::new(arg0)};
        let v1 = RegistryAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<HouseAdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<RegistryAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun initialize_house_data<T0>(arg0: HouseAdminCap, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 11);
        let v0 = HouseData<T0>{
            id         : 0x2::object::new(arg3),
            balance    : 0x2::coin::into_balance<T0>(arg1),
            house      : 0x2::tx_context::sender(arg3),
            public_key : arg2,
        };
        let HouseAdminCap { id: v1 } = arg0;
        0x2::object::delete(v1);
        0x2::transfer::share_object<HouseData<T0>>(v0);
    }

    public fun initialize_token_registry(arg0: RegistryAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenRegistry{
            id               : 0x2::object::new(arg1),
            admin            : 0x2::tx_context::sender(arg1),
            token_type_names : vector[],
            min_stakes       : vector[],
        };
        let RegistryAdminCap { id: v1 } = arg0;
        0x2::object::delete(v1);
        0x2::transfer::share_object<TokenRegistry>(v0);
    }

    public fun place_bet_and_create_game<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut HouseData<T0>, arg2: &TokenRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 >= get_min_stake_for_token<T0>(arg2), 20);
        assert!(balance<T0>(arg1) >= v0, 12);
        let v1 = 0x2::coin::into_balance<T0>(arg0);
        0x2::balance::join<T0>(&mut v1, 0x2::balance::split<T0>(&mut arg1.balance, v0));
        let v2 = Game<T0>{
            id           : 0x2::object::new(arg3),
            total_stake  : v1,
            player       : 0x2::tx_context::sender(arg3),
            player_cards : b"",
            player_sum   : 0,
            dealer_cards : b"",
            dealer_sum   : 0,
            status       : 0,
            counter      : 0,
            used_cards   : b"",
        };
        let v3 = GameCreatedEvent{game_id: 0x2::object::id<Game<T0>>(&v2)};
        0x2::event::emit<GameCreatedEvent>(v3);
        0x2::transfer::share_object<Game<T0>>(v2);
    }

    public fun player<T0>(arg0: &Game<T0>) : address {
        arg0.player
    }

    public fun player_cards<T0>(arg0: &Game<T0>) : vector<u8> {
        arg0.player_cards
    }

    public fun player_sum<T0>(arg0: &Game<T0>) : u8 {
        arg0.player_sum
    }

    fun player_won_post_handling<T0>(arg0: &mut Game<T0>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.status = 1;
        let v0 = GameOutcomeEvent{
            game_id        : 0x2::object::uid_to_inner(&arg0.id),
            game_status    : arg0.status,
            winner_address : arg0.player,
            message        : arg1,
        };
        0x2::event::emit<GameOutcomeEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.total_stake, 0x2::balance::value<T0>(&arg0.total_stake), arg2), arg0.player);
    }

    public fun public_key<T0>(arg0: &HouseData<T0>) : vector<u8> {
        arg0.public_key
    }

    public fun refund_unstarted_game<T0>(arg0: &mut Game<T0>, arg1: &mut HouseData<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 13);
        let v0 = if (0x1::vector::is_empty<u8>(&arg0.player_cards)) {
            if (0x1::vector::is_empty<u8>(&arg0.dealer_cards)) {
                if (arg0.player_sum == 0) {
                    arg0.dealer_sum == 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 23);
        assert!(0x2::tx_context::sender(arg2) == arg0.player || 0x2::tx_context::sender(arg2) == arg1.house, 14);
        tie_post_handling<T0>(arg0, arg1, arg2);
    }

    entry fun stand<T0>(arg0: &mut Game<T0>, arg1: &mut HouseData<T0>, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 13);
        assert!(0x2::tx_context::sender(arg3) == arg1.house, 21);
        let v0 = 0x2::random::new_generator(arg2, arg3);
        while (arg0.dealer_sum < 17) {
            let v1 = &mut v0;
            let v2 = get_next_random_card<T0>(v1, arg0);
            0x1::vector::push_back<u8>(&mut arg0.dealer_cards, v2);
            arg0.dealer_sum = get_card_sum(&arg0.dealer_cards);
        };
        if (arg0.dealer_sum > 21) {
            player_won_post_handling<T0>(arg0, b"Dealer Busted!", arg3);
        } else {
            let v3 = if (arg0.dealer_sum == 21) {
                if (arg0.player_sum == 21) {
                    0x1::vector::length<u8>(&arg0.dealer_cards) == 2
                } else {
                    false
                }
            } else {
                false
            };
            if (v3) {
                house_won_post_handling<T0>(arg0, arg1, arg3);
            } else if (arg0.dealer_sum > arg0.player_sum) {
                house_won_post_handling<T0>(arg0, arg1, arg3);
            } else if (arg0.player_sum > arg0.dealer_sum) {
                player_won_post_handling<T0>(arg0, b"Player won!", arg3);
            } else {
                tie_post_handling<T0>(arg0, arg1, arg3);
            };
        };
    }

    public fun stand_request_current_player_sum(arg0: &StandRequest) : u8 {
        arg0.current_player_sum
    }

    public fun stand_request_game_id(arg0: &StandRequest) : 0x2::object::ID {
        arg0.game_id
    }

    public fun status<T0>(arg0: &Game<T0>) : u8 {
        arg0.status
    }

    fun tie_post_handling<T0>(arg0: &mut Game<T0>, arg1: &mut HouseData<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.status = 3;
        let v0 = GameOutcomeEvent{
            game_id        : 0x2::object::uid_to_inner(&arg0.id),
            game_status    : arg0.status,
            winner_address : @0x0,
            message        : b"Tie",
        };
        0x2::event::emit<GameOutcomeEvent>(v0);
        let v1 = 0x2::balance::value<T0>(&arg0.total_stake) / 2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.total_stake, v1, arg2), arg0.player);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut arg0.total_stake, v1, arg2)));
    }

    public fun token_registry_admin(arg0: &TokenRegistry) : address {
        arg0.admin
    }

    public fun token_registry_min_stakes(arg0: &TokenRegistry) : vector<u64> {
        arg0.min_stakes
    }

    public fun token_registry_type_names(arg0: &TokenRegistry) : vector<vector<u8>> {
        arg0.token_type_names
    }

    fun token_type_key<T0>() : vector<u8> {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    public fun top_up<T0>(arg0: &mut HouseData<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun total_stake<T0>(arg0: &Game<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.total_stake)
    }

    public fun used_cards<T0>(arg0: &Game<T0>) : vector<u8> {
        arg0.used_cards
    }

    public fun withdraw<T0>(arg0: &mut HouseData<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.house, 21);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, 0x2::balance::value<T0>(&arg0.balance), arg1), arg0.house);
    }

    // decompiled from Move bytecode v6
}

