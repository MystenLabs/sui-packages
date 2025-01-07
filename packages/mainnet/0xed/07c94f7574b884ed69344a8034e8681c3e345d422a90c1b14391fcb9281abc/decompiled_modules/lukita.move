module 0xed07c94f7574b884ed69344a8034e8681c3e345d422a90c1b14391fcb9281abc::lukita {
    struct LUKITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUKITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUKITA>(arg0, 9, b"LUKITA", b"Luka Modri", b"Luka Modric MT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f13b83f3-8292-4eb6-adf9-3de5e3bb9fb5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUKITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUKITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

