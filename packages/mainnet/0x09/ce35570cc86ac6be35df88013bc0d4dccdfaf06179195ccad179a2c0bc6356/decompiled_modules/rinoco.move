module 0x9ce35570cc86ac6be35df88013bc0d4dccdfaf06179195ccad179a2c0bc6356::rinoco {
    struct RINOCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RINOCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RINOCO>(arg0, 6, b"Rinoco", b"Rinoco sui", x"576861742069732052696e6f636f0a41742052696e6f636f2c2077652061696d20746f2072656b696e646c652074686520636f6c6c65637469626c65206d61676963206f66204e465473206279206372656174696e67206120776f726c64207465656d696e67207769746820696e6372656469626c6520637265617475726573207468617420796f75276c6c2077616e7420746f20636f6c6c656374207468656d20616c6c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000035972_b70f63bb96.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RINOCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RINOCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

