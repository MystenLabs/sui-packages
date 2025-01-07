module 0xd0ad8c626897e5fe03fd92f34a8f2056543c626131f5ff6c8720a74cc5a2bf09::BootsoftheMyrrh {
    struct BOOTSOFTHEMYRRH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOTSOFTHEMYRRH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOTSOFTHEMYRRH>(arg0, 0, b"COS", b"Boots of the Myrrh", b"The Aurahma wish you a happy 2022 holiday and new year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Feet_Boots_of_the_Myrrh.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOTSOFTHEMYRRH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOTSOFTHEMYRRH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

