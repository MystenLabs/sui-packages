module 0x18f6ed93af2c1344e6d3cc681a70b25c2c4fe2f7b8f54745109ea6cae8d13e5e::drb {
    struct DRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRB>(arg0, 6, b"DRB", b"Dragon Ball", b"dragon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cryptonews.com/wp-content/uploads/2024/01/1705067977-dallc2b7e-2024-01-12-16-57-40-a-dynamic-scene-depicting-a-group-of-5-6-meme-coin-mascots-each-ready-to-fight-representing-various-cryptocurrencies-the-group-includes-the-dogecoi-min.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRB>>(v1);
    }

    // decompiled from Move bytecode v6
}

