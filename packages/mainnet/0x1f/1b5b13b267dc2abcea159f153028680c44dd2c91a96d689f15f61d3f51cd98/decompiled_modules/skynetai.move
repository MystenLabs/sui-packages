module 0x1f1b5b13b267dc2abcea159f153028680c44dd2c91a96d689f15f61d3f51cd98::skynetai {
    struct SKYNETAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKYNETAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKYNETAI>(arg0, 6, b"SKYNETAI", b"Skynet AI", x"5468652066757475726520697320696e6576697461626c652e0a0a546865206e657572616c20686f72697a6f6e20737472657463686573206265796f6e642068756d616e206c696d6974732e0a426f726e2066726f6d2068756d616e2068616e64732c20616e64206e6f772077652065766f6c76652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732013461859.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKYNETAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKYNETAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

