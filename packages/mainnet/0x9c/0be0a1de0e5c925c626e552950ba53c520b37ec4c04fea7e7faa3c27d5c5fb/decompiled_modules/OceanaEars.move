module 0x9c0be0a1de0e5c925c626e552950ba53c520b37ec4c04fea7e7faa3c27d5c5fb::OceanaEars {
    struct OCEANAEARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCEANAEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCEANAEARS>(arg0, 0, b"COS", b"Oceana Ears", b"Adornments hewn from idle hands, out to sea.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Oceana_Ears.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCEANAEARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCEANAEARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

