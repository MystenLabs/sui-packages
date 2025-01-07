module 0x871a2f1bb45632a5ebac205f9300216375945061c59b478b35b5e994dcc6f830::suiqurtle {
    struct SUIQURTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIQURTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIQURTLE>(arg0, 6, b"SUIQURTLE", b"SUIQURTLE6900", b"Community Driven. Community Everything. SUIQURTLE6900", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_13_115804_d9f3538045.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIQURTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIQURTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

