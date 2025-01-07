module 0x6a1999cfff00c144341c6fb05d2b114d2c9860bc1838ac1f1fa6de9fc01fd7b4::lgt {
    struct LGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LGT>(arg0, 9, b"LGT", b"Lilgod ", x"224c696c476f6420546f6b656e2028244c494c474f4429202d20456d706f776572696e6720446976696e65205765616c7468204372656174696f6e220a0a546f6b656e2053796d626f6c3a20244c494c474f440a0a546f6b656e20547970653a205574696c69747920546f6b656e0a0a546f74616c20537570706c793a20312c3030302c3030302c3030300a0a4465736372697074696f6e3a204c696c476f6420546f6b656e2069732061207265766f6c7574696f6e617279206469676974616c2061737365742064657369676e656420746f20656d706f77657220696e646976696475616c7320746f20637265617465207765616c746820", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/75bd5578-c016-46e6-be7b-ca56ea8268d1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

