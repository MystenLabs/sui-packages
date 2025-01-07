module 0x25074e128c864ad3671157e8403ac38c5afe8afdcbe7d097ef064400fdd06d9c::AttendantEars {
    struct ATTENDANTEARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATTENDANTEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATTENDANTEARS>(arg0, 0, b"COS", b"Attendant Ears", b"Protect this place... keep it clean... quell the noises...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Attendant_Ears.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ATTENDANTEARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATTENDANTEARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

