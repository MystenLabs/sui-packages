module 0x83848a3032cfec1140113c4894bb926ed35de98d470f006660faf6fbd1161a83::suitoro {
    struct SUITORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITORO>(arg0, 6, b"SUITORO", b"Suitoro", b"Most bullish meme in the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suitoro_twitter_profile_a1460d11c2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITORO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITORO>>(v1);
    }

    // decompiled from Move bytecode v6
}

