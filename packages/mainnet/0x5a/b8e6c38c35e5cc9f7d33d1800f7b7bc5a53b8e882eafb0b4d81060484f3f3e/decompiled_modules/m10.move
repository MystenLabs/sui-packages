module 0x5ab8e6c38c35e5cc9f7d33d1800f7b7bc5a53b8e882eafb0b4d81060484f3f3e::m10 {
    struct M10 has drop {
        dummy_field: bool,
    }

    fun init(arg0: M10, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M10>(arg0, 6, b"M10", b"Messi", b"goll", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiga3bfhajxaev4evrh6udxnzklmu4rjguov5bi3zjuzkjh45li7qe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M10>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<M10>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

