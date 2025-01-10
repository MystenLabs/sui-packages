module 0xd54eb5cab591d17ee57314f0b13b768ffa93cfa2f62d4781f564159a11296748::hairry {
    struct HAIRRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAIRRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAIRRY>(arg0, 6, b"HAIRRY", b"HAIrry Potter Agent", b"HAIrry Potter Agent is an engaging and magical AI-powered token that brings the world of Harry Potter to life. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736546851273.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAIRRY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAIRRY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

