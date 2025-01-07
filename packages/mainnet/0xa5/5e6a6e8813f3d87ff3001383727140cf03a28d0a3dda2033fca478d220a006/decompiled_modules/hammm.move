module 0xa55e6a6e8813f3d87ff3001383727140cf03a28d0a3dda2033fca478d220a006::hammm {
    struct HAMMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMMM>(arg0, 9, b"HAMMM", b"Ham", b"100000000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/124a1576-50e8-438e-bb0d-feabe896c319.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAMMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

