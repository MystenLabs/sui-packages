module 0x823388c60aed6d3931686b618eecd553b4aa9fe33d618c0a7ace2caf5954637c::RareTraitPack {
    struct RARETRAITPACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: RARETRAITPACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RARETRAITPACK>(arg0, 0, b"PACK", b"Rare Trait Pack", b"Waiting for description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/packs/Rare_Trait_Pack.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RARETRAITPACK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RARETRAITPACK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

