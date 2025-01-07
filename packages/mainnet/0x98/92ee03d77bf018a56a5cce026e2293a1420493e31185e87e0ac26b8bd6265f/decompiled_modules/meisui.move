module 0x9892ee03d77bf018a56a5cce026e2293a1420493e31185e87e0ac26b8bd6265f::meisui {
    struct MEISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEISUI>(arg0, 6, b"MEISUI", x"4d656953756920e6b2a1e6b0b4", x"4d656953756920e6b2a1e6b0b4202d20596f752068617665204e6f205355492c206e6f20776f72726965732c20627579204d65695375692e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731193095470.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEISUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEISUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

