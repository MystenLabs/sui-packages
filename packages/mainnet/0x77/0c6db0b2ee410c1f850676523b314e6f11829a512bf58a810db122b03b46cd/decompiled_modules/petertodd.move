module 0x770c6db0b2ee410c1f850676523b314e6f11829a512bf58a810db122b03b46cd::petertodd {
    struct PETERTODD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PETERTODD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PETERTODD>(arg0, 6, b"Petertodd", b"satoshi yakamoto", b"Petter Todd is SATOSHI (HBO)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/peter_465530a2e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PETERTODD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PETERTODD>>(v1);
    }

    // decompiled from Move bytecode v6
}

