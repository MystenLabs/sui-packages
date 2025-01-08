module 0x6f2633309b566ae88ff82a5342dac846d34838d3db5b03a4007f08b404d901c3::lofi {
    struct LOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOFI>(arg0, 6, b"LOFI", b"Lofi the yeti", x"57652061726520616c6c204c6f66692e20436f6c6c656374697665206d697373696f6e20697320746f206275696c642061207468726976696e672c20666f72776172642d7468696e6b696e672065636f73797374656d206f6e207468652053756920626c6f636b636861696e2e0a0a54656c656772616d3a2068747470733a2f2f742e6d652f4c6f66694f6e5375690a583a2068747470733a2f2f782e636f6d2f6c6f6669746865796574690a576562203a2068747470733a2f2f6c6f6669746865796574692e636f6d2f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250108_212212_264_0d1ea74b22.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

