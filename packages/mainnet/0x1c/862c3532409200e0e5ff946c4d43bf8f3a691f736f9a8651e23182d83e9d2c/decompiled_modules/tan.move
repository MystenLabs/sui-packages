module 0x1c862c3532409200e0e5ff946c4d43bf8f3a691f736f9a8651e23182d83e9d2c::tan {
    struct TAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAN>(arg0, 9, b"TAN", x"4769e1bba16e206de1bab774", b"Hfishufbuwvixb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f1491d5f-8629-4cf1-9b98-d83c5fb5acb6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

