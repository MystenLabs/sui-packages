module 0xc388b1613b2f26f509ac21b426fb0175513fbd7d31e394070d3fe770a6c00d06::suikyu {
    struct SUIKYU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKYU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKYU>(arg0, 6, b"SUIKYU", b"Suikyu Yume Pokemon", b"Suikyu Yume Pokemon builds the first sleep to earn Pokemon game on SuiNetwork.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidi2xgiqgdcyguppttxixotjypikrezug5eziuh5qfwob6yiekuku")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKYU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIKYU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

