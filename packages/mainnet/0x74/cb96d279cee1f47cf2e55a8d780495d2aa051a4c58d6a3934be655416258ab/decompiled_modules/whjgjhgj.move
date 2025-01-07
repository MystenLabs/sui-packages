module 0x74cb96d279cee1f47cf2e55a8d780495d2aa051a4c58d6a3934be655416258ab::whjgjhgj {
    struct WHJGJHGJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHJGJHGJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHJGJHGJ>(arg0, 9, b"WHJGJHGJ", b"hgjhgj", b"uiuyuihjhg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/080686fa-250a-43ce-b329-a75921b27118.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHJGJHGJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHJGJHGJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

