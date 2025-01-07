module 0x95911d0d2b2aed3b70ea67dc20d5a3eea0c26628cab32a43e1897b0ba273eda0::rolsui {
    struct ROLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROLSUI>(arg0, 6, b"ROLSUI", b"ROLANDO SUIIII", b"SUIIIIIIIIIIIIIIIIIIIIII", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_jpeg_27603647c8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROLSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROLSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

