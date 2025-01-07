module 0xac7599daec43c77951f6249944b871defc0470b7192caf15e96b82121b4f4972::czfour {
    struct CZFOUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZFOUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CZFOUR>(arg0, 9, b"CZFOUR", b"FOUR", b"Do you remember CZ number4 thing?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6231b494-b504-43d7-bde5-e1feb57541ce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZFOUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CZFOUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

