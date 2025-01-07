module 0xea8ee3ff90e6c61641ecbefa5e9ba425c11d64272c0ccef6c410c31fa033e8c5::nse {
    struct NSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NSE>(arg0, 6, b"NSE", b"NEED SPACE", b"An exploration from a mysterious space", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1562_f36519a0a6.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

