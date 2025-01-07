module 0x3ae976ef1345716195c811464ea8957499fcda338211ca0e65e68a58ca7c774::game {
    struct Game has store, key {
        id: 0x2::object::UID,
        total_bets: 0x2::balance::Balance<0x820453d29a70f37b4555f7e8340c278119a84b8de48d701eaf34e61489246cf::lihuazhang_faucet_coin::LIHUAZHANG_FAUCET_COIN>,
        guess: u64,
        player: address,
    }

    struct NewGame has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        guess: u64,
        user_bets: u64,
    }

    struct Outcome has copy, drop {
        game_id: 0x2::object::ID,
        status: u8,
    }

    public fun game_exists(arg0: &0x3ae976ef1345716195c811464ea8957499fcda338211ca0e65e68a58ca7c774::house_data::HouseData, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_<0x2::object::ID>(0x3ae976ef1345716195c811464ea8957499fcda338211ca0e65e68a58ca7c774::house_data::borrow(arg0), arg1)
    }

    public fun play_game(arg0: 0x2::object::ID, arg1: u64, arg2: &mut 0x3ae976ef1345716195c811464ea8957499fcda338211ca0e65e68a58ca7c774::house_data::HouseData, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(game_exists(arg2, arg0), 5);
        let Game {
            id         : v0,
            total_bets : v1,
            guess      : v2,
            player     : v3,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Game>(0x3ae976ef1345716195c811464ea8957499fcda338211ca0e65e68a58ca7c774::house_data::borrow_mut(arg2), arg0);
        0x2::object::delete(v0);
        let v4 = if (v2 == arg1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x820453d29a70f37b4555f7e8340c278119a84b8de48d701eaf34e61489246cf::lihuazhang_faucet_coin::LIHUAZHANG_FAUCET_COIN>>(0x2::coin::from_balance<0x820453d29a70f37b4555f7e8340c278119a84b8de48d701eaf34e61489246cf::lihuazhang_faucet_coin::LIHUAZHANG_FAUCET_COIN>(v1, arg3), v3);
            1
        } else {
            0x2::balance::join<0x820453d29a70f37b4555f7e8340c278119a84b8de48d701eaf34e61489246cf::lihuazhang_faucet_coin::LIHUAZHANG_FAUCET_COIN>(0x3ae976ef1345716195c811464ea8957499fcda338211ca0e65e68a58ca7c774::house_data::borrow_balance_mut(arg2), v1);
            2
        };
        let v5 = Outcome{
            game_id : arg0,
            status  : v4,
        };
        0x2::event::emit<Outcome>(v5);
    }

    public fun start_game(arg0: &0x2::clock::Clock, arg1: 0x2::coin::Coin<0x820453d29a70f37b4555f7e8340c278119a84b8de48d701eaf34e61489246cf::lihuazhang_faucet_coin::LIHUAZHANG_FAUCET_COIN>, arg2: &mut 0x3ae976ef1345716195c811464ea8957499fcda338211ca0e65e68a58ca7c774::house_data::HouseData, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<0x820453d29a70f37b4555f7e8340c278119a84b8de48d701eaf34e61489246cf::lihuazhang_faucet_coin::LIHUAZHANG_FAUCET_COIN>(&arg1);
        assert!(0x3ae976ef1345716195c811464ea8957499fcda338211ca0e65e68a58ca7c774::house_data::balance(arg2) >= v0, 3);
        let v1 = 0x2::balance::split<0x820453d29a70f37b4555f7e8340c278119a84b8de48d701eaf34e61489246cf::lihuazhang_faucet_coin::LIHUAZHANG_FAUCET_COIN>(0x3ae976ef1345716195c811464ea8957499fcda338211ca0e65e68a58ca7c774::house_data::borrow_balance_mut(arg2), v0);
        0x2::coin::put<0x820453d29a70f37b4555f7e8340c278119a84b8de48d701eaf34e61489246cf::lihuazhang_faucet_coin::LIHUAZHANG_FAUCET_COIN>(&mut v1, arg1);
        let v2 = 0x2::object::new(arg3);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = 0x2::clock::timestamp_ms(arg0) % 10;
        let v5 = Game{
            id         : v2,
            total_bets : v1,
            guess      : v4,
            player     : 0x2::tx_context::sender(arg3),
        };
        let v6 = NewGame{
            game_id   : v3,
            player    : 0x2::tx_context::sender(arg3),
            guess     : v4,
            user_bets : v0,
        };
        0x2::event::emit<NewGame>(v6);
        0x2::dynamic_object_field::add<0x2::object::ID, Game>(0x3ae976ef1345716195c811464ea8957499fcda338211ca0e65e68a58ca7c774::house_data::borrow_mut(arg2), v3, v5);
        v3
    }

    // decompiled from Move bytecode v6
}

