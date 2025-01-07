module 0x13ed18cc503244f78d18588d38a6c176a52231d6e9a29d7a66c2b644585ad72c::SeraphWingsofWadacrespo {
    struct SERAPHWINGSOFWADACRESPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SERAPHWINGSOFWADACRESPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SERAPHWINGSOFWADACRESPO>(arg0, 0, b"COS", b"Seraph Wings of Wadacrespo", b"Downward swept through a Glutton gloomswarm.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Seraph_Wings_of_Wadacrespo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SERAPHWINGSOFWADACRESPO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SERAPHWINGSOFWADACRESPO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

