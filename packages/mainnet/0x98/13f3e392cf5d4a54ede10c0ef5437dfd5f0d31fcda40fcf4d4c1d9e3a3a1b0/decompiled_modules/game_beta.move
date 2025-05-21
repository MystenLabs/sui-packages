module 0x9813f3e392cf5d4a54ede10c0ef5437dfd5f0d31fcda40fcf4d4c1d9e3a3a1b0::game_beta {
    struct FlipGame has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>,
    }

    struct Admin has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    public entry fun Deposit(arg0: &mut FlipGame, arg1: &mut 0x2::coin::Coin<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>(arg1) >= arg2, 1000);
        0x2::balance::join<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>(&mut arg0.balance, 0x2::coin::into_balance<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>(0x2::coin::split<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>(arg1, arg2, arg3)));
    }

    entry fun Play(arg0: &mut FlipGame, arg1: &0x2::random::Random, arg2: bool, arg3: &mut 0x2::coin::Coin<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>(&arg0.balance) >= arg4, 1001);
        assert!(0x2::coin::value<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>(arg3) >= arg4, 1000);
        assert!(arg4 * 10 <= 0x2::balance::value<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>(&arg0.balance), 1001);
        let v0 = 0x2::random::new_generator(arg1, arg5);
        if (0x2::random::generate_u8(&mut v0) % 2 == 0 == arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>>(0x2::coin::from_balance<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>(0x2::balance::split<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>(&mut arg0.balance, arg4), arg5), 0x2::tx_context::sender(arg5));
        } else {
            Deposit(arg0, arg3, arg4, arg5);
        };
    }

    public entry fun Withdraw(arg0: &mut FlipGame, arg1: &Admin, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>(&arg0.balance) >= arg2, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>>(0x2::coin::from_balance<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>(0x2::balance::split<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>(&mut arg0.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FlipGame{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x554024c1b70d9cd4b6b03a9ff2a9a6eab8b887dace637ec423001b2383509192::oiia_faucet::OIIA_FAUCET>(),
        };
        let v1 = Admin{
            id   : 0x2::object::new(arg0),
            name : 0x1::string::utf8(b"SherVite"),
        };
        0x2::transfer::transfer<Admin>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<FlipGame>(v0);
    }

    // decompiled from Move bytecode v6
}

