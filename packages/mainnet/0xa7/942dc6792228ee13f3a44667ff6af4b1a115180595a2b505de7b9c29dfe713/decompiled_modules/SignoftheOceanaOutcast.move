module 0xa7942dc6792228ee13f3a44667ff6af4b1a115180595a2b505de7b9c29dfe713::SignoftheOceanaOutcast {
    struct SIGNOFTHEOCEANAOUTCAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIGNOFTHEOCEANAOUTCAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIGNOFTHEOCEANAOUTCAST>(arg0, 0, b"COS", b"Sign of the Oceana Outcast", b"Crossing the horizon... still dreaming of home...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Sign_of_the_Oceana_Outcast.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIGNOFTHEOCEANAOUTCAST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIGNOFTHEOCEANAOUTCAST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

