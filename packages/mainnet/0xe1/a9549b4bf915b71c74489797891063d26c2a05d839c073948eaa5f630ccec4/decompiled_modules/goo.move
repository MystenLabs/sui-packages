module 0xe1a9549b4bf915b71c74489797891063d26c2a05d839c073948eaa5f630ccec4::goo {
    struct GOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOO>(arg0, 6, b"GOO", b"GOOGLE", b"Search the world's information, including webpages, images, videos and more. Google has many special features to help you find exactly what you're looking", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifv7gztm6s6z2mlnwyd32xn47u53itoqdzgfmkecxt4anot3mabgq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GOO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

