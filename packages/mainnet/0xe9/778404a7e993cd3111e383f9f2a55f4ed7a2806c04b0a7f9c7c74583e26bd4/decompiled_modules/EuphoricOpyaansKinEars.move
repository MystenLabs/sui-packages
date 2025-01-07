module 0xe9778404a7e993cd3111e383f9f2a55f4ed7a2806c04b0a7f9c7c74583e26bd4::EuphoricOpyaansKinEars {
    struct EUPHORICOPYAANSKINEARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EUPHORICOPYAANSKINEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EUPHORICOPYAANSKINEARS>(arg0, 0, b"COS", b"Euphoric Opyaan's Kin Ears", b"Stamp and dance and scream and laugh-Opyaan welcomes all!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Euphoric_Opyaan's_Kin_Ears.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EUPHORICOPYAANSKINEARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EUPHORICOPYAANSKINEARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

