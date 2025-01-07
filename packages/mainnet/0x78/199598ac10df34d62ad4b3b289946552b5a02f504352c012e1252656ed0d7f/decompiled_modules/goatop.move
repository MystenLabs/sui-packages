module 0x78199598ac10df34d62ad4b3b289946552b5a02f504352c012e1252656ed0d7f::goatop {
    struct GOATOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOATOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOATOP>(arg0, 6, b"GOATOP", b"GOAT to the Top", x"5768656e20746865206d61726b6574e280997320726f636b792c2062757420796f75e28099726520474f4154696e67206974210a412068696c6172696f7573206d6f756e7461696e20676f6174207374727567676c696e672075702061207374656570207065616b2c20736c697070696e67206f6e20726f636b73207965742064657465726d696e656420746f2072656163682074686520746f702c206d6972726f7273207468652070657273697374656e6365206f66206d656d6520636f696e2074726164657273206e617669676174696e672074686520766f6c6174696c652063727970746f206d61726b65742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733078347178.28")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOATOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOATOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

