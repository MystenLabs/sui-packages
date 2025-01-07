module 0xfaf0980f0514eaaf4b24537909cdf9d30725773ce2d77fbbaf62e3957aff8c33::fundog {
    struct FUNDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUNDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUNDOG>(arg0, 6, b"FUNDOG", b"FUNDOG COIN", b"Dog staying with his professor for years", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_06_17_13_12_399eeb6d72.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUNDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

