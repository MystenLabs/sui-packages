module 0x3fb5d5b05557c3fe832c720dec96c6f6f622879fa0586b5c8b5eb8252e3f2dbc::hwen_swap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct MySwap has key {
        id: 0x2::object::UID,
        hwen_coin: 0x2::balance::Balance<0x25c077dd399fe7d9a18271df29ea6b4922782d64f6aee06e218c0af9586546b::hwen_coin::HWEN_COIN>,
        faucet_coin: 0x2::balance::Balance<0xc4a538a0f477051636e06e2cea07a179f5a62e8125ed1eef92fa84993eb729ac::hwen_faucet_coin::HWEN_FAUCET_COIN>,
    }

    public entry fun deposit_faucet_coin(arg0: &mut MySwap, arg1: 0x2::coin::Coin<0xc4a538a0f477051636e06e2cea07a179f5a62e8125ed1eef92fa84993eb729ac::hwen_faucet_coin::HWEN_FAUCET_COIN>) {
        0x2::balance::join<0xc4a538a0f477051636e06e2cea07a179f5a62e8125ed1eef92fa84993eb729ac::hwen_faucet_coin::HWEN_FAUCET_COIN>(&mut arg0.faucet_coin, 0x2::coin::into_balance<0xc4a538a0f477051636e06e2cea07a179f5a62e8125ed1eef92fa84993eb729ac::hwen_faucet_coin::HWEN_FAUCET_COIN>(arg1));
    }

    entry fun deposit_hwen_coin(arg0: &mut MySwap, arg1: 0x2::coin::Coin<0x25c077dd399fe7d9a18271df29ea6b4922782d64f6aee06e218c0af9586546b::hwen_coin::HWEN_COIN>) {
        0x2::balance::join<0x25c077dd399fe7d9a18271df29ea6b4922782d64f6aee06e218c0af9586546b::hwen_coin::HWEN_COIN>(&mut arg0.hwen_coin, 0x2::coin::into_balance<0x25c077dd399fe7d9a18271df29ea6b4922782d64f6aee06e218c0af9586546b::hwen_coin::HWEN_COIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = MySwap{
            id          : 0x2::object::new(arg0),
            hwen_coin   : 0x2::balance::zero<0x25c077dd399fe7d9a18271df29ea6b4922782d64f6aee06e218c0af9586546b::hwen_coin::HWEN_COIN>(),
            faucet_coin : 0x2::balance::zero<0xc4a538a0f477051636e06e2cea07a179f5a62e8125ed1eef92fa84993eb729ac::hwen_faucet_coin::HWEN_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<MySwap>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun swap_faucet_to_hwen(arg0: &mut MySwap, arg1: 0x2::coin::Coin<0xc4a538a0f477051636e06e2cea07a179f5a62e8125ed1eef92fa84993eb729ac::hwen_faucet_coin::HWEN_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xc4a538a0f477051636e06e2cea07a179f5a62e8125ed1eef92fa84993eb729ac::hwen_faucet_coin::HWEN_FAUCET_COIN>(&mut arg0.faucet_coin, 0x2::coin::into_balance<0xc4a538a0f477051636e06e2cea07a179f5a62e8125ed1eef92fa84993eb729ac::hwen_faucet_coin::HWEN_FAUCET_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x25c077dd399fe7d9a18271df29ea6b4922782d64f6aee06e218c0af9586546b::hwen_coin::HWEN_COIN>>(0x2::coin::from_balance<0x25c077dd399fe7d9a18271df29ea6b4922782d64f6aee06e218c0af9586546b::hwen_coin::HWEN_COIN>(0x2::balance::split<0x25c077dd399fe7d9a18271df29ea6b4922782d64f6aee06e218c0af9586546b::hwen_coin::HWEN_COIN>(&mut arg0.hwen_coin, 0x2::coin::value<0xc4a538a0f477051636e06e2cea07a179f5a62e8125ed1eef92fa84993eb729ac::hwen_faucet_coin::HWEN_FAUCET_COIN>(&arg1) / 2), arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun swap_hwen_to_faucet(arg0: &mut MySwap, arg1: 0x2::coin::Coin<0x25c077dd399fe7d9a18271df29ea6b4922782d64f6aee06e218c0af9586546b::hwen_coin::HWEN_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x25c077dd399fe7d9a18271df29ea6b4922782d64f6aee06e218c0af9586546b::hwen_coin::HWEN_COIN>(&mut arg0.hwen_coin, 0x2::coin::into_balance<0x25c077dd399fe7d9a18271df29ea6b4922782d64f6aee06e218c0af9586546b::hwen_coin::HWEN_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc4a538a0f477051636e06e2cea07a179f5a62e8125ed1eef92fa84993eb729ac::hwen_faucet_coin::HWEN_FAUCET_COIN>>(0x2::coin::from_balance<0xc4a538a0f477051636e06e2cea07a179f5a62e8125ed1eef92fa84993eb729ac::hwen_faucet_coin::HWEN_FAUCET_COIN>(0x2::balance::split<0xc4a538a0f477051636e06e2cea07a179f5a62e8125ed1eef92fa84993eb729ac::hwen_faucet_coin::HWEN_FAUCET_COIN>(&mut arg0.faucet_coin, 0x2::coin::value<0x25c077dd399fe7d9a18271df29ea6b4922782d64f6aee06e218c0af9586546b::hwen_coin::HWEN_COIN>(&arg1) * 2), arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun withdraw_faucet_coin(arg0: &AdminCap, arg1: &mut MySwap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc4a538a0f477051636e06e2cea07a179f5a62e8125ed1eef92fa84993eb729ac::hwen_faucet_coin::HWEN_FAUCET_COIN>>(0x2::coin::from_balance<0xc4a538a0f477051636e06e2cea07a179f5a62e8125ed1eef92fa84993eb729ac::hwen_faucet_coin::HWEN_FAUCET_COIN>(0x2::balance::split<0xc4a538a0f477051636e06e2cea07a179f5a62e8125ed1eef92fa84993eb729ac::hwen_faucet_coin::HWEN_FAUCET_COIN>(&mut arg1.faucet_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_hwen_coin(arg0: &AdminCap, arg1: &mut MySwap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x25c077dd399fe7d9a18271df29ea6b4922782d64f6aee06e218c0af9586546b::hwen_coin::HWEN_COIN>>(0x2::coin::from_balance<0x25c077dd399fe7d9a18271df29ea6b4922782d64f6aee06e218c0af9586546b::hwen_coin::HWEN_COIN>(0x2::balance::split<0x25c077dd399fe7d9a18271df29ea6b4922782d64f6aee06e218c0af9586546b::hwen_coin::HWEN_COIN>(&mut arg1.hwen_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

