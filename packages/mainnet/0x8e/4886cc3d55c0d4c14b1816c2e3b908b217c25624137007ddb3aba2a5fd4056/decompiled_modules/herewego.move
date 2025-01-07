module 0x8e4886cc3d55c0d4c14b1816c2e3b908b217c25624137007ddb3aba2a5fd4056::herewego {
    struct HEREWEGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEREWEGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEREWEGO>(arg0, 9, b"HEREWEGO", b"Wego", x"546f20746865206e6578742047656e65726174696f6ef09fa7ac", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/24c18e9c-a867-4ad3-b2bd-e3de68911edf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEREWEGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEREWEGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

