module 0x92d4f3012e4220bd5ebfec676a0c132d96c5f6925b02825eacd55da7e5f638ae::move_game {
    struct Game has key {
        id: 0x2::object::UID,
        amt: 0x2::balance::Balance<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>,
    }

    struct Admin has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit(arg0: &mut Game, arg1: 0x2::coin::Coin<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>(&mut arg0.amt, 0x2::coin::into_balance<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id  : 0x2::object::new(arg0),
            amt : 0x2::balance::zero<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>(),
        };
        let v1 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Game>(v0);
        0x2::transfer::transfer<Admin>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_player_win(arg0: u8, arg1: u8) : bool {
        (arg0 + 1) % 3 == arg1
    }

    public fun play(arg0: &mut Game, arg1: u8, arg2: 0x2::coin::Coin<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>(&arg2);
        assert!(0x2::balance::value<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>(&arg0.amt) >= v0 * 10, 1001);
        let v1 = 0x2::random::new_generator(arg3, arg4);
        let v2 = 0x2::random::generate_u8(&mut v1) % 3;
        if (arg1 == v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>>(arg2, 0x2::tx_context::sender(arg4));
        } else if (is_player_win(arg1, v2)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>>(0x2::coin::from_balance<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>(0x2::balance::split<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>(&mut arg0.amt, v0), arg4), 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>>(arg2, 0x2::tx_context::sender(arg4));
        } else {
            deposit(arg0, arg2, arg4);
        };
    }

    public entry fun withdraw(arg0: &mut Game, arg1: &Admin, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>(&arg0.amt) >= arg2, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>>(0x2::coin::from_balance<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>(0x2::balance::split<0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin::COLLARALLOC_FAUCET_COIN>(&mut arg0.amt, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

