module 0x7f2ae320c116a333481d37b70f1dd5b2a71f30a6333bb20e7b870f08a7675ab5::corn {
    struct CORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORN>(arg0, 6, b"CORN", b"SUIt Corn", b"Its just a sweet corn on SUI. :D", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c6dadb7f_7afb_4141_98e8_69cff6983918_ac3b05292f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CORN>>(v1);
    }

    // decompiled from Move bytecode v6
}

