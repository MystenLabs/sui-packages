module 0x13b4f65555ea80443fb4d2744e9edd735f12406c8250b7517e663370fdc0e985::jaffa {
    struct JAFFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAFFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAFFA>(arg0, 6, b"JAFFA", b"MR.JAFFA", b"Official Jaffa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jaffa_9822337006.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAFFA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAFFA>>(v1);
    }

    // decompiled from Move bytecode v6
}

