module 0x8b1f7b0c27ef57ba6793766bc2a279a06ea89fe9721f58e5b5e9e22839c41f8c::game {
    struct Game has store, key {
        id: 0x2::object::UID,
        player: address,
        total_stake: 0x2::balance::Balance<0x2::sui::SUI>,
        guess_epoch: 0x1::option::Option<u64>,
        guess: 0x1::option::Option<bool>,
        vrf_input: 0x1::option::Option<vector<u8>>,
        fee_bp: u16,
        status: u8,
    }

    struct StartGameEvent has copy, drop {
        game_id: 0x2::object::ID,
        status: u8,
    }

    struct StartGuessEvent has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        player_stake: u64,
        guess: bool,
        vrf_input: vector<u8>,
        fee_bp: u16,
        status: u8,
    }

    struct EndGameEvent has copy, drop {
        game_id: 0x2::object::ID,
        status: u8,
    }

    fun borrow_mut(arg0: &mut 0x8b1f7b0c27ef57ba6793766bc2a279a06ea89fe9721f58e5b5e9e22839c41f8c::house_data::HouseData, arg1: 0x2::object::ID) : &mut Game {
        assert!(game_exists(arg0, arg1), 6);
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Game>(0x8b1f7b0c27ef57ba6793766bc2a279a06ea89fe9721f58e5b5e9e22839c41f8c::house_data::borrow_mut(arg0), arg1)
    }

    public fun borrow_game(arg0: &0x8b1f7b0c27ef57ba6793766bc2a279a06ea89fe9721f58e5b5e9e22839c41f8c::house_data::HouseData, arg1: 0x2::object::ID) : &Game {
        assert!(game_exists(arg0, arg1), 6);
        0x2::dynamic_object_field::borrow<0x2::object::ID, Game>(0x8b1f7b0c27ef57ba6793766bc2a279a06ea89fe9721f58e5b5e9e22839c41f8c::house_data::borrow(arg0), arg1)
    }

    public(friend) fun borrow_total_stake_mut(arg0: &mut Game) : &mut 0x2::balance::Balance<0x2::sui::SUI> {
        &mut arg0.total_stake
    }

    public fun cancel_game(arg0: &mut 0x8b1f7b0c27ef57ba6793766bc2a279a06ea89fe9721f58e5b5e9e22839c41f8c::house_data::HouseData, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(game_exists(arg0, arg1), 6);
        let Game {
            id          : v0,
            player      : v1,
            total_stake : v2,
            guess_epoch : v3,
            guess       : _,
            vrf_input   : _,
            fee_bp      : _,
            status      : v7,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Game>(0x8b1f7b0c27ef57ba6793766bc2a279a06ea89fe9721f58e5b5e9e22839c41f8c::house_data::borrow_mut(arg0), arg1);
        let v8 = v3;
        let v9 = v2;
        0x2::object::delete(v0);
        assert!(v7 == 1, 7);
        assert!(*0x1::option::borrow<u64>(&v8) + 6 <= 0x2::tx_context::epoch(arg2), 9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v9, 0x2::balance::value<0x2::sui::SUI>(&v9) / (2 as u64)), arg2), v1);
        0x2::balance::join<0x2::sui::SUI>(0x8b1f7b0c27ef57ba6793766bc2a279a06ea89fe9721f58e5b5e9e22839c41f8c::house_data::borrow_balance_mut(arg0), v9);
        let v10 = EndGameEvent{
            game_id : arg1,
            status  : 5,
        };
        0x2::event::emit<EndGameEvent>(v10);
    }

    fun create_game(arg0: &mut 0x8b1f7b0c27ef57ba6793766bc2a279a06ea89fe9721f58e5b5e9e22839c41f8c::house_data::HouseData, arg1: &0x8b1f7b0c27ef57ba6793766bc2a279a06ea89fe9721f58e5b5e9e22839c41f8c::ticket::Ticket, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, Game) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(0x2::tx_context::sender(arg3) == 0x8b1f7b0c27ef57ba6793766bc2a279a06ea89fe9721f58e5b5e9e22839c41f8c::ticket::player(arg1), 5);
        assert!(v0 >= 0x8b1f7b0c27ef57ba6793766bc2a279a06ea89fe9721f58e5b5e9e22839c41f8c::house_data::min_stake(arg0), 0);
        assert!(v0 <= 0x8b1f7b0c27ef57ba6793766bc2a279a06ea89fe9721f58e5b5e9e22839c41f8c::house_data::max_stake(arg0), 1);
        assert!(0x8b1f7b0c27ef57ba6793766bc2a279a06ea89fe9721f58e5b5e9e22839c41f8c::house_data::balance(arg0) >= v0, 3);
        let v1 = 0x2::balance::split<0x2::sui::SUI>(0x8b1f7b0c27ef57ba6793766bc2a279a06ea89fe9721f58e5b5e9e22839c41f8c::house_data::borrow_balance_mut(arg0), v0);
        0x2::coin::put<0x2::sui::SUI>(&mut v1, arg2);
        let v2 = Game{
            id          : 0x2::object::new(arg3),
            player      : 0x2::tx_context::sender(arg3),
            total_stake : v1,
            guess_epoch : 0x1::option::none<u64>(),
            guess       : 0x1::option::none<bool>(),
            vrf_input   : 0x1::option::none<vector<u8>>(),
            fee_bp      : 0x8b1f7b0c27ef57ba6793766bc2a279a06ea89fe9721f58e5b5e9e22839c41f8c::house_data::base_fee_in_bp(arg0),
            status      : 0,
        };
        (0x2::object::id<Game>(&v2), v2)
    }

    public fun end_game(arg0: &mut 0x8b1f7b0c27ef57ba6793766bc2a279a06ea89fe9721f58e5b5e9e22839c41f8c::house_data::HouseData, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_game(arg0, arg1);
        assert!(v0.status == 1, 7);
        let v1 = 0x8b1f7b0c27ef57ba6793766bc2a279a06ea89fe9721f58e5b5e9e22839c41f8c::house_data::public_key(arg0);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg2, &v1, 0x1::option::borrow<vector<u8>>(&v0.vrf_input)), 2);
        let v2 = 0x2::hash::blake2b256(&arg2);
        let v3 = *0x1::vector::borrow<u8>(&v2, 0) % 2 == 0;
        let v4 = borrow_mut(arg0, arg1);
        let v5 = if (0x1::option::borrow<bool>(&v0.guess) == &v3) {
            v4.status = 3;
            let v6 = fee_amount(total_stake(v4), v4.fee_bp);
            let v7 = borrow_total_stake_mut(v4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(v7), arg3), v4.player);
            0x2::balance::join<0x2::sui::SUI>(0x8b1f7b0c27ef57ba6793766bc2a279a06ea89fe9721f58e5b5e9e22839c41f8c::house_data::borrow_fees_mut(arg0), 0x2::balance::split<0x2::sui::SUI>(v7, v6));
            3
        } else {
            v4.status = 4;
            let v8 = total_stake(v4);
            0x2::balance::join<0x2::sui::SUI>(0x8b1f7b0c27ef57ba6793766bc2a279a06ea89fe9721f58e5b5e9e22839c41f8c::house_data::borrow_balance_mut(arg0), 0x2::balance::split<0x2::sui::SUI>(borrow_total_stake_mut(v4), v8));
            4
        };
        let v9 = EndGameEvent{
            game_id : arg1,
            status  : v5,
        };
        0x2::event::emit<EndGameEvent>(v9);
    }

    public fun fee_amount(arg0: u64, arg1: u16) : u64 {
        ((((arg0 / (2 as u64)) as u128) * (arg1 as u128) / 10000) as u64)
    }

    public fun fee_in_bp(arg0: &Game) : u16 {
        arg0.fee_bp
    }

    public fun game_exists(arg0: &0x8b1f7b0c27ef57ba6793766bc2a279a06ea89fe9721f58e5b5e9e22839c41f8c::house_data::HouseData, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_<0x2::object::ID>(0x8b1f7b0c27ef57ba6793766bc2a279a06ea89fe9721f58e5b5e9e22839c41f8c::house_data::borrow(arg0), arg1)
    }

    public fun guess(arg0: &Game) : bool {
        assert!(0x1::option::is_some<bool>(&arg0.guess), 8);
        *0x1::option::borrow<bool>(&arg0.guess)
    }

    public fun guess_epoch(arg0: &Game) : u64 {
        assert!(0x1::option::is_some<u64>(&arg0.guess_epoch), 8);
        *0x1::option::borrow<u64>(&arg0.guess_epoch)
    }

    public fun player(arg0: &Game) : address {
        arg0.player
    }

    public fun start_game(arg0: &mut 0x8b1f7b0c27ef57ba6793766bc2a279a06ea89fe9721f58e5b5e9e22839c41f8c::house_data::HouseData, arg1: &0x8b1f7b0c27ef57ba6793766bc2a279a06ea89fe9721f58e5b5e9e22839c41f8c::ticket::Ticket, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1) = create_game(arg0, arg1, arg2, arg3);
        0x2::dynamic_object_field::add<0x2::object::ID, Game>(0x8b1f7b0c27ef57ba6793766bc2a279a06ea89fe9721f58e5b5e9e22839c41f8c::house_data::borrow_mut(arg0), v0, v1);
        let v2 = StartGameEvent{
            game_id : v0,
            status  : 0,
        };
        0x2::event::emit<StartGameEvent>(v2);
        v0
    }

    public fun start_guess(arg0: &mut 0x8b1f7b0c27ef57ba6793766bc2a279a06ea89fe9721f58e5b5e9e22839c41f8c::house_data::HouseData, arg1: &mut 0x8b1f7b0c27ef57ba6793766bc2a279a06ea89fe9721f58e5b5e9e22839c41f8c::ticket::Ticket, arg2: 0x2::object::ID, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_mut(arg0, arg2);
        assert!(player(v0) == 0x8b1f7b0c27ef57ba6793766bc2a279a06ea89fe9721f58e5b5e9e22839c41f8c::ticket::player(arg1), 5);
        assert!(0x2::tx_context::sender(arg4) == v0.player, 4);
        assert!(status(v0) == 0, 7);
        let v1 = 0x8b1f7b0c27ef57ba6793766bc2a279a06ea89fe9721f58e5b5e9e22839c41f8c::ticket::get_vrf_input_and_increment(arg1);
        0x1::option::fill<bool>(&mut v0.guess, arg3);
        0x1::option::fill<vector<u8>>(&mut v0.vrf_input, v1);
        0x1::option::fill<u64>(&mut v0.guess_epoch, 0x2::tx_context::epoch(arg4));
        v0.status = 1;
        let v2 = StartGuessEvent{
            game_id      : arg2,
            player       : player(v0),
            player_stake : total_stake(v0) / (2 as u64),
            guess        : arg3,
            vrf_input    : v1,
            fee_bp       : fee_in_bp(v0),
            status       : 1,
        };
        0x2::event::emit<StartGuessEvent>(v2);
    }

    public fun status(arg0: &Game) : u8 {
        arg0.status
    }

    public fun total_stake(arg0: &Game) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.total_stake)
    }

    public fun vrf_input(arg0: &Game) : vector<u8> {
        assert!(0x1::option::is_some<vector<u8>>(&arg0.vrf_input), 8);
        *0x1::option::borrow<vector<u8>>(&arg0.vrf_input)
    }

    // decompiled from Move bytecode v6
}

