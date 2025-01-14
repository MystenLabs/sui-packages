module 0xecc5bdb863bf0f10e1d417bfeecfd4758416adf367efb6a7848cee0b541b4c1::brainca {
    struct BRAINCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAINCA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BRAINCA>(arg0, 6, b"BRAINCA", b"Brainiac AI by SuiAI", b"YOUR SMART PROGRAMMING ASSISTANT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/4_Z_Xuo3n_P_400x400_291177e51e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BRAINCA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAINCA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

