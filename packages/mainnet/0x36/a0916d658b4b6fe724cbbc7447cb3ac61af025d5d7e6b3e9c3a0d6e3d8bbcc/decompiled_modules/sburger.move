module 0x36a0916d658b4b6fe724cbbc7447cb3ac61af025d5d7e6b3e9c3a0d6e3d8bbcc::sburger {
    struct SBURGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBURGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBURGER>(arg0, 6, b"sBURGER", b"BURGER", x"536f6d656f6e65207573656420746f2065786368616e67652042544320666f722070697a7a6120696e2074686520706173742c20627574206e6f77205472756d70206973207573696e672042544320746f206275792068616d627572676572732c2077686963682069732061206e6577206d696c6573746f6e65200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/type_default_350_0_3a49dc29b2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBURGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBURGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

