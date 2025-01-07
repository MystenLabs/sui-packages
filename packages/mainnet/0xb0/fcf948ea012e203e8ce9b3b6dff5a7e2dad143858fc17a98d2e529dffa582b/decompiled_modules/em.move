module 0xb0fcf948ea012e203e8ce9b3b6dff5a7e2dad143858fc17a98d2e529dffa582b::em {
    struct EM has drop {
        dummy_field: bool,
    }

    fun init(arg0: EM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EM>(arg0, 6, b"EM", b"Elon Musk", b"elon m", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cryptonews.com/wp-content/uploads/2024/01/1705067977-dallc2b7e-2024-01-12-16-57-40-a-dynamic-scene-depicting-a-group-of-5-6-meme-coin-mascots-each-ready-to-fight-representing-various-cryptocurrencies-the-group-includes-the-dogecoi-min.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EM>>(v1);
    }

    // decompiled from Move bytecode v6
}

