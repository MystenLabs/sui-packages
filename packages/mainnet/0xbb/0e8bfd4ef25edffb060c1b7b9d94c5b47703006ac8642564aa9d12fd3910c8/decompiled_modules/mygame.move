module 0xbb0e8bfd4ef25edffb060c1b7b9d94c5b47703006ac8642564aa9d12fd3910c8::mygame {
    struct Event has copy, drop {
        choice: u8,
        random: u8,
        win: bool,
        github_id: 0x1::string::String,
        record: 0x1::string::String,
    }

    struct Game has key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<0xbb0e8bfd4ef25edffb060c1b7b9d94c5b47703006ac8642564aa9d12fd3910c8::zzf222_faucet_coin::ZZF222_FAUCET_COIN>,
        ticket: u64,
        reward: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit(arg0: &mut Game, arg1: 0x2::coin::Coin<0xbb0e8bfd4ef25edffb060c1b7b9d94c5b47703006ac8642564aa9d12fd3910c8::zzf222_faucet_coin::ZZF222_FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xbb0e8bfd4ef25edffb060c1b7b9d94c5b47703006ac8642564aa9d12fd3910c8::zzf222_faucet_coin::ZZF222_FAUCET_COIN>(&arg1);
        assert!(v0 >= arg2, 1);
        let v1 = 0x2::coin::into_balance<0xbb0e8bfd4ef25edffb060c1b7b9d94c5b47703006ac8642564aa9d12fd3910c8::zzf222_faucet_coin::ZZF222_FAUCET_COIN>(arg1);
        if (v0 > arg2) {
            0x2::balance::join<0xbb0e8bfd4ef25edffb060c1b7b9d94c5b47703006ac8642564aa9d12fd3910c8::zzf222_faucet_coin::ZZF222_FAUCET_COIN>(&mut arg0.pool, 0x2::balance::split<0xbb0e8bfd4ef25edffb060c1b7b9d94c5b47703006ac8642564aa9d12fd3910c8::zzf222_faucet_coin::ZZF222_FAUCET_COIN>(&mut v1, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xbb0e8bfd4ef25edffb060c1b7b9d94c5b47703006ac8642564aa9d12fd3910c8::zzf222_faucet_coin::ZZF222_FAUCET_COIN>>(0x2::coin::from_balance<0xbb0e8bfd4ef25edffb060c1b7b9d94c5b47703006ac8642564aa9d12fd3910c8::zzf222_faucet_coin::ZZF222_FAUCET_COIN>(v1, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::join<0xbb0e8bfd4ef25edffb060c1b7b9d94c5b47703006ac8642564aa9d12fd3910c8::zzf222_faucet_coin::ZZF222_FAUCET_COIN>(&mut arg0.pool, v1);
        };
    }

    public entry fun get_zzf222_faucet_coin(arg0: &mut 0x2::coin::TreasuryCap<0xbb0e8bfd4ef25edffb060c1b7b9d94c5b47703006ac8642564aa9d12fd3910c8::zzf222_faucet_coin::ZZF222_FAUCET_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0xbb0e8bfd4ef25edffb060c1b7b9d94c5b47703006ac8642564aa9d12fd3910c8::zzf222_faucet_coin::mint(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    public entry fun guess(arg0: 0x2::coin::Coin<0xbb0e8bfd4ef25edffb060c1b7b9d94c5b47703006ac8642564aa9d12fd3910c8::zzf222_faucet_coin::ZZF222_FAUCET_COIN>, arg1: &mut Game, arg2: u8, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == 1 || arg2 == 2 || arg2 == 3 || arg2 == 4 || arg2 == 5, 0);
        assert!(0x2::balance::value<0xbb0e8bfd4ef25edffb060c1b7b9d94c5b47703006ac8642564aa9d12fd3910c8::zzf222_faucet_coin::ZZF222_FAUCET_COIN>(&arg1.pool) >= arg1.reward - arg1.ticket, 2);
        let v0 = 0x2::coin::value<0xbb0e8bfd4ef25edffb060c1b7b9d94c5b47703006ac8642564aa9d12fd3910c8::zzf222_faucet_coin::ZZF222_FAUCET_COIN>(&arg0);
        assert!(v0 >= arg1.ticket, 1);
        let v1 = 0x2::coin::into_balance<0xbb0e8bfd4ef25edffb060c1b7b9d94c5b47703006ac8642564aa9d12fd3910c8::zzf222_faucet_coin::ZZF222_FAUCET_COIN>(arg0);
        if (v0 > arg1.ticket) {
            0x2::balance::join<0xbb0e8bfd4ef25edffb060c1b7b9d94c5b47703006ac8642564aa9d12fd3910c8::zzf222_faucet_coin::ZZF222_FAUCET_COIN>(&mut arg1.pool, 0x2::balance::split<0xbb0e8bfd4ef25edffb060c1b7b9d94c5b47703006ac8642564aa9d12fd3910c8::zzf222_faucet_coin::ZZF222_FAUCET_COIN>(&mut v1, arg1.ticket));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xbb0e8bfd4ef25edffb060c1b7b9d94c5b47703006ac8642564aa9d12fd3910c8::zzf222_faucet_coin::ZZF222_FAUCET_COIN>>(0x2::coin::from_balance<0xbb0e8bfd4ef25edffb060c1b7b9d94c5b47703006ac8642564aa9d12fd3910c8::zzf222_faucet_coin::ZZF222_FAUCET_COIN>(v1, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<0xbb0e8bfd4ef25edffb060c1b7b9d94c5b47703006ac8642564aa9d12fd3910c8::zzf222_faucet_coin::ZZF222_FAUCET_COIN>(&mut arg1.pool, v1);
        };
        let v2 = 0x2::random::new_generator(arg3, arg4);
        let v3 = 0x2::random::generate_u8_in_range(&mut v2, 1, 5);
        if (arg2 == v3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xbb0e8bfd4ef25edffb060c1b7b9d94c5b47703006ac8642564aa9d12fd3910c8::zzf222_faucet_coin::ZZF222_FAUCET_COIN>>(0x2::coin::from_balance<0xbb0e8bfd4ef25edffb060c1b7b9d94c5b47703006ac8642564aa9d12fd3910c8::zzf222_faucet_coin::ZZF222_FAUCET_COIN>(0x2::balance::split<0xbb0e8bfd4ef25edffb060c1b7b9d94c5b47703006ac8642564aa9d12fd3910c8::zzf222_faucet_coin::ZZF222_FAUCET_COIN>(&mut arg1.pool, arg1.reward), arg4), 0x2::tx_context::sender(arg4));
            let v4 = Event{
                choice    : arg2,
                random    : v3,
                win       : true,
                github_id : 0x1::string::utf8(b"zzf222"),
                record    : 0x1::string::utf8(b"You Win!"),
            };
            0x2::event::emit<Event>(v4);
        } else {
            let v5 = Event{
                choice    : arg2,
                random    : v3,
                win       : false,
                github_id : 0x1::string::utf8(b"zzf222"),
                record    : 0x1::string::utf8(b"You Lose!"),
            };
            0x2::event::emit<Event>(v5);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id     : 0x2::object::new(arg0),
            pool   : 0x2::balance::zero<0xbb0e8bfd4ef25edffb060c1b7b9d94c5b47703006ac8642564aa9d12fd3910c8::zzf222_faucet_coin::ZZF222_FAUCET_COIN>(),
            ticket : 1000,
            reward : 2000,
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xbb0e8bfd4ef25edffb060c1b7b9d94c5b47703006ac8642564aa9d12fd3910c8::zzf222_faucet_coin::ZZF222_FAUCET_COIN>>(0x2::coin::from_balance<0xbb0e8bfd4ef25edffb060c1b7b9d94c5b47703006ac8642564aa9d12fd3910c8::zzf222_faucet_coin::ZZF222_FAUCET_COIN>(0x2::balance::split<0xbb0e8bfd4ef25edffb060c1b7b9d94c5b47703006ac8642564aa9d12fd3910c8::zzf222_faucet_coin::ZZF222_FAUCET_COIN>(&mut arg1.pool, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

