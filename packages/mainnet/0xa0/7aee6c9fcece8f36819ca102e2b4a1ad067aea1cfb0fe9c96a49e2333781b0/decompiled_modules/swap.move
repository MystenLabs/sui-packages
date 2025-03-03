module 0xa07aee6c9fcece8f36819ca102e2b4a1ad067aea1cfb0fe9c96a49e2333781b0::swap {
    struct Pool has key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<0xba74e7bdc1d7b7663844417a6ae4ecbffb909c834aac8c16f88db6f6aaed408e::qqb::QQB>,
        coin_b: 0x2::balance::Balance<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct SwapEvent has copy, drop {
        swapper: address,
        in_amount: u64,
        out_amount: u64,
        in_coin_type: 0x1::string::String,
        out_coin_type: 0x1::string::String,
        time: u64,
    }

    public entry fun add_liquidity(arg0: &AdminCap, arg1: &mut Pool, arg2: 0x2::coin::Coin<0xba74e7bdc1d7b7663844417a6ae4ecbffb909c834aac8c16f88db6f6aaed408e::qqb::QQB>, arg3: 0x2::coin::Coin<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xba74e7bdc1d7b7663844417a6ae4ecbffb909c834aac8c16f88db6f6aaed408e::qqb::QQB>(&arg2) > 0 && 0x2::coin::value<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>(&arg3) > 0, 17);
        0x2::balance::join<0xba74e7bdc1d7b7663844417a6ae4ecbffb909c834aac8c16f88db6f6aaed408e::qqb::QQB>(&mut arg1.coin_a, 0x2::coin::into_balance<0xba74e7bdc1d7b7663844417a6ae4ecbffb909c834aac8c16f88db6f6aaed408e::qqb::QQB>(arg2));
        0x2::balance::join<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>(&mut arg1.coin_b, 0x2::coin::into_balance<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>(arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id     : 0x2::object::new(arg0),
            coin_a : 0x2::balance::zero<0xba74e7bdc1d7b7663844417a6ae4ecbffb909c834aac8c16f88db6f6aaed408e::qqb::QQB>(),
            coin_b : 0x2::balance::zero<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Pool>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_a_to_b(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xba74e7bdc1d7b7663844417a6ae4ecbffb909c834aac8c16f88db6f6aaed408e::qqb::QQB>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xba74e7bdc1d7b7663844417a6ae4ecbffb909c834aac8c16f88db6f6aaed408e::qqb::QQB>(&arg1);
        assert!(v0 > 0, 17);
        let v1 = 0x2::balance::value<0xba74e7bdc1d7b7663844417a6ae4ecbffb909c834aac8c16f88db6f6aaed408e::qqb::QQB>(&arg0.coin_a);
        assert!(v1 > 0, 18);
        let v2 = 0x2::balance::value<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>(&arg0.coin_b);
        assert!(v2 > 0, 18);
        let v3 = v0 / 100000000 * v2 / (v1 + v0) / 100000000;
        assert!(v2 > v3, 18);
        0x2::balance::join<0xba74e7bdc1d7b7663844417a6ae4ecbffb909c834aac8c16f88db6f6aaed408e::qqb::QQB>(&mut arg0.coin_a, 0x2::coin::into_balance<0xba74e7bdc1d7b7663844417a6ae4ecbffb909c834aac8c16f88db6f6aaed408e::qqb::QQB>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>>(0x2::coin::take<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>(&mut arg0.coin_b, v3, arg2), 0x2::tx_context::sender(arg2));
        let v4 = SwapEvent{
            swapper       : 0x2::tx_context::sender(arg2),
            in_amount     : v0,
            out_amount    : v3,
            in_coin_type  : 0x1::string::utf8(b"QQB"),
            out_coin_type : 0x1::string::utf8(b"FAUCET_COIN"),
            time          : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<SwapEvent>(v4);
    }

    public entry fun swap_b_to_a(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>(&arg1);
        assert!(v0 > 0, 17);
        let v1 = 0x2::balance::value<0xba74e7bdc1d7b7663844417a6ae4ecbffb909c834aac8c16f88db6f6aaed408e::qqb::QQB>(&arg0.coin_a);
        assert!(v1 > 0, 18);
        let v2 = 0x2::balance::value<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>(&arg0.coin_b);
        assert!(v2 > 0, 18);
        let v3 = v0 / 100000000 * v1 / (v2 + v0) / 100000000;
        assert!(v1 > v3, 18);
        0x2::balance::join<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>(&mut arg0.coin_b, 0x2::coin::into_balance<0xb719adc514601326081489f46e57db8e384da20525e629bf2ac877aec3749adf::faucet_coin::FAUCET_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xba74e7bdc1d7b7663844417a6ae4ecbffb909c834aac8c16f88db6f6aaed408e::qqb::QQB>>(0x2::coin::take<0xba74e7bdc1d7b7663844417a6ae4ecbffb909c834aac8c16f88db6f6aaed408e::qqb::QQB>(&mut arg0.coin_a, v3, arg2), 0x2::tx_context::sender(arg2));
        let v4 = SwapEvent{
            swapper       : 0x2::tx_context::sender(arg2),
            in_amount     : v0,
            out_amount    : v3,
            in_coin_type  : 0x1::string::utf8(b"FAUCET_COIN"),
            out_coin_type : 0x1::string::utf8(b"QQB"),
            time          : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<SwapEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

