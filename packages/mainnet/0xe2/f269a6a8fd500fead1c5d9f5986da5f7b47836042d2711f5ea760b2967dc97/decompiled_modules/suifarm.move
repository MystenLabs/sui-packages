module 0xe2f269a6a8fd500fead1c5d9f5986da5f7b47836042d2711f5ea760b2967dc97::suifarm {
    struct SUIFARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFARM>(arg0, 9, b"SUIFARM", b"Suifarm", b"Farming is a necessity ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/45a063d6-b1a5-4e24-8d6d-c8380949cf78-IMG_4617.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFARM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIFARM>>(v1);
    }

    // decompiled from Move bytecode v6
}

