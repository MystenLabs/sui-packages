module 0x37aac6461e7a780c5bb1d75af3aa5ba88b836419fd08a2d518d98128de5e283b::trung {
    struct TRUNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUNG>(arg0, 9, b"TRUNG", b"Torung", b"Trung pt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1570cba2-6b58-4884-84a7-8cc8bbcd1f08.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

