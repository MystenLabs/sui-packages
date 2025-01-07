module 0x83fe38a8410503df6c8128b475d408e55d766f44442ee897fb367893d4f15b26::colo {
    struct COLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: COLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COLO>(arg0, 9, b"COLO", b"COLORE", b"COLORED BUBBLES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3825bfeb-9634-4617-ae1f-f62099f3ca8a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

