module 0x4ac405cb510ce70645ef86a6cdb3eb3b1f1d5beb2c0602543affb6cdd6ba164b::gragra {
    struct GRAGRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRAGRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRAGRA>(arg0, 9, b"GRAGRA", b"Gra gra", b"Gra fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5792e317-ce63-4e2f-852f-bccd1efd9dc8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRAGRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRAGRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

