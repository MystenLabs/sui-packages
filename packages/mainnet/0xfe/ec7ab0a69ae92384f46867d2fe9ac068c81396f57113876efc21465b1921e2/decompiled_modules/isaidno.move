module 0xfeec7ab0a69ae92384f46867d2fe9ac068c81396f57113876efc21465b1921e2::isaidno {
    struct ISAIDNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISAIDNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISAIDNO>(arg0, 9, b"ISAIDNO", b"ISN", b"ISAIDNO token is for people who know how to refuse someone's requests, because the token is for people who value their own comfort. The token is for people who are striving for the goal of being independent, self-reliant, and in their comfort zone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ebb52af4-9008-4bc0-a87f-adc2310832b2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISAIDNO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ISAIDNO>>(v1);
    }

    // decompiled from Move bytecode v6
}

