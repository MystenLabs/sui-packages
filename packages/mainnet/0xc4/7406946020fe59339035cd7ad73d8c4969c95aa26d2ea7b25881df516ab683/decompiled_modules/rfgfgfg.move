module 0xc47406946020fe59339035cd7ad73d8c4969c95aa26d2ea7b25881df516ab683::rfgfgfg {
    struct RFGFGFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RFGFGFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RFGFGFG>(arg0, 9, b"RFGFGFG", b"hfhgfhfghf", b"fgggggggg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f4b0b8b1-3b81-48d9-a995-d76a1bd5752c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RFGFGFG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RFGFGFG>>(v1);
    }

    // decompiled from Move bytecode v6
}

