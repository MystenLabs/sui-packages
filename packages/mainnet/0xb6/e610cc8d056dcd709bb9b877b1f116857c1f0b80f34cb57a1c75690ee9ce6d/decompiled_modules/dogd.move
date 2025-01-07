module 0xb6e610cc8d056dcd709bb9b877b1f116857c1f0b80f34cb57a1c75690ee9ce6d::dogd {
    struct DOGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGD>(arg0, 6, b"DOGD", b"DogeDesigner", x"24444f474420697320746865206d656d6520636f696e207265646566696e696e672066756e20616e64207574696c697479206f6e20746865205375692e20436f6d6d756e6974792d64726976656e20616e642068797065722d6d656d657469632c20444f474420626c656e647320696e7465726e65742063756c7475726520776974682063757474696e672d6564676520746563682c20616e6420656e646c65737320637265617469766974792e204a6f696e2074686520444f4744207265766f6c7574696f6e20616e64207475726e206d656d657320696e746f2076616c75652120f09f9095f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732465643689.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

