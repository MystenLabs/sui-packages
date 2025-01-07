module 0x30f914d2d6d171447e01022774fa7d78ab7644ec4a337c2d7b7a6d859972c76d::fick {
    struct FICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FICK>(arg0, 6, b"FICK", b"Fishstick", b"Fishstick, the most memeable Fortnite skin is now on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_02_22_48_24_d56c21d741.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

