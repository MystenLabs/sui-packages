module 0x7830c5086f55a4d7e7f1879dfaa62c4c04ee9c80decf634444798d8c7834edbd::ring {
    struct RING has drop {
        dummy_field: bool,
    }

    fun init(arg0: RING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RING>(arg0, 6, b"Ring", b"Life Ring of Sui", b"Stay afloat in Suis waves. Your rescue in rough waters. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ring_1_7aa230db19.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RING>>(v1);
    }

    // decompiled from Move bytecode v6
}

