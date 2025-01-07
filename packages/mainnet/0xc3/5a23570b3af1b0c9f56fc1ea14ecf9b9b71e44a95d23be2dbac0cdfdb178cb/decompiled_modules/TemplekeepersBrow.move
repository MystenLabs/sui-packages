module 0xc35a23570b3af1b0c9f56fc1ea14ecf9b9b71e44a95d23be2dbac0cdfdb178cb::TemplekeepersBrow {
    struct TEMPLEKEEPERSBROW has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEMPLEKEEPERSBROW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEMPLEKEEPERSBROW>(arg0, 0, b"COS", b"Templekeeper's Brow", b"Kind one, take pity on us writhing things...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Templekeeper's_Brow.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEMPLEKEEPERSBROW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEMPLEKEEPERSBROW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

