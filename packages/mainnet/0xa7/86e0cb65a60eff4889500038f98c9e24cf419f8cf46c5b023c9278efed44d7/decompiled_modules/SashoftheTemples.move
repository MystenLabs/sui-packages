module 0xa786e0cb65a60eff4889500038f98c9e24cf419f8cf46c5b023c9278efed44d7::SashoftheTemples {
    struct SASHOFTHETEMPLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASHOFTHETEMPLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASHOFTHETEMPLES>(arg0, 0, b"COS", b"Sash of the Temples", b"Left behind in a shrouded urn...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Sash_of_the_Temples.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SASHOFTHETEMPLES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASHOFTHETEMPLES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

