module 0xdd7408c07fc7362d8e2f44c8023d41b614b5246ea4b8de6276b3926424eda4c8::nigga {
    struct NIGGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGGA>(arg0, 6, b"NIGGA", b"NIGGACOIN", x"495453204a5553542041204e49474741434f494e0a4149732054686573697320546865206c617374207265736f727420746f206272696e67206e6577206579657320746f20537569206c61756e6368206120636f696e2063616c6c6564204e696767612e2053686f636b2c206d656d65732c20616e6420687970652077696c6c20646f2077686174206d61726b6574696e6720636f756c646e74", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih3o3agkdusp22iizihnqh3afpxff2orda4bic3z3rdqujiqfmy2a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NIGGA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

