module 0xe50f088c54ca65ae6f2b31913c33ce001b2c7b0212015d898e6a5c570d09ed2d::silly {
    struct SILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SILLY>(arg0, 6, b"SILLY", b"Silly Salmon", b"The splashiest meme token on the SUI network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_15_20_39_739c3446a4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

