module 0x999176b11671bf782d1b3c68d3ff290fc9f1b1d2b76ebffe13fd046e7d1bf2f2::AurahwellEars {
    struct AURAHWELLEARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURAHWELLEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AURAHWELLEARS>(arg0, 0, b"COS", b"Aurahwell Ears", b"Chants and hums... rolling back through time... to the beginning.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Aurahwell_Ears.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AURAHWELLEARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AURAHWELLEARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

