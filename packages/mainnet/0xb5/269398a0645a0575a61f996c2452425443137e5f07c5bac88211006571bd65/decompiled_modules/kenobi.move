module 0xb5269398a0645a0575a61f996c2452425443137e5f07c5bac88211006571bd65::kenobi {
    struct KENOBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KENOBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KENOBI>(arg0, 9, b"KENOBI", b"Pnut", b"Pnut Kenobi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/657ac7a2-9b1b-43a0-8cb0-912f51f91cd1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KENOBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KENOBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

