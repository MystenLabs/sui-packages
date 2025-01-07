module 0x381024737fdf7ec99b4a1358937c8647a44f0aeedc89ac76697d66bb573db09c::mvini {
    struct MVINI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MVINI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MVINI>(arg0, 9, b"MVINI", b"Vini", b"Web3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/657d03f4-19c4-47c0-98f1-b63418d406f1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MVINI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MVINI>>(v1);
    }

    // decompiled from Move bytecode v6
}

