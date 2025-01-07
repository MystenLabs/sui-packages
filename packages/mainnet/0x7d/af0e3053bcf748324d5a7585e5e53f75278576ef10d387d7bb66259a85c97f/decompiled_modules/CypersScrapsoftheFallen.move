module 0x7daf0e3053bcf748324d5a7585e5e53f75278576ef10d387d7bb66259a85c97f::CypersScrapsoftheFallen {
    struct CYPERSSCRAPSOFTHEFALLEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYPERSSCRAPSOFTHEFALLEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYPERSSCRAPSOFTHEFALLEN>(arg0, 0, b"COS", b"Cyper's Scraps of the Fallen", b"In war, so much is wasted...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Cypers_Scraps_of_the_Fallen.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CYPERSSCRAPSOFTHEFALLEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYPERSSCRAPSOFTHEFALLEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

