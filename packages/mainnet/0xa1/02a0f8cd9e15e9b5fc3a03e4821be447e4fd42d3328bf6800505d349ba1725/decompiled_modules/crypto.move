module 0xa102a0f8cd9e15e9b5fc3a03e4821be447e4fd42d3328bf6800505d349ba1725::crypto {
    struct CRYPTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYPTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYPTO>(arg0, 6, b"Crypto", b"cryptographywar", b"Gain more", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicyrvd6kte6w7gypmvczd7uuiuvrsmlz6mb57tiqpcz7nqjjnyv3m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYPTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CRYPTO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

