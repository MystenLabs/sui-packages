module 0x48eddde241ca0cdab1b79abbc998f3a62b9081f07cc5c135bafde2f49e96466f::msui {
    struct MSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSUI>(arg0, 6, b"MSui", b"Meme Sea", b"The cat, dog, hamster, and fish present in Meme Sea prepare to fight with arms. The order starts with the weapons you get from the island coming from level 1.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0948_1febc18c8b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

