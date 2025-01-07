module 0x3300c2674f85a05a3f5453fa2350c415571c64869f47e5ba3165b7e3885651de::lobs {
    struct LOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOBS>(arg0, 6, b"LOBS", b"SuiLobster", b"When $LOBS isn't pulling pranks, he's pulling profits. Whether it's stonks or memes, this little red devil knows how to keep things spicyand your bags heavy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lobster_guide_hero_fdcdfdfa68.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

