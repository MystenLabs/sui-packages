module 0x9088d3d8f76562176781c6d59476fc840c77b6917f942576f4471d969dd09a97::lukita {
    struct LUKITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUKITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUKITA>(arg0, 9, b"LUKITA", b"Luka Modri", b"Luka Modric MT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5e1fad61-9068-47bf-9fd5-c6faf8322b16.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUKITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUKITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

