module 0x5d2be52df828b50c940a46ea21dc7789df6b83fae4ce73d81ff911778f0d17d5::totalshlaaaaag {
    struct TOTALSHLAAAAAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOTALSHLAAAAAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOTALSHLAAAAAG>(arg0, 9, b"TOTAL SHLAAAAAG", b"TOTALSHLA", b"I'm not just a slag...I'm a TOTAL SHLAAAaaG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1759943221/sui_tokens/yyweq2de7a0mraxyz0h1.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<TOTALSHLAAAAAG>>(0x2::coin::mint<TOTALSHLAAAAAG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TOTALSHLAAAAAG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOTALSHLAAAAAG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

