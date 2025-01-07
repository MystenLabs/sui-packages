module 0x3709c18e23a8b23c9d081a90845bc7147e3563e33c4737bc9b719134f99d853c::DivineBlossom {
    struct DIVINEBLOSSOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIVINEBLOSSOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIVINEBLOSSOM>(arg0, 0, b"COS", b"Divine Blossom", b"Ever-thin... with blooming light...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Divine_Blossom.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIVINEBLOSSOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIVINEBLOSSOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

