module 0x6f64b95e090ff9a91013290e079e0d90c694eefd479641d0eb6516706fbffb05::bsuis {
    struct BSUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSUIS>(arg0, 6, b"Bsuis", b"Blastsuise", b"The powerful water pokemon now on sui to waterblast everyone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0206_880eebe3cd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSUIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSUIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

