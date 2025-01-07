module 0x6c02a636eb05db59086d595ef829e2a408ccb0cc6cb6a7570c8737999dbc1f14::ta {
    struct TA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TA>(arg0, 6, b"TA", b"Talon", b"d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cryptonews.com/wp-content/uploads/2024/01/1705067977-dallc2b7e-2024-01-12-16-57-40-a-dynamic-scene-depicting-a-group-of-5-6-meme-coin-mascots-each-ready-to-fight-representing-various-cryptocurrencies-the-group-includes-the-dogecoi-min.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TA>>(v1);
    }

    // decompiled from Move bytecode v6
}

