module 0xb1574f451a023d68120b979e4d79e7b0feab54740675cf13d7bc8944be231d84::ikigai {
    struct IKIGAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: IKIGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IKIGAI>(arg0, 6, b"IKIGAI", b"IKIGAI ON SUI", x"24494b494741490a0a57656c636f6d6521205768617420697320494b494741493f2049742073696d706c79206d65616e732066696e64696e6720736f6d65206d65616e696e6720746f2020796f7572206c6966652e204c6f6f6b696e6720666f72207468696e67732074686174207361746973667920796f752e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3566_23d34ac7d4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IKIGAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IKIGAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

