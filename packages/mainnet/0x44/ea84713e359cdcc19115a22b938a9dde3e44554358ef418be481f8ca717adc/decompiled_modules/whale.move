module 0x44ea84713e359cdcc19115a22b938a9dde3e44554358ef418be481f8ca717adc::whale {
    struct WHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WHALE>(arg0, 6, b"WHALE", b"Whale Tracker Ai", b"Tracks large purchase and holds by crypto whales of micro cap cryptocurrencies with a fully diluted market cap under 1 million US dollars that have been listed on Dextools in the last two days.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_8102_b69b6fe81b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WHALE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

