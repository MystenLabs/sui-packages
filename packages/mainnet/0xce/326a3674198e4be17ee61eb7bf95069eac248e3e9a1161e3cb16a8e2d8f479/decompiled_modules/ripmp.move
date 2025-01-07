module 0xce326a3674198e4be17ee61eb7bf95069eac248e3e9a1161e3cb16a8e2d8f479::ripmp {
    struct RIPMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIPMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIPMP>(arg0, 6, b"RIPMP", b"R.I.P MOVEPUMP", b"THIS IS MOVEPUMPS LAST TOKEN, RIP.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004247_b8ba33642c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIPMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIPMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

