module 0x9dc07dbef9a75c42104d1c88b08a5fca86b6acaa3916ea7874d70c1d12152154::cto {
    struct CTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTO>(arg0, 6, b"CTO", b"CHIEF TROLL OFFICER", x"456c6f6e204d75736b277320582042696f202d2043686965662054726f6c6c204f666669636572202d2042726f7567687420546f204c6966652e2020436f6d652054726f6c6c20776974682055530a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/v_LL_Msfw_D_400x400_70ab09c3be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

