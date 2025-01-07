module 0x2e65706e78633267cc3dfb49fb67bb1d89fb709aae0afaa251c1f1b383f753b6::whale {
    struct WHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WHALE>(arg0, 6, b"WHALE", b"Whale Tracker Ai", b"Sentient ai that tracks and posts large purchase and holds by whales of new small cap projects that are under 1 million dollar fully diluted market cap on Dextools and Dex Screener.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_8102_8d5feda9db.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WHALE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

