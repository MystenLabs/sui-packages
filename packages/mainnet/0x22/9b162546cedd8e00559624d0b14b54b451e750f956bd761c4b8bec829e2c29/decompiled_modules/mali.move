module 0x229b162546cedd8e00559624d0b14b54b451e750f956bd761c4b8bec829e2c29::mali {
    struct MALI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MALI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MALI>(arg0, 9, b"MALI", b"Mastings", b"Mastings token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5f699f3e-a8a7-4520-be7f-f9819c045958.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MALI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MALI>>(v1);
    }

    // decompiled from Move bytecode v6
}

