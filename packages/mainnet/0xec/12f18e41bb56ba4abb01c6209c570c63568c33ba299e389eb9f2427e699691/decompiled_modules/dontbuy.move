module 0xec12f18e41bb56ba4abb01c6209c570c63568c33ba299e389eb9f2427e699691::dontbuy {
    struct DONTBUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONTBUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONTBUY>(arg0, 9, b"dontbuy", b"test", b"dont buy its just a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DONTBUY>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONTBUY>>(v2, @0x29a6cf9f0c5e78c471898c2e8f14372e627aad62c90f2c256ac8d5c04127d77a);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONTBUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

