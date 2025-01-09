module 0x1d39663598a979f42ba6c29237d08450cf9fc7bce5e2dde6d40a044502f01355::azsh {
    struct AZSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AZSH>(arg0, 6, b"AZSH", b"AzerothShiba on sui", b"Welcome to the world of AzerothShiba! Explore the world of Shiba Inu and own unique NFTs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_09_09_11_25_736ea0b65d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AZSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

