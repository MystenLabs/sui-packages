module 0x95e6c074f2c876692f4f5a9c2a134814deb10438724078ff26bd89b9997d9de4::csc {
    struct CSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSC>(arg0, 6, b"CSC", b"Cooking Sui Coin", b"Let me cook until smoky, and a fragrant aroma for sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic6pt42ndhqrbtorvm356bmkuenjlvihmigzrup7nubl5tcmnoyxq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CSC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

