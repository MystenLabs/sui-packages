module 0xfc8398b415169a05b61ab45656e1d9a449e7c9e48607e143b08e6d3169a251e3::wizard {
    struct WIZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIZARD>(arg0, 6, b"WIZARD", b"Sui Wizard", x"54686520656e6368616e74696e6720736f726365726572206f662074686520537569204e6574776f726b2c2063617374696e67206d61676963616c207370656c6c7320776974682077617465722e2057697468206120666c69636b206f66206869732077616e642c206865207472616e73666f726d73206c697175696469747920696e746f20696e6372656469626c65206f70706f7274756e69746965732e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_3_1e75a79fe6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIZARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIZARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

