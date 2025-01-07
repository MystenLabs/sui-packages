module 0xa0874140d8ddd624ba37142f0e9ca89c180a7affb311ee041a6e97f05253eff7::flip_coin {
    struct Game has key {
        id: 0x2::object::UID,
        amt: 0x2::balance::Balance<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>,
        github_id: vector<u8>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun add_rmb(arg0: &mut Game, arg1: 0x2::coin::Coin<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>) {
        0x2::balance::join<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>(&mut arg0.amt, 0x2::coin::into_balance<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id        : 0x2::object::new(arg0),
            amt       : 0x2::balance::zero<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>(),
            github_id : b"guoying2026",
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun play(arg0: &mut Game, arg1: &0x2::random::Random, arg2: bool, arg3: 0x2::coin::Coin<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>(&arg3);
        assert!(0x2::balance::value<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>(&arg0.amt) >= v0 * 10, 273);
        let v1 = 0x2::random::new_generator(arg1, arg4);
        if (arg2 == 0x2::random::generate_bool(&mut v1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>>(0x2::coin::from_balance<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>(0x2::balance::split<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>(&mut arg0.amt, v0), arg4), 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>>(arg3, 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>(&mut arg0.amt, 0x2::coin::into_balance<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>(arg3));
        };
    }

    public entry fun remove_rmb(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>>(0x2::coin::from_balance<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>(0x2::balance::split<0x6388a5b287e979f5f51632e320c6ae0cfdd96b39b087113ae58c3b26c5d03d4e::rmb::RMB>(&mut arg1.amt, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

