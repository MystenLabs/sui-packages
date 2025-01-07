module 0x5fd63b0b5df342febae21d31671bf8c154261f1f7c2682e13b755e9e8c6f1b14::moondawg {
    struct MOONDAWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONDAWG>(arg0, 6, b"MOONDAWG", b"SuiMoonDawg", b"At MoonDawg, we are on a mission to revolutionize the world of cryptocurrency and blockchain technology. Our token, inspired by the dynamic and playful spirit of dogs, embodies a unique blend of fun and functionality, creating a vibrant and engaged community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241002_234725_547a3ef948.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONDAWG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONDAWG>>(v1);
    }

    // decompiled from Move bytecode v6
}

