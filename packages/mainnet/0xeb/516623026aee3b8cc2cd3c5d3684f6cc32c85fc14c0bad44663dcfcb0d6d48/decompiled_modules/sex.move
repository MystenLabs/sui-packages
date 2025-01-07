module 0xeb516623026aee3b8cc2cd3c5d3684f6cc32c85fc14c0bad44663dcfcb0d6d48::sex {
    struct SEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEX>(arg0, 6, b"SEX", b"SEX6900", x"7469636b657220697320245345580a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_00_42_15_7fbbec034b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

