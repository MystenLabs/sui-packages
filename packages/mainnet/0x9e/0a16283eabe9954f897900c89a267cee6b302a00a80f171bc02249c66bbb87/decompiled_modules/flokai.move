module 0x9e0a16283eabe9954f897900c89a267cee6b302a00a80f171bc02249c66bbb87::flokai {
    struct FLOKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOKAI>(arg0, 9, b"FLOKAI", b"Flokai Token", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<FLOKAI>>(0x2::coin::mint<FLOKAI>(&mut v2, 10000000000000000, arg1), @0x30f2b1146c6693cfa0a5f9580b24d1de21b4dd7cd6a820c1c264631c860e2d2d);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOKAI>>(v2, @0x30f2b1146c6693cfa0a5f9580b24d1de21b4dd7cd6a820c1c264631c860e2d2d);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FLOKAI>>(v1, @0x30f2b1146c6693cfa0a5f9580b24d1de21b4dd7cd6a820c1c264631c860e2d2d);
    }

    // decompiled from Move bytecode v6
}

