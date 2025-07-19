module 0x7f0118bbbc623968e26c4728755d5c7e96176ca577792603b3832a41f6bf2aa7::sakamoto {
    struct SAKAMOTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAKAMOTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAKAMOTO>(arg0, 6, b"SAKAMOTO", b"Sakamoto Neko", b"Sakamoto Neko = Satoshi's Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidbml645kmdmrnqoobf4ck6usbovc5vrwkd5z64waoejcoqjkp5rm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAKAMOTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAKAMOTO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

