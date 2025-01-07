module 0x3876a23d71e500ffec38961543ec4c632af41ae464087aad28e9d7a0b195667b::PensPrimordialDisplay {
    struct PENSPRIMORDIALDISPLAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENSPRIMORDIALDISPLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENSPRIMORDIALDISPLAY>(arg0, 0, b"COS", b"Pen's Primordial Display", b"To be cleansed... renewed... to be reunited... to wait...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Pens_Primordial_Display.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENSPRIMORDIALDISPLAY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENSPRIMORDIALDISPLAY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

