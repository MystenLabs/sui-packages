module 0x6bca7204925180617087fd4a7b0998ac0c58d57c26433b6b675b6d2a77ce3fcf::luffy {
    struct LUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUFFY>(arg0, 6, b"LUFFY", b"SuiOnePiece", b"SuiOnePiece is a unique digital asset built on the Sui blockchain, inspired by the adventurous and ambitious spirit of the \"One Piece\" theme. Designed to embody values like discovery, growth, and community, SuiOnePiece offers holders not just a token but a journey of opportunities within the Sui ecosystem. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Anime_XL_monkey_d_luffy_0_484dc217e9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUFFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUFFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

