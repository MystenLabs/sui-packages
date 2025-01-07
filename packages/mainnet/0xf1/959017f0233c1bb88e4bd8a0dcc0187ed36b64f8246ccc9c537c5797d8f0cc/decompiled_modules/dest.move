module 0xf1959017f0233c1bb88e4bd8a0dcc0187ed36b64f8246ccc9c537c5797d8f0cc::dest {
    struct DEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEST>(arg0, 9, b"DEST", b"Destrol ", b"A crypto bull from the infernal interior of the Earth's core ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/17b3e302-f808-4ab3-9ca0-09e10643a92c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

