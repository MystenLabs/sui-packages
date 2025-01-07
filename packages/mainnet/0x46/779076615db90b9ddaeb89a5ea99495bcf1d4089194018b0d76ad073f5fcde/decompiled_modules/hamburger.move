module 0x46779076615db90b9ddaeb89a5ea99495bcf1d4089194018b0d76ad073f5fcde::hamburger {
    struct HAMBURGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMBURGER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HAMBURGER>(arg0, 6, b"HAMBURGER", b"HAMBURGER", b"SuiEmoji Hamburger", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/hamburger.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HAMBURGER>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMBURGER>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

