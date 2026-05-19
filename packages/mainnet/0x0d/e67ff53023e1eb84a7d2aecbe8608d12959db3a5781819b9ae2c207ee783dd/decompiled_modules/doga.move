module 0xde67ff53023e1eb84a7d2aecbe8608d12959db3a5781819b9ae2c207ee783dd::doga {
    struct DOGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGA>(arg0, 9, b"DOGA", b"Doga Finance", b"Doga Finance Test Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmVKTy4xHheHBq5idhD2xRQALi2Pa6e7EWoF6XJZmHnHcu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOGA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

