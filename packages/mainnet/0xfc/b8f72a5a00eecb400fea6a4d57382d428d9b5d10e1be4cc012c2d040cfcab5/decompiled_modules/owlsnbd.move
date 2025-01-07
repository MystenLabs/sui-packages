module 0xfcb8f72a5a00eecb400fea6a4d57382d428d9b5d10e1be4cc012c2d040cfcab5::owlsnbd {
    struct OWLSNBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWLSNBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWLSNBD>(arg0, 9, b"OWLSNBD", b"hdjdn", b"jdndb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dc84eb42-9b9c-4acc-ba4b-abb0f36f7eb0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWLSNBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWLSNBD>>(v1);
    }

    // decompiled from Move bytecode v6
}

