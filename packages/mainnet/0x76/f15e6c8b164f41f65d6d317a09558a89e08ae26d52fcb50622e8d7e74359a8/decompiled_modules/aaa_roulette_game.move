module 0x8988fad4a4c250d909736b1c2c9a56ff9b9f5c250b85cd6694f324c40eeb5ab2::aaa_roulette_game {
    struct GamePot<phantom T0> has store, key {
        id: 0x2::object::UID,
        creator_address: address,
        players: vector<address>,
        bets: vector<0x2::balance::Balance<T0>>,
        bet_amount: u64,
        max_players: u64,
        chambers_amount: u64,
        is_started: bool,
        vrf_input: vector<u8>,
        players_in_game_order: vector<address>,
    }

    struct GameRegistry has store, key {
        id: 0x2::object::UID,
    }

    struct GamePotCreatedEvent has copy, drop, store {
        creator: address,
        pot_id: 0x2::object::ID,
        pot_type: vector<u8>,
        bet_amount: u64,
        max_players: u64,
        chambers_amount: u64,
    }

    struct GamePotCreatedEventV2 has copy, drop, store {
        creator: address,
        pot_id: 0x2::object::ID,
        pot_type: vector<u8>,
        bet_amount: u64,
        max_players: u64,
        chambers_amount: u64,
        trace_id: vector<u8>,
    }

    struct PlayerJoinedEvent has copy, drop, store {
        player: address,
        pot_type: vector<u8>,
        bet_value: u64,
    }

    struct GameResolvedEvent has copy, drop, store {
        pot_id: 0x2::object::ID,
        pot_type: vector<u8>,
        vrf_output: vector<u8>,
        public_key: vector<u8>,
        proof: vector<u8>,
        loaded_chamber_position: u8,
        turns: vector<u8>,
        loser: address,
        winners: vector<address>,
        loser_bet_value: u64,
        amount_per_winner: u64,
        creator_reward: u64,
        platform_fee: u64,
    }

    struct GamePotCancelledEvent has copy, drop, store {
        pot_id: 0x2::object::ID,
    }

    struct PlayerJoinedEventV2 has copy, drop, store {
        player: address,
        pot_id: 0x2::object::ID,
        pot_type: vector<u8>,
        bet_value: u64,
        players_in_game_order: vector<address>,
    }

    struct PlayerLeftEvent has copy, drop, store {
        pot_id: 0x2::object::ID,
        player: address,
    }

    struct GameStartedEvent has copy, drop, store {
        pot_id: 0x2::object::ID,
        vrf_input: vector<u8>,
        players_in_game_order: vector<address>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun add_pot<T0>(arg0: &mut GameRegistry, arg1: GamePot<T0>) {
        0x2::dynamic_field::add<0x2::object::ID, GamePot<T0>>(&mut arg0.id, 0x2::object::id<GamePot<T0>>(&arg1), arg1);
    }

    fun borrow_pot_mut<T0>(arg0: &mut GameRegistry, arg1: 0x2::object::ID) : &mut GamePot<T0> {
        0x2::dynamic_field::borrow_mut<0x2::object::ID, GamePot<T0>>(&mut arg0.id, arg1)
    }

    public fun cancel_game<T0>(arg0: 0x2::object::ID, arg1: &mut GameRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_pot_mut<T0>(arg1, arg0);
        if (v0.creator_address != 0x2::tx_context::sender(arg2)) {
            abort 5
        };
        if (v0.is_started) {
            abort 6
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&v0.players)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x1::vector::pop_back<0x2::balance::Balance<T0>>(&mut v0.bets), arg2), 0x1::vector::pop_back<address>(&mut v0.players));
            v1 = v1 + 1;
        };
        let v2 = GamePotCancelledEvent{pot_id: arg0};
        0x2::event::emit<GamePotCancelledEvent>(v2);
        remove_pot<T0>(arg1, arg0);
    }

    public fun cancel_game_admin<T0>(arg0: &mut AdminCap, arg1: 0x2::object::ID, arg2: &mut GameRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_pot_mut<T0>(arg2, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&v0.players)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x1::vector::pop_back<0x2::balance::Balance<T0>>(&mut v0.bets), arg3), 0x1::vector::pop_back<address>(&mut v0.players));
            v1 = v1 + 1;
        };
        let v2 = GamePotCancelledEvent{pot_id: arg1};
        0x2::event::emit<GamePotCancelledEvent>(v2);
        remove_pot<T0>(arg2, arg1);
    }

    public fun create_game_pot<T0>(arg0: &mut GameRegistry, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        if (arg4 < 5 || arg4 > 40) {
            abort 4
        };
        if (arg4 < arg3) {
            abort 10
        };
        if (0x2::coin::value<T0>(&arg1) != arg2) {
            abort 2
        };
        let v0 = GamePot<T0>{
            id                    : 0x2::object::new(arg5),
            creator_address       : 0x2::tx_context::sender(arg5),
            players               : 0x1::vector::empty<address>(),
            bets                  : 0x1::vector::empty<0x2::balance::Balance<T0>>(),
            bet_amount            : arg2,
            max_players           : arg3,
            chambers_amount       : arg4,
            is_started            : false,
            vrf_input             : 0x1::vector::empty<u8>(),
            players_in_game_order : 0x1::vector::empty<address>(),
        };
        let v1 = 0x2::object::id<GamePot<T0>>(&v0);
        let v2 = GamePotCreatedEvent{
            creator         : 0x2::tx_context::sender(arg5),
            pot_id          : v1,
            pot_type        : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>())),
            bet_amount      : arg2,
            max_players     : arg3,
            chambers_amount : arg4,
        };
        0x2::event::emit<GamePotCreatedEvent>(v2);
        add_pot<T0>(arg0, v0);
        join_game<T0>(arg1, v1, arg0, arg5);
        v1
    }

    public fun create_game_pot_v2<T0>(arg0: &mut GameRegistry, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        if (arg4 < 5 || arg4 > 40) {
            abort 4
        };
        if (arg4 < arg3) {
            abort 10
        };
        if (0x2::coin::value<T0>(&arg1) != arg2) {
            abort 2
        };
        let v0 = GamePot<T0>{
            id                    : 0x2::object::new(arg6),
            creator_address       : 0x2::tx_context::sender(arg6),
            players               : 0x1::vector::empty<address>(),
            bets                  : 0x1::vector::empty<0x2::balance::Balance<T0>>(),
            bet_amount            : arg2,
            max_players           : arg3,
            chambers_amount       : arg4,
            is_started            : false,
            vrf_input             : 0x1::vector::empty<u8>(),
            players_in_game_order : 0x1::vector::empty<address>(),
        };
        let v1 = 0x2::object::id<GamePot<T0>>(&v0);
        let v2 = GamePotCreatedEventV2{
            creator         : 0x2::tx_context::sender(arg6),
            pot_id          : v1,
            pot_type        : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>())),
            bet_amount      : arg2,
            max_players     : arg3,
            chambers_amount : arg4,
            trace_id        : arg5,
        };
        0x2::event::emit<GamePotCreatedEventV2>(v2);
        add_pot<T0>(arg0, v0);
        join_game<T0>(arg1, v1, arg0, arg6);
        v1
    }

    public fun create_registry(arg0: &mut AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GameRegistry{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<GameRegistry>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun join_game<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::object::ID, arg2: &mut GameRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_pot_mut<T0>(arg2, arg1);
        if (v0.is_started) {
            abort 6
        };
        if (0x1::vector::length<address>(&v0.players) >= v0.max_players) {
            abort 1
        };
        if (0x2::coin::value<T0>(&arg0) != v0.bet_amount) {
            abort 2
        };
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v0.players)) {
            if (0x1::vector::borrow<address>(&v0.players, v2) == &v1) {
                abort 0
            };
            v2 = v2 + 1;
        };
        let v3 = 0x2::coin::into_balance<T0>(arg0);
        0x1::vector::push_back<address>(&mut v0.players, v1);
        0x1::vector::push_back<0x2::balance::Balance<T0>>(&mut v0.bets, v3);
        let v4 = PlayerJoinedEventV2{
            player                : v1,
            pot_id                : arg1,
            pot_type              : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>())),
            bet_value             : 0x2::balance::value<T0>(&v3),
            players_in_game_order : v0.players_in_game_order,
        };
        0x2::event::emit<PlayerJoinedEventV2>(v4);
    }

    public fun leave_game<T0>(arg0: 0x2::object::ID, arg1: &mut GameRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_pot_mut<T0>(arg1, arg0);
        if (v0.is_started) {
            abort 6
        };
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v0.players)) {
            if (0x1::vector::borrow<address>(&v0.players, v2) == &v1) {
                0x1::vector::remove<address>(&mut v0.players, v2);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x1::vector::remove<0x2::balance::Balance<T0>>(&mut v0.bets, v2), arg2), v1);
                break
            };
            v2 = v2 + 1;
        };
        let v3 = PlayerLeftEvent{
            pot_id : arg0,
            player : v1,
        };
        0x2::event::emit<PlayerLeftEvent>(v3);
    }

    fun remove_pot<T0>(arg0: &mut GameRegistry, arg1: 0x2::object::ID) {
        let GamePot {
            id                    : v0,
            creator_address       : _,
            players               : _,
            bets                  : v3,
            bet_amount            : _,
            max_players           : _,
            chambers_amount       : _,
            is_started            : _,
            vrf_input             : _,
            players_in_game_order : _,
        } = 0x2::dynamic_field::remove<0x2::object::ID, GamePot<T0>>(&mut arg0.id, arg1);
        0x2::object::delete(v0);
        0x1::vector::destroy_empty<0x2::balance::Balance<T0>>(v3);
    }

    public fun resolve_game_pot<T0>(arg0: &mut AdminCap, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: vector<u8>, arg7: &mut GameRegistry, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_pot_mut<T0>(arg7, arg1);
        if (!0x2::ecvrf::ecvrf_verify(&arg2, &v0.vrf_input, &arg3, &arg4)) {
            abort 7
        };
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&arg6)) {
            v1 = v1 + *0x1::vector::borrow<u8>(&arg6, v2);
            v2 = v2 + 1;
        };
        if (v1 != arg5) {
            abort 8
        };
        let v3 = 0x1::vector::borrow<address>(&v0.players_in_game_order, (0x1::vector::length<u8>(&arg6) - 1) % 0x1::vector::length<address>(&v0.players_in_game_order));
        let (v4, v5) = 0x1::vector::index_of<address>(&v0.players, v3);
        if (!v4) {
            abort 9
        };
        let v6 = 0x1::vector::borrow_mut<0x2::balance::Balance<T0>>(&mut v0.bets, v5);
        let v7 = 0x2::balance::value<T0>(v6);
        let v8 = v7 * 25 / 1000;
        let v9 = v7 * 25 / 1000;
        let v10 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v6, v8), arg8);
        let v11 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v6, v9), arg8);
        let v12 = (v7 - v8 - v9) / (0x1::vector::length<address>(&v0.players) - 1);
        let v13 = 0;
        let v14 = 0x1::vector::length<address>(&v0.players);
        let v15 = 0x1::vector::empty<address>();
        while (v13 < v14) {
            let v16 = 0x1::vector::borrow<address>(&v0.players, v13);
            if (v16 != v3) {
                0x1::vector::push_back<address>(&mut v15, *v16);
                let v17 = &mut v0.bets;
                let v18 = split_loser_bet<T0>(v17, v5, v12);
                let v19 = 0x1::vector::borrow_mut<0x2::balance::Balance<T0>>(&mut v0.bets, v13);
                0x2::balance::join<T0>(v19, v18);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(v19), arg8), *v16);
            };
            v13 = v13 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x1::vector::borrow_mut<0x2::balance::Balance<T0>>(&mut v0.bets, v5)), arg8), 0x2::tx_context::sender(arg8));
        let v20 = 0;
        while (v20 < v14) {
            0x2::balance::destroy_zero<T0>(0x1::vector::pop_back<0x2::balance::Balance<T0>>(&mut v0.bets));
            v20 = v20 + 1;
        };
        let v21 = GameResolvedEvent{
            pot_id                  : arg1,
            pot_type                : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>())),
            vrf_output              : arg2,
            public_key              : arg3,
            proof                   : arg4,
            loaded_chamber_position : arg5,
            turns                   : arg6,
            loser                   : *v3,
            winners                 : v15,
            loser_bet_value         : v7,
            amount_per_winner       : v12,
            creator_reward          : v8,
            platform_fee            : v9,
        };
        0x2::event::emit<GameResolvedEvent>(v21);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v10, v0.creator_address);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v11, 0x2::tx_context::sender(arg8));
        remove_pot<T0>(arg7, arg1);
    }

    fun split_loser_bet<T0>(arg0: &mut vector<0x2::balance::Balance<T0>>, arg1: u64, arg2: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(0x1::vector::borrow_mut<0x2::balance::Balance<T0>>(arg0, arg1), arg2)
    }

    public fun start_game<T0>(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: vector<address>, arg3: &mut GameRegistry, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_pot_mut<T0>(arg3, arg0);
        if (v0.creator_address != 0x2::tx_context::sender(arg4)) {
            abort 5
        };
        if (v0.chambers_amount < 0x1::vector::length<address>(&arg2)) {
            abort 11
        };
        v0.is_started = true;
        v0.vrf_input = arg1;
        v0.players_in_game_order = arg2;
        let v1 = GameStartedEvent{
            pot_id                : arg0,
            vrf_input             : arg1,
            players_in_game_order : arg2,
        };
        0x2::event::emit<GameStartedEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

