module 0x4091df41462c35b0b1ce61367bd1e1e34bf86e9b8b1596e029f67b25fa9467c7::kaori {
    struct KAORI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAORI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAORI>(arg0, 9, b"KAORI", b" KAORI", b"KA O RI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/864c3524-b030-4885-8699-206e3f717e9c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAORI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAORI>>(v1);
    }

    // decompiled from Move bytecode v6
}

