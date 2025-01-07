module 0x96bc81f89e6aac06b1ec506abb33ac92388baab22ca5155cb7871395e26111f::FeatherLeaf {
    struct FEATHERLEAF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEATHERLEAF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEATHERLEAF>(arg0, 0, b"COS", b"FeatherLeaf", b"Plucked from the owl-spoken cloud shade... gift from above...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_FeatherLeaf.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FEATHERLEAF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEATHERLEAF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

