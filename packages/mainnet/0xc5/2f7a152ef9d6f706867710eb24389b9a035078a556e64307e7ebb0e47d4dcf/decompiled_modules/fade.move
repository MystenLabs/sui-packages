module 0xc52f7a152ef9d6f706867710eb24389b9a035078a556e64307e7ebb0e47d4dcf::fade {
    struct FADE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FADE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FADE>(arg0, 6, b"FADE", b"Burst", b"Burst fade parin to ya", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732200702443.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FADE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FADE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

