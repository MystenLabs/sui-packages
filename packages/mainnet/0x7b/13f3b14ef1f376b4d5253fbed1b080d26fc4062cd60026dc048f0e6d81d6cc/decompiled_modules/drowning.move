module 0x7b13f3b14ef1f376b4d5253fbed1b080d26fc4062cd60026dc048f0e6d81d6cc::drowning {
    struct DROWNING has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROWNING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROWNING>(arg0, 6, b"DROWNING", b"Drowning on Sui", x"48656c702120476c75622c20676c75622e2e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Drowning_1_c3bdb5b229.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROWNING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DROWNING>>(v1);
    }

    // decompiled from Move bytecode v6
}

