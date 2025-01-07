module 0x3911c4e78d6cf212471e577ecada0330ad4542b9f23b0e3d0a0641122b527ff9::zhaoxilingcheng_game {
    struct GameResult has copy, drop {
        your_choice: 0x1::string::String,
        dice_points: u8,
        result: 0x1::string::String,
        is_winner: bool,
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

    entry fun creat_game<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game<T0>{
            id     : 0x2::object::new(arg0),
            pool   : 0x2::balance::zero<T0>(),
            ticket : 100000000,
            reward : 200000000,
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

    public fun game_pool<T0>(arg0: &Game<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pool)
    }

    public fun game_reward<T0>(arg0: &Game<T0>) : u64 {
        arg0.reward
    }

    public fun game_ticket<T0>(arg0: &Game<T0>) : u64 {
        arg0.ticket
    }

    fun get_dice_points(arg0: &0x2::clock::Clock) : u8 {
        ((0x2::clock::timestamp_ms(arg0) % 6 + 1) as u8)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    fun map_choice_to_string(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Small")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Big")
        } else {
            0x1::string::utf8(b"Invalid")
        }
    }

    public entry fun play<T0>(arg0: u8, arg1: &mut Game<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1.pool) >= arg1.reward - arg1.ticket, 1);
        assert!(arg0 < 2, 0);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 >= arg1.ticket, 2);
        let v1 = 0x2::coin::into_balance<T0>(arg2);
        if (v0 > arg1.ticket) {
            0x2::balance::join<T0>(&mut arg1.pool, 0x2::balance::split<T0>(&mut v1, arg1.ticket));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<T0>(&mut arg1.pool, v1);
        };
        let v2 = get_dice_points(arg3);
        let (v3, v4) = if (arg0 == 0 && v2 < 4 || arg0 == 1 && v2 > 3) {
            (0x1::string::utf8(b"Win"), true)
        } else {
            (0x1::string::utf8(b"Lose"), false)
        };
        if (v4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.pool, arg1.reward), arg4), 0x2::tx_context::sender(arg4));
        };
        let v5 = GameResult{
            your_choice : map_choice_to_string(arg0),
            dice_points : v2,
            result      : v3,
            is_winner   : v4,
        };
        0x2::event::emit<GameResult>(v5);
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

