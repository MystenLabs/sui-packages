module 0x3058b1f280e8c800508f6f3c44da29d3f8de2de29fb204522993a6ce242cc987::msm {
    struct MSM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSM>(arg0, 6, b"MSM", b"Mummy Shark Meme", x"556e777261702074686520756c74696d617465206d656d6520636f696e2073656e736174696f6e21204d756d6d7920536861726b2069732076696272616e742c20636f6d6d756e6974792d64726976656e2c20616e64207061636b6564207769746820766972616c20706f74656e7469616c2e204a6f696e207468652063727970746f20776176657320616e64206d616b6520612073706c61736820776974682074686973206c6567656e6461727920736861726b2120f09fa6882e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736152649614.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

