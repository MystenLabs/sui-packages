module 0x2eacd783509d029b8b5317f5fc6629663620ae732c7581ba7cd2065933695e56::owl {
    struct OWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWL>(arg0, 6, b"OWL", b"HopOwl", x"4675636b20486f70207765206c61756e6368206f6e20547572626f730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730991711250.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

