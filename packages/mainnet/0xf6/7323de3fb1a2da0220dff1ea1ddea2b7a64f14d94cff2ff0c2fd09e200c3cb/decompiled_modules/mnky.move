module 0xf67323de3fb1a2da0220dff1ea1ddea2b7a64f14d94cff2ff0c2fd09e200c3cb::mnky {
    struct MNKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNKY>(arg0, 6, b"MNKY", b"SUI MOONKEY", b"SUIMoonkey is more than just a token, it represents a bold journey toward limitless possibilities. From the depths of ambition to the heights of success, Moonkey inspires its community to dream big and aim higher. With every step, Moonkey builds a story of growth, fun, and a united vision.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiad3jgnletd4ixcwejaqu36c6t57elcz34bl3vngsdcpui3u3mmjy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MNKY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

