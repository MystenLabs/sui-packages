module 0x6c3e1daf8f647f4f36d9b5b48b6504eb79119bbaf390418da018a5af97ce2d3d::swap_greyhao {
    struct SwapPool has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaocoin::GREYHAOCOIN>,
        faucet_coin: 0x2::balance::Balance<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>,
    }

    struct Admin has key {
        id: 0x2::object::UID,
    }

    public entry fun add_coin_to_pool(arg0: &mut SwapPool, arg1: &mut 0x2::coin::Coin<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaocoin::GREYHAOCOIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaocoin::GREYHAOCOIN>(&mut arg0.coin, 0x2::coin::into_balance<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaocoin::GREYHAOCOIN>(0x2::coin::split<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaocoin::GREYHAOCOIN>(arg1, arg2, arg3)));
    }

    public entry fun add_faucet_to_pool(arg0: &mut SwapPool, arg1: &mut 0x2::coin::Coin<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>(&mut arg0.faucet_coin, 0x2::coin::into_balance<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>(0x2::coin::split<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>(arg1, arg2, arg3)));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SwapPool{
            id          : 0x2::object::new(arg0),
            coin        : 0x2::balance::zero<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaocoin::GREYHAOCOIN>(),
            faucet_coin : 0x2::balance::zero<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>(),
        };
        0x2::transfer::share_object<SwapPool>(v0);
        let v1 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Admin>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_to_coin(arg0: &mut SwapPool, arg1: &mut 0x2::coin::Coin<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>(arg1) >= arg2, 1);
        let v0 = arg2 / 5;
        assert!(0x2::balance::value<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaocoin::GREYHAOCOIN>(&arg0.coin) >= v0, 0);
        0x2::balance::join<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>(&mut arg0.faucet_coin, 0x2::coin::into_balance<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>(0x2::coin::split<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>(arg1, arg2, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaocoin::GREYHAOCOIN>>(0x2::coin::from_balance<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaocoin::GREYHAOCOIN>(0x2::balance::split<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaocoin::GREYHAOCOIN>(&mut arg0.coin, v0), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_to_faucet(arg0: &mut SwapPool, arg1: &mut 0x2::coin::Coin<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaocoin::GREYHAOCOIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaocoin::GREYHAOCOIN>(arg1) >= arg2, 1);
        let v0 = arg2 * 5;
        assert!(0x2::balance::value<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>(&arg0.faucet_coin) >= v0, 0);
        0x2::balance::join<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaocoin::GREYHAOCOIN>(&mut arg0.coin, 0x2::coin::into_balance<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaocoin::GREYHAOCOIN>(0x2::coin::split<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaocoin::GREYHAOCOIN>(arg1, arg2, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>>(0x2::coin::from_balance<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>(0x2::balance::split<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>(&mut arg0.faucet_coin, v0), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_coin_from_pool(arg0: &Admin, arg1: &mut SwapPool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaocoin::GREYHAOCOIN>(&arg1.coin) >= arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaocoin::GREYHAOCOIN>>(0x2::coin::from_balance<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaocoin::GREYHAOCOIN>(0x2::balance::split<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaocoin::GREYHAOCOIN>(&mut arg1.coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_faucet_from_pool(arg0: &Admin, arg1: &mut SwapPool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>(&arg1.faucet_coin) >= arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>>(0x2::coin::from_balance<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>(0x2::balance::split<0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet::GREYHAOFAUCET>(&mut arg1.faucet_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

