module 0x679f4f04bce8d849a1f6488655cd67c9b91c1d5c757bebee8e8ff59ca14311bb::hands_rock_paper_scissors {
    struct GameCap has key {
        id: 0x2::object::UID,
        creator: address,
    }

    struct Game has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        hands: 0x2::table::Table<0x1::string::String, vector<0x1::string::String>>,
    }

    fun check(arg0: vector<u8>) : bool {
        arg0 == b"rock" || arg0 == b"paper" || arg0 == b"scissor"
    }

    entry fun choose_hand(arg0: &GameCap, arg1: Game, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == b"left" || arg2 == b"right", 2);
        let Game {
            id      : v0,
            balance : v1,
            hands   : v2,
        } = arg1;
        let v3 = v2;
        let v4 = v1;
        0x2::object::delete(v0);
        let v5 = if (user_win(*0x1::vector::borrow<0x1::string::String>(0x2::table::borrow<0x1::string::String, vector<0x1::string::String>>(&v3, 0x1::string::utf8(b"user")), choose_to_number(arg2)), *0x1::vector::borrow<0x1::string::String>(0x2::table::borrow<0x1::string::String, vector<0x1::string::String>>(&v3, 0x1::string::utf8(b"robot")), 0x2::clock::timestamp_ms(arg3) % 2))) {
            0x2::tx_context::sender(arg4)
        } else {
            arg0.creator
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v4, 0x2::math::min(0x2::balance::value<0x2::sui::SUI>(&v4), 1000000000), arg4), v5);
        0x2::table::drop<0x1::string::String, vector<0x1::string::String>>(v3);
        if (0x2::balance::value<0x2::sui::SUI>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v4, 0x2::balance::value<0x2::sui::SUI>(&v4), arg4), 0x2::tx_context::sender(arg4));
        };
        0x2::balance::destroy_zero<0x2::sui::SUI>(v4);
    }

    fun choose_to_number(arg0: vector<u8>) : u64 {
        if (arg0 == b"left") {
            0
        } else {
            1
        }
    }

    entry fun create_game(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) > 0, 0);
        assert!(check(arg0) && check(arg1), 1);
        let v0 = number_to_hand(0x2::clock::timestamp_ms(arg3) % 3);
        let v1 = 0x2::table::new<0x1::string::String, vector<0x1::string::String>>(arg4);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(arg0));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(arg1));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(v0));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(number_to_hand((hand_to_number(arg0) + hand_to_number(arg1) + hand_to_number(v0)) % 3)));
        0x2::table::add<0x1::string::String, vector<0x1::string::String>>(&mut v1, 0x1::string::utf8(b"user"), v2);
        0x2::table::add<0x1::string::String, vector<0x1::string::String>>(&mut v1, 0x1::string::utf8(b"robot"), v4);
        let v6 = Game{
            id      : 0x2::object::new(arg4),
            balance : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
            hands   : v1,
        };
        0x2::transfer::transfer<Game>(v6, 0x2::tx_context::sender(arg4));
    }

    fun hand_to_number(arg0: vector<u8>) : u64 {
        if (arg0 == b"rock") {
            0
        } else if (arg0 == b"paper") {
            1
        } else {
            2
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameCap{
            id      : 0x2::object::new(arg0),
            creator : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::freeze_object<GameCap>(v0);
    }

    fun number_to_hand(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            b"rock"
        } else if (arg0 == 1) {
            b"paper"
        } else {
            b"scissor"
        }
    }

    fun user_win(arg0: 0x1::string::String, arg1: 0x1::string::String) : bool {
        let v0 = 0x1::string::utf8(b"rock");
        let v1 = 0x1::string::utf8(b"paper");
        let v2 = 0x1::string::utf8(b"scissor");
        arg0 == v0 && arg1 == v2 || arg0 == v2 && arg1 == v1 || arg0 == v1 && arg1 == v0
    }

    // decompiled from Move bytecode v6
}

