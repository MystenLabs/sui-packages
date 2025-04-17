module 0x30ec5f1b0b84bfb8f35c2d86574a044a21c60276339a74499b9148fb1a3f676d::swap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Swap has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin::TCOIN>,
        faucet_coin: 0x2::balance::Balance<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>,
    }

    public entry fun coin_to_faucet(arg0: &mut Swap, arg1: &mut 0x2::coin::Coin<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin::TCOIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin::TCOIN>(arg1) >= arg2, 102);
        let v0 = 0x2::balance::value<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin::TCOIN>(&arg0.coin);
        let v1 = 0x2::balance::value<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>(&arg0.faucet_coin);
        let v2 = v1 - v0 * v1 / (v0 + arg2);
        assert!(0x2::balance::value<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>(&arg0.faucet_coin) >= v2, 101);
        0x2::balance::join<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin::TCOIN>(&mut arg0.coin, 0x2::coin::into_balance<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin::TCOIN>(0x2::coin::split<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin::TCOIN>(arg1, arg2, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>>(0x2::coin::from_balance<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>(0x2::balance::split<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>(&mut arg0.faucet_coin, v2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun deposit(arg0: &AdminCap, arg1: &mut Swap, arg2: &mut 0x2::coin::Coin<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin::TCOIN>, arg3: u64, arg4: &mut 0x2::coin::Coin<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg3 > 0) {
            0x2::balance::join<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin::TCOIN>(&mut arg1.coin, 0x2::coin::into_balance<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin::TCOIN>(0x2::coin::split<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin::TCOIN>(arg2, arg3, arg6)));
        };
        if (arg5 > 0) {
            0x2::balance::join<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>(&mut arg1.faucet_coin, 0x2::coin::into_balance<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>(0x2::coin::split<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>(arg4, arg5, arg6)));
        };
    }

    public entry fun faucet_to_coin(arg0: &mut Swap, arg1: &mut 0x2::coin::Coin<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>(arg1) >= arg2, 102);
        let v0 = 0x2::balance::value<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin::TCOIN>(&arg0.coin);
        let v1 = 0x2::balance::value<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>(&arg0.faucet_coin);
        let v2 = v0 - v0 * v1 / (v1 + arg2);
        assert!(0x2::balance::value<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin::TCOIN>(&arg0.coin) >= v2, 100);
        0x2::balance::join<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>(&mut arg0.faucet_coin, 0x2::coin::into_balance<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>(0x2::coin::split<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>(arg1, arg2, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin::TCOIN>>(0x2::coin::from_balance<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin::TCOIN>(0x2::balance::split<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin::TCOIN>(&mut arg0.coin, v2), arg3), 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Swap{
            id          : 0x2::object::new(arg0),
            coin        : 0x2::balance::zero<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin::TCOIN>(),
            faucet_coin : 0x2::balance::zero<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>(),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Swap>(v1);
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut Swap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg2 > 0 && 0x2::balance::value<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin::TCOIN>(&arg1.coin) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin::TCOIN>>(0x2::coin::from_balance<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin::TCOIN>(0x2::balance::split<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin::TCOIN>(&mut arg1.coin, arg2), arg4), 0x2::tx_context::sender(arg4));
        };
        if (arg3 > 0 && 0x2::balance::value<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>(&arg1.faucet_coin) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>>(0x2::coin::from_balance<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>(0x2::balance::split<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>(&mut arg1.faucet_coin, arg3), arg4), 0x2::tx_context::sender(arg4));
        };
    }

    // decompiled from Move bytecode v6
}

