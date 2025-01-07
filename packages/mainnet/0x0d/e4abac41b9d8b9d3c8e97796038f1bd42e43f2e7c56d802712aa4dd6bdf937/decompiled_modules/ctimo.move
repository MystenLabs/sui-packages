module 0xde4abac41b9d8b9d3c8e97796038f1bd42e43f2e7c56d802712aa4dd6bdf937::ctimo {
    struct CTIMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTIMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTIMO>(arg0, 9, b"CTIMO", b"TIMO", b"TIMO'S CAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0f97ad59-db3e-4650-9a2b-a35ba0c34e58.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTIMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTIMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

