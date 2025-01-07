module 0x5fcb410279728eb1c5d81ee6e9671f54b7860f991cd43f668379454c42290f3f::SingleRareTraitPack {
    struct SINGLERARETRAITPACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SINGLERARETRAITPACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SINGLERARETRAITPACK>(arg0, 0, b"PACK", b"Single Rare Trait Pack", b"undefined", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/packs/Single_Rare_Trait_Pack.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SINGLERARETRAITPACK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SINGLERARETRAITPACK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

