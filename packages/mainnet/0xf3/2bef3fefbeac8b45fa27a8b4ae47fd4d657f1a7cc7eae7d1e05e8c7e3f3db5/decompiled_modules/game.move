module 0xf32bef3fefbeac8b45fa27a8b4ae47fd4d657f1a7cc7eae7d1e05e8c7e3f3db5::game {
    struct GameResultEvent has copy, drop {
        is_win: bool,
        you_choice: 0x1::string::String,
        computer_choice: 0x1::string::String,
        result: 0x1::string::String,
    }

    struct Game<phantom T0> has key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<T0>,
        ticket: u64,
        reward: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun create_game<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game<T0>{
            id     : 0x2::object::new(arg0),
            pool   : 0x2::balance::zero<T0>(),
            ticket : 100,
            reward : 200,
        };
        0x2::transfer::share_object<Game<T0>>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun deposit<T0>(arg0: &mut Game<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= arg2, 2);
        let v1 = 0x2::coin::into_balance<T0>(arg1);
        if (v0 > arg2) {
            0x2::balance::join<T0>(&mut arg0.pool, 0x2::balance::split<T0>(&mut v1, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::join<T0>(&mut arg0.pool, v1);
        };
    }

    fun get_random_choice(arg0: &0x2::clock::Clock) : u8 {
        ((0x2::clock::timestamp_ms(arg0) % 3) as u8)
    }

    fun map_choice_to_string(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"rock")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"paper")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"scissors")
        } else {
            0x1::string::utf8(b"Invalid")
        }
    }

    public entry fun play<T0>(arg0: u8, arg1: &mut Game<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1.pool) >= arg1.reward - arg1.ticket, 3);
        assert!(arg0 < 3, 1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 >= arg1.ticket, 2);
        let v1 = 0x2::coin::into_balance<T0>(arg2);
        if (v0 > arg1.ticket) {
            0x2::balance::join<T0>(&mut arg1.pool, 0x2::balance::split<T0>(&mut v1, arg1.ticket));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<T0>(&mut arg1.pool, v1);
        };
        let v2 = get_random_choice(arg3);
        let (v3, v4) = if (arg0 == 0 && v2 == 1 || arg0 == 1 && v2 == 2 || arg0 == 2 && v2 == 0) {
            (0x1::string::utf8(b"Win"), true)
        } else if (arg0 == v2) {
            (0x1::string::utf8(b"Draw"), false)
        } else {
            (0x1::string::utf8(b"Lose"), false)
        };
        if (v4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.pool, arg1.reward), arg4), 0x2::tx_context::sender(arg4));
        };
        let v5 = GameResultEvent{
            is_win          : v4,
            you_choice      : map_choice_to_string(arg0),
            computer_choice : map_choice_to_string(v2),
            result          : v3,
        };
        0x2::event::emit<GameResultEvent>(v5);
    }

    public entry fun set_reward<T0>(arg0: &AdminCap, arg1: &mut Game<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.reward = arg2;
    }

    public entry fun set_ticket<T0>(arg0: &AdminCap, arg1: &mut Game<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.ticket = arg2;
    }

    public entry fun withdraw<T0>(arg0: &AdminCap, arg1: &mut Game<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.pool, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

