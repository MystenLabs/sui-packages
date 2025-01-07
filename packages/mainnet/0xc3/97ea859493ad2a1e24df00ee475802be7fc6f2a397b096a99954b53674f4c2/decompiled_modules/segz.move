module 0xc397ea859493ad2a1e24df00ee475802be7fc6f2a397b096a99954b53674f4c2::segz {
    struct SEGZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEGZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEGZ>(arg0, 9, b"SEGZ", b"shadrach ", b"I am one of a kind ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f5309b26-18a1-48ce-8290-feb5c772ca3a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEGZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEGZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

