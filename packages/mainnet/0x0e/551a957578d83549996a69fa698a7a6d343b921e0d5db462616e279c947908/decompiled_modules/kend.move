module 0xe551a957578d83549996a69fa698a7a6d343b921e0d5db462616e279c947908::kend {
    struct KEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEND>(arg0, 9, b"KEND", b"hdnd", b"bebd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6630c3af-0962-442e-a56c-cb938aa30c34.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

