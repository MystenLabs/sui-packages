module 0x5559064fbf22daa34e25144e4d31035e63beaf94f5457a04f8c3fb247ea92f92::lsuiyan {
    struct LSUIYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LSUIYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LSUIYAN>(arg0, 6, b"LSUIYAN", b"LORD SUIYAN", b"LSUIYAN is just meme on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730993617025.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LSUIYAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LSUIYAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

