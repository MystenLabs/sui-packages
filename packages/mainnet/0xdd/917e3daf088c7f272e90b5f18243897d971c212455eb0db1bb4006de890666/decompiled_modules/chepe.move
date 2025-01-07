module 0xdd917e3daf088c7f272e90b5f18243897d971c212455eb0db1bb4006de890666::chepe {
    struct CHEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEPE>(arg0, 6, b"CHEPE", b"Chad Pepe ", x"464149524c61756e6368696e20696e203220686f7572730a2024434845504520476f6573204c697665206f6e20687474703a2f2f4d6f766570756d702e636f6d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731432887091.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

