module 0x80da2b68a8bc6502da02123ee81f6638cb677948f44ba07d596a5e74fee3ffab::frt {
    struct FRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRT>(arg0, 9, b"FRT", b"Frog", b"Just a frog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3cd9b867-dfd1-4a21-bac1-bd31b51f1d71.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

