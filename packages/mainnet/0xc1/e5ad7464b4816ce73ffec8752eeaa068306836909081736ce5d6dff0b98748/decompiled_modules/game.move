module 0xc1e5ad7464b4816ce73ffec8752eeaa068306836909081736ce5d6dff0b98748::game {
    struct Game has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>,
    }

    struct Admin has key {
        id: 0x2::object::UID,
    }

    public entry fun Deposit(arg0: &mut Game, arg1: &mut 0x2::coin::Coin<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>, arg2: u64) {
        assert!(0x2::coin::value<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>(arg1) >= arg2, 1000);
        0x2::balance::join<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>(&mut arg0.balance, 0x2::balance::split<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>(0x2::coin::balance_mut<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>(arg1), arg2));
    }

    public entry fun Play(arg0: &mut Game, arg1: &0x2::random::Random, arg2: bool, arg3: &mut 0x2::coin::Coin<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>(&arg0.balance) >= 2 * arg4, 1001);
        assert!(0x2::coin::value<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>(arg3) >= arg4, 1000);
        let v0 = 0x2::random::new_generator(arg1, arg5);
        if (0x2::random::generate_bool(&mut v0) == arg2) {
            0x2::coin::join<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>(arg3, 0x2::coin::take<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>(&mut arg0.balance, 2 * arg4, arg5));
            0x1::string::utf8(b"Veincealan is sad because you won the game and took the prize money.");
        } else {
            Deposit(arg0, arg3, arg4);
            0x1::string::utf8(b"Veincealan is happy because you lost your principal.");
        };
    }

    public entry fun Withdraw(arg0: &mut Game, arg1: &Admin, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>(&arg0.balance) >= arg2, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>>(0x2::coin::take<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>(&mut arg0.balance, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>(),
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Admin>(v1, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

