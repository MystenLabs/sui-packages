module 0x3d8beb623abd9112fc63315cfa1a72ee61b545ef83734499a01d6174ab367324::toto {
    struct TOTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOTO>(arg0, 6, b"TOTO", b"TOTO SUI", b"A Tiny Bite for a Huge Profit!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiaatuh6qwqf7r7lqkfjkusqwusisroyv453xqbvvud2sfiwolmdgm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOTO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

