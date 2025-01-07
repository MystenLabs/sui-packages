module 0x41237772a66b8dfb816907600535caf8cf9bdc52cf0d66f509a6f07702f3afd5::shibu {
    struct SHIBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBU>(arg0, 9, b"SHIBU", b"Shibu", b"sHIB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3246d69f-56a2-43f9-92a4-a90b5496e8d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

