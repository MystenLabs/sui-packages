module 0x74260483cbb2ef2a14da8aedaca24b941fb26f491e0b021928c498a43b0e2498::mcen {
    struct MCEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCEN>(arg0, 6, b"MCEN", b"Main Character Energy", x"596f757665207761746368656420796f7572206c6966652066726f6d2074686520736964656c696e657320666f7220746f6f206c6f6e672e200a596f75206e65656420746f2074616b6520636f6e74726f6c2e204e6f772e200a4974732074696d6520746f206265636f6d6520746865206d61696e206368617261637465722e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241226_214913_660_6ae6ebc3ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

