module 0x897710955880ea1b60091ff5c2c4d62dd9e5caa95a7d8f3eb08b24f60b425093::mucbang {
    struct MUCBANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUCBANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUCBANG>(arg0, 9, b"MUCBANG", b"Muc Bang", b"MUCBANG MUC BANG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/26a153c7-abdc-409c-acff-09368a38a6e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUCBANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUCBANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

