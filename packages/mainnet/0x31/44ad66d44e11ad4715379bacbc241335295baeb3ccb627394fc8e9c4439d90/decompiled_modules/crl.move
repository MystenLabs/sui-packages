module 0x3144ad66d44e11ad4715379bacbc241335295baeb3ccb627394fc8e9c4439d90::crl {
    struct CRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRL>(arg0, 9, b"CRL", b"Chernobil", b"NEVER FORGET CHERNOBIL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/157bd00a-be93-4180-a1aa-4fb1000c8ad3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

