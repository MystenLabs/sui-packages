module 0x623488bbc4a367bf15063ffa3b1eab35dd9f050fcf8998e77e09a8f831b4a80f::game {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct GamePool has key {
        id: 0x2::object::UID,
        amount: 0x2::balance::Balance<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>,
    }

    public entry fun get_coin(arg0: &AdminCap, arg1: &mut GamePool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 0x2::balance::value<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>(&arg1.amount), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>>(0x2::coin::from_balance<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>(0x2::balance::split<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>(&mut arg1.amount, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GamePool{
            id     : 0x2::object::new(arg0),
            amount : 0x2::balance::zero<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>(),
        };
        0x2::transfer::share_object<GamePool>(v1);
    }

    public entry fun play(arg0: &mut 0x2::coin::Coin<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>, arg1: &mut GamePool, arg2: bool, arg3: &0x2::random::Random, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>(arg0) > arg4, 2);
        assert!(arg4 <= 0x2::balance::value<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>(&arg1.amount), 1);
        let v0 = 0x2::random::new_generator(arg3, arg5);
        if (0x2::random::generate_bool(&mut v0) == arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>>(0x2::coin::from_balance<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>(0x2::balance::split<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>(&mut arg1.amount, arg4), arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::join<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>(&mut arg1.amount, 0x2::coin::into_balance<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>(0x2::coin::split<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>(arg0, arg4, arg5)));
        };
    }

    public entry fun save_coin(arg0: &AdminCap, arg1: &mut 0x2::coin::Coin<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>, arg2: &mut GamePool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>(arg1) > arg3, 2);
        0x2::balance::join<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>(&mut arg2.amount, 0x2::coin::into_balance<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>(0x2::coin::split<0xfb3e9a93cf5c3eea461acc619ed4ae8cf45484cb51a10dcca4bb591191c0768e::faucet_procarihana::FAUCET_PROCARIHANA>(arg1, arg3, arg4)));
    }

    // decompiled from Move bytecode v6
}

