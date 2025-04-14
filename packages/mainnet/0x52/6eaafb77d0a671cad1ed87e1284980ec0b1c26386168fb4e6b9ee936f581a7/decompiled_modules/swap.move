module 0x526eaafb77d0a671cad1ed87e1284980ec0b1c26386168fb4e6b9ee936f581a7::swap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Swap has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::procarihana::PROCARIHANA>,
        faucet_coin: 0x2::balance::Balance<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>,
    }

    public entry fun coin_to_faucet(arg0: &mut Swap, arg1: &mut 0x2::coin::Coin<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::procarihana::PROCARIHANA>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::procarihana::PROCARIHANA>(arg1) >= arg2, 102);
        let v0 = 0x2::balance::value<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::procarihana::PROCARIHANA>(&arg0.coin);
        let v1 = 0x2::balance::value<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>(&arg0.faucet_coin);
        let v2 = v1 - v0 * v1 / (v0 + arg2);
        assert!(0x2::balance::value<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>(&arg0.faucet_coin) >= v2, 101);
        0x2::balance::join<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::procarihana::PROCARIHANA>(&mut arg0.coin, 0x2::coin::into_balance<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::procarihana::PROCARIHANA>(0x2::coin::split<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::procarihana::PROCARIHANA>(arg1, arg2, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>>(0x2::coin::from_balance<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>(0x2::balance::split<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>(&mut arg0.faucet_coin, v2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun faucet_to_coin(arg0: &mut Swap, arg1: &mut 0x2::coin::Coin<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>(arg1) >= arg2, 102);
        let v0 = 0x2::balance::value<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::procarihana::PROCARIHANA>(&arg0.coin);
        let v1 = 0x2::balance::value<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>(&arg0.faucet_coin);
        let v2 = v0 - v0 * v1 / (v1 + arg2);
        assert!(0x2::balance::value<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::procarihana::PROCARIHANA>(&arg0.coin) >= v2, 100);
        0x2::balance::join<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>(&mut arg0.faucet_coin, 0x2::coin::into_balance<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>(0x2::coin::split<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>(arg1, arg2, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::procarihana::PROCARIHANA>>(0x2::coin::from_balance<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::procarihana::PROCARIHANA>(0x2::balance::split<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::procarihana::PROCARIHANA>(&mut arg0.coin, v2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun get_coin(arg0: &AdminCap, arg1: &mut Swap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg2 > 0 && 0x2::balance::value<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::procarihana::PROCARIHANA>(&arg1.coin) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::procarihana::PROCARIHANA>>(0x2::coin::from_balance<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::procarihana::PROCARIHANA>(0x2::balance::split<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::procarihana::PROCARIHANA>(&mut arg1.coin, arg2), arg4), 0x2::tx_context::sender(arg4));
        };
        if (arg3 > 0 && 0x2::balance::value<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>(&arg1.faucet_coin) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>>(0x2::coin::from_balance<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>(0x2::balance::split<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>(&mut arg1.faucet_coin, arg3), arg4), 0x2::tx_context::sender(arg4));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Swap{
            id          : 0x2::object::new(arg0),
            coin        : 0x2::balance::zero<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::procarihana::PROCARIHANA>(),
            faucet_coin : 0x2::balance::zero<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>(),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Swap>(v1);
    }

    public entry fun save_coin(arg0: &AdminCap, arg1: &mut Swap, arg2: &mut 0x2::coin::Coin<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::procarihana::PROCARIHANA>, arg3: u64, arg4: &mut 0x2::coin::Coin<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg3 > 0) {
            0x2::balance::join<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::procarihana::PROCARIHANA>(&mut arg1.coin, 0x2::coin::into_balance<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::procarihana::PROCARIHANA>(0x2::coin::split<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::procarihana::PROCARIHANA>(arg2, arg3, arg6)));
        };
        if (arg5 > 0) {
            0x2::balance::join<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>(&mut arg1.faucet_coin, 0x2::coin::into_balance<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>(0x2::coin::split<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>(arg4, arg5, arg6)));
        };
    }

    // decompiled from Move bytecode v6
}

