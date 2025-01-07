module 0x3e3ed0ba5e6bd3025d1486d7b3646c5e37c1dabd4d9b013d0c6b379baf9fa5d8::squidly {
    struct SQUIDLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIDLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIDLY>(arg0, 6, b"SQUIDLY", b"SQUIDLY on SUI", b"Squidly is a chubby, blue squid with a cheerful and funny personality on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Picsart_24_12_16_13_02_34_001_d256675292.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIDLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIDLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

