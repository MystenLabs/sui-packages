module 0xe77d201a03b24c4e27e66238b9c8d32b92c7eebf33d2dda5313c3d3a645fe2f8::tas {
    struct TAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAS>(arg0, 6, b"TAS", b"Taylor SW", b"taylor", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cryptonews.com/wp-content/uploads/2024/01/1705067977-dallc2b7e-2024-01-12-16-57-40-a-dynamic-scene-depicting-a-group-of-5-6-meme-coin-mascots-each-ready-to-fight-representing-various-cryptocurrencies-the-group-includes-the-dogecoi-min.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

