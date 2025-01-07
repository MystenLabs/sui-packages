module 0xbd040adf5015d65ab3d96239eebb26dcd46fb5aba8dd361d5a7f4c10573691aa::chillbra {
    struct CHILLBRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLBRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLBRA>(arg0, 6, b"CHILLBRA", b"Justchillbra", b"CHILLBRA: Andrew Cobra Tate meets the Year of the Snake in 2025. Relaxed, confident, and chill AF.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000050586_6b51b366ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLBRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLBRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

