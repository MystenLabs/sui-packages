module 0x372f3fd69b527cd99763b850592a05875409e11c0e1804f56c90521142f26e89::skale {
    struct SKALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKALE>(arg0, 9, b"SKALE", b"Igbus", b"Kids doing their own things ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/76f91cdb-42e8-49db-bfb9-17175d4c74f8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

