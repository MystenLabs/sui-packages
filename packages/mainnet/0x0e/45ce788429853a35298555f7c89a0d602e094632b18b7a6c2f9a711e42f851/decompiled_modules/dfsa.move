module 0xe45ce788429853a35298555f7c89a0d602e094632b18b7a6c2f9a711e42f851::dfsa {
    struct DFSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFSA>(arg0, 9, b"DFSA", b"B", b"GEW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8192dbd0-8485-45ef-8a62-2053d7148ccc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

