module 0x6bd97c4b771c5a392d14a4e61a69c843c27f508b65593c198ab047d391158a5b::AlienidJellynode {
    struct ALIENIDJELLYNODE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALIENIDJELLYNODE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALIENIDJELLYNODE>(arg0, 0, b"COS", b"Alienid Jellynode", b"Blobby flesh-matter of oceans aloft...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Alienid_Jellynode.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALIENIDJELLYNODE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALIENIDJELLYNODE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

