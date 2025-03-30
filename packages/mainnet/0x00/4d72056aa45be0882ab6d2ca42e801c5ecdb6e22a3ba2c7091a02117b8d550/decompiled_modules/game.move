module 0x4d72056aa45be0882ab6d2ca42e801c5ecdb6e22a3ba2c7091a02117b8d550::game {
    struct Game has key {
        id: 0x2::object::UID,
        amount: 0x2::balance::Balance<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit(arg0: &mut Game, arg1: 0x2::coin::Coin<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(&mut arg0.amount, 0x2::coin::into_balance<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id     : 0x2::object::new(arg0),
            amount : 0x2::balance::zero<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(),
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun play(arg0: &mut Game, arg1: &0x2::random::Random, arg2: bool, arg3: 0x2::coin::Coin<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(&arg3);
        assert!(0x2::balance::value<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(&arg0.amount) >= v0 * 10, 17);
        let v1 = 0x2::random::new_generator(arg1, arg4);
        if (arg2 == 0x2::random::generate_bool(&mut v1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>>(0x2::coin::from_balance<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(0x2::balance::split<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(&mut arg0.amount, v0), arg4), 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>>(arg3, 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(&mut arg0.amount, 0x2::coin::into_balance<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(arg3));
        };
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>>(0x2::coin::from_balance<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(0x2::balance::split<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(&mut arg1.amount, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

