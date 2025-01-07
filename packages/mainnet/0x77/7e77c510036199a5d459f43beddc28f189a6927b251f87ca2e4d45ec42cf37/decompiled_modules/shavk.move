module 0x777e77c510036199a5d459f43beddc28f189a6927b251f87ca2e4d45ec42cf37::shavk {
    struct SHAVK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAVK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAVK>(arg0, 6, b"SHAVK", b"SHARK OF SUI", b"SHAVK is guarding the SUI memecoins from big whales", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_05_09_25_50_244460d1b7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAVK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHAVK>>(v1);
    }

    // decompiled from Move bytecode v6
}

