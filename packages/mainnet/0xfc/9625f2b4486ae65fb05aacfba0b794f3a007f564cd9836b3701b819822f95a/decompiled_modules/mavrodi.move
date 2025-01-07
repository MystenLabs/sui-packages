module 0xfc9625f2b4486ae65fb05aacfba0b794f3a007f564cd9836b3701b819822f95a::mavrodi {
    struct MAVRODI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAVRODI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAVRODI>(arg0, 6, b"MAVRODI", b"Mavrodi MMM", b"Mav_rodi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/scale_1200_9ca737632d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAVRODI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAVRODI>>(v1);
    }

    // decompiled from Move bytecode v6
}

