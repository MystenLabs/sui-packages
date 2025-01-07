module 0x6b5ed7060f487ca441286c4beee05913561b8572cb13aa753691c54c381168b8::olnen {
    struct OLNEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLNEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLNEN>(arg0, 9, b"OLNEN", b"heke", b"hdbd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/efcc5521-851a-4d8a-9f64-82fdf7655417.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLNEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OLNEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

