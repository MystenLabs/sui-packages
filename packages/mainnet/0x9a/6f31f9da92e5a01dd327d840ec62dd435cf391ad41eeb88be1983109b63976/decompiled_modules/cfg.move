module 0x9a6f31f9da92e5a01dd327d840ec62dd435cf391ad41eeb88be1983109b63976::cfg {
    struct CFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CFG>(arg0, 6, b"CFG", b"ChildFrog", b"FROG ON SUI ECO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiepj67f5vwo7a6kezbndesr3tbhstbpidwrujbiuhiulpj4qimh3e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CFG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

