module 0xa17f2ca5362fcf2920d594d4244696892355b0343260e6bf2fad4f01051c6bc3::wushi13s {
    struct WUSHI13S has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUSHI13S, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUSHI13S>(arg0, 8, b"WUSHI13S", b"WUSHI13S", b"this is WUSHI13S", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WUSHI13S>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<WUSHI13S>>(v0);
    }

    // decompiled from Move bytecode v6
}

