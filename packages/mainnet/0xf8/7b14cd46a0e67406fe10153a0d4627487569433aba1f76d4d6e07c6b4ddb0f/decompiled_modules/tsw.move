module 0xf87b14cd46a0e67406fe10153a0d4627487569433aba1f76d4d6e07c6b4ddb0f::tsw {
    struct TSW has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSW>(arg0, 6, b"TSW", b"Taylor SW", b"Taylor ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cryptonews.com/wp-content/uploads/2024/01/1705067977-dallc2b7e-2024-01-12-16-57-40-a-dynamic-scene-depicting-a-group-of-5-6-meme-coin-mascots-each-ready-to-fight-representing-various-cryptocurrencies-the-group-includes-the-dogecoi-min.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSW>>(v1);
    }

    // decompiled from Move bytecode v6
}

