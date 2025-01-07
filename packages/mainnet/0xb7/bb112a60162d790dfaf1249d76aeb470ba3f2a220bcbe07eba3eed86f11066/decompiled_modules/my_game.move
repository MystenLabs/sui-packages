module 0xb7bb112a60162d790dfaf1249d76aeb470ba3f2a220bcbe07eba3eed86f11066::my_game {
    struct Game has key {
        id: 0x2::object::UID,
        val: 0x2::balance::Balance<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::faucetcoin::FAUCETCOIN>,
        creator: 0x1::ascii::String,
    }

    struct Admin has key {
        id: 0x2::object::UID,
    }

    public entry fun add_coin(arg0: &mut Game, arg1: 0x2::coin::Coin<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::faucetcoin::FAUCETCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::faucetcoin::FAUCETCOIN>(&mut arg0.val, 0x2::coin::into_balance<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::faucetcoin::FAUCETCOIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id      : 0x2::object::new(arg0),
            val     : 0x2::balance::zero<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::faucetcoin::FAUCETCOIN>(),
            creator : 0x1::ascii::string(b"Ch1hiro"),
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Admin>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun play(arg0: &mut Game, arg1: bool, arg2: 0x2::coin::Coin<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::faucetcoin::FAUCETCOIN>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::faucetcoin::FAUCETCOIN>(&arg2);
        let v1 = 0x2::tx_context::sender(arg4);
        if (0x2::balance::value<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::faucetcoin::FAUCETCOIN>(&arg0.val) < v0) {
            abort 100
        };
        let v2 = 0x2::random::new_generator(arg3, arg4);
        if (arg1 == 0x2::random::generate_bool(&mut v2)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::faucetcoin::FAUCETCOIN>>(0x2::coin::from_balance<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::faucetcoin::FAUCETCOIN>(0x2::balance::split<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::faucetcoin::FAUCETCOIN>(&mut arg0.val, v0), arg4), v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::faucetcoin::FAUCETCOIN>>(arg2, v1);
        } else {
            0x2::balance::join<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::faucetcoin::FAUCETCOIN>(&mut arg0.val, 0x2::coin::into_balance<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::faucetcoin::FAUCETCOIN>(arg2));
        };
    }

    public entry fun remove_coin(arg0: &Admin, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::faucetcoin::FAUCETCOIN>>(0x2::coin::from_balance<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::faucetcoin::FAUCETCOIN>(0x2::balance::split<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::faucetcoin::FAUCETCOIN>(&mut arg1.val, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun split_coin<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::split<T0>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

