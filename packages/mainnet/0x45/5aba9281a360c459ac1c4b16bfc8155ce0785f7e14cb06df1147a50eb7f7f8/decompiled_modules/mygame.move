module 0x455aba9281a360c459ac1c4b16bfc8155ce0785f7e14cb06df1147a50eb7f7f8::mygame {
    struct NewGame has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        guess: u64,
        user_stake: u64,
    }

    struct Outcome has copy, drop {
        game_id: 0x2::object::ID,
        ans: u64,
        status: u8,
    }

    struct Game has store, key {
        id: 0x2::object::UID,
        total_stake: 0x2::balance::Balance<0x4aff5560adba35a7a92864a8f2dfc5e8344f6284fa745861d2c55cbfc60d5340::AYOUNG_FAUCET_COIN::AYOUNG_FAUCET_COIN>,
        guess: u64,
        player: address,
    }

    public fun finish_game(arg0: 0x2::object::ID, arg1: &mut 0x455aba9281a360c459ac1c4b16bfc8155ce0785f7e14cb06df1147a50eb7f7f8::game_data::GameData, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(game_exists(arg1, arg0), 5);
        let Game {
            id          : v0,
            total_stake : v1,
            guess       : v2,
            player      : v3,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Game>(0x455aba9281a360c459ac1c4b16bfc8155ce0785f7e14cb06df1147a50eb7f7f8::game_data::borrow_mut(arg1), arg0);
        let v4 = v1;
        0x2::object::delete(v0);
        let v5 = get_random(arg2);
        let v6 = if (0x2::math::diff((v2 as u64), (v5 as u64)) > 50) {
            0x2::balance::join<0x4aff5560adba35a7a92864a8f2dfc5e8344f6284fa745861d2c55cbfc60d5340::AYOUNG_FAUCET_COIN::AYOUNG_FAUCET_COIN>(0x455aba9281a360c459ac1c4b16bfc8155ce0785f7e14cb06df1147a50eb7f7f8::game_data::borrow_fees_mut(arg1), 0x2::balance::split<0x4aff5560adba35a7a92864a8f2dfc5e8344f6284fa745861d2c55cbfc60d5340::AYOUNG_FAUCET_COIN::AYOUNG_FAUCET_COIN>(&mut v4, 0x2::balance::value<0x4aff5560adba35a7a92864a8f2dfc5e8344f6284fa745861d2c55cbfc60d5340::AYOUNG_FAUCET_COIN::AYOUNG_FAUCET_COIN>(&v4) / 5));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4aff5560adba35a7a92864a8f2dfc5e8344f6284fa745861d2c55cbfc60d5340::AYOUNG_FAUCET_COIN::AYOUNG_FAUCET_COIN>>(0x2::coin::from_balance<0x4aff5560adba35a7a92864a8f2dfc5e8344f6284fa745861d2c55cbfc60d5340::AYOUNG_FAUCET_COIN::AYOUNG_FAUCET_COIN>(v4, arg2), v3);
            1
        } else {
            0x2::balance::join<0x4aff5560adba35a7a92864a8f2dfc5e8344f6284fa745861d2c55cbfc60d5340::AYOUNG_FAUCET_COIN::AYOUNG_FAUCET_COIN>(0x455aba9281a360c459ac1c4b16bfc8155ce0785f7e14cb06df1147a50eb7f7f8::game_data::borrow_balance_mut(arg1), v4);
            2
        };
        let v7 = Outcome{
            game_id : arg0,
            ans     : v5,
            status  : v6,
        };
        0x2::event::emit<Outcome>(v7);
    }

    public fun game_exists(arg0: &0x455aba9281a360c459ac1c4b16bfc8155ce0785f7e14cb06df1147a50eb7f7f8::game_data::GameData, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_<0x2::object::ID>(0x455aba9281a360c459ac1c4b16bfc8155ce0785f7e14cb06df1147a50eb7f7f8::game_data::borrow(arg0), arg1)
    }

    fun get_random(arg0: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::bcs::new(*0x2::tx_context::digest(arg0));
        ((0x2::bcs::peel_u64(&mut v0) % 100) as u64)
    }

    fun internal_start_game(arg0: u64, arg1: 0x2::coin::Coin<0x4aff5560adba35a7a92864a8f2dfc5e8344f6284fa745861d2c55cbfc60d5340::AYOUNG_FAUCET_COIN::AYOUNG_FAUCET_COIN>, arg2: &mut 0x455aba9281a360c459ac1c4b16bfc8155ce0785f7e14cb06df1147a50eb7f7f8::game_data::GameData, arg3: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, Game) {
        assert!(arg0 >= 0 && arg0 <= 100, 3);
        let v0 = 0x2::coin::value<0x4aff5560adba35a7a92864a8f2dfc5e8344f6284fa745861d2c55cbfc60d5340::AYOUNG_FAUCET_COIN::AYOUNG_FAUCET_COIN>(&arg1);
        assert!(v0 <= 0x455aba9281a360c459ac1c4b16bfc8155ce0785f7e14cb06df1147a50eb7f7f8::game_data::max_stake(arg2), 1);
        assert!(v0 >= 0x455aba9281a360c459ac1c4b16bfc8155ce0785f7e14cb06df1147a50eb7f7f8::game_data::min_stake(arg2), 0);
        assert!(0x455aba9281a360c459ac1c4b16bfc8155ce0785f7e14cb06df1147a50eb7f7f8::game_data::balance(arg2) >= v0, 4);
        let v1 = 0x2::balance::split<0x4aff5560adba35a7a92864a8f2dfc5e8344f6284fa745861d2c55cbfc60d5340::AYOUNG_FAUCET_COIN::AYOUNG_FAUCET_COIN>(0x455aba9281a360c459ac1c4b16bfc8155ce0785f7e14cb06df1147a50eb7f7f8::game_data::borrow_balance_mut(arg2), v0);
        0x2::coin::put<0x4aff5560adba35a7a92864a8f2dfc5e8344f6284fa745861d2c55cbfc60d5340::AYOUNG_FAUCET_COIN::AYOUNG_FAUCET_COIN>(&mut v1, arg1);
        let v2 = 0x2::object::new(arg3);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = Game{
            id          : v2,
            total_stake : v1,
            guess       : arg0,
            player      : 0x2::tx_context::sender(arg3),
        };
        let v5 = NewGame{
            game_id    : v3,
            player     : 0x2::tx_context::sender(arg3),
            guess      : arg0,
            user_stake : v0,
        };
        0x2::event::emit<NewGame>(v5);
        (v3, v4)
    }

    public fun start_game(arg0: u64, arg1: 0x2::coin::Coin<0x4aff5560adba35a7a92864a8f2dfc5e8344f6284fa745861d2c55cbfc60d5340::AYOUNG_FAUCET_COIN::AYOUNG_FAUCET_COIN>, arg2: &mut 0x455aba9281a360c459ac1c4b16bfc8155ce0785f7e14cb06df1147a50eb7f7f8::game_data::GameData, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1) = internal_start_game(arg0, arg1, arg2, arg3);
        0x2::dynamic_object_field::add<0x2::object::ID, Game>(0x455aba9281a360c459ac1c4b16bfc8155ce0785f7e14cb06df1147a50eb7f7f8::game_data::borrow_mut(arg2), v0, v1);
        v0
    }

    // decompiled from Move bytecode v6
}

