module 0x3ab2116f6acd8e51efcb5ee64aed6aae8fddddb11c1e2944ab80126515fbab1e::locked {
    struct LOCKED has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOCKED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOCKED>(arg0, 9, b"LOCKED", b"Lockin", b"Locked is a meme token symbolizing untapped potential and exclusivity, ready to explode once the market \"unlocks.\" It teases the idea of massive gains awaiting holders during the next super cycle. Simple, mysterious, and full of hype!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1514860851081142277/9PJw_lDi.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LOCKED>(&mut v2, 600000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOCKED>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOCKED>>(v1);
    }

    // decompiled from Move bytecode v6
}

