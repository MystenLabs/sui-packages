module 0x417f5a31a341745c33dcf682f1592cbd32e4473ffe2fa241dd14fee1a53f9ed::gonsui {
    struct GONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GONSUI>(arg0, 6, b"GONSUI", b"First Gondola Sui", x"54686572657320746f6f206d75636820746f207365652c206576656e2069662077652063616e7420746f756368206974212068747470733a2f2f676f6e646f6c616f6e7375692e78797a0a68747470733a2f2f782e636f6d2f476f6e646f6c615f5375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_27_f03b249e81.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

