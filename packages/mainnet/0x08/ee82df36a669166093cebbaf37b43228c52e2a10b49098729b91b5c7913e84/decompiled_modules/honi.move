module 0x8ee82df36a669166093cebbaf37b43228c52e2a10b49098729b91b5c7913e84::honi {
    struct HONI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HONI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HONI>(arg0, 9, b"HONI", b"Hon", b"HONTOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d04593e9-3421-43f1-8b73-c14b1d89f817.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HONI>>(v1);
    }

    // decompiled from Move bytecode v6
}

