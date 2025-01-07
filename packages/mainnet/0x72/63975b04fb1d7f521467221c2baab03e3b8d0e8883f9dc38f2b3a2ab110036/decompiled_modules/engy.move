module 0x7263975b04fb1d7f521467221c2baab03e3b8d0e8883f9dc38f2b3a2ab110036::engy {
    struct ENGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENGY>(arg0, 9, b"ENGY", b"ENERGY ", b"Free energy for everyone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/358af6d0-2c16-4dbc-b00b-c89b53ff2693.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ENGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

