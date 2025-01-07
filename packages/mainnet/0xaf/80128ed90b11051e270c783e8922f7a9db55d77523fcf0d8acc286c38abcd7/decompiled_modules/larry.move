module 0xaf80128ed90b11051e270c783e8922f7a9db55d77523fcf0d8acc286c38abcd7::larry {
    struct LARRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LARRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LARRY>(arg0, 6, b"LARRY", b"Larry the Lobster", x"4f4646494349414c204c4152525920544845204c4f42535445520a0a57656c636f6d6520746f2074686520537569204c61676f6f6e2e204865726520796f752063616e2066696e64206d616e79206f6365616e206477656c6c6572732c20627574206e6f6e6520617265206173206d756368206f662061204d555343554c415220484f444c27696e67204348414420617320244c415252592e0a0a244c415252592068617320612031302042696c6c696f6e20737570706c792c204c50206973206275726e7420616e642030252062757920616e642073656c6c207461782e0a0a234c6976654c696b654c41525259", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LARRY_LOGO_WIF_SAND_75c8c4e679.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LARRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LARRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

