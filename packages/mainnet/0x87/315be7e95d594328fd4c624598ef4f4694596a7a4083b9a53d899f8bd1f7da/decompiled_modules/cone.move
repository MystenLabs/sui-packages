module 0x87315be7e95d594328fd4c624598ef4f4694596a7a4083b9a53d899f8bd1f7da::cone {
    struct CONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONE>(arg0, 9, b"CONE", b"Bitcone", b"Bitcone from r/coneheads subreddit. The OG meme coin based on the Reddit Collectible Avatars Conehead art piece", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8ff5455f00994ba0bba3b4ef449307a1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CONE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

