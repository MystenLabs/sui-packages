module 0xf40f121899689d2b314d0f17fc5ff9e163e31eee40a92a37e43e34baaa36a047::coin_toss_game_billa_github2016 {
    struct Game<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<T0>,
        ticket: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct GAME_RESULT_EVENT has copy, drop {
        game_id: 0x2::object::ID,
        player_address: address,
        result: u8,
        coin_result: 0x1::string::String,
        is_win: bool,
    }

    public fun create_game<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Game<T0>{
            id     : 0x2::object::new(arg1),
            pool   : 0x2::balance::zero<T0>(),
            ticket : 100000000,
        };
        0x2::coin::put<T0>(&mut v0.pool, arg0);
        0x2::transfer::share_object<Game<T0>>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun increase_game_pool<T0>(arg0: &AdminCap, arg1: &mut Game<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg1.pool, 0x2::coin::into_balance<T0>(arg2));
    }

    fun init(arg0: &0x2::tx_context::TxContext) {
    }

    public entry fun play<T0>(arg0: &mut Game<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= arg0.ticket, 2);
        assert!(0x2::balance::value<T0>(&arg0.pool) >= arg0.ticket, 1);
        let v1 = 0x2::random::new_generator(arg3, arg4);
        let v2 = 0x2::random::generate_u8_in_range(&mut v1, 1, 2);
        let v3 = 0x1::string::utf8(b"front");
        if (v2 == 2) {
            v3 = 0x1::string::utf8(b"reverse");
        };
        if (v2 == arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pool, arg0.ticket), arg4), 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
        } else {
            let v4 = 0x2::coin::into_balance<T0>(arg1);
            if (v0 > arg0.ticket) {
                0x2::balance::join<T0>(&mut arg0.pool, 0x2::balance::split<T0>(&mut v4, arg0.ticket));
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg4), 0x2::tx_context::sender(arg4));
            } else {
                0x2::balance::join<T0>(&mut arg0.pool, v4);
            };
        };
        let v5 = GAME_RESULT_EVENT{
            game_id        : 0x2::object::uid_to_inner(&arg0.id),
            player_address : 0x2::tx_context::sender(arg4),
            result         : v2,
            coin_result    : v3,
            is_win         : v2 == arg2,
        };
        0x2::event::emit<GAME_RESULT_EVENT>(v5);
    }

    public entry fun withdraw<T0>(arg0: &AdminCap, arg1: &mut Game<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 0x2::balance::value<T0>(&arg1.pool), 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.pool, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

