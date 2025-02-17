module 0x96edb7a68cc692929d20709d4a4e892181a0c75b67cfe865d9a36a47d0ced7c0::jailhayden {
    struct JAILHAYDEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAILHAYDEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAILHAYDEN>(arg0, 6, b"JAILHAYDEN", b"Jail Hayden Mark Davis", x"4a41494c48415944454e0a68747470733a2f2f782e636f6d2f6265616e69656d6178692f7374617475732f31383930393738303332363537303634323033", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/header_d962f4a46d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAILHAYDEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAILHAYDEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

