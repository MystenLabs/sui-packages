module 0xcd52115c9464fd605e09a8a7348c0a4684935a74c21a356f20b407262a44c621::hgt {
    struct HGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HGT>(arg0, 6, b"HGT", b"HotGirlToken", x"486f744769726c546f6b656e202824484754292069732061206d656d6520746f6b656e20776974682061206d697373696f6e20746f2063656c65627261746520616e6420737570706f727420686f74206769726c7320776f726c64776964652e200a4f6e63652074686520626f6e64696e672070726f63657373206973207375636365737366756c6c7920636f6d706c657465642c2074686520776562736974652077696c6c20626520637265617465642c20616e64207468652070726f636573732077696c6c2062652066696e616c697a65642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736000757470.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HGT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HGT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

