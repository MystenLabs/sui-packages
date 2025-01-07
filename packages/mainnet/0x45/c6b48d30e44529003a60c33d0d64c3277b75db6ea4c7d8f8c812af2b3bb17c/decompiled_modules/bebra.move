module 0x45c6b48d30e44529003a60c33d0d64c3277b75db6ea4c7d8f8c812af2b3bb17c::bebra {
    struct BEBRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEBRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEBRA>(arg0, 9, b"BEBRA", b"bebra", b"Official Bebra Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bb83336e-4f75-446f-9645-6c067d1de346.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEBRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEBRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

