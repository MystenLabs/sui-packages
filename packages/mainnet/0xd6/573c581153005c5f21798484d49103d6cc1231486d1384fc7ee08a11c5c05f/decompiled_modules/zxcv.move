module 0xd6573c581153005c5f21798484d49103d6cc1231486d1384fc7ee08a11c5c05f::zxcv {
    struct ZXCV has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZXCV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<ZXCV>(arg0, 6, b"ZXCV", b"ZXCV XX Something Yield", b"ZXCV XX Something Yield", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZXCV>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZXCV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<ZXCV>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

