module 0xaf8bafa9fc3350a51500657eeb885c6e20a0f54670c15139148cfeed55ec4192::task4 {
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

    fun bytes_to_u64(arg0: vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            v0 = v0 | (*0x1::vector::borrow<u8>(&arg0, v1) as u64) << ((8 * (7 - v1)) as u8);
            v1 = v1 + 1;
        };
        v0
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

    fun get_spin_result(arg0: &mut 0x2::tx_context::TxContext) : SpinResult {
        let v0 = rand_u64_range(0, 5, arg0);
        let v1 = rand_u64_range(0, 5, arg0);
        SpinResult{
            spin1 : (v0 as u8),
            spin2 : (v1 as u8),
            spin3 : (rand_u64_range(0, 5, arg0) as u8),
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun play<T0>(arg0: &mut Game<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg0.pool) >= arg0.reward - arg0.ticket, 1);
        let v0 = get_spin_result(arg2);
        let v1 = SpinResult{
            spin1 : 2,
            spin2 : 2,
            spin3 : 2,
        };
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(v2 >= arg0.ticket, 2);
        let v3 = 0x2::coin::into_balance<T0>(arg1);
        if (v2 > arg0.ticket) {
            0x2::balance::join<T0>(&mut arg0.pool, 0x2::balance::split<T0>(&mut v3, arg0.ticket));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg2), 0x2::tx_context::sender(arg2));
        } else {
            0x2::balance::join<T0>(&mut arg0.pool, v3);
        };
        let v4 = if (v0.spin1 == v1.spin1) {
            if (v0.spin2 == v1.spin2) {
                v0.spin3 == v1.spin3
            } else {
                false
            }
        } else {
            false
        };
        let (v5, v6) = if (v4) {
            (0x1::string::utf8(b"Congratulations, you hit the jackpot! Collect your coins"), true)
        } else {
            (0x1::string::utf8(b"Try again, better luck next time!"), false)
        };
        if (v6) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pool, arg0.reward), arg2), 0x2::tx_context::sender(arg2));
        };
        let v7 = GameResult{
            result    : v5,
            is_winner : v6,
        };
        0x2::event::emit<GameResult>(v7);
    }

    public fun rand_u64_range(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        rand_u64_range_with_seed(seed(arg2), arg0, arg1)
    }

    fun rand_u64_range_with_seed(arg0: vector<u8>, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > arg1, 101);
        rand_u64_with_seed(arg0) % (arg2 - arg1) + arg1
    }

    fun rand_u64_with_seed(arg0: vector<u8>) : u64 {
        bytes_to_u64(arg0)
    }

    fun seed(arg0: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x2::object::new(arg0);
        0x2::object::delete(v0);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x2::tx_context::TxContext>(arg0));
        0x1::vector::append<u8>(&mut v1, 0x2::object::uid_to_bytes(&v0));
        0x1::hash::sha3_256(v1)
    }

    public entry fun withdraw<T0>(arg0: &AdminCap, arg1: &mut Game<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.pool, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

