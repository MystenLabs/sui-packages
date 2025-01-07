module 0x6f4e5103cd3a8b51a3ebeabe82890c7ff36f3e2c2a89db9d66189cf2b1109477::pato {
    struct PATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PATO>(arg0, 6, b"PATO", b"PATO SUI", x"204865277320676f7420746865206d6f7665732c206865277320676f74207468652067726f6f76652120200a0a2044616e6365206d6f766573206172652021200a0a5041544f2c2074686520766972616c20696e7465726e65742064616e63696e67206475636b206d656d652064616e636573206f6e20537569206e6f77210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6580_f1235a4ae5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

