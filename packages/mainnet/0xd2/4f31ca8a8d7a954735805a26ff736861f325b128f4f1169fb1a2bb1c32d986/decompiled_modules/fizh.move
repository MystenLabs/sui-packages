module 0xd24f31ca8a8d7a954735805a26ff736861f325b128f4f1169fb1a2bb1c32d986::fizh {
    struct FIZH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIZH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIZH>(arg0, 6, b"FIZH", b"King Fizh", b"Life is More Funny at Sea! Conquering the Ocean!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreife6dopzdsi36g262fsavrj63lyyitsnbop7g522xqccse4mjaneu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIZH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FIZH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

