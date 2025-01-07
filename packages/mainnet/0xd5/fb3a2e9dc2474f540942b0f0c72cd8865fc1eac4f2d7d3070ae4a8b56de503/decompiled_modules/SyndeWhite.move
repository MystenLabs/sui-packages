module 0xd5fb3a2e9dc2474f540942b0f0c72cd8865fc1eac4f2d7d3070ae4a8b56de503::SyndeWhite {
    struct SYNDEWHITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYNDEWHITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYNDEWHITE>(arg0, 0, b"COS", b"Synde White", b"Aground on flowing grass.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Body_Synde_White.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SYNDEWHITE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYNDEWHITE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

