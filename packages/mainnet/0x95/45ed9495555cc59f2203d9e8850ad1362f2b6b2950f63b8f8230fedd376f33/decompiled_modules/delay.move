module 0x9545ed9495555cc59f2203d9e8850ad1362f2b6b2950f63b8f8230fedd376f33::delay {
    struct DELAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DELAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DELAY>(arg0, 6, b"DELAY", b"DelaySuiCoin", b"$DELAY - One of the most deflationary meme coins out there, which is kinds the opposite of how most other meme coin fare", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000024223_230c098568.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DELAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DELAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

