module 0x698409c8f228c1ec2385e1cb7b8a92d755e1c1065bd81a9bfe508016716e914b::shihsui {
    struct SHIHSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIHSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIHSUI>(arg0, 6, b"SHIHSUI", b"Shih Sui AI", b"Just a cute, fun & loving doggy AI based meme coin which was inspired from the Shih Tzu breed.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736024807579.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIHSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIHSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

