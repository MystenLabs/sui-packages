module 0x4a9ec4d69d0c460a59a2c1ea82730542e7fd32ab943257605d48f91b1fd686dd::suino {
    struct SUINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINO>(arg0, 6, b"SUINO", b"Articsuino", b"Legendary bird Pokemon that is said to appear to doomed degens who are lost in the cold icy trenches.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidwb65fpzxgjxjlsh5hgjyguur3rlph5vugqk3br6hp6jsnk5o2ae")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUINO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

