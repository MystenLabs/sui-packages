module 0x549608f95ed02d6a924c3a636683864f76fb11c7d1a1abc86025c14fa401fb7e::zhusu {
    struct ZHUSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZHUSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZHUSU>(arg0, 6, b"Zhusu", b"zhusui", x"7a6875737569206973757a68750a0a49276d207374696c6c206865726520666f722074686520636f6d656261636b2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zhusu_78dd9f2d1f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZHUSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZHUSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

