module 0xa6c85467bbeccb866123ff5ff524889fd70e13463ab2f155691d6163fb13a228::swap {
    struct Pool has key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<0xfd84f883d3f329c2f6000ee378a924ed0c116822918bf78f0d0acdd28d8408d5::mycoin::MYCOIN>,
        coin_b: 0x2::balance::Balance<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>,
    }

    struct LiquidityEvent has copy, drop {
        provider: address,
        coin_a_amount: u64,
        coin_b_amount: u64,
        coin_a_type: 0x1::string::String,
        coin_b_type: 0x1::string::String,
        timestamp: u64,
    }

    struct SwapEvent has copy, drop {
        sender: address,
        coin_in_amount: u64,
        coin_out_amount: u64,
        coin_in_type: 0x1::string::String,
        coin_out_type: 0x1::string::String,
        timestamp: u64,
    }

    public entry fun add_liquidity(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xfd84f883d3f329c2f6000ee378a924ed0c116822918bf78f0d0acdd28d8408d5::mycoin::MYCOIN>, arg2: 0x2::coin::Coin<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xfd84f883d3f329c2f6000ee378a924ed0c116822918bf78f0d0acdd28d8408d5::mycoin::MYCOIN>(&arg1);
        let v1 = 0x2::coin::value<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>(&arg2);
        assert!(v0 > 0 && v1 > 0, 1);
        0x2::balance::join<0xfd84f883d3f329c2f6000ee378a924ed0c116822918bf78f0d0acdd28d8408d5::mycoin::MYCOIN>(&mut arg0.coin_a, 0x2::coin::into_balance<0xfd84f883d3f329c2f6000ee378a924ed0c116822918bf78f0d0acdd28d8408d5::mycoin::MYCOIN>(arg1));
        0x2::balance::join<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>(&mut arg0.coin_b, 0x2::coin::into_balance<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>(arg2));
        let v2 = LiquidityEvent{
            provider      : 0x2::tx_context::sender(arg3),
            coin_a_amount : v0,
            coin_b_amount : v1,
            coin_a_type   : 0x1::string::utf8(b"mycoin"),
            coin_b_type   : 0x1::string::utf8(b"faucet_coin"),
            timestamp     : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<LiquidityEvent>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id     : 0x2::object::new(arg0),
            coin_a : 0x2::balance::zero<0xfd84f883d3f329c2f6000ee378a924ed0c116822918bf78f0d0acdd28d8408d5::mycoin::MYCOIN>(),
            coin_b : 0x2::balance::zero<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    public entry fun swap_a_to_b(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xfd84f883d3f329c2f6000ee378a924ed0c116822918bf78f0d0acdd28d8408d5::mycoin::MYCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xfd84f883d3f329c2f6000ee378a924ed0c116822918bf78f0d0acdd28d8408d5::mycoin::MYCOIN>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x2::balance::value<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>(&arg0.coin_b);
        assert!(v1 > 0, 0);
        let v2 = v0 * v1 / (0x2::balance::value<0xfd84f883d3f329c2f6000ee378a924ed0c116822918bf78f0d0acdd28d8408d5::mycoin::MYCOIN>(&arg0.coin_a) + v0);
        assert!(v2 > 0 && v2 <= v1, 0);
        0x2::balance::join<0xfd84f883d3f329c2f6000ee378a924ed0c116822918bf78f0d0acdd28d8408d5::mycoin::MYCOIN>(&mut arg0.coin_a, 0x2::coin::into_balance<0xfd84f883d3f329c2f6000ee378a924ed0c116822918bf78f0d0acdd28d8408d5::mycoin::MYCOIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>>(0x2::coin::take<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>(&mut arg0.coin_b, v2, arg2), 0x2::tx_context::sender(arg2));
        let v3 = SwapEvent{
            sender          : 0x2::tx_context::sender(arg2),
            coin_in_amount  : v0,
            coin_out_amount : v2,
            coin_in_type    : 0x1::string::utf8(b"MYCOIN"),
            coin_out_type   : 0x1::string::utf8(b"faucet_coin"),
            timestamp       : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<SwapEvent>(v3);
    }

    public entry fun swap_b_to_a(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x2::balance::value<0xfd84f883d3f329c2f6000ee378a924ed0c116822918bf78f0d0acdd28d8408d5::mycoin::MYCOIN>(&arg0.coin_a);
        assert!(v1 > 0, 0);
        let v2 = 0x2::balance::value<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>(&arg0.coin_b);
        let v3 = v0 * v1 / (v2 + v0);
        assert!(v3 > 0 && v3 <= v2, 0);
        0x2::balance::join<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>(&mut arg0.coin_b, 0x2::coin::into_balance<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xfd84f883d3f329c2f6000ee378a924ed0c116822918bf78f0d0acdd28d8408d5::mycoin::MYCOIN>>(0x2::coin::take<0xfd84f883d3f329c2f6000ee378a924ed0c116822918bf78f0d0acdd28d8408d5::mycoin::MYCOIN>(&mut arg0.coin_a, v3, arg2), 0x2::tx_context::sender(arg2));
        let v4 = SwapEvent{
            sender          : 0x2::tx_context::sender(arg2),
            coin_in_amount  : v0,
            coin_out_amount : v3,
            coin_in_type    : 0x1::string::utf8(b"FAUCET_COIN"),
            coin_out_type   : 0x1::string::utf8(b"MYCOIN"),
            timestamp       : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<SwapEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

