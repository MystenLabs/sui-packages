module 0x40ea507b4140f287502d4915609497caa7b60540499fc8789e4685cef6486cd4::owkenbd {
    struct OWKENBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWKENBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWKENBD>(arg0, 9, b"OWKENBD", b"hdjdne", b"bdns", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7be6cd49-589d-4bb8-8544-4c28763efddd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWKENBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWKENBD>>(v1);
    }

    // decompiled from Move bytecode v6
}

