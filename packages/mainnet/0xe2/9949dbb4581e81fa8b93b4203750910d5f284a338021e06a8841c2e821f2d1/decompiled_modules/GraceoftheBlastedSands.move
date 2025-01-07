module 0xe29949dbb4581e81fa8b93b4203750910d5f284a338021e06a8841c2e821f2d1::GraceoftheBlastedSands {
    struct GRACEOFTHEBLASTEDSANDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRACEOFTHEBLASTEDSANDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRACEOFTHEBLASTEDSANDS>(arg0, 0, b"COS", b"Grace of the Blasted Sands", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Grace_of_the_Blasted_Sands.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRACEOFTHEBLASTEDSANDS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRACEOFTHEBLASTEDSANDS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

