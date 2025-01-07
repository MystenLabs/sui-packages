module 0x93ec98f9b9c19c6d742c5a577c5e65ce2588f54d8f830e575a3a76eef75e5c3::CommonTraitPack {
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

