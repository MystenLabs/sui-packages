module 0x7d0f272a7adb29ef6f79cf4d8ef702795c74cdf041342c1bbd43d982fc36b3dc::coin_swap {
    struct CoinSwap has key {
        id: 0x2::object::UID,
        coin_bal: 0x2::balance::Balance<0xc33104fcf22a2ef5e2736a698104fb82436b4c3f70fdc2f2bfa6b2c383c9c532::my_token::MY_TOKEN>,
        faucet_coin_bal: 0x2::balance::Balance<0xc33104fcf22a2ef5e2736a698104fb82436b4c3f70fdc2f2bfa6b2c383c9c532::my_token_faucet::MY_TOKEN_FAUCET>,
    }

    public entry fun desipot_my_faucet_token(arg0: &mut CoinSwap, arg1: 0x2::coin::Coin<0xc33104fcf22a2ef5e2736a698104fb82436b4c3f70fdc2f2bfa6b2c383c9c532::my_token_faucet::MY_TOKEN_FAUCET>) {
        0x2::balance::join<0xc33104fcf22a2ef5e2736a698104fb82436b4c3f70fdc2f2bfa6b2c383c9c532::my_token_faucet::MY_TOKEN_FAUCET>(&mut arg0.faucet_coin_bal, 0x2::coin::into_balance<0xc33104fcf22a2ef5e2736a698104fb82436b4c3f70fdc2f2bfa6b2c383c9c532::my_token_faucet::MY_TOKEN_FAUCET>(arg1));
    }

    public entry fun desipot_my_token(arg0: &mut CoinSwap, arg1: 0x2::coin::Coin<0xc33104fcf22a2ef5e2736a698104fb82436b4c3f70fdc2f2bfa6b2c383c9c532::my_token::MY_TOKEN>) {
        0x2::balance::join<0xc33104fcf22a2ef5e2736a698104fb82436b4c3f70fdc2f2bfa6b2c383c9c532::my_token::MY_TOKEN>(&mut arg0.coin_bal, 0x2::coin::into_balance<0xc33104fcf22a2ef5e2736a698104fb82436b4c3f70fdc2f2bfa6b2c383c9c532::my_token::MY_TOKEN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinSwap{
            id              : 0x2::object::new(arg0),
            coin_bal        : 0x2::balance::zero<0xc33104fcf22a2ef5e2736a698104fb82436b4c3f70fdc2f2bfa6b2c383c9c532::my_token::MY_TOKEN>(),
            faucet_coin_bal : 0x2::balance::zero<0xc33104fcf22a2ef5e2736a698104fb82436b4c3f70fdc2f2bfa6b2c383c9c532::my_token_faucet::MY_TOKEN_FAUCET>(),
        };
        0x2::transfer::share_object<CoinSwap>(v0);
    }

    public entry fun swap_faucet_to_token(arg0: &mut CoinSwap, arg1: &mut 0x2::coin::Coin<0xc33104fcf22a2ef5e2736a698104fb82436b4c3f70fdc2f2bfa6b2c383c9c532::my_token_faucet::MY_TOKEN_FAUCET>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2 / 2;
        assert!(v0 < 0x2::balance::value<0xc33104fcf22a2ef5e2736a698104fb82436b4c3f70fdc2f2bfa6b2c383c9c532::my_token_faucet::MY_TOKEN_FAUCET>(&arg0.faucet_coin_bal), 4369);
        0x2::balance::join<0xc33104fcf22a2ef5e2736a698104fb82436b4c3f70fdc2f2bfa6b2c383c9c532::my_token_faucet::MY_TOKEN_FAUCET>(&mut arg0.faucet_coin_bal, 0x2::balance::split<0xc33104fcf22a2ef5e2736a698104fb82436b4c3f70fdc2f2bfa6b2c383c9c532::my_token_faucet::MY_TOKEN_FAUCET>(0x2::coin::balance_mut<0xc33104fcf22a2ef5e2736a698104fb82436b4c3f70fdc2f2bfa6b2c383c9c532::my_token_faucet::MY_TOKEN_FAUCET>(arg1), arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc33104fcf22a2ef5e2736a698104fb82436b4c3f70fdc2f2bfa6b2c383c9c532::my_token_faucet::MY_TOKEN_FAUCET>>(0x2::coin::take<0xc33104fcf22a2ef5e2736a698104fb82436b4c3f70fdc2f2bfa6b2c383c9c532::my_token_faucet::MY_TOKEN_FAUCET>(&mut arg0.faucet_coin_bal, v0, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_token_to_faucet(arg0: &mut CoinSwap, arg1: &mut 0x2::coin::Coin<0xc33104fcf22a2ef5e2736a698104fb82436b4c3f70fdc2f2bfa6b2c383c9c532::my_token::MY_TOKEN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 * 2 < 0x2::balance::value<0xc33104fcf22a2ef5e2736a698104fb82436b4c3f70fdc2f2bfa6b2c383c9c532::my_token_faucet::MY_TOKEN_FAUCET>(&arg0.faucet_coin_bal), 4369);
        0x2::balance::join<0xc33104fcf22a2ef5e2736a698104fb82436b4c3f70fdc2f2bfa6b2c383c9c532::my_token::MY_TOKEN>(&mut arg0.coin_bal, 0x2::balance::split<0xc33104fcf22a2ef5e2736a698104fb82436b4c3f70fdc2f2bfa6b2c383c9c532::my_token::MY_TOKEN>(0x2::coin::balance_mut<0xc33104fcf22a2ef5e2736a698104fb82436b4c3f70fdc2f2bfa6b2c383c9c532::my_token::MY_TOKEN>(arg1), arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc33104fcf22a2ef5e2736a698104fb82436b4c3f70fdc2f2bfa6b2c383c9c532::my_token_faucet::MY_TOKEN_FAUCET>>(0x2::coin::take<0xc33104fcf22a2ef5e2736a698104fb82436b4c3f70fdc2f2bfa6b2c383c9c532::my_token_faucet::MY_TOKEN_FAUCET>(&mut arg0.faucet_coin_bal, arg2 * 2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

