module 0x6f68049da5a25d3c9186aff4df77214659cdf7bb380c1085996452ac6c617c02::GoldenOldOlympianCrown {
    struct GOLDENOLDOLYMPIANCROWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDENOLDOLYMPIANCROWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDENOLDOLYMPIANCROWN>(arg0, 0, b"COS", b"Golden Old Olympian Crown", b"A throne... an empty chair... a scepter swept across the floor...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Golden_Old_Olympian_Crown.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOLDENOLDOLYMPIANCROWN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDENOLDOLYMPIANCROWN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

