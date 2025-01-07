module 0x4351e2b59c20b93d6a6d5e9f7892005dc84799427298a265156be659af73dcf5::SacredCoreCircuitry {
    struct SACREDCORECIRCUITRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SACREDCORECIRCUITRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SACREDCORECIRCUITRY>(arg0, 0, b"COS", b"SacredCore Circuitry", b"What lost God would discard such elegant machinery?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_SacredCore_Circuitry.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SACREDCORECIRCUITRY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SACREDCORECIRCUITRY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

