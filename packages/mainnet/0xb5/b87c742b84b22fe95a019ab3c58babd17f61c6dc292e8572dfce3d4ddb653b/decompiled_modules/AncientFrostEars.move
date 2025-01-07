module 0xb5b87c742b84b22fe95a019ab3c58babd17f61c6dc292e8572dfce3d4ddb653b::AncientFrostEars {
    struct ANCIENTFROSTEARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANCIENTFROSTEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANCIENTFROSTEARS>(arg0, 0, b"COS", b"Ancient Frost Ears", b"Cloaked, forever still, in the icicle brackens of a future unknown.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Ancient_Frost_Ears.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANCIENTFROSTEARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANCIENTFROSTEARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

