module 0x515149a7531641ec8a1dd1a86949f0e8a5464ea2dd2fd6756a084926534164f9::ChargedAncientFrostEars {
    struct CHARGEDANCIENTFROSTEARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARGEDANCIENTFROSTEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHARGEDANCIENTFROSTEARS>(arg0, 0, b"COS", b"Charged Ancient Frost Ears", b"Release the knowledge within-but are they ready to know?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Charged_Ancient_Frost_Ears.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHARGEDANCIENTFROSTEARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARGEDANCIENTFROSTEARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

