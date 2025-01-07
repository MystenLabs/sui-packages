module 0x77e6affe33352d70cb7db22ce93aba720ba9c80b281f4a0b016d4062810e2f8c::fengsui {
    struct FENGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FENGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FENGSUI>(arg0, 6, b"FENGSUI", b"FENG SUI", b"$FENGSUI produces balance and harmony on sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7711_a0b99b7c97.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FENGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FENGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

