module 0x8da4829e15ae20a154d96e29f39166fa7ed45be448f9c2cc72e6155c6e1f2991::coco {
    struct COCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCO>(arg0, 6, b"COCO", b"COCO TROLL FACE", x"4920616d20696e206c6f766520776974682074686520434f434f0a0a24434f434f2077617320626f726e0a50756d702062792070756d702e204c696e65206279206c696e652e204d656d65206279206d656d652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifoufw73zxweueixapu3bomqa3rmtimvzi2yp52cyqamtsisigsie")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COCO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

