module 0xcfb4c70a19f082843d3c8eed599ee1e952023aa636cb7cb313803f5dd932440d::pansu {
    struct PANSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANSU>(arg0, 6, b"PANSU", b"Pansui", b"$PANSU Innovative blockchain ecosystem for a decentralized future. Join the fast, safe, and scalable digital financial revolution.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia4w5ngyrrgpdwzv4ddtrrbsa2v7hlfqgbbp6rl54wwhsgwyotrs4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PANSU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

