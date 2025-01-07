module 0x6a3ffe08afc4ba503b6e5f9379023e56ceab4de5de630ff709597c22be2fee22::suiper {
    struct SUIPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPER>(arg0, 6, b"SUIPER", b"Suiperman", b"its The real SUIPERMAN !!, dont falling to the scam", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0550_6bb4093cad.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

