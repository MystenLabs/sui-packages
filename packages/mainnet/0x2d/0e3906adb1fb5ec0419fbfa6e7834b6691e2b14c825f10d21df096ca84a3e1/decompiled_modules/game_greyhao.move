module 0x2d0e3906adb1fb5ec0419fbfa6e7834b6691e2b14c825f10d21df096ca84a3e1::game_greyhao {
    struct Game has key {
        id: 0x2::object::UID,
        pool_amount: 0x2::balance::Balance<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>,
    }

    struct Admin has key {
        id: 0x2::object::UID,
    }

    public entry fun addCoinToGamePool(arg0: &mut Game, arg1: &mut 0x2::coin::Coin<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 0x2::coin::value<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>(arg1), 257);
        0x2::balance::join<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>(&mut arg0.pool_amount, 0x2::balance::split<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>(0x2::coin::balance_mut<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>(arg1), arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id          : 0x2::object::new(arg0),
            pool_amount : 0x2::balance::zero<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>(),
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Admin>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun play(arg0: &mut Game, arg1: &0x2::random::Random, arg2: u8, arg3: &mut 0x2::coin::Coin<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>(&arg0.pool_amount) >= arg4 * 3, 257);
        assert!(0x2::balance::value<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>(0x2::coin::balance<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>(arg3)) >= arg4, 257);
        let v0 = 0x2::random::new_generator(arg1, arg5);
        if (0x2::random::generate_u8_in_range(&mut v0, 1, 6) == arg2) {
            0x2::coin::join<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>(arg3, 0x2::coin::take<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>(&mut arg0.pool_amount, arg4, arg5));
        } else {
            addCoinToGamePool(arg0, arg3, arg4, arg5);
        };
    }

    public entry fun removeCoinFromGamePool(arg0: &Admin, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>(&arg1.pool_amount) >= arg2, 257);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>>(0x2::coin::take<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>(&mut arg1.pool_amount, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

