module 0xecd7b000058a58b595779eeac180270b599d735dd1ae474aa18d8ece7d987e22::plt {
    struct PLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLT>(arg0, 9, b"PLT", b"PLANET", b"MAGICAL PLANETS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b1f734ac-84f8-485d-8c20-4a4b0a005a48.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

