module 0x5ba54bf18b294c42e36bb48741690d1587e842fad6177871126fa3b27916b9d3::partyguy {
    struct PARTYGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARTYGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PARTYGUY>(arg0, 6, b"PARTYGUY", b"Sui Party Guy", b"Party Guy On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifc6hqieihm5kcxg3bqne5f4inkqcfk3vn4435o6gbxxdad55c4uq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARTYGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PARTYGUY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

