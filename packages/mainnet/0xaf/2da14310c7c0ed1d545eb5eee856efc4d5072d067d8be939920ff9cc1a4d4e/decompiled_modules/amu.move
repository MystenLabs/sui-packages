module 0xaf2da14310c7c0ed1d545eb5eee856efc4d5072d067d8be939920ff9cc1a4d4e::amu {
    struct AMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMU>(arg0, 9, b"AMU", b"AmongUs ", b"being an imposter of your own self. inspiration from the game.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b4e7c6f3-035f-4e5d-89c8-5a9a7c7f865d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

