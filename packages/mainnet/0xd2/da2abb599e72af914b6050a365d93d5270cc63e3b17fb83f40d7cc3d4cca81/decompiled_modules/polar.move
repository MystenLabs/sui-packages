module 0xd2da2abb599e72af914b6050a365d93d5270cc63e3b17fb83f40d7cc3d4cca81::polar {
    struct POLAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLAR>(arg0, 6, b"POLAR", b"Polar Bear", x"5468697320637564646c7920506f6c617220426561722069732074616b696e67206f7665722053756920776974682069747320636861726d696e6720616e64206368696c6c2076696265732e204e6f7420796f757220757375616c20666965726365207072656461746f722c20504f4c4152206973206865726520746f206d656c742068656172747320616e64206272696e6720612063616c6d2c20636f6f6c20656e6572677920746f2074686520537569206e6574776f726b2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Polar_GIF_a027c06cc8.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

