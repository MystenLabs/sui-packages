module 0xa81623bfc2377ba8be8efcbcba731032a6b154640218ec061787b49c9dff891b::mmc {
    struct MMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMC>(arg0, 6, b"MMC", b"MoveMarketCap", x"50726f6a65637473206261736564206f6e204d6f76652c205072696365732026204368617274732e200a0a436f6e746163742d20696e666f406d6f76656d61726b65746361702e636f6d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_13_09_38_97daa3d92a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

