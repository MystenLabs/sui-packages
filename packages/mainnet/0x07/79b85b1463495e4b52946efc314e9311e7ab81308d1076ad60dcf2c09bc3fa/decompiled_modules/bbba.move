module 0x779b85b1463495e4b52946efc314e9311e7ab81308d1076ad60dcf2c09bc3fa::bbba {
    struct BBBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBBA>(arg0, 9, b"BBBA", b"BBB", b"BBBAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dev-file.walletapp.waveonsui.com/images/wave-pumps/75d26434-cd13-42c5-9671-3401da62fc7f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

