module 0xa8ca759a31509ae82fa7b3b333ede9762920366809c74b798c71a6648b5aea82::dreap {
    struct DREAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DREAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DREAP>(arg0, 6, b"DREAP", b"Dog Reaper", b"Dog Reaper is the life taker of sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zou_Qx_OWA_Agtt_S6_eea085ef7f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DREAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DREAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

