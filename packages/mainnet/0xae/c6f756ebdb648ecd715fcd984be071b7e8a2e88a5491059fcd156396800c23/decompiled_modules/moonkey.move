module 0xaec6f756ebdb648ecd715fcd984be071b7e8a2e88a5491059fcd156396800c23::moonkey {
    struct MOONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONKEY>(arg0, 6, b"MOONKEY", b"SUIMOONKEY", b"SUIMoonkey is more than just a token, it represents a bold journey toward limitless possibilities. From the depths of ambition to the heights of success, Moonkey inspires its community to dream big and aim higher. With every step, Moonkey builds a story of growth, fun, and a united vision.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiad3jgnletd4ixcwejaqu36c6t57elcz34bl3vngsdcpui3u3mmjy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOONKEY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

