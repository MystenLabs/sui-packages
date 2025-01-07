module 0xc1af002a79556a896112be423f3497e9d36c2b5963dc3340bc5d88a846718990::lgt {
    struct LGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LGT>(arg0, 9, b"LGT", b"Lilgod ", x"0a0a4465736372697074696f6e3a204c696c476f6420546f6b656e2069732061207265766f6c7574696f6e617279206469676974616c2061737365742064657369676e656420746f20656d706f77657220696e646976696475616c7320746f20637265617465207765616c746820616e642070726f7370657269747920696e207468656972206c697665732e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4abd91a4-ec0c-44e3-a3bd-c778b89ea433.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

