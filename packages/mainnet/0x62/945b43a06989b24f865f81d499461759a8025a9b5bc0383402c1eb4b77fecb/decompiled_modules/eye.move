module 0x62945b43a06989b24f865f81d499461759a8025a9b5bc0383402c1eb4b77fecb::eye {
    struct EYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EYE>(arg0, 6, b"EYE", b"Cyborg Eye", b"It's the eye of a cyborg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731346039813.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EYE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EYE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

