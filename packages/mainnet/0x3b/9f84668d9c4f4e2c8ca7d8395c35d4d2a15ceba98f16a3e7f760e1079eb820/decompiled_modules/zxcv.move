module 0x3b9f84668d9c4f4e2c8ca7d8395c35d4d2a15ceba98f16a3e7f760e1079eb820::zxcv {
    struct ZXCV has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZXCV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZXCV>(arg0, 9, b"ZXCV", b"cbxz", b"sdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://steamm-assets.s3.amazonaws.com/token-icon.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZXCV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZXCV>>(v1);
    }

    // decompiled from Move bytecode v6
}

