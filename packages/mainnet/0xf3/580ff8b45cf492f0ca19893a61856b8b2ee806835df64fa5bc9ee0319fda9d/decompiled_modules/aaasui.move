module 0xf3580ff8b45cf492f0ca19893a61856b8b2ee806835df64fa5bc9ee0319fda9d::aaasui {
    struct AAASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAASUI>(arg0, 6, b"AAASUI", b"aaaa sui", b"Can't stop won't stop (thinking about Sui)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014592_e7a7bf97aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

