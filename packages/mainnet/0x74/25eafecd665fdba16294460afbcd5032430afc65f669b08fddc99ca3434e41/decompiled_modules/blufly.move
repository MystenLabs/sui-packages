module 0x7425eafecd665fdba16294460afbcd5032430afc65f669b08fddc99ca3434e41::blufly {
    struct BLUFLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUFLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUFLY>(arg0, 6, b"BLUFLY", b"Blufly Sui", b"Flying To The Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/L_14_c191864091.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUFLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUFLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

