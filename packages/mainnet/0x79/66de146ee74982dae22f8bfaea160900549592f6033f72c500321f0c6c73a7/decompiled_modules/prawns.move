module 0x7966de146ee74982dae22f8bfaea160900549592f6033f72c500321f0c6c73a7::prawns {
    struct PRAWNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRAWNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRAWNS>(arg0, 6, b"PRAWNS", b"Prawnsui", b"Prawns for you, prawns for me, prawns for SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/prawns_for_life_77db53ef1d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRAWNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRAWNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

