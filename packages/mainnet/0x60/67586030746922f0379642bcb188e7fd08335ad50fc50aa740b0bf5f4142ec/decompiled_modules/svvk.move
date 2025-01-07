module 0x6067586030746922f0379642bcb188e7fd08335ad50fc50aa740b0bf5f4142ec::svvk {
    struct SVVK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SVVK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SVVK>(arg0, 6, b"SVVK", b"Savage Viking", x"496e74726f647563696e67205361766167652056696b696e6720e280942074686520737069726974206f6620666561726c65737320636f6e71756573742c20726562656c6c696f6e2c20616e642056696b696e6720726573696c69656e63652e20576974682065616368207472616e73616374696f6e2c20746865205361766167652056696b696e6720726f61727320776974682074686520737472656e677468206f6620616e6369656e74204e6f72736520676f64732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731522558274.PNG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SVVK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SVVK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

