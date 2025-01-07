module 0xdce5c1db358174fb0dc5b48243c53b116451b2b1a7183a8db3be53001f38219c::fldjjdk {
    struct FLDJJDK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLDJJDK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLDJJDK>(arg0, 9, b"FLDJJDK", b"Susjdk", b"Dkdknnjkkig", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/87995f86-0d37-45fc-b190-944587d029a7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLDJJDK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLDJJDK>>(v1);
    }

    // decompiled from Move bytecode v6
}

