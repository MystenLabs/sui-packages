module 0x2ebf71283bced7908449ce42be0b47fbacabc60d65cdb553dda6aaef541196be::txc {
    struct TXC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TXC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TXC>(arg0, 9, b"TXC", b"Taxic", b"A token for big price explosions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c907148e-9be1-4eaa-9c3b-5394760e0f76.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TXC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TXC>>(v1);
    }

    // decompiled from Move bytecode v6
}

