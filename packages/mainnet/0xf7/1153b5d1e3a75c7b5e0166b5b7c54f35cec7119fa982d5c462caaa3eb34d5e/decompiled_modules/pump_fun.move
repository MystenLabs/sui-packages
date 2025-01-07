module 0xf71153b5d1e3a75c7b5e0166b5b7c54f35cec7119fa982d5c462caaa3eb34d5e::pump_fun {
    struct TokenInfo has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<PUMP_FUN>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: address,
    }

    struct PUMP_FUN has drop {
        dummy_field: bool,
    }

    public entry fun buy_token(arg0: &mut TokenInfo, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= arg2, 0);
        let v0 = arg2 * 1 / 100;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<PUMP_FUN>>(0x2::coin::take<PUMP_FUN>(&mut arg0.balance, arg2 - v0, arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_balance, v0, arg3), arg0.admin);
    }

    fun init(arg0: PUMP_FUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMP_FUN>(arg0, 9, b"PUMP_FUN", b"PFN", b"Pump Fun Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUMP_FUN>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PUMP_FUN>>(v2);
        let v3 = TokenInfo{
            id          : 0x2::object::new(arg1),
            balance     : 0x2::coin::into_balance<PUMP_FUN>(0x2::coin::mint<PUMP_FUN>(&mut v2, 1000000000000000000, arg1)),
            sui_balance : 0x2::balance::zero<0x2::sui::SUI>(),
            admin       : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<TokenInfo>(v3);
    }

    // decompiled from Move bytecode v6
}

