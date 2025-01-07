module 0xd845436433d8ec7d9d81a46cb3bb585d455f5115b89ba4c8109e28ceeb097add::isaidno {
    struct ISAIDNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISAIDNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISAIDNO>(arg0, 9, b"ISAIDNO", b"ISN", b"ISAIDNO token is for people who know how to refuse someone's requests, because the token is for people who value their own comfort. The token is for people who are striving for the goal of being independent, self-reliant, and in their comfort zone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d46cf744-b26a-40de-93e4-8f82aa5db0fb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISAIDNO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ISAIDNO>>(v1);
    }

    // decompiled from Move bytecode v6
}

