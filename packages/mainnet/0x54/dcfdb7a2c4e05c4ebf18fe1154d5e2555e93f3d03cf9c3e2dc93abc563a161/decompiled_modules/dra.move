module 0x54dcfdb7a2c4e05c4ebf18fe1154d5e2555e93f3d03cf9c3e2dc93abc563a161::dra {
    struct DRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRA>(arg0, 6, b"DRA", b"DRAGON BALL", b"dragon ball", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cryptonews.com/wp-content/uploads/2024/01/1705067977-dallc2b7e-2024-01-12-16-57-40-a-dynamic-scene-depicting-a-group-of-5-6-meme-coin-mascots-each-ready-to-fight-representing-various-cryptocurrencies-the-group-includes-the-dogecoi-min.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

