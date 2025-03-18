module 0xc1bd9be7d2c96b819f20ba0a745879724f722630835747929fb90be08e00112c::suicheckdata {
    struct SUICHECKDATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHECKDATA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742272411160.png"));
        let (v1, v2) = 0x2::coin::create_currency<SUICHECKDATA>(arg0, 6, b"SUICHECKDATA", b"SUICHECKDATA", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHECKDATA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICHECKDATA>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<SUICHECKDATA>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUICHECKDATA>>(arg0);
    }

    // decompiled from Move bytecode v6
}

