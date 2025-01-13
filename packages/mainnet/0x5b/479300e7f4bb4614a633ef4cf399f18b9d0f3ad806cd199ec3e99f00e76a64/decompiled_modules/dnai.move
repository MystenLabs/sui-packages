module 0x5b479300e7f4bb4614a633ef4cf399f18b9d0f3ad806cd199ec3e99f00e76a64::dnai {
    struct DNAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DNAI>(arg0, 6, b"DNAI", b"SUIDNAI by SuiAI", x"444e41202824444e41292069732074686520626c75657072696e74206f66206c696665e28094616e64206e6f772c2074686520666f756e646174696f6e206f662061207265766f6c7574696f6e617279206d656d6520636f696e21204272696467696e672062696f6c6f677920616e6420626c6f636b636861696e2c2024444e412063656c656272617465732074686520657373656e6365206f662065766f6c7574696f6e20616e6420696e6e6f766174696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/0_846906baae.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DNAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

