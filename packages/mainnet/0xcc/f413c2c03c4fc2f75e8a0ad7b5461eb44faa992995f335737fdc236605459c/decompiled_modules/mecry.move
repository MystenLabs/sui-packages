module 0xccf413c2c03c4fc2f75e8a0ad7b5461eb44faa992995f335737fdc236605459c::mecry {
    struct MECRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MECRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MECRY>(arg0, 6, b"MECRY", b"MEME", b"CRY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-efea87dea3f94e8084e073588c980c50.r2.dev/logo/01JBVAXGJ5QWZFF04ERMBMSZEF/01JC506TR2XQEXR9THSV6YD501")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MECRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MECRY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

