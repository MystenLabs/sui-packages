module 0xdeddaf2b9fde9498225350570d596c781b1439be473d23628f2579421a9a4541::js_luck_number_game {
    struct LuckNumberGame has key {
        id: 0x2::object::UID,
        last_timestamp: u64,
        vault: 0x2::balance::Balance<0xb8db87209eafdc3799c38dd92b616f2be1ca4fd4809c0909f897d6dfcc44f0df::js_faucet_coin::JS_FAUCET_COIN>,
        winner_lucky_number: 0x1::option::Option<u64>,
        owner_2_number: 0x2::vec_map::VecMap<address, u64>,
        participants: u64,
    }

    public entry fun buy_ticket(arg0: &mut LuckNumberGame, arg1: &mut 0x2::coin::Coin<0xb8db87209eafdc3799c38dd92b616f2be1ca4fd4809c0909f897d6dfcc44f0df::js_faucet_coin::JS_FAUCET_COIN>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg0.last_timestamp == 0) {
            arg0.last_timestamp = 0x2::clock::timestamp_ms(arg2);
        };
        assert!(0x2::coin::value<0xb8db87209eafdc3799c38dd92b616f2be1ca4fd4809c0909f897d6dfcc44f0df::js_faucet_coin::JS_FAUCET_COIN>(arg1) > 1000, 1);
        0x2::balance::join<0xb8db87209eafdc3799c38dd92b616f2be1ca4fd4809c0909f897d6dfcc44f0df::js_faucet_coin::JS_FAUCET_COIN>(&mut arg0.vault, 0x2::coin::into_balance<0xb8db87209eafdc3799c38dd92b616f2be1ca4fd4809c0909f897d6dfcc44f0df::js_faucet_coin::JS_FAUCET_COIN>(0x2::coin::split<0xb8db87209eafdc3799c38dd92b616f2be1ca4fd4809c0909f897d6dfcc44f0df::js_faucet_coin::JS_FAUCET_COIN>(arg1, 1000, arg3)));
        arg0.participants = arg0.participants + 1;
        0x2::vec_map::insert<address, u64>(&mut arg0.owner_2_number, 0x2::tx_context::sender(arg3), arg0.participants);
    }

    entry fun get_lucky_number(arg0: &mut LuckNumberGame, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) - arg0.last_timestamp > 300000, 3);
        assert!(!0x1::option::is_none<u64>(&arg0.winner_lucky_number), 2);
        let v0 = 0x2::random::new_generator(arg1, arg3);
        arg0.winner_lucky_number = 0x1::option::some<u64>(0x2::random::generate_u64_in_range(&mut v0, 1, arg0.participants));
        arg0.last_timestamp = 0x2::clock::timestamp_ms(arg2);
    }

    public entry fun get_reward(arg0: &mut LuckNumberGame, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::clock::timestamp_ms(arg1) - arg0.last_timestamp < 600000) {
            let v0 = 0x2::tx_context::sender(arg2);
            assert!(0x1::option::borrow<u64>(&arg0.winner_lucky_number) == 0x2::vec_map::get<address, u64>(&arg0.owner_2_number, &v0), 4);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb8db87209eafdc3799c38dd92b616f2be1ca4fd4809c0909f897d6dfcc44f0df::js_faucet_coin::JS_FAUCET_COIN>>(0x2::coin::from_balance<0xb8db87209eafdc3799c38dd92b616f2be1ca4fd4809c0909f897d6dfcc44f0df::js_faucet_coin::JS_FAUCET_COIN>(0x2::balance::split<0xb8db87209eafdc3799c38dd92b616f2be1ca4fd4809c0909f897d6dfcc44f0df::js_faucet_coin::JS_FAUCET_COIN>(&mut arg0.vault, 0x2::balance::value<0xb8db87209eafdc3799c38dd92b616f2be1ca4fd4809c0909f897d6dfcc44f0df::js_faucet_coin::JS_FAUCET_COIN>(&arg0.vault)), arg2), 0x2::tx_context::sender(arg2));
        reset_game(arg0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LuckNumberGame{
            id                  : 0x2::object::new(arg0),
            last_timestamp      : 0,
            vault               : 0x2::balance::zero<0xb8db87209eafdc3799c38dd92b616f2be1ca4fd4809c0909f897d6dfcc44f0df::js_faucet_coin::JS_FAUCET_COIN>(),
            winner_lucky_number : 0x1::option::none<u64>(),
            owner_2_number      : 0x2::vec_map::empty<address, u64>(),
            participants        : 0,
        };
        0x2::transfer::share_object<LuckNumberGame>(v0);
    }

    fun reset_game(arg0: &mut LuckNumberGame) {
        arg0.last_timestamp = 0;
        arg0.winner_lucky_number = 0x1::option::none<u64>();
        arg0.owner_2_number = 0x2::vec_map::empty<address, u64>();
        arg0.participants = 0;
    }

    // decompiled from Move bytecode v6
}

