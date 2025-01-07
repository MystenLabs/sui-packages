module 0x3e4b04f936da9243e4fb68f546ae1322bb15a4845f9e57aa5056fe58246b7638::pcmn {
    struct PCMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PCMN>(arg0, 6, b"PCMN", b"PacMoon SUI", b"PUMP PACMOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pacmon_7f21446909.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PCMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

