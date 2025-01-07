module 0x2cc68331bf99da3a4be2ebb35c6df8efd38e33a0c4cc6ea48bc7960fceace900::mev_attack_resistant_single_player_satoshi {
    struct NewGame has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        vrf_input: vector<u8>,
        guess: 0x1::string::String,
        user_stake: u64,
        fee_bp: u16,
    }

    struct Outcome has copy, drop {
        game_id: 0x2::object::ID,
        status: u8,
    }

    struct Game has store, key {
        id: 0x2::object::UID,
        guess_placed_epoch: 0x1::option::Option<u64>,
        total_stake: 0x2::balance::Balance<0x2::sui::SUI>,
        guess: 0x1::option::Option<0x1::string::String>,
        player: address,
        vrf_input: 0x1::option::Option<vector<u8>>,
        fee_bp: u16,
        status: u8,
    }

    fun borrow_mut(arg0: &mut 0x2cc68331bf99da3a4be2ebb35c6df8efd38e33a0c4cc6ea48bc7960fceace900::house_data::HouseData, arg1: 0x2::object::ID) : &mut Game {
        assert!(game_exists(arg0, arg1), 8);
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Game>(0x2cc68331bf99da3a4be2ebb35c6df8efd38e33a0c4cc6ea48bc7960fceace900::house_data::borrow_mut(arg0), arg1)
    }

    public fun borrow_game(arg0: &0x2cc68331bf99da3a4be2ebb35c6df8efd38e33a0c4cc6ea48bc7960fceace900::house_data::HouseData, arg1: 0x2::object::ID) : &Game {
        assert!(game_exists(arg0, arg1), 8);
        0x2::dynamic_object_field::borrow<0x2::object::ID, Game>(0x2cc68331bf99da3a4be2ebb35c6df8efd38e33a0c4cc6ea48bc7960fceace900::house_data::borrow(arg0), arg1)
    }

    public fun create_game_and_submit_stake(arg0: &mut 0x2cc68331bf99da3a4be2ebb35c6df8efd38e33a0c4cc6ea48bc7960fceace900::house_data::HouseData, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2cc68331bf99da3a4be2ebb35c6df8efd38e33a0c4cc6ea48bc7960fceace900::house_data::base_fee_in_bp(arg0);
        let (v1, v2) = internal_create_game_and_submit_stake(arg0, arg1, v0, arg2);
        0x2::dynamic_object_field::add<0x2::object::ID, Game>(0x2cc68331bf99da3a4be2ebb35c6df8efd38e33a0c4cc6ea48bc7960fceace900::house_data::borrow_mut(arg0), v1, v2);
        v1
    }

    public fun dispute_and_win(arg0: &mut 0x2cc68331bf99da3a4be2ebb35c6df8efd38e33a0c4cc6ea48bc7960fceace900::house_data::HouseData, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(game_exists(arg0, arg1), 8);
        let Game {
            id                 : v0,
            guess_placed_epoch : v1,
            total_stake        : v2,
            guess              : _,
            player             : v4,
            vrf_input          : _,
            fee_bp             : _,
            status             : v7,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Game>(0x2cc68331bf99da3a4be2ebb35c6df8efd38e33a0c4cc6ea48bc7960fceace900::house_data::borrow_mut(arg0), arg1);
        let v8 = v1;
        0x2::object::delete(v0);
        assert!(v7 == 1, 6);
        assert!(*0x1::option::borrow<u64>(&v8) + 7 <= 0x2::tx_context::epoch(arg2), 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg2), v4);
        let v9 = Outcome{
            game_id : arg1,
            status  : 4,
        };
        0x2::event::emit<Outcome>(v9);
    }

    public fun fee_amount(arg0: u64, arg1: u16) : u64 {
        ((((arg0 / (2 as u64)) as u128) * (arg1 as u128) / 10000) as u64)
    }

    public fun fee_in_bp(arg0: &Game) : u16 {
        arg0.fee_bp
    }

    public fun finish_game(arg0: &mut 0x2cc68331bf99da3a4be2ebb35c6df8efd38e33a0c4cc6ea48bc7960fceace900::house_data::HouseData, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(game_exists(arg0, arg1), 8);
        let Game {
            id                 : v0,
            guess_placed_epoch : _,
            total_stake        : v2,
            guess              : v3,
            player             : v4,
            vrf_input          : v5,
            fee_bp             : v6,
            status             : v7,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Game>(0x2cc68331bf99da3a4be2ebb35c6df8efd38e33a0c4cc6ea48bc7960fceace900::house_data::borrow_mut(arg0), arg1);
        let v8 = v5;
        let v9 = v3;
        let v10 = v2;
        0x2::object::delete(v0);
        assert!(v7 == 1, 6);
        let v11 = 0x2cc68331bf99da3a4be2ebb35c6df8efd38e33a0c4cc6ea48bc7960fceace900::house_data::public_key(arg0);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg2, &v11, 0x1::option::borrow<vector<u8>>(&v8)), 2);
        let v12 = 0x2::hash::blake2b256(&arg2);
        let v13 = if (map_guess(*0x1::option::borrow<0x1::string::String>(&v9)) == *0x1::vector::borrow<u8>(&v12, 0) % 2) {
            0x2::balance::join<0x2::sui::SUI>(0x2cc68331bf99da3a4be2ebb35c6df8efd38e33a0c4cc6ea48bc7960fceace900::house_data::borrow_fees_mut(arg0), 0x2::balance::split<0x2::sui::SUI>(&mut v10, fee_amount(0x2::balance::value<0x2::sui::SUI>(&v10), v6)));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v10, arg3), v4);
            2
        } else {
            0x2::balance::join<0x2::sui::SUI>(0x2cc68331bf99da3a4be2ebb35c6df8efd38e33a0c4cc6ea48bc7960fceace900::house_data::borrow_balance_mut(arg0), v10);
            3
        };
        let v14 = Outcome{
            game_id : arg1,
            status  : v13,
        };
        0x2::event::emit<Outcome>(v14);
    }

    public fun game_exists(arg0: &0x2cc68331bf99da3a4be2ebb35c6df8efd38e33a0c4cc6ea48bc7960fceace900::house_data::HouseData, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_<0x2::object::ID>(0x2cc68331bf99da3a4be2ebb35c6df8efd38e33a0c4cc6ea48bc7960fceace900::house_data::borrow(arg0), arg1)
    }

    public fun guess(arg0: &Game) : u8 {
        assert!(0x1::option::is_some<0x1::string::String>(&arg0.guess), 9);
        map_guess(*0x1::option::borrow<0x1::string::String>(&arg0.guess))
    }

    public fun guess_placed_epoch(arg0: &Game) : u64 {
        assert!(0x1::option::is_some<u64>(&arg0.guess_placed_epoch), 9);
        *0x1::option::borrow<u64>(&arg0.guess_placed_epoch)
    }

    fun internal_create_game_and_submit_stake(arg0: &mut 0x2cc68331bf99da3a4be2ebb35c6df8efd38e33a0c4cc6ea48bc7960fceace900::house_data::HouseData, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, Game) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 <= 0x2cc68331bf99da3a4be2ebb35c6df8efd38e33a0c4cc6ea48bc7960fceace900::house_data::max_stake(arg0), 1);
        assert!(v0 >= 0x2cc68331bf99da3a4be2ebb35c6df8efd38e33a0c4cc6ea48bc7960fceace900::house_data::min_stake(arg0), 0);
        assert!(0x2cc68331bf99da3a4be2ebb35c6df8efd38e33a0c4cc6ea48bc7960fceace900::house_data::balance(arg0) >= v0, 5);
        let v1 = 0x2::balance::split<0x2::sui::SUI>(0x2cc68331bf99da3a4be2ebb35c6df8efd38e33a0c4cc6ea48bc7960fceace900::house_data::borrow_balance_mut(arg0), v0);
        0x2::coin::put<0x2::sui::SUI>(&mut v1, arg1);
        let v2 = Game{
            id                 : 0x2::object::new(arg3),
            guess_placed_epoch : 0x1::option::none<u64>(),
            total_stake        : v1,
            guess              : 0x1::option::none<0x1::string::String>(),
            player             : 0x2::tx_context::sender(arg3),
            vrf_input          : 0x1::option::none<vector<u8>>(),
            fee_bp             : arg2,
            status             : 0,
        };
        (0x2::object::id<Game>(&v2), v2)
    }

    fun map_guess(arg0: 0x1::string::String) : u8 {
        let v0 = b"H";
        let v1 = b"T";
        assert!(0x1::string::bytes(&arg0) == &v0 || 0x1::string::bytes(&arg0) == &v1, 4);
        if (0x1::string::bytes(&arg0) == &v0) {
            0
        } else {
            1
        }
    }

    public fun player(arg0: &Game) : address {
        arg0.player
    }

    public fun stake(arg0: &Game) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.total_stake)
    }

    public fun status(arg0: &Game) : u8 {
        arg0.status
    }

    public fun submit_guess(arg0: &mut 0x2cc68331bf99da3a4be2ebb35c6df8efd38e33a0c4cc6ea48bc7960fceace900::house_data::HouseData, arg1: &mut 0x2cc68331bf99da3a4be2ebb35c6df8efd38e33a0c4cc6ea48bc7960fceace900::counter_nft::Counter, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(game_exists(arg0, arg2), 8);
        map_guess(arg3);
        let v0 = borrow_mut(arg0, arg2);
        assert!(0x2::tx_context::sender(arg4) == v0.player, 7);
        assert!(status(v0) == 0, 6);
        0x1::option::fill<0x1::string::String>(&mut v0.guess, arg3);
        let v1 = 0x2cc68331bf99da3a4be2ebb35c6df8efd38e33a0c4cc6ea48bc7960fceace900::counter_nft::get_vrf_input_and_increment(arg1);
        0x1::option::fill<vector<u8>>(&mut v0.vrf_input, v1);
        0x1::option::fill<u64>(&mut v0.guess_placed_epoch, 0x2::tx_context::epoch(arg4));
        v0.status = 1;
        let v2 = NewGame{
            game_id    : arg2,
            player     : player(v0),
            vrf_input  : v1,
            guess      : arg3,
            user_stake : stake(v0) / (2 as u64),
            fee_bp     : fee_in_bp(v0),
        };
        0x2::event::emit<NewGame>(v2);
    }

    public fun vrf_input(arg0: &Game) : vector<u8> {
        assert!(0x1::option::is_some<vector<u8>>(&arg0.vrf_input), 9);
        *0x1::option::borrow<vector<u8>>(&arg0.vrf_input)
    }

    // decompiled from Move bytecode v6
}

