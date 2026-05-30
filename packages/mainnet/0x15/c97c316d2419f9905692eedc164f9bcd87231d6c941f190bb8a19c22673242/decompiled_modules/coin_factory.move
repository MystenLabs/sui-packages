module 0x15c97c316d2419f9905692eedc164f9bcd87231d6c941f190bb8a19c22673242::coin_factory {
    struct COIN_FACTORY has drop {
        dummy_field: bool,
    }

    struct FactoryStorage has key {
        id: 0x2::object::UID,
        total_coins_created: u64,
    }

    public entry fun deploy_new_coin(arg0: &mut FactoryStorage, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        arg0.total_coins_created = arg0.total_coins_created + 1;
    }

    fun init(arg0: COIN_FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_FACTORY>(arg0, 9, b"SUI_PUMP", b"Sui Pump Token", b"Real token deployed automatically via Sui Token Launcher", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/w2bdZ9X.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_FACTORY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_FACTORY>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = FactoryStorage{
            id                  : 0x2::object::new(arg1),
            total_coins_created : 0,
        };
        0x2::transfer::share_object<FactoryStorage>(v2);
    }

    public entry fun mint_coin(arg0: &mut 0x2::coin::TreasuryCap<COIN_FACTORY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<COIN_FACTORY>>(0x2::coin::mint<COIN_FACTORY>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v7
}

