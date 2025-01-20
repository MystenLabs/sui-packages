module 0x29e6d1d9fa991b5e5fd7f66fb147b7cb2d1664eacbc505af5c80c5905b5388a3::usa {
    struct USA has drop {
        dummy_field: bool,
    }

    fun init(arg0: USA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USA>(arg0, 6, b"USA", b"Made in USA", x"4275696c74206f6e20696e746567726974792c206d61646520696e20416d65726963612e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250121_035631_697_6c5bb22906.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USA>>(v1);
    }

    // decompiled from Move bytecode v6
}

