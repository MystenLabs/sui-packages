module 0xefef43e6ce1e42e17c9f4d3a209217e6aa25ffa040edd4b1cc5425dc2e1c348c::swap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Swap has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia::OIIA>,
        faucet_coin: 0x2::balance::Balance<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>,
    }

    public entry fun coin_to_faucet(arg0: &mut Swap, arg1: &mut 0x2::coin::Coin<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia::OIIA>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia::OIIA>(arg1) >= arg2, 102);
        let v0 = 0x2::balance::value<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia::OIIA>(&arg0.coin);
        let v1 = 0x2::balance::value<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>(&arg0.faucet_coin);
        let v2 = v1 - v0 * v1 / (v0 + arg2);
        assert!(0x2::balance::value<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>(&arg0.faucet_coin) >= v2, 101);
        0x2::balance::join<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia::OIIA>(&mut arg0.coin, 0x2::coin::into_balance<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia::OIIA>(0x2::coin::split<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia::OIIA>(arg1, arg2, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>>(0x2::coin::from_balance<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>(0x2::balance::split<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>(&mut arg0.faucet_coin, v2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun deposit(arg0: &AdminCap, arg1: &mut Swap, arg2: &mut 0x2::coin::Coin<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia::OIIA>, arg3: u64, arg4: &mut 0x2::coin::Coin<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg3 > 0) {
            0x2::balance::join<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia::OIIA>(&mut arg1.coin, 0x2::coin::into_balance<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia::OIIA>(0x2::coin::split<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia::OIIA>(arg2, arg3, arg6)));
        };
        if (arg5 > 0) {
            0x2::balance::join<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>(&mut arg1.faucet_coin, 0x2::coin::into_balance<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>(0x2::coin::split<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>(arg4, arg5, arg6)));
        };
    }

    public entry fun faucet_to_coin(arg0: &mut Swap, arg1: &mut 0x2::coin::Coin<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>(arg1) >= arg2, 102);
        let v0 = 0x2::balance::value<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia::OIIA>(&arg0.coin);
        let v1 = 0x2::balance::value<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>(&arg0.faucet_coin);
        let v2 = v0 - v0 * v1 / (v1 + arg2);
        assert!(0x2::balance::value<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia::OIIA>(&arg0.coin) >= v2, 100);
        0x2::balance::join<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>(&mut arg0.faucet_coin, 0x2::coin::into_balance<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>(0x2::coin::split<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>(arg1, arg2, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia::OIIA>>(0x2::coin::from_balance<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia::OIIA>(0x2::balance::split<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia::OIIA>(&mut arg0.coin, v2), arg3), 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Swap{
            id          : 0x2::object::new(arg0),
            coin        : 0x2::balance::zero<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia::OIIA>(),
            faucet_coin : 0x2::balance::zero<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>(),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Swap>(v1);
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut Swap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg2 > 0 && 0x2::balance::value<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia::OIIA>(&arg1.coin) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia::OIIA>>(0x2::coin::from_balance<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia::OIIA>(0x2::balance::split<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia::OIIA>(&mut arg1.coin, arg2), arg4), 0x2::tx_context::sender(arg4));
        };
        if (arg3 > 0 && 0x2::balance::value<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>(&arg1.faucet_coin) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>>(0x2::coin::from_balance<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>(0x2::balance::split<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>(&mut arg1.faucet_coin, arg3), arg4), 0x2::tx_context::sender(arg4));
        };
    }

    // decompiled from Move bytecode v6
}

