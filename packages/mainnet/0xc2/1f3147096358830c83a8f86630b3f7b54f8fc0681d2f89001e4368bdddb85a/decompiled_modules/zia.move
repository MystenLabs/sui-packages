module 0xc21f3147096358830c83a8f86630b3f7b54f8fc0681d2f89001e4368bdddb85a::zia {
    struct ZIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZIA>(arg0, 6, b"ZIA", b"Zia ", x"0a5a696120697320616e20697272657369737469626c792061646f7261626c6520776869746520506f6d6572616e69616e207769746820666c756666792c20636c6f75642d6c696b65206675722e2048657220627269676874206579657320737061726b6c65207769746820637572696f736974792c20616e64206865722074696e79207061777320626f756e636520656e65726765746963616c6c792c20737072656164696e67206a6f792077686572657665722073686520676f65732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735556075564.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZIA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZIA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

