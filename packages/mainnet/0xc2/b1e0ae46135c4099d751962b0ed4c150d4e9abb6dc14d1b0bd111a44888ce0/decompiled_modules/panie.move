module 0xc2b1e0ae46135c4099d751962b0ed4c150d4e9abb6dc14d1b0bd111a44888ce0::panie {
    struct PANIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANIE>(arg0, 6, b"Panie", b"Panie sui", b"NOT SURE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036279_1a0f0627c7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

