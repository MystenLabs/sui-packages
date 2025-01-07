module 0xd80dc5b4ebd8c55093ace94854d2c45abd4b5755c06865582b9fac40c37b48be::ugoat {
    struct UGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: UGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UGOAT>(arg0, 6, b"UGOAT", b"UniGoat", x"546869732069732061206d656d6520636f696e206272696e67696e672066616e7461737920616e642066756e20696e746f2074686520626c6f636b636861696e20776f726c642e204d616a65737469632c20627920646566696e6974696f6e2c206120756e69636f726e206973206120636f6d62696e6174696f6e206f662074686520616e6369656e7420776f6e64657220616e64206120706c617966756c20676f61742c202455474f41542069732064657369676e656420746f206361707475726520686561727473206f6620616c6c206d656d65206c6f7665727320776f726c64776964652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Uni_Goat_TAC_Zy_V_J_Jt_Ruzq_Q_Ig9_K_65fba5715e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UGOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UGOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

