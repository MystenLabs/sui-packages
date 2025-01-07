module 0xcb903beb350dc80331723f52fd5770fa5066d3d1300ff079f872c835d78320b1::suki {
    struct SUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUKI>(arg0, 6, b"SUKI", b"SUKI ON SUI", x"68747470733a2f2f656e2e77696b6970656469612e6f72672f77696b692f446f67655f286d656d6529234f726967696e5f616e645f70726f6e756e63696174696f6e0a0a68747470733a2f2f6b6e6f77796f75726d656d652e636f6d2f6d656d65732f646f6765", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3924_12cf8f5513.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

