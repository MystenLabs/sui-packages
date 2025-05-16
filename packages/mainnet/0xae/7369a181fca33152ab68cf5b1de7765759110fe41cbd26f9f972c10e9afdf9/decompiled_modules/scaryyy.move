module 0xae7369a181fca33152ab68cf5b1de7765759110fe41cbd26f9f972c10e9afdf9::scaryyy {
    struct SCARYYY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCARYYY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCARYYY>(arg0, 6, b"Scaryyy", b"Scary", b"Scary, scary", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicf56hf6lxwqmz3o5jy6kxr4jf725f3nmemcezlts2grkgjse7tom")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCARYYY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SCARYYY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

