module 0xcbeabbf7a3c05f7e8edb10e21dc9ca07f657d87c1d433a57bba1996bdb82938e::fcpm {
    struct FCPM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCPM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCPM>(arg0, 9, b"FCPM", b"Facepalm", b"Omg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/63f608fd-4b63-4c0c-ae14-b2991605ccf5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCPM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FCPM>>(v1);
    }

    // decompiled from Move bytecode v6
}

