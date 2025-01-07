module 0x6a8863decb822e290636086bc065527d390a2fa2e87f2e3649bbb92af2a868a6::GraceoftheValaan {
    struct GRACEOFTHEVALAAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRACEOFTHEVALAAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRACEOFTHEVALAAN>(arg0, 0, b"COS", b"Grace of the Valaan", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Grace_of_the_Valaan.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRACEOFTHEVALAAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRACEOFTHEVALAAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

