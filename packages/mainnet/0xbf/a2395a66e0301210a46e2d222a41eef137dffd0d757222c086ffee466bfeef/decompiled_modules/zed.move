module 0xbfa2395a66e0301210a46e2d222a41eef137dffd0d757222c086ffee466bfeef::zed {
    struct ZED has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZED>(arg0, 6, b"ZED", b"Zesdan", x"225a657364616e222074726f6e672070686f6e672063c3a163682074c6b0c6a16e67206c61692c2076e1bb9b6920c3a16e682073c3a16e672078616e682076c3a0206ee1bb816e20637962657270756e6b2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/0e9ed179-8e88-467b-977f-fc99ffd03ea8.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

