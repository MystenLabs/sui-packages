module 0x4fb94b7b63350745592ae0ddf44b20d071d3b7e1fb75f820ae5911c5c6796414::single_player_satoshi {
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
        guess_placed_epoch: u64,
        total_stake: 0x2::balance::Balance<0x2::sui::SUI>,
        guess: 0x1::string::String,
        player: address,
        vrf_input: vector<u8>,
        fee_bp: u16,
    }

    public fun borrow_game(arg0: 0x2::object::ID, arg1: &0x4fb94b7b63350745592ae0ddf44b20d071d3b7e1fb75f820ae5911c5c6796414::house_data::HouseData) : &Game {
        assert!(game_exists(arg1, arg0), 6);
        0x2::dynamic_object_field::borrow<0x2::object::ID, Game>(0x4fb94b7b63350745592ae0ddf44b20d071d3b7e1fb75f820ae5911c5c6796414::house_data::borrow(arg1), arg0)
    }

    public fun dispute_and_win(arg0: &mut 0x4fb94b7b63350745592ae0ddf44b20d071d3b7e1fb75f820ae5911c5c6796414::house_data::HouseData, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(game_exists(arg0, arg1), 6);
        let Game {
            id                 : v0,
            guess_placed_epoch : v1,
            total_stake        : v2,
            guess              : _,
            player             : v4,
            vrf_input          : _,
            fee_bp             : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Game>(0x4fb94b7b63350745592ae0ddf44b20d071d3b7e1fb75f820ae5911c5c6796414::house_data::borrow_mut(arg0), arg1);
        0x2::object::delete(v0);
        assert!(v1 + 7 <= 0x2::tx_context::epoch(arg2), 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg2), v4);
        let v7 = Outcome{
            game_id : arg1,
            status  : 3,
        };
        0x2::event::emit<Outcome>(v7);
    }

    public fun fee_amount(arg0: u64, arg1: u16) : u64 {
        ((((arg0 / (2 as u64)) as u128) * (arg1 as u128) / 10000) as u64)
    }

    public fun fee_in_bp(arg0: &Game) : u16 {
        arg0.fee_bp
    }

    public fun finish_game(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: &mut 0x4fb94b7b63350745592ae0ddf44b20d071d3b7e1fb75f820ae5911c5c6796414::house_data::HouseData, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(game_exists(arg2, arg0), 6);
        let Game {
            id                 : v0,
            guess_placed_epoch : _,
            total_stake        : v2,
            guess              : v3,
            player             : v4,
            vrf_input          : v5,
            fee_bp             : v6,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Game>(0x4fb94b7b63350745592ae0ddf44b20d071d3b7e1fb75f820ae5911c5c6796414::house_data::borrow_mut(arg2), arg0);
        let v7 = v5;
        let v8 = v2;
        0x2::object::delete(v0);
        let v9 = 0x4fb94b7b63350745592ae0ddf44b20d071d3b7e1fb75f820ae5911c5c6796414::house_data::public_key(arg2);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg1, &v9, &v7), 2);
        let v10 = 0x2::hash::blake2b256(&arg1);
        let v11 = if (map_guess(v3) == *0x1::vector::borrow<u8>(&v10, 0) % 2) {
            0x2::balance::join<0x2::sui::SUI>(0x4fb94b7b63350745592ae0ddf44b20d071d3b7e1fb75f820ae5911c5c6796414::house_data::borrow_fees_mut(arg2), 0x2::balance::split<0x2::sui::SUI>(&mut v8, fee_amount(0x2::balance::value<0x2::sui::SUI>(&v8), v6)));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v8, arg3), v4);
            1
        } else {
            0x2::balance::join<0x2::sui::SUI>(0x4fb94b7b63350745592ae0ddf44b20d071d3b7e1fb75f820ae5911c5c6796414::house_data::borrow_balance_mut(arg2), v8);
            2
        };
        let v12 = Outcome{
            game_id : arg0,
            status  : v11,
        };
        0x2::event::emit<Outcome>(v12);
    }

    public fun game_exists(arg0: &0x4fb94b7b63350745592ae0ddf44b20d071d3b7e1fb75f820ae5911c5c6796414::house_data::HouseData, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_<0x2::object::ID>(0x4fb94b7b63350745592ae0ddf44b20d071d3b7e1fb75f820ae5911c5c6796414::house_data::borrow(arg0), arg1)
    }

    public fun guess(arg0: &Game) : u8 {
        map_guess(arg0.guess)
    }

    public fun guess_placed_epoch(arg0: &Game) : u64 {
        arg0.guess_placed_epoch
    }

    fun internal_start_game(arg0: 0x1::string::String, arg1: &mut 0x4fb94b7b63350745592ae0ddf44b20d071d3b7e1fb75f820ae5911c5c6796414::counter_nft::Counter, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x4fb94b7b63350745592ae0ddf44b20d071d3b7e1fb75f820ae5911c5c6796414::house_data::HouseData, arg4: u16, arg5: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, Game) {
        map_guess(arg0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 <= 0x4fb94b7b63350745592ae0ddf44b20d071d3b7e1fb75f820ae5911c5c6796414::house_data::max_stake(arg3), 1);
        assert!(v0 >= 0x4fb94b7b63350745592ae0ddf44b20d071d3b7e1fb75f820ae5911c5c6796414::house_data::min_stake(arg3), 0);
        assert!(0x4fb94b7b63350745592ae0ddf44b20d071d3b7e1fb75f820ae5911c5c6796414::house_data::balance(arg3) >= v0, 5);
        let v1 = 0x2::balance::split<0x2::sui::SUI>(0x4fb94b7b63350745592ae0ddf44b20d071d3b7e1fb75f820ae5911c5c6796414::house_data::borrow_balance_mut(arg3), v0);
        0x2::coin::put<0x2::sui::SUI>(&mut v1, arg2);
        let v2 = 0x4fb94b7b63350745592ae0ddf44b20d071d3b7e1fb75f820ae5911c5c6796414::counter_nft::get_vrf_input_and_increment(arg1);
        let v3 = 0x2::object::new(arg5);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = Game{
            id                 : v3,
            guess_placed_epoch : 0x2::tx_context::epoch(arg5),
            total_stake        : v1,
            guess              : arg0,
            player             : 0x2::tx_context::sender(arg5),
            vrf_input          : v2,
            fee_bp             : arg4,
        };
        let v6 = NewGame{
            game_id    : v4,
            player     : 0x2::tx_context::sender(arg5),
            vrf_input  : v2,
            guess      : arg0,
            user_stake : v0,
            fee_bp     : arg4,
        };
        0x2::event::emit<NewGame>(v6);
        (v4, v5)
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

    public fun start_game(arg0: 0x1::string::String, arg1: &mut 0x4fb94b7b63350745592ae0ddf44b20d071d3b7e1fb75f820ae5911c5c6796414::counter_nft::Counter, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x4fb94b7b63350745592ae0ddf44b20d071d3b7e1fb75f820ae5911c5c6796414::house_data::HouseData, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x4fb94b7b63350745592ae0ddf44b20d071d3b7e1fb75f820ae5911c5c6796414::house_data::base_fee_in_bp(arg3);
        let (v1, v2) = internal_start_game(arg0, arg1, arg2, arg3, v0, arg4);
        0x2::dynamic_object_field::add<0x2::object::ID, Game>(0x4fb94b7b63350745592ae0ddf44b20d071d3b7e1fb75f820ae5911c5c6796414::house_data::borrow_mut(arg3), v1, v2);
        v1
    }

    public fun vrf_input(arg0: &Game) : vector<u8> {
        arg0.vrf_input
    }

    // decompiled from Move bytecode v6
}

