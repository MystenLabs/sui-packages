module 0xcb3b5df68a5f844dfe26d7225b9924aa2eaea5a23a6fcb6c16d2deecd4d0cc2e::TravelersCowl {
    struct TRAVELERSCOWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRAVELERSCOWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRAVELERSCOWL>(arg0, 0, b"COS", b"Traveler's Cowl", b"Stay safe on shaded nights... kept still from the bandits...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Traveler's_Cowl.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRAVELERSCOWL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRAVELERSCOWL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

