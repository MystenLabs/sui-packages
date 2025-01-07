module 0xc9e2739d2af9c80a101702539fb9b48be364d36e48f4514f282c2430c2ab0a50::poppy {
    struct POPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPPY>(arg0, 6, b"POPPY", b"POPPY SUI", b"Poppy is inspired by one of the few Matt Furie personas that can be said to be truly unique. Poppy will ignited the meme revolution with countless memes that showcased his unparalleled power in every form and cemented his renowned status. Originating in online culture, Poppy is a movement that can unites people and provides joy and comedy throughout the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_22_37_01_ab0c1bbdb4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

