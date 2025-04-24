module 0x2242e71c54b389c5e4001c2635c598469c5900020cc873e21d01a542124b260::zxcv {
    struct ZXCV has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZXCV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZXCV>(arg0, 9, b"ZXCV", b"zxcv", b"asdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://steamm-assets.s3.amazonaws.com/token-icon.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZXCV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZXCV>>(v1);
    }

    // decompiled from Move bytecode v6
}

