module 0x443f485e519c5781ee2d72ac4e7eee0ca23d2b28b17412a32cdcb9be53ecf1e4::mooon {
    struct MOOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOON>(arg0, 9, b"MOOON", b"Moon", x"546869732069732061206d6f6f6e20f09f8c9a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a17a1a7f-8a1e-47bd-b557-e5cc3644c0ea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

