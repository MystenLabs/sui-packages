module 0xa5e295b8a02d9dcdd7a85d1d1f6c0dcd5b714c7be6fda27b25eb332adc2eda99::CommonTraitPack {
    struct COMMONTRAITPACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMMONTRAITPACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMMONTRAITPACK>(arg0, 0, b"PACK", b"Common Trait Pack", b"Waiting for description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/packs/Common_Trait_Pack.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COMMONTRAITPACK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMMONTRAITPACK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

