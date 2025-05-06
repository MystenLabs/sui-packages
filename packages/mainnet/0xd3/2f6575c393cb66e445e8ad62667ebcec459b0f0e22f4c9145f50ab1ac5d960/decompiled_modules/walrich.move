module 0xd32f6575c393cb66e445e8ad62667ebcec459b0f0e22f4c9145f50ab1ac5d960::walrich {
    struct WALRICH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALRICH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALRICH>(arg0, 6, b"WALRICH", b"Walrichonsui", x"4c61756e636820496e636f6d696e67204f6e206d6f6f6e62616773200a4a6f696e2074686520636f6d6d756e6974792024594f554e47202452494348", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaiy32bx3sgh4gojzxsr22c5i6rji7e345qzw64kfaxm7layrp43y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALRICH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WALRICH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

