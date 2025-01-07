module 0xaf3d5025f1098b7963935ece4b8993799afa427cf694443a94f63d0ab79087e4::whoiiii {
    struct WHOIIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHOIIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHOIIII>(arg0, 9, b"WHOIIII", b"Who", b"Who is the best ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/282210bb-66ed-4c69-aa38-313a375e6659.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHOIIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHOIIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

