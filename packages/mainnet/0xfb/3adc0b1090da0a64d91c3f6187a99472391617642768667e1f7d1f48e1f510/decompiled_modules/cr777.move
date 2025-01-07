module 0xfb3adc0b1090da0a64d91c3f6187a99472391617642768667e1f7d1f48e1f510::cr777 {
    struct CR777 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CR777, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CR777>(arg0, 9, b"CR777", b"Cr7", b"Butyyyyy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3f905714-f1d4-4632-86be-eb5c3d22f53c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CR777>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CR777>>(v1);
    }

    // decompiled from Move bytecode v6
}

