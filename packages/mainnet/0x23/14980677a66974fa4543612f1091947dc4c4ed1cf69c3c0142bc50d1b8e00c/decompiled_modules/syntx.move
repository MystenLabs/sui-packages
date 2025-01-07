module 0x2314980677a66974fa4543612f1091947dc4c4ed1cf69c3c0142bc50d1b8e00c::syntx {
    struct SYNTX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYNTX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYNTX>(arg0, 6, b"SYNTX", b"SYNTX AI Bot", b"Your Edge in the Crypto Market. AI-powered tools to track wallets, analyze trends, and spot winning tokens.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/56345634_670231dc32.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYNTX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYNTX>>(v1);
    }

    // decompiled from Move bytecode v6
}

