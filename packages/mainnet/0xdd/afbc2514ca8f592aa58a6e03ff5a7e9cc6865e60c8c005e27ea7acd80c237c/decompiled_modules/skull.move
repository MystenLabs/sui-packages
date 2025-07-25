module 0xddafbc2514ca8f592aa58a6e03ff5a7e9cc6865e60c8c005e27ea7acd80c237c::skull {
    struct SKULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKULL>(arg0, 6, b"SKULL", b"SKULOURFUL", b"If you think you know whats inside your head. think again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicxuum75e6ovoc3i2ll5nmebfj3y4lbzbvwihizvbtyxnmzrdf2zu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SKULL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

