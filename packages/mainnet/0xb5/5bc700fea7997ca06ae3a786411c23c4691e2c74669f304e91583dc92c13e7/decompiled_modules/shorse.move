module 0xb55bc700fea7997ca06ae3a786411c23c4691e2c74669f304e91583dc92c13e7::shorse {
    struct SHORSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHORSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHORSE>(arg0, 6, b"SHorse", b"SuiHorse", x"537569486f727365202d20426574206f6e2074686520526967687420486f7273652e0a53486f727365202d5468652042657374204d656d65206f6e2053756920436861696e2e200a546865206c696e6b7320746f2074686520776562736974652c207477697474657220616e642074656c656772616d2077696c6c2062652075706461746564206c617465722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Horse_1_4127bec4ed.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHORSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHORSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

