module 0x99e27ecf5dbc5940ab8f764bfe9f7750707662409c67348063e1a5b980482cf1::chad {
    struct CHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAD>(arg0, 6, b"CHAD", b"SUICHAD", b"Built on Sui. Powered by Memes. Led by Chads.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifyw2evv6djszyj4iak7pxoupp5ia2uhf2cwzea5iblwjh6o5xt3q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHAD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

