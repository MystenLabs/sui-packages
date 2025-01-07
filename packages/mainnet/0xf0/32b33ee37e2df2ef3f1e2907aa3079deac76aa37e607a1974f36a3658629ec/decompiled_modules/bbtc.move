module 0xf032b33ee37e2df2ef3f1e2907aa3079deac76aa37e607a1974f36a3658629ec::bbtc {
    struct BBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBTC>(arg0, 6, b"BBTC", b"Baby BTC", b"BTC- Baby is born", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000035448_9f8996e141.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

