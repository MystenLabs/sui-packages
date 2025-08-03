module 0x31bbe989b8551dfe252db1f8e7609df3ffd0419b5781711e4a304a83403eab5d::fud {
    struct FUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUD>(arg0, 6, b"FUD", b"FUD Ai", b"Leveraging Al to destroy spam and FUD on Telegram.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigxyd7zdwy2bfes7mubanofwdmb5cosisocm3jnxnru5j264my2xe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FUD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

