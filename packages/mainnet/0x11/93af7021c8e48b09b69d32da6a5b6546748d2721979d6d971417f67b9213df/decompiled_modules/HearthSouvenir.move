module 0x1193af7021c8e48b09b69d32da6a5b6546748d2721979d6d971417f67b9213df::HearthSouvenir {
    struct HEARTHSOUVENIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEARTHSOUVENIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEARTHSOUVENIR>(arg0, 0, b"COS", b"Hearth Souvenir", b"A little trinket-a keepsake-from adventures forgotten.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Hearth_Souvenir.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEARTHSOUVENIR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEARTHSOUVENIR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

