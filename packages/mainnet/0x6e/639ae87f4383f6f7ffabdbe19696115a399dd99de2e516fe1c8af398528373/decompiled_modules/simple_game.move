module 0x6e639ae87f4383f6f7ffabdbe19696115a399dd99de2e516fe1c8af398528373::simple_game {
    struct Game has key {
        id: 0x2::object::UID,
        play_time: u64,
        pause: bool,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct EventGuess has copy, drop {
        random: u8,
        win: bool,
        amount: u64,
    }

    struct SIMPLE_GAME has drop {
        dummy_field: bool,
    }

    public entry fun add_pool(arg0: &AdminCap, arg1: &mut Game, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<0x2::sui::SUI>(&mut arg1.balance, arg2);
    }

    public entry fun emgency_withdraw(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    fun get_rand_num(arg0: &0x2::clock::Clock, arg1: u32) : u8 {
        ((0x2::clock::timestamp_ms(arg0) % (arg1 as u64) + 1) as u8)
    }

    fun init(arg0: SIMPLE_GAME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id        : 0x2::object::new(arg1),
            play_time : 0,
            pause     : false,
            balance   : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun pause_game(arg0: &AdminCap, arg1: &mut Game, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.pause = arg2;
    }

    entry fun play(arg0: &mut Game, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.pause, 3);
        arg0.play_time = arg0.play_time + 1;
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= 100000000 && v0 <= 1000000000, 1);
        assert!(v0 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), 2);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
        let v1 = get_rand_num(arg2, 2);
        if (v1 == 1) {
            let v2 = EventGuess{
                random : v1,
                win    : true,
                amount : v0 * 2,
            };
            0x2::event::emit<EventGuess>(v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v0 * 2), arg3), 0x2::tx_context::sender(arg3));
        } else if (v1 == 2) {
            let v3 = EventGuess{
                random : v1,
                win    : false,
                amount : v0,
            };
            0x2::event::emit<EventGuess>(v3);
        };
    }

    // decompiled from Move bytecode v6
}

