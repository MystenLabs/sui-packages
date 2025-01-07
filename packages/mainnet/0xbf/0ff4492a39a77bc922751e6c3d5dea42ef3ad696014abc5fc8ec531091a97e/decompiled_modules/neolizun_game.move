module 0xbf0ff4492a39a77bc922751e6c3d5dea42ef3ad696014abc5fc8ec531091a97e::neolizun_game {
    struct GameResult has copy, drop {
        result: 0x1::string::String,
        is_winner: bool,
    }

    struct Game<phantom T0> has key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<T0>,
        ticket: u64,
        reward: u64,
    }

    struct SpinResult has copy, drop, store {
        spin1: u8,
        spin2: u8,
        spin3: u8,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    entry fun creat_game<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game<T0>{
            id     : 0x2::object::new(arg0),
            pool   : 0x2::balance::zero<T0>(),
            ticket : 1000,
            reward : 2000,
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

    fun get_spin_result(arg0: &0x2::clock::Clock) : SpinResult {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        SpinResult{
            spin1 : ((v0 % ((5 as u64) + 1)) as u8),
            spin2 : ((v0 / 100 % ((5 as u64) + 1)) as u8),
            spin3 : ((v0 / 10000 % ((5 as u64) + 1)) as u8),
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun play<T0>(arg0: u8, arg1: &mut Game<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1.pool) >= arg1.reward - arg1.ticket, 1);
        let v0 = get_spin_result(arg3);
        let v1 = SpinResult{
            spin1 : 2,
            spin2 : 2,
            spin3 : 2,
        };
        let v2 = 0x2::coin::value<T0>(&arg2);
        assert!(v2 >= arg1.ticket, 2);
        let v3 = 0x2::coin::into_balance<T0>(arg2);
        if (v2 > arg1.ticket) {
            0x2::balance::join<T0>(&mut arg1.pool, 0x2::balance::split<T0>(&mut v3, arg1.ticket));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<T0>(&mut arg1.pool, v3);
        };
        let (v4, v5) = if (v0.spin1 == v1.spin1 && v0.spin2 == v1.spin2 && v0.spin3 == v1.spin3) {
            (0x1::string::utf8(x"436f6e67726174756c6174696f6e732c20796f752068697420746865206a61636b706f742120436f6c6c65637420796f757220636f696e73f09f9884"), true)
        } else {
            (0x1::string::utf8(x"54727920616761696e2c20626574746572206c75636b206e6578742074696d6521f09f9294"), false)
        };
        if (v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.pool, arg1.reward), arg4), 0x2::tx_context::sender(arg4));
        };
        let v6 = GameResult{
            result    : v4,
            is_winner : v5,
        };
        0x2::event::emit<GameResult>(v6);
    }

    public entry fun withdraw<T0>(arg0: &AdminCap, arg1: &mut Game<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.pool, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

