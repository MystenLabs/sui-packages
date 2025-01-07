module 0xe5871d9109205586eeb1381283229bbcd096e1f681938d46099c199f4b3b321b::rege {
    struct REGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: REGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REGE>(arg0, 6, b"REGE", b"dbfdb", b"dbfdbd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2178374_w1400h1400c1cx700cy350cxt0cyt0cxb1400cyb700_e4a93593ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

