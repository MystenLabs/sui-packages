module 0xc2f3ca5c374fa9ebd17fec7077432fe68b684b7bf96fa168a13e225ca7ff7532::farming {
    struct FARMING has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARMING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARMING>(arg0, 9, b"FARMING", b"Gold ", b"24 hours farming ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/51778db3-d610-4910-b533-f7489dca5b7f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARMING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FARMING>>(v1);
    }

    // decompiled from Move bytecode v6
}

