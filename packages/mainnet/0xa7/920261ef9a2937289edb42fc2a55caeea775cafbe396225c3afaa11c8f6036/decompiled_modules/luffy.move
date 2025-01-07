module 0xa7920261ef9a2937289edb42fc2a55caeea775cafbe396225c3afaa11c8f6036::luffy {
    struct LUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUFFY>(arg0, 6, b"LUFFY", b"SuiOnePiece", b"SuiOnePiece is a unique digital asset built on the Sui blockchain, inspired by the adventurous and ambitious spirit of the \"One Piece\" theme. Designed to embody values like discovery, growth, and community, SuiOnePiece offers holders not just a token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731199109341.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUFFY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUFFY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

