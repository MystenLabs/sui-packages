module 0x83ab22adbf04ea6c3af2b47dccb78f067686575924a96e209f90d2e79d462759::csx {
    struct CSX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSX>(arg0, 9, b"CSX", b"EW", b"CVXZ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/acbe6c13-2df5-4f29-8010-a9a4156d86a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CSX>>(v1);
    }

    // decompiled from Move bytecode v6
}

