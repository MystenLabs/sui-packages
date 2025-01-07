module 0xc1fbefe1c29bad301bfe1a57323fe3910cc7373ddbe9c6dbe7025d169b98676::kaspa {
    struct KASPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KASPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KASPA>(arg0, 6, b"KASPA", b"SUI Kaspy", x"486f772049204c6f7374204d696c6c696f6e7320696e20244b41535041205468616e6b7320746f204d79204361742e2e0a4c6f6e672073746f72792062757420697320776f72746820697420492067756573732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_29_13_45_05_9337d033e2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KASPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KASPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

