module 0x87d121a8b7fb6c0ad9207ffcfc63b9383758c5cf6d8ff5a2d3085a2a47334d50::suino {
    struct SUINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINO>(arg0, 6, b"SUINO", b"Articsuino", b"Legendary bird Pokemon that is said to appear to doomed degens who are lost in the cold icy trenches.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibrmy2bgi4kuleot4fucdviimhy7hkbl24z47nsi7lps5epm6fnji")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUINO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

