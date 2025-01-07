module 0xf760edd477cf620788bf9fab82600873590162822c8484ab0834d3d31c9ed27d::suiluffy {
    struct SUILUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILUFFY>(arg0, 6, b"SUILUFFY", b"SuiOnePiece", b"SuiOnePiece is a unique digital asset built on the Sui blockchain, inspired by the adventurous and ambitious spirit of the \"One Piece\" theme. Designed to embody values like discovery, growth, and community, SuiOnePiece offers holders not just a token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731711882800.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUILUFFY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILUFFY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

