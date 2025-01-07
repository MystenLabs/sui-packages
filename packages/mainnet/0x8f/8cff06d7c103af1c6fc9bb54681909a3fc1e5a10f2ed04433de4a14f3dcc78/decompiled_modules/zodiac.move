module 0x8f8cff06d7c103af1c6fc9bb54681909a3fc1e5a10f2ed04433de4a14f3dcc78::zodiac {
    struct ZODIAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZODIAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZODIAC>(arg0, 6, b"Zodiac", b"Zodiac Signs", b"Daily Reading about your Zodiac Signs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735027258465.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZODIAC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZODIAC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

