module 0xf5c65878485e37f4ac049df598fff410cf4f542f1d3bbb72298f32a8faddb990::dmon {
    struct DMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMON>(arg0, 6, b"DMON", b"DIGIMON", b"It's not Pokemon it's Digimon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifvxvrw2tczwe32t7h744kyxzdtndwxms7wzio5fj44krwzddbm3u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DMON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

