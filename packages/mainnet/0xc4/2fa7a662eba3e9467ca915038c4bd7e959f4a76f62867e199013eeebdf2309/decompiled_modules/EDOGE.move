module 0xc42fa7a662eba3e9467ca915038c4bd7e959f4a76f62867e199013eeebdf2309::EDOGE {
    struct EDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDOGE>(arg0, 6, b"ElonDoge", b"EDOGE", x"54686520756c74696d617465206d656d6520636f696e20636f6d62696e696e6720456c6f6e204d75736b2773206c6567656e6461727920696e666c75656e636520616e6420446f6765636f696e277320706c617966756c207370697269742e20456c6f6e446f67652069732074686520726f636b6574206675656c20666f7220746865206e6578742063727970746f206d656d65207265766f6c7574696f6ee280946265636175736520776879206d6f6f6e207768656e20796f752063616e204d6172733f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://replicate.delivery/xezq/kf1XfS3IeXaP6JCdFqcv7OYfx0focLmPCAgi2nnhkJTkr9voC/out-0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDOGE>>(v0, @0x691c5d4f7bd7c39b39907d3ca01b8c2643c87de134766ca4f78be51e0a9fde1b);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

