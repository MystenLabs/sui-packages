module 0x480c54e1a2fadac2ee1d839529e7bdf33b267f2c6fa18b37e38789978e2deacd::kicatan {
    struct KICATAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KICATAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KICATAN>(arg0, 9, b"KICATAN", b"Kicata", b"Kicata is mem ki cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6f34f039-6969-4a92-9d82-8a65b0e988be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KICATAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KICATAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

