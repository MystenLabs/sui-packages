module 0xc3d44c03a1121691da48dcf8778f8db0524d3a9fcfd19086ffdd418bbacb24a7::UncommonTraitPack {
    struct UNCOMMONTRAITPACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNCOMMONTRAITPACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNCOMMONTRAITPACK>(arg0, 0, b"PACK", b"Uncommon Trait Pack", b"Waiting for description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/packs/Uncommon_Trait_Pack.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNCOMMONTRAITPACK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNCOMMONTRAITPACK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

