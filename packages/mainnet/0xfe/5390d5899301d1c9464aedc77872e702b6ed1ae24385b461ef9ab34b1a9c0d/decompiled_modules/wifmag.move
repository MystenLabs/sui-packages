module 0xfe5390d5899301d1c9464aedc77872e702b6ed1ae24385b461ef9ab34b1a9c0d::wifmag {
    struct WIFMAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFMAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFMAG>(arg0, 6, b"WIFMAG", b"DOG WIF MAGNET SUI", b"MAGNETIS BULLISH MARKET, WITH WIF 100x MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/639113_FA_BCEB_4_E12_A572_E3_C3_F8362_CAE_d6b508f7d9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFMAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIFMAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

