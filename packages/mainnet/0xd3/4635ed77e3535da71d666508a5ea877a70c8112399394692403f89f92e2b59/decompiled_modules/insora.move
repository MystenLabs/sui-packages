module 0xd34635ed77e3535da71d666508a5ea877a70c8112399394692403f89f92e2b59::insora {
    struct INSORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: INSORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INSORA>(arg0, 6, b"INSORA", b"Insora AI", x"556e6c6f636b2074686520467574757265206f66204175746f6d617465642054726164696e67207769746820496e736f726120414920576865726520546563686e6f6c6f6779204d656574732050726f6669746162696c6974792e20496e7665737420546f64617920616e64204561726e20546f6d6f72726f772e4d6178696d697a6520596f75722052657475726e7320776974682043757474696e672d4564676520416c676f726974686d69632054726164696e6720426f74732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737811300686.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INSORA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INSORA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

