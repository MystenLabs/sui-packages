module 0x6ce0b745018f2871efd31a455e149479bfa464de61a0a533204160b07ef59efb::diarab {
    struct DIARAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIARAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIARAB>(arg0, 9, b"DIARAB", b"Rabbit", b"Diamond Rabbit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9a82004b-c391-456e-91c9-0e0f8c15c628.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIARAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIARAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

