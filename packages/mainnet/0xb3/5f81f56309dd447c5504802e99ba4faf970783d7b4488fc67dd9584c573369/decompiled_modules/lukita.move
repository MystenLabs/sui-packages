module 0xb35f81f56309dd447c5504802e99ba4faf970783d7b4488fc67dd9584c573369::lukita {
    struct LUKITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUKITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUKITA>(arg0, 9, b"LUKITA", b"Luka Modri", b"Luka Modric MT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1b28843c-64ab-4eb8-a5cf-a53c2815a54e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUKITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUKITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

