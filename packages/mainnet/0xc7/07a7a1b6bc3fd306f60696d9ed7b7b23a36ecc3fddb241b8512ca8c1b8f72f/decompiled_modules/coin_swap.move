module 0xc707a7a1b6bc3fd306f60696d9ed7b7b23a36ecc3fddb241b8512ca8c1b8f72f::coin_swap {
    struct CoinSwap has key {
        id: 0x2::object::UID,
        coin_bal: 0x2::balance::Balance<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token::MY_TOKEN>,
        faucet_coin_bal: 0x2::balance::Balance<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>,
    }

    public entry fun desipot_my_faucet_token(arg0: &mut CoinSwap, arg1: 0x2::coin::Coin<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>) {
        0x2::balance::join<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>(&mut arg0.faucet_coin_bal, 0x2::coin::into_balance<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>(arg1));
    }

    public entry fun desipot_my_token(arg0: &mut CoinSwap, arg1: 0x2::coin::Coin<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token::MY_TOKEN>) {
        0x2::balance::join<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token::MY_TOKEN>(&mut arg0.coin_bal, 0x2::coin::into_balance<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token::MY_TOKEN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinSwap{
            id              : 0x2::object::new(arg0),
            coin_bal        : 0x2::balance::zero<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token::MY_TOKEN>(),
            faucet_coin_bal : 0x2::balance::zero<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>(),
        };
        0x2::transfer::share_object<CoinSwap>(v0);
    }

    public entry fun swap_faucet_to_token(arg0: &mut CoinSwap, arg1: &mut 0x2::coin::Coin<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2 / 2;
        assert!(v0 < 0x2::balance::value<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>(&arg0.faucet_coin_bal), 4369);
        0x2::balance::join<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>(&mut arg0.faucet_coin_bal, 0x2::balance::split<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>(0x2::coin::balance_mut<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>(arg1), arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>>(0x2::coin::take<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>(&mut arg0.faucet_coin_bal, v0, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_token_to_faucet(arg0: &mut CoinSwap, arg1: &mut 0x2::coin::Coin<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token::MY_TOKEN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 * 2 < 0x2::balance::value<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>(&arg0.faucet_coin_bal), 4369);
        0x2::balance::join<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token::MY_TOKEN>(&mut arg0.coin_bal, 0x2::balance::split<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token::MY_TOKEN>(0x2::coin::balance_mut<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token::MY_TOKEN>(arg1), arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>>(0x2::coin::take<0xd0ed551927a06ebc54ed5aaaf9e45ccf8b0c5ee1da96fdc91ecd90cea3ae1b0c::my_token_faucet::MY_TOKEN_FAUCET>(&mut arg0.faucet_coin_bal, arg2 * 2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

