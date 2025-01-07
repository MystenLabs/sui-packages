module 0x654a9ef3c3a3d1793f5d0006a8912c398b301162c7db3965bf1e2e4cf4726429::SashoftheDivineGates {
    struct SASHOFTHEDIVINEGATES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASHOFTHEDIVINEGATES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASHOFTHEDIVINEGATES>(arg0, 0, b"COS", b"Sash of the Divine Gates", b"Left behind on a crumbling archway...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Sash_of_the_Divine_Gates.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SASHOFTHEDIVINEGATES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASHOFTHEDIVINEGATES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

