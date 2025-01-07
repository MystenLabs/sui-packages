module 0x76c5be08481759db8a418253eb5fba7c08b2615a94427dc801b375e667442c87::game {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct CryptoCtl_Game has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x595755e12a700673fd174e05eac9a6e22cfb5d202de027d5830c256bd20d5b3a::faucet_coin::FAUCET_COIN>,
    }

    struct GAME has drop {
        dummy_field: bool,
    }

    public entry fun deposit(arg0: &mut CryptoCtl_Game, arg1: &mut 0x2::coin::Coin<0x595755e12a700673fd174e05eac9a6e22cfb5d202de027d5830c256bd20d5b3a::faucet_coin::FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x595755e12a700673fd174e05eac9a6e22cfb5d202de027d5830c256bd20d5b3a::faucet_coin::FAUCET_COIN>(arg1) >= arg2, 1002);
        0x2::balance::join<0x595755e12a700673fd174e05eac9a6e22cfb5d202de027d5830c256bd20d5b3a::faucet_coin::FAUCET_COIN>(&mut arg0.balance, 0x2::coin::into_balance<0x595755e12a700673fd174e05eac9a6e22cfb5d202de027d5830c256bd20d5b3a::faucet_coin::FAUCET_COIN>(0x2::coin::split<0x595755e12a700673fd174e05eac9a6e22cfb5d202de027d5830c256bd20d5b3a::faucet_coin::FAUCET_COIN>(arg1, arg2, arg3)));
    }

    fun init(arg0: GAME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CryptoCtl_Game{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<0x595755e12a700673fd174e05eac9a6e22cfb5d202de027d5830c256bd20d5b3a::faucet_coin::FAUCET_COIN>(),
        };
        0x2::transfer::share_object<CryptoCtl_Game>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun play(arg0: &mut CryptoCtl_Game, arg1: &0x2::random::Random, arg2: bool, arg3: &mut 0x2::coin::Coin<0x595755e12a700673fd174e05eac9a6e22cfb5d202de027d5830c256bd20d5b3a::faucet_coin::FAUCET_COIN>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x595755e12a700673fd174e05eac9a6e22cfb5d202de027d5830c256bd20d5b3a::faucet_coin::FAUCET_COIN>(&arg0.balance) >= arg4, 1001);
        assert!(0x2::coin::value<0x595755e12a700673fd174e05eac9a6e22cfb5d202de027d5830c256bd20d5b3a::faucet_coin::FAUCET_COIN>(arg3) >= arg4, 1002);
        let v0 = 0x2::random::new_generator(arg1, arg5);
        if (0x2::random::generate_bool(&mut v0) == arg2) {
            0x2::coin::join<0x595755e12a700673fd174e05eac9a6e22cfb5d202de027d5830c256bd20d5b3a::faucet_coin::FAUCET_COIN>(arg3, 0x2::coin::take<0x595755e12a700673fd174e05eac9a6e22cfb5d202de027d5830c256bd20d5b3a::faucet_coin::FAUCET_COIN>(&mut arg0.balance, arg4, arg5));
        } else {
            deposit(arg0, arg3, arg4, arg5);
        };
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut CryptoCtl_Game, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x595755e12a700673fd174e05eac9a6e22cfb5d202de027d5830c256bd20d5b3a::faucet_coin::FAUCET_COIN>(&arg1.balance) >= arg2, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x595755e12a700673fd174e05eac9a6e22cfb5d202de027d5830c256bd20d5b3a::faucet_coin::FAUCET_COIN>>(0x2::coin::take<0x595755e12a700673fd174e05eac9a6e22cfb5d202de027d5830c256bd20d5b3a::faucet_coin::FAUCET_COIN>(&mut arg1.balance, arg2, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

