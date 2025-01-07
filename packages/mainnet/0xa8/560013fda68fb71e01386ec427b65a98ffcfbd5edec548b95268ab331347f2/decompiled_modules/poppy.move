module 0xa8560013fda68fb71e01386ec427b65a98ffcfbd5edec548b95268ab331347f2::poppy {
    struct POPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPPY>(arg0, 6, b"POPPY", b"POPPY SUI", b"Poppy is inspired by one of the few Matt Furie personas that can be said to be truly unique. Poppy will ignited the meme revolution with countless memes that showcased his unparalleled power in every form and cemented his renowned status. Originating in online culture, Poppy is a movement that can unites people and provides joy and comedy throughout the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_25_04_16_30_40bd3dc3d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

