module 0xc5ff303cfc2643fa5fd1fc8a14085f1f395bcc14bf353e1631ae192e824f599e::tru {
    struct TRU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRU>(arg0, 9, b"TRU", b"TRUMP", b"sdfsdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dev-file-walletapp.waveonsui.com/images/wave-pumps/2f164536-3fc2-41e1-bc0e-8a44f5fd2c35.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRU>>(v1);
    }

    // decompiled from Move bytecode v6
}

