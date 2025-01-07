module 0x8ad17c676a4ed4324cdaadd7ce2827ffdb3dbd279e4a0e19b1d3c6c9187e7ff2::mancingnga {
    struct MANCINGNGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANCINGNGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANCINGNGA>(arg0, 9, b"MANCINGNGA", b"Mancing ng", b"Mancing dlu su", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/727c8d5b-70f9-4f7a-93f9-fe613476ee1e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANCINGNGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANCINGNGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

