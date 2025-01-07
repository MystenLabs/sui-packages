module 0x2c74308d68eab7c867a9450cc4eea75e51cd045c370cf0e90439ccf271f35d01::EnclaveLotusBell {
    struct ENCLAVELOTUSBELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENCLAVELOTUSBELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENCLAVELOTUSBELL>(arg0, 0, b"COS", b"Enclave Lotus Bell", b"It will ring once, and only once, before the end of all things.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Enclave_Lotus_Bell.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ENCLAVELOTUSBELL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENCLAVELOTUSBELL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

