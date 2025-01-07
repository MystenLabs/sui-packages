module 0xa2bf7d50b662f2ff6f385d94a046a4bde662dd06117e0df00f95f56a188fa5b2::ctnu {
    struct CTNU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTNU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTNU>(arg0, 9, b"CTNU", b"Cati-inu ", b"Cati finance ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5d773fb2-5b1c-4969-bc7d-342f189060a2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTNU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTNU>>(v1);
    }

    // decompiled from Move bytecode v6
}

