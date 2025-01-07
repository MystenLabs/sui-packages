module 0xff1b84c20188403ddcb51c22620a8db84dc6a9c2d191aa8400747cad07ae95a2::guess_hand {
    struct Game has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xff1b84c20188403ddcb51c22620a8db84dc6a9c2d191aa8400747cad07ae95a2::aot::AOT>,
        hands: 0x2::table::Table<0x1::ascii::String, vector<0x1::ascii::String>>,
    }

    struct GameCap has key {
        id: 0x2::object::UID,
        creator: address,
    }

    fun check(arg0: vector<u8>) : bool {
        arg0 == b"rock" || arg0 == b"scissor" || arg0 == b"paper"
    }

    public entry fun choose_hand(arg0: &GameCap, arg1: Game, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let Game {
            id      : v0,
            balance : v1,
            hands   : v2,
        } = arg1;
        let v3 = v2;
        let v4 = v1;
        0x2::object::delete(v0);
        assert!(0x2::balance::value<0xff1b84c20188403ddcb51c22620a8db84dc6a9c2d191aa8400747cad07ae95a2::aot::AOT>(&v4) > 0, 3);
        let v5 = roll_clock(arg3, arg4);
        let v6 = if (user_win(*0x1::vector::borrow<0x1::ascii::String>(0x2::table::borrow<0x1::ascii::String, vector<0x1::ascii::String>>(&v3, 0x1::ascii::string(b"user")), choose_to_number(arg2)), *0x1::vector::borrow<0x1::ascii::String>(0x2::table::borrow<0x1::ascii::String, vector<0x1::ascii::String>>(&v3, 0x1::ascii::string(b"robot")), v5))) {
            0x2::tx_context::sender(arg4)
        } else {
            arg0.creator
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xff1b84c20188403ddcb51c22620a8db84dc6a9c2d191aa8400747cad07ae95a2::aot::AOT>>(0x2::coin::take<0xff1b84c20188403ddcb51c22620a8db84dc6a9c2d191aa8400747cad07ae95a2::aot::AOT>(&mut v4, 0x2::math::min(0x2::balance::value<0xff1b84c20188403ddcb51c22620a8db84dc6a9c2d191aa8400747cad07ae95a2::aot::AOT>(&v4), 1000000000), arg4), v6);
        0x2::table::drop<0x1::ascii::String, vector<0x1::ascii::String>>(v3);
        if (0x2::balance::value<0xff1b84c20188403ddcb51c22620a8db84dc6a9c2d191aa8400747cad07ae95a2::aot::AOT>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xff1b84c20188403ddcb51c22620a8db84dc6a9c2d191aa8400747cad07ae95a2::aot::AOT>>(0x2::coin::take<0xff1b84c20188403ddcb51c22620a8db84dc6a9c2d191aa8400747cad07ae95a2::aot::AOT>(&mut v4, 0x2::balance::value<0xff1b84c20188403ddcb51c22620a8db84dc6a9c2d191aa8400747cad07ae95a2::aot::AOT>(&v4), arg4), 0x2::tx_context::sender(arg4));
        };
        0x2::balance::destroy_zero<0xff1b84c20188403ddcb51c22620a8db84dc6a9c2d191aa8400747cad07ae95a2::aot::AOT>(v4);
    }

    fun choose_to_number(arg0: vector<u8>) : u64 {
        if (arg0 == b"left") {
            0
        } else {
            1
        }
    }

    entry fun create_game(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x2::coin::Coin<0xff1b84c20188403ddcb51c22620a8db84dc6a9c2d191aa8400747cad07ae95a2::aot::AOT>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xff1b84c20188403ddcb51c22620a8db84dc6a9c2d191aa8400747cad07ae95a2::aot::AOT>(&arg2) > 0, 0);
        assert!(check(arg0) && check(arg1), 1);
        let v0 = roll_clock(arg3, arg4);
        let v1 = number_to_hand(v0);
        let v2 = 0x2::table::new<0x1::ascii::String, vector<0x1::ascii::String>>(arg4);
        let v3 = 0x1::vector::empty<0x1::ascii::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::ascii::String>(v4, 0x1::ascii::string(arg0));
        0x1::vector::push_back<0x1::ascii::String>(v4, 0x1::ascii::string(arg1));
        let v5 = 0x1::vector::empty<0x1::ascii::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::ascii::String>(v6, 0x1::ascii::string(v1));
        0x1::vector::push_back<0x1::ascii::String>(v6, 0x1::ascii::string(number_to_hand((hand_to_number(arg0) + hand_to_number(arg1) + hand_to_number(v1)) % 3)));
        0x2::table::add<0x1::ascii::String, vector<0x1::ascii::String>>(&mut v2, 0x1::ascii::string(b"user"), v3);
        0x2::table::add<0x1::ascii::String, vector<0x1::ascii::String>>(&mut v2, 0x1::ascii::string(b"robot"), v5);
        let v7 = Game{
            id      : 0x2::object::new(arg4),
            balance : 0x2::coin::into_balance<0xff1b84c20188403ddcb51c22620a8db84dc6a9c2d191aa8400747cad07ae95a2::aot::AOT>(arg2),
            hands   : v2,
        };
        0x2::transfer::transfer<Game>(v7, 0x2::tx_context::sender(arg4));
    }

    fun hand_to_number(arg0: vector<u8>) : u64 {
        if (arg0 == b"rock") {
            0
        } else if (arg0 == b"scissor") {
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
            b"scissor"
        } else {
            b"paper"
        }
    }

    fun roll(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        0x2::random::generate_u64_in_range(&mut v0, 0, 2)
    }

    fun roll_clock(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        0x2::clock::timestamp_ms(arg0) % 3
    }

    fun user_win(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String) : bool {
        let v0 = 0x1::ascii::string(b"rock");
        let v1 = 0x1::ascii::string(b"scissor");
        let v2 = 0x1::ascii::string(b"paper");
        arg0 == v0 && arg1 == v1 || arg0 == v1 && arg1 == v2 || arg0 == v2 && arg1 == v0
    }

    // decompiled from Move bytecode v6
}

