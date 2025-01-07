module 0x87689398d26914ae899484e788bf02a30eee2d9c4af9b2c6b97423402a785631::HavensBranchEars {
    struct HAVENSBRANCHEARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAVENSBRANCHEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAVENSBRANCHEARS>(arg0, 0, b"COS", b"Havens Branch-Ears", b"Seek divination among the highest of heights.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Havens_Branch-Ears.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAVENSBRANCHEARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAVENSBRANCHEARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

