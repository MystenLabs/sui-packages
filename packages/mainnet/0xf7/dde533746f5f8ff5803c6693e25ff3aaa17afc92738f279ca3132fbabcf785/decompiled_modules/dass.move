module 0xf7dde533746f5f8ff5803c6693e25ff3aaa17afc92738f279ca3132fbabcf785::dass {
    struct DASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DASS>(arg0, 6, b"DASS", b"Dog Wif Asshole", b"mmmmmm feeling gud in here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiawymbrko6iemyk5p5xfvywo7qlysc73ihzroxqbry2yji4svx64e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DASS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

