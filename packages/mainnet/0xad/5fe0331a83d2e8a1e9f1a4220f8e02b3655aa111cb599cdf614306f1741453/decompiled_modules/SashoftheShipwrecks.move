module 0xad5fe0331a83d2e8a1e9f1a4220f8e02b3655aa111cb599cdf614306f1741453::SashoftheShipwrecks {
    struct SASHOFTHESHIPWRECKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASHOFTHESHIPWRECKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASHOFTHESHIPWRECKS>(arg0, 0, b"COS", b"Sash of the Shipwrecks", b"Left behind in a capsized rig...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Sash_of_the_Shipwrecks.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SASHOFTHESHIPWRECKS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASHOFTHESHIPWRECKS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

