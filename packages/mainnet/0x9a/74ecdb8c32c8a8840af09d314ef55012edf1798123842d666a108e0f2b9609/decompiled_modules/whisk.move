module 0x9a74ecdb8c32c8a8840af09d314ef55012edf1798123842d666a108e0f2b9609::whisk {
    struct WHISK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHISK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHISK>(arg0, 6, b"WHISK", b"WhiskCoin", x"576869736b436f696e206272696e67732074686520636861726d206f66206b697474656e7320746f2074686520626c6f636b636861696e2e20576974682065616368207472616e73616374696f6e2c20796f75e2809972652068656c70696e67206275696c6420612062726967687465722066757475726520666f7220737472617920616e696d616c732c206f6e6520776869736b657220617420612074696d652e20486f6c6420574849534b2c20616e64206561726e2072657761726473207768696c6520737570706f7274696e67207061777369746976652063617573657321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731348812982.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHISK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHISK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

