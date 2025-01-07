module 0xcf0aa730adba4df9f337a8de23c1e05d5b134b0ad49b826cecfc2ff9414adf05::pattie {
    struct PATTIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PATTIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PATTIE>(arg0, 6, b"PATTIE", b"Pattie on sui", b"If you're hungry now a pattie will fill your stomach, if you're poor, you won't buy a pattie ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052844_b4f67d2763.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PATTIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PATTIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

