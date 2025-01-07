module 0x21fe316ae6dc8abc999aa0b106c9f10508d551499bc160106d61244a5b23cfe2::smsk {
    struct SMSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMSK>(arg0, 6, b"SMSK", b"SuiMusk", x"5375694d75736b2069732074686520686f7474657374206e6577206d656d65636f696e206f6e205375692c2070726f6d6973696e67206d6f6f6e2d626f756e642072657475726e7320616e64206c696768746e696e672d66617374207472616e73616374696f6e732e20496e73706972656420627920456c6f6e2c20706f7765726564206279204465466920e28093206a6f696e206e6f7720616e6420646f6ee2809974206d69737320746865206e65787420626967207468696e672120f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731371990397.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMSK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMSK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

