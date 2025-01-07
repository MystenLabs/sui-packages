module 0x1365656b7973b47bd475a585464f2addd5e2c158593ed2be0cebaf9331ca1e9c::swap {
    struct Pool has key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<0x1f8d02082b92c84d74b4b524d5c425f5db43f2dd5268d22522920c94addbccbc::funnyyanne_coin::FUNNYYANNE_COIN>,
        coin_b: 0x2::balance::Balance<0xc23a7d57739bd26fafb3daa58d4aeddcd9d17a6e205e5aaf6897f371bcf97eb2::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>,
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

    public entry fun add_liquidity(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x1f8d02082b92c84d74b4b524d5c425f5db43f2dd5268d22522920c94addbccbc::funnyyanne_coin::FUNNYYANNE_COIN>, arg2: 0x2::coin::Coin<0xc23a7d57739bd26fafb3daa58d4aeddcd9d17a6e205e5aaf6897f371bcf97eb2::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x1f8d02082b92c84d74b4b524d5c425f5db43f2dd5268d22522920c94addbccbc::funnyyanne_coin::FUNNYYANNE_COIN>(&arg1);
        let v1 = 0x2::coin::value<0xc23a7d57739bd26fafb3daa58d4aeddcd9d17a6e205e5aaf6897f371bcf97eb2::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>(&arg2);
        assert!(v0 > 0 && v1 > 0, 1);
        0x2::balance::join<0x1f8d02082b92c84d74b4b524d5c425f5db43f2dd5268d22522920c94addbccbc::funnyyanne_coin::FUNNYYANNE_COIN>(&mut arg0.coin_a, 0x2::coin::into_balance<0x1f8d02082b92c84d74b4b524d5c425f5db43f2dd5268d22522920c94addbccbc::funnyyanne_coin::FUNNYYANNE_COIN>(arg1));
        0x2::balance::join<0xc23a7d57739bd26fafb3daa58d4aeddcd9d17a6e205e5aaf6897f371bcf97eb2::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>(&mut arg0.coin_b, 0x2::coin::into_balance<0xc23a7d57739bd26fafb3daa58d4aeddcd9d17a6e205e5aaf6897f371bcf97eb2::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>(arg2));
        let v2 = LiquidityEvent{
            provider      : 0x2::tx_context::sender(arg3),
            coin_a_amount : v0,
            coin_b_amount : v1,
            coin_a_type   : 0x1::string::utf8(b"FUNNYYANNE_COIN"),
            coin_b_type   : 0x1::string::utf8(b"FUNNYYANNE_FAUCET_COIN"),
            timestamp     : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<LiquidityEvent>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id     : 0x2::object::new(arg0),
            coin_a : 0x2::balance::zero<0x1f8d02082b92c84d74b4b524d5c425f5db43f2dd5268d22522920c94addbccbc::funnyyanne_coin::FUNNYYANNE_COIN>(),
            coin_b : 0x2::balance::zero<0xc23a7d57739bd26fafb3daa58d4aeddcd9d17a6e205e5aaf6897f371bcf97eb2::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    public entry fun swap_a_to_b(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x1f8d02082b92c84d74b4b524d5c425f5db43f2dd5268d22522920c94addbccbc::funnyyanne_coin::FUNNYYANNE_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x1f8d02082b92c84d74b4b524d5c425f5db43f2dd5268d22522920c94addbccbc::funnyyanne_coin::FUNNYYANNE_COIN>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x2::balance::value<0xc23a7d57739bd26fafb3daa58d4aeddcd9d17a6e205e5aaf6897f371bcf97eb2::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>(&arg0.coin_b);
        assert!(v1 > 0, 0);
        let v2 = v0 * v1 / (0x2::balance::value<0x1f8d02082b92c84d74b4b524d5c425f5db43f2dd5268d22522920c94addbccbc::funnyyanne_coin::FUNNYYANNE_COIN>(&arg0.coin_a) + v0);
        assert!(v2 > 0 && v2 <= v1, 0);
        0x2::balance::join<0x1f8d02082b92c84d74b4b524d5c425f5db43f2dd5268d22522920c94addbccbc::funnyyanne_coin::FUNNYYANNE_COIN>(&mut arg0.coin_a, 0x2::coin::into_balance<0x1f8d02082b92c84d74b4b524d5c425f5db43f2dd5268d22522920c94addbccbc::funnyyanne_coin::FUNNYYANNE_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc23a7d57739bd26fafb3daa58d4aeddcd9d17a6e205e5aaf6897f371bcf97eb2::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>>(0x2::coin::take<0xc23a7d57739bd26fafb3daa58d4aeddcd9d17a6e205e5aaf6897f371bcf97eb2::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>(&mut arg0.coin_b, v2, arg2), 0x2::tx_context::sender(arg2));
        let v3 = SwapEvent{
            sender          : 0x2::tx_context::sender(arg2),
            coin_in_amount  : v0,
            coin_out_amount : v2,
            coin_in_type    : 0x1::string::utf8(b"FUNNYYANNE_COIN"),
            coin_out_type   : 0x1::string::utf8(b"FUNNYYANNE_FAUCET_COIN"),
            timestamp       : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<SwapEvent>(v3);
    }

    public entry fun swap_b_to_a(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xc23a7d57739bd26fafb3daa58d4aeddcd9d17a6e205e5aaf6897f371bcf97eb2::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xc23a7d57739bd26fafb3daa58d4aeddcd9d17a6e205e5aaf6897f371bcf97eb2::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x2::balance::value<0x1f8d02082b92c84d74b4b524d5c425f5db43f2dd5268d22522920c94addbccbc::funnyyanne_coin::FUNNYYANNE_COIN>(&arg0.coin_a);
        assert!(v1 > 0, 0);
        let v2 = v0 * v1 / (0x2::balance::value<0xc23a7d57739bd26fafb3daa58d4aeddcd9d17a6e205e5aaf6897f371bcf97eb2::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>(&arg0.coin_b) + v0);
        assert!(v2 > 0 && v2 <= v1, 0);
        0x2::balance::join<0xc23a7d57739bd26fafb3daa58d4aeddcd9d17a6e205e5aaf6897f371bcf97eb2::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>(&mut arg0.coin_b, 0x2::coin::into_balance<0xc23a7d57739bd26fafb3daa58d4aeddcd9d17a6e205e5aaf6897f371bcf97eb2::funnyyanne_faucet_coin::FUNNYYANNE_FAUCET_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1f8d02082b92c84d74b4b524d5c425f5db43f2dd5268d22522920c94addbccbc::funnyyanne_coin::FUNNYYANNE_COIN>>(0x2::coin::take<0x1f8d02082b92c84d74b4b524d5c425f5db43f2dd5268d22522920c94addbccbc::funnyyanne_coin::FUNNYYANNE_COIN>(&mut arg0.coin_a, v2, arg2), 0x2::tx_context::sender(arg2));
        let v3 = SwapEvent{
            sender          : 0x2::tx_context::sender(arg2),
            coin_in_amount  : v0,
            coin_out_amount : v2,
            coin_in_type    : 0x1::string::utf8(b"FUNNYYANNE_FAUCET_COIN"),
            coin_out_type   : 0x1::string::utf8(b"FUNNYYANNE_COIN"),
            timestamp       : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<SwapEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

