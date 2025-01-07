module 0x959aadfeb0e0d11106fcc4ddbf75a32e5c877f09254aa4996602f76c7cd38568::glub {
    struct GLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLUB>(arg0, 6, b"GLUB", b"Glub", x"476c7562202d20467269656e64206f6620426c7562202d2054686520536c696768746c7920456363656e74726963202747726f757065722046697368272077686f2072756e73206120444547454e204f4e4c5920636c756220666f7220535549206d656d65636f696e20747261646572732e204c6976657320616d6f6e6773742074686520436f72616c2e204e6f2d486f6c64732d42617272656420446567656e657261637920456e636f7572616765642e0a0a4a6f696e206d6520696e2054656c656772616d20746f2073656520746865206c61746573742053554920616c7068612e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GLUB_3_3a60ae39e4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

