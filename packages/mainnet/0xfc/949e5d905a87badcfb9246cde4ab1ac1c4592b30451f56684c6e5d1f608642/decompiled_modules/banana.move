module 0xfc949e5d905a87badcfb9246cde4ab1ac1c4592b30451f56684c6e5d1f608642::banana {
    struct BANANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANANA>(arg0, 6, b"Banana", b"Banana S31", x"4f6e204e6f76656d6265722031382c2053706163652077696c6c206c61756e636820612062616e616e61206f6e2069747320726f636b65742c20616e642040656c6f6e20697320676f696e6720746f2074776565742061626f75742069742120f09f9a80f09f8d8c20537461792074756e656420666f72207468697320756e69717565206d697373696f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731547586995.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BANANA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANANA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

