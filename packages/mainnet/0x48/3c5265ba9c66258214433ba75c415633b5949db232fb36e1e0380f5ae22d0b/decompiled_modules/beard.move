module 0x483c5265ba9c66258214433ba75c415633b5949db232fb36e1e0380f5ae22d0b::beard {
    struct BEARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEARD>(arg0, 6, b"BEARD", b"Blue Beard", x"426c75656265617264206973206e6f74206a7573742061206d656d65202d20697420697320612063756c74206d6f76656d656e74206f6620746865205375692065636f73797374656d210a4a6f696e20757320616e64207765617220796f757220626c75652062656172642077697468207072696465210a536f6f6e2065766572796f6e6520696e20746865205355492065636f73797374656d2077696c6c2062652073706f7274696e67206120626c7565206265617264210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BEARD_a92967b5fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

