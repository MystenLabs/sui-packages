module 0xd484b1f66014036a2a30727e45f9ef4a163d62f63a8ea123e8f1b1ea95e733e8::my_swap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        iusd: 0x2::balance::Balance<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd::IUSD>,
        iusd_Faucet: 0x2::balance::Balance<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>,
    }

    public entry fun deposit_faucet_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>(&arg1);
        assert!(v0 >= arg2, 1000);
        let v1 = 0x2::coin::into_balance<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>(arg1);
        if (v0 == arg2) {
            0x2::balance::join<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>(&mut arg0.iusd_Faucet, v1);
        } else {
            0x2::balance::join<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>(&mut arg0.iusd_Faucet, 0x2::balance::split<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>(&mut v1, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>>(0x2::coin::from_balance<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>(v1, arg3), 0x2::tx_context::sender(arg3));
        };
    }

    public entry fun deposit_my_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd::IUSD>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd::IUSD>(&arg1);
        assert!(v0 >= arg2, 1000);
        let v1 = 0x2::coin::into_balance<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd::IUSD>(arg1);
        if (v0 == arg2) {
            0x2::balance::join<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd::IUSD>(&mut arg0.iusd, v1);
        } else {
            0x2::balance::join<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd::IUSD>(&mut arg0.iusd, 0x2::balance::split<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd::IUSD>(&mut v1, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd::IUSD>>(0x2::coin::from_balance<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd::IUSD>(v1, arg3), 0x2::tx_context::sender(arg3));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id          : 0x2::object::new(arg0),
            iusd        : 0x2::balance::zero<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd::IUSD>(),
            iusd_Faucet : 0x2::balance::zero<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>(),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Pool>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_faucet_coin_to_my_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2 * 1000 / 2000;
        assert!(0x2::balance::value<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd::IUSD>(&arg0.iusd) >= v0, 1001);
        deposit_faucet_coin(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd::IUSD>>(0x2::coin::from_balance<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd::IUSD>(0x2::balance::split<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd::IUSD>(&mut arg0.iusd, v0), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_my_coin_to_faucet_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd::IUSD>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2 * 2000 / 1000;
        assert!(0x2::balance::value<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>(&arg0.iusd_Faucet) >= v0, 1001);
        deposit_my_coin(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>>(0x2::coin::from_balance<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>(0x2::balance::split<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>(&mut arg0.iusd_Faucet, v0), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_coin(arg0: &AdminCap, arg1: &mut Pool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd::IUSD>(&arg1.iusd) >= arg2, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd::IUSD>>(0x2::coin::from_balance<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd::IUSD>(0x2::balance::split<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd::IUSD>(&mut arg1.iusd, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_faucet_coin(arg0: &AdminCap, arg1: &mut Pool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>(&arg1.iusd_Faucet) >= arg2, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>>(0x2::coin::from_balance<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>(0x2::balance::split<0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet::IUSD_FAUCET>(&mut arg1.iusd_Faucet, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

