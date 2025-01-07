module 0x2b2c062d5b3cadf9a61e9fa02c159efa1ec3654908ec4cc984c6215864746571::niska {
    struct NISKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NISKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NISKA>(arg0, 6, b"NISKA", b"NISKA SUI", b"NISKA ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SADADASD_bc7e23f852.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NISKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NISKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

