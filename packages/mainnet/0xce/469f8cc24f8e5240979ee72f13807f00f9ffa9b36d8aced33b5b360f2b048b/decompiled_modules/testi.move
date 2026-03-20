module 0xce469f8cc24f8e5240979ee72f13807f00f9ffa9b36d8aced33b5b360f2b048b::testi {
    struct TESTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTI>(arg0, 6, b"Testi", b"Test", b"Testuuuu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihpchrernzsr4d2dexnhvzefyp2o2nkiuru3tjixe3bdvgpkaushi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

