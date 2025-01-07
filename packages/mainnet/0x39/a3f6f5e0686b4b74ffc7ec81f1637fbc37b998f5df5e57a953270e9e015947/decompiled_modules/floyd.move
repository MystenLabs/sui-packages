module 0x39a3f6f5e0686b4b74ffc7ec81f1637fbc37b998f5df5e57a953270e9e015947::floyd {
    struct FLOYD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOYD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOYD>(arg0, 6, b"Floyd", b"George Floyd", b"dead", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/phphnr2_H1_d96c44a75d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOYD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOYD>>(v1);
    }

    // decompiled from Move bytecode v6
}

