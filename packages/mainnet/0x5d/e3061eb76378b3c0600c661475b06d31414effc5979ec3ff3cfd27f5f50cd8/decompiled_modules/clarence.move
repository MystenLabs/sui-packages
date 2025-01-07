module 0x5de3061eb76378b3c0600c661475b06d31414effc5979ec3ff3cfd27f5f50cd8::clarence {
    struct CLARENCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLARENCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLARENCE>(arg0, 6, b"CLARENCE", b"Clarence", x"436c6172656e63652069732061206d656d6520746f6b656e20696e73706972656420627920616e206f7074696d69737469632c20637572696f7573206368617261637465722077686f20616c77617973207365657320746865206272696768742073696465206f66206c6966652e20456d626f6479696e672074686520737069726974206f6620616476656e7475726520616e6420667269656e64736869702c20436c6172656e636520656e74657273207468652063727970746f20776f726c6420746f20737072656164206c617567687465722c206a6f792c20616e6420756e666f726765747461626c65206368696c64686f6f64206d656d6f726965732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma_UP_6z4rc_PJL_Ldvv_RS_Bea_H_Vm_G_Akd1iewo_Pe_L_Gndq32_HSL_70989c816c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLARENCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLARENCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

