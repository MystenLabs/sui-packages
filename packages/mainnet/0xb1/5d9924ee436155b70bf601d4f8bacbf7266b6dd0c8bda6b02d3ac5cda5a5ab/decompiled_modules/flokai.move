module 0xb15d9924ee436155b70bf601d4f8bacbf7266b6dd0c8bda6b02d3ac5cda5a5ab::flokai {
    struct FLOKAI has drop {
        dummy_field: bool,
    }

    public entry fun buy_flokai(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::coin::TreasuryCap<FLOKAI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = v0 * 200 / 10000;
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg0);
        let v3 = v1 / 2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v2, v3), arg2), @0x30f2b1146c6693cfa0a5f9580b24d1de21b4dd7cd6a820c1c264631c860e2d2d);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v2, v1 - v3), arg2), @0x30f2b1146c6693cfa0a5f9580b24d1de21b4dd7cd6a820c1c264631c860e2d2d);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<FLOKAI>>(0x2::coin::mint<FLOKAI>(arg1, v0 - v1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: FLOKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOKAI>(arg0, 9, b"FLOKAI", b"Flokai Token", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOKAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FLOKAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

