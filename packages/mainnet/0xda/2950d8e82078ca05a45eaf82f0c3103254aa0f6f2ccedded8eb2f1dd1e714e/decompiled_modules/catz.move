module 0xda2950d8e82078ca05a45eaf82f0c3103254aa0f6f2ccedded8eb2f1dd1e714e::catz {
    struct CATZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATZ>(arg0, 9, b"CATZ", b"Catss", b"Meow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ee40c8bd-1440-4bb7-a387-3e67c89d8d0b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

