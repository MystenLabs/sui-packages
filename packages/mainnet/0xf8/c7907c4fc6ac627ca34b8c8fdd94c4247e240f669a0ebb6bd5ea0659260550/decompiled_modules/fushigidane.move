module 0xf8c7907c4fc6ac627ca34b8c8fdd94c4247e240f669a0ebb6bd5ea0659260550::fushigidane {
    struct FUSHIGIDANE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUSHIGIDANE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUSHIGIDANE>(arg0, 6, b"Fushigidane", b"Fushi Sui", b"Welcome to the next generation of memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bc0ecc43dce0144e1bc22219db39a518a7ffdbc0_hq_65563c9509.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUSHIGIDANE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUSHIGIDANE>>(v1);
    }

    // decompiled from Move bytecode v6
}

