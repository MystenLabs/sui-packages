module 0x373d928e1b335b56dcb8a3f03e2fa1a5a633fefdbb079622d0d9956119cb11cd::psui {
    struct PSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSUI>(arg0, 6, b"PSUI", b"PEPSUI", x"506570737569202d20536f6461207761746572206f66205355492e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x9983e29d4f04ea08288ab4c3f395a9a73cca62a58f8187f57877805f5ae5dd17_pepsui_pepsui_7f514ce93f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

