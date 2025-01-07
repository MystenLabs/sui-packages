module 0x440e4f33eab2cc50852e7b6467b88d038a836daeb79313954e563f29645a7062::task5 {
    struct LiquidityEvent has copy, drop {
        provider: address,
        coin_a_amount: u64,
        coin_b_amount: u64,
        coin_a_type: 0x1::string::String,
        coin_b_type: 0x1::string::String,
        timestamp: u64,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<0xb3743a94cbc755521c27fb5d91e2c8b34ea5b0df899654c20d2f965d301bb7dd::faucet_coin::FAUCET_COIN>,
        coin_b: 0x2::balance::Balance<0xc1c3bc0379fb47eb69add8e7ea01acd42eaa65f6bb7ac5dcf2b5faa235dbd126::mycoin::MYCOIN>,
    }

    public entry fun add_liquidity(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xb3743a94cbc755521c27fb5d91e2c8b34ea5b0df899654c20d2f965d301bb7dd::faucet_coin::FAUCET_COIN>, arg2: 0x2::coin::Coin<0xc1c3bc0379fb47eb69add8e7ea01acd42eaa65f6bb7ac5dcf2b5faa235dbd126::mycoin::MYCOIN>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xb3743a94cbc755521c27fb5d91e2c8b34ea5b0df899654c20d2f965d301bb7dd::faucet_coin::FAUCET_COIN>(&mut arg0.coin_a, 0x2::coin::into_balance<0xb3743a94cbc755521c27fb5d91e2c8b34ea5b0df899654c20d2f965d301bb7dd::faucet_coin::FAUCET_COIN>(arg1));
        0x2::balance::join<0xc1c3bc0379fb47eb69add8e7ea01acd42eaa65f6bb7ac5dcf2b5faa235dbd126::mycoin::MYCOIN>(&mut arg0.coin_b, 0x2::coin::into_balance<0xc1c3bc0379fb47eb69add8e7ea01acd42eaa65f6bb7ac5dcf2b5faa235dbd126::mycoin::MYCOIN>(arg2));
        let v0 = LiquidityEvent{
            provider      : 0x2::tx_context::sender(arg3),
            coin_a_amount : 0x2::coin::value<0xb3743a94cbc755521c27fb5d91e2c8b34ea5b0df899654c20d2f965d301bb7dd::faucet_coin::FAUCET_COIN>(&arg1),
            coin_b_amount : 0x2::coin::value<0xc1c3bc0379fb47eb69add8e7ea01acd42eaa65f6bb7ac5dcf2b5faa235dbd126::mycoin::MYCOIN>(&arg2),
            coin_a_type   : 0x1::string::utf8(b"SY711_FAUCET"),
            coin_b_type   : 0x1::string::utf8(b"SY711Coin"),
            timestamp     : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<LiquidityEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id     : 0x2::object::new(arg0),
            coin_a : 0x2::balance::zero<0xb3743a94cbc755521c27fb5d91e2c8b34ea5b0df899654c20d2f965d301bb7dd::faucet_coin::FAUCET_COIN>(),
            coin_b : 0x2::balance::zero<0xc1c3bc0379fb47eb69add8e7ea01acd42eaa65f6bb7ac5dcf2b5faa235dbd126::mycoin::MYCOIN>(),
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    public entry fun swap_a_to_b(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xb3743a94cbc755521c27fb5d91e2c8b34ea5b0df899654c20d2f965d301bb7dd::faucet_coin::FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xb3743a94cbc755521c27fb5d91e2c8b34ea5b0df899654c20d2f965d301bb7dd::faucet_coin::FAUCET_COIN>(&mut arg0.coin_a, 0x2::coin::into_balance<0xb3743a94cbc755521c27fb5d91e2c8b34ea5b0df899654c20d2f965d301bb7dd::faucet_coin::FAUCET_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc1c3bc0379fb47eb69add8e7ea01acd42eaa65f6bb7ac5dcf2b5faa235dbd126::mycoin::MYCOIN>>(0x2::coin::from_balance<0xc1c3bc0379fb47eb69add8e7ea01acd42eaa65f6bb7ac5dcf2b5faa235dbd126::mycoin::MYCOIN>(0x2::balance::split<0xc1c3bc0379fb47eb69add8e7ea01acd42eaa65f6bb7ac5dcf2b5faa235dbd126::mycoin::MYCOIN>(&mut arg0.coin_b, 0x2::coin::value<0xb3743a94cbc755521c27fb5d91e2c8b34ea5b0df899654c20d2f965d301bb7dd::faucet_coin::FAUCET_COIN>(&arg1) * 2), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_b_to_a(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xc1c3bc0379fb47eb69add8e7ea01acd42eaa65f6bb7ac5dcf2b5faa235dbd126::mycoin::MYCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xc1c3bc0379fb47eb69add8e7ea01acd42eaa65f6bb7ac5dcf2b5faa235dbd126::mycoin::MYCOIN>(&mut arg0.coin_b, 0x2::coin::into_balance<0xc1c3bc0379fb47eb69add8e7ea01acd42eaa65f6bb7ac5dcf2b5faa235dbd126::mycoin::MYCOIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb3743a94cbc755521c27fb5d91e2c8b34ea5b0df899654c20d2f965d301bb7dd::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0xb3743a94cbc755521c27fb5d91e2c8b34ea5b0df899654c20d2f965d301bb7dd::faucet_coin::FAUCET_COIN>(0x2::balance::split<0xb3743a94cbc755521c27fb5d91e2c8b34ea5b0df899654c20d2f965d301bb7dd::faucet_coin::FAUCET_COIN>(&mut arg0.coin_a, 0x2::coin::value<0xc1c3bc0379fb47eb69add8e7ea01acd42eaa65f6bb7ac5dcf2b5faa235dbd126::mycoin::MYCOIN>(&arg1) * 2), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

