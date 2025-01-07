module 0xc3f129f1e893dc01aa22d1231a33c2d668de2ede1a6be2daaa3f139e4bf65580::hgoat {
    struct HGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HGOAT>(arg0, 6, b"HGOAT", b"Hop Goat", b"Hop Goat is a goat-inspired token that thrives on the principles of community-led decentralization and widespread adoption.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730963373080.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HGOAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HGOAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

