module 0xa0c8bfb9c5f665283e5b1e15893cd148e4bca1cb3d292fb019109b94c852aa61::brain {
    struct BRAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAIN>(arg0, 6, b"BRAIN", b"BrAInGen", b"BrainGen is the first-ever AI-powered meme coin, blending humor with cutting-edge artificial intelligence. Designed for tech-savvy meme enthusiasts, $BRAIN aims to become the smartest coin in the crypto space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736242045104.15")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRAIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

