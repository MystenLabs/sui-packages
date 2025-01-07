module 0xb67942102cffa02cb0fa2c9a81b8f0694125118d194747b8bb1ea8a25f25e66b::btcc {
    struct BTCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCC>(arg0, 9, b"BTCC", b"Bitchain", b"Bitcoin chain meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8a97dcf9-bf77-41a0-9309-7dba9d13e3a1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTCC>>(v1);
    }

    // decompiled from Move bytecode v6
}

