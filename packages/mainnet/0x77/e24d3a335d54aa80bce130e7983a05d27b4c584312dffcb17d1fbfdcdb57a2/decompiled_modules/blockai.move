module 0x77e24d3a335d54aa80bce130e7983a05d27b4c584312dffcb17d1fbfdcdb57a2::blockai {
    struct BLOCKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOCKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOCKAI>(arg0, 6, b"BlockAI", b"Block AI", b"NFT Block", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logos_6ee84c61df.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOCKAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOCKAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

