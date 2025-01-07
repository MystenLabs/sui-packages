module 0xb51778961b65f7c0203314156027098189395a787392f1e08eb7cced26ce7278::FungalTooth {
    struct FUNGALTOOTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUNGALTOOTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUNGALTOOTH>(arg0, 0, b"COS", b"Fungal Tooth", b"Ripped from the gums of beasts... refusing to be understood...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Fungal_Tooth.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUNGALTOOTH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNGALTOOTH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

