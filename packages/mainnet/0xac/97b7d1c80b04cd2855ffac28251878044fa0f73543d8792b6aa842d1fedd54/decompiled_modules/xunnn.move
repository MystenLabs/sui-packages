module 0xac97b7d1c80b04cd2855ffac28251878044fa0f73543d8792b6aa842d1fedd54::xunnn {
    struct XUNNN has drop {
        dummy_field: bool,
    }

    fun init(arg0: XUNNN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742294531186.png"));
        let (v1, v2) = 0x2::coin::create_currency<XUNNN>(arg0, 6, b"XUNNN", b"XUNNN", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XUNNN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XUNNN>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<XUNNN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<XUNNN>>(arg0);
    }

    // decompiled from Move bytecode v6
}

