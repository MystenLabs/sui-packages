module 0x402665d84cff26f8977a99495c299f7fa47913079b96aad45dd665b75186a0db::game_demo {
    struct FlipGame has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x659c9d2eada860b6c0b6e93b7735563a32a4aa6a57317c661d46bb63d71252a7::betheldev_faucetcoin::BETHELDEV_FAUCETCOIN>,
    }

    struct Admin has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    public entry fun Deposit(arg0: &mut FlipGame, arg1: &mut 0x2::coin::Coin<0x659c9d2eada860b6c0b6e93b7735563a32a4aa6a57317c661d46bb63d71252a7::betheldev_faucetcoin::BETHELDEV_FAUCETCOIN>, arg2: u64) {
        assert!(0x2::coin::value<0x659c9d2eada860b6c0b6e93b7735563a32a4aa6a57317c661d46bb63d71252a7::betheldev_faucetcoin::BETHELDEV_FAUCETCOIN>(arg1) >= arg2, 1000);
        0x2::balance::join<0x659c9d2eada860b6c0b6e93b7735563a32a4aa6a57317c661d46bb63d71252a7::betheldev_faucetcoin::BETHELDEV_FAUCETCOIN>(&mut arg0.balance, 0x2::balance::split<0x659c9d2eada860b6c0b6e93b7735563a32a4aa6a57317c661d46bb63d71252a7::betheldev_faucetcoin::BETHELDEV_FAUCETCOIN>(0x2::coin::balance_mut<0x659c9d2eada860b6c0b6e93b7735563a32a4aa6a57317c661d46bb63d71252a7::betheldev_faucetcoin::BETHELDEV_FAUCETCOIN>(arg1), arg2));
    }

    entry fun Play(arg0: &mut FlipGame, arg1: &0x2::random::Random, arg2: bool, arg3: &mut 0x2::coin::Coin<0x659c9d2eada860b6c0b6e93b7735563a32a4aa6a57317c661d46bb63d71252a7::betheldev_faucetcoin::BETHELDEV_FAUCETCOIN>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x659c9d2eada860b6c0b6e93b7735563a32a4aa6a57317c661d46bb63d71252a7::betheldev_faucetcoin::BETHELDEV_FAUCETCOIN>(&arg0.balance) >= arg4, 1001);
        assert!(0x2::coin::value<0x659c9d2eada860b6c0b6e93b7735563a32a4aa6a57317c661d46bb63d71252a7::betheldev_faucetcoin::BETHELDEV_FAUCETCOIN>(arg3) >= arg4, 1000);
        assert!(arg4 * 10 <= 0x2::balance::value<0x659c9d2eada860b6c0b6e93b7735563a32a4aa6a57317c661d46bb63d71252a7::betheldev_faucetcoin::BETHELDEV_FAUCETCOIN>(&arg0.balance), 1001);
        let v0 = 0x2::random::new_generator(arg1, arg5);
        if (0x2::random::generate_bool(&mut v0) == arg2) {
            0x2::coin::join<0x659c9d2eada860b6c0b6e93b7735563a32a4aa6a57317c661d46bb63d71252a7::betheldev_faucetcoin::BETHELDEV_FAUCETCOIN>(arg3, 0x2::coin::take<0x659c9d2eada860b6c0b6e93b7735563a32a4aa6a57317c661d46bb63d71252a7::betheldev_faucetcoin::BETHELDEV_FAUCETCOIN>(&mut arg0.balance, arg4, arg5));
        } else {
            Deposit(arg0, arg3, arg4);
        };
    }

    public entry fun Withdraw(arg0: &mut FlipGame, arg1: &Admin, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x659c9d2eada860b6c0b6e93b7735563a32a4aa6a57317c661d46bb63d71252a7::betheldev_faucetcoin::BETHELDEV_FAUCETCOIN>(&arg0.balance) >= arg2, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x659c9d2eada860b6c0b6e93b7735563a32a4aa6a57317c661d46bb63d71252a7::betheldev_faucetcoin::BETHELDEV_FAUCETCOIN>>(0x2::coin::take<0x659c9d2eada860b6c0b6e93b7735563a32a4aa6a57317c661d46bb63d71252a7::betheldev_faucetcoin::BETHELDEV_FAUCETCOIN>(&mut arg0.balance, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FlipGame{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x659c9d2eada860b6c0b6e93b7735563a32a4aa6a57317c661d46bb63d71252a7::betheldev_faucetcoin::BETHELDEV_FAUCETCOIN>(),
        };
        let v1 = Admin{
            id   : 0x2::object::new(arg0),
            name : 0x1::string::utf8(b"BethelDEV"),
        };
        0x2::transfer::transfer<Admin>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<FlipGame>(v0);
    }

    // decompiled from Move bytecode v6
}

