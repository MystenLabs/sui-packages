module 0x87d5c344036afa55391a0b2313931da4edbb93b0ed325e6771fd5b7d2e46e3a7::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE>(arg0, 9, b"DOGE", b"D.O.G.E.", b"President-elect Trump has appointed Elon Musk to lead the \"Department of Government Efficiency\" (Doge). Musk and Vivek Ramaswamy aim to reduce bureaucracy and save billions in federal spending by July 4th, 2026.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/88d78f62-2dc2-4524-873d-41ea1cd24941.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

