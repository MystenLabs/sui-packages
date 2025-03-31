module 0xd0bb0d2dfe587ac1438b430e158ad2ba7bc4fac112bded92be4dfa9d515ff6fb::game {
    struct Game has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    public entry fun deposit(arg0: &mut Game, arg1: &mut 0x2::coin::Coin<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>, arg2: u64) {
        assert!(0x2::coin::value<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(arg1) >= arg2, 9223372337502486527);
        0x2::balance::join<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(&mut arg0.balance, 0x2::balance::split<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(0x2::coin::balance_mut<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(arg1), arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(),
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdminCap{
            id   : 0x2::object::new(arg0),
            name : 0x1::string::utf8(b"firefly"),
        };
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun play(arg0: &mut Game, arg1: &0x2::random::Random, arg2: bool, arg3: &mut 0x2::coin::Coin<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(&arg0.balance) >= arg4, 9223372255898107903);
        assert!(0x2::coin::value<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(arg3) >= arg4, 9223372260193075199);
        assert!(arg4 * 10 <= 0x2::balance::value<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(&arg0.balance), 9223372264488042495);
        let v0 = 0x2::random::new_generator(arg1, arg5);
        if (0x2::random::generate_bool(&mut v0) == arg2) {
            0x2::coin::join<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(arg3, 0x2::coin::take<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(&mut arg0.balance, arg4, arg5));
        } else {
            deposit(arg0, arg3, arg4);
        };
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(&arg1.balance) >= arg2, 9223372384747126783);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>>(0x2::coin::take<0xba695b7c5f47db5d85606ee1a5f6ad4b54638094f2e72181d5f370f64505fe5e::kamisayaka_coin::KAMISAYAKA_COIN>(&mut arg1.balance, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

