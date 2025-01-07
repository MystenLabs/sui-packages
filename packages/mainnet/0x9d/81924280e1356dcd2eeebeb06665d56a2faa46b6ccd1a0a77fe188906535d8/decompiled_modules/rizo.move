module 0x9d81924280e1356dcd2eeebeb06665d56a2faa46b6ccd1a0a77fe188906535d8::rizo {
    struct RIZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIZO>(arg0, 6, b"RIZO", b"HahaYes", x"486168615965732120456c6f6e73204661766f72697465204d656d65202452495a4f0a0a687474703a2f2f686168617965732e70726f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/l73_D_Vvml_400x400_2008c7f40e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

