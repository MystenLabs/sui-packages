module 0x42274bb4ca8366ea8104f068240784a19bf958763b2bd81768fa2436c5a4a5d6::sophia {
    struct SOPHIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOPHIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOPHIA>(arg0, 6, b"SOPHIA", b"Sophia Grok Companion", b"Meet Sophia, your adorable AI companion in the world of memecoins. Cute, intelligent, and ready to revolutionize your crypto experience with kawaii charm and cutting-edge technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeig7jagjs2yakqkj7kvj5f3l5oefv2orhzreqaormilvqu3ddfgk2y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOPHIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SOPHIA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

