module 0x3f55c0b78eafa8be3a6f222ff8e2afab227abe8b49fb7b49230f93079d57d045::isaidno {
    struct ISAIDNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISAIDNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISAIDNO>(arg0, 9, b"ISAIDNO", b"ISN", b"ISAIDNO token is for people who know how to refuse someone's requests, because the token is for people who value their own comfort. The token is for people who are striving for the goal of being independent, self-reliant, and in their comfort zone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e55b7433-d2e1-462f-a3ff-a36da64fb6f4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISAIDNO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ISAIDNO>>(v1);
    }

    // decompiled from Move bytecode v6
}

