module 0x2d1125fb8b4fefe70f79bdf61f46d11f149fc0af39545a5c2931ef843d213f35::swap {
    struct Pool has key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>,
        coin_b: 0x2::balance::Balance<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>,
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

    public entry fun add_liquidity(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>, arg2: 0x2::coin::Coin<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>(&arg1);
        let v1 = 0x2::coin::value<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>(&arg2);
        assert!(v0 > 0 && v1 > 0, 1);
        0x2::balance::join<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>(&mut arg0.coin_a, 0x2::coin::into_balance<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>(arg1));
        0x2::balance::join<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>(&mut arg0.coin_b, 0x2::coin::into_balance<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>(arg2));
        let v2 = LiquidityEvent{
            provider      : 0x2::tx_context::sender(arg3),
            coin_a_amount : v0,
            coin_b_amount : v1,
            coin_a_type   : 0x1::string::utf8(b"CMDSCZ_COIN"),
            coin_b_type   : 0x1::string::utf8(b"CMDSCZ_FAUCET_COIN"),
            timestamp     : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<LiquidityEvent>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id     : 0x2::object::new(arg0),
            coin_a : 0x2::balance::zero<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>(),
            coin_b : 0x2::balance::zero<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    public entry fun swap_a_to_b(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x2::balance::value<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>(&arg0.coin_b);
        assert!(v1 > 0, 0);
        let v2 = v0 * v1 / (0x2::balance::value<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>(&arg0.coin_a) + v0);
        assert!(v2 > 0 && v2 <= v1, 0);
        0x2::balance::join<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>(&mut arg0.coin_a, 0x2::coin::into_balance<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>>(0x2::coin::take<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>(&mut arg0.coin_b, v2, arg2), 0x2::tx_context::sender(arg2));
        let v3 = SwapEvent{
            sender          : 0x2::tx_context::sender(arg2),
            coin_in_amount  : v0,
            coin_out_amount : v2,
            coin_in_type    : 0x1::string::utf8(b"CMDSCZ_COIN"),
            coin_out_type   : 0x1::string::utf8(b"CMDSCZ_FAUCET_COIN"),
            timestamp       : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<SwapEvent>(v3);
    }

    public entry fun swap_b_to_a(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x2::balance::value<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>(&arg0.coin_a);
        assert!(v1 > 0, 0);
        let v2 = v0 * v1 / (0x2::balance::value<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>(&arg0.coin_b) + v0);
        assert!(v2 > 0 && v2 <= v1, 0);
        0x2::balance::join<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>(&mut arg0.coin_b, 0x2::coin::into_balance<0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin::CMDSCZ_FAUCET_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>>(0x2::coin::take<0x539851bd3fa43cd434f05ff588f87eca8db3d3c5007dc5c9093ef5c7028ade62::cmdscz_coin::CMDSCZ_COIN>(&mut arg0.coin_a, v2, arg2), 0x2::tx_context::sender(arg2));
        let v3 = SwapEvent{
            sender          : 0x2::tx_context::sender(arg2),
            coin_in_amount  : v0,
            coin_out_amount : v2,
            coin_in_type    : 0x1::string::utf8(b"CMDSCZ_FAUCET_COIN"),
            coin_out_type   : 0x1::string::utf8(b"CMDSCZ_COIN"),
            timestamp       : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<SwapEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

