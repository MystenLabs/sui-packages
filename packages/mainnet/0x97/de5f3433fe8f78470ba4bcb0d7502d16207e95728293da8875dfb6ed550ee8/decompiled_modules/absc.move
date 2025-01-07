module 0x97de5f3433fe8f78470ba4bcb0d7502d16207e95728293da8875dfb6ed550ee8::absc {
    struct ABSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABSC>(arg0, 9, b"ABSC", b"Absharcol", b"Engaging social activities to create happiness", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6539e56d-86dd-44a0-a250-b5f04ee7072f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABSC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABSC>>(v1);
    }

    // decompiled from Move bytecode v6
}

