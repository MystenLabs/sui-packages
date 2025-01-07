module 0x4c1aa4c479bce63a974202c2a6322b12b24792879fd049f3ca43c75b97f72137::suiemoji {
    struct SUIEMOJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIEMOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIEMOJI>(arg0, 9, b"SUIEMOJI", b"Suiji", b"Best project ever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c6545fd0-8dfc-4ec0-acd1-3223e1a0f577.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIEMOJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIEMOJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

