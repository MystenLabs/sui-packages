module 0xdc35e3c4569395d5f3eefc58af3f169480cf195883185e8f763d302db710829b::skip {
    struct SKIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKIP>(arg0, 6, b"SKIP", b"SKIP TRUTH", b"Skip Truth the new the new face of SUI, move over $TOOKER, theres a new jerno in town.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/skip_cc38fae310.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

