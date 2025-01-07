module 0x1e51c80041c01a7a8ee02e26a4b23062bfe3ffeb059cbbcb091a2cabbf140a1c::pring {
    struct PRING has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRING>(arg0, 6, b"PRING", b"PRINGUL", b"love pringles love $PRING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_06_19_23_12_b7c7928892.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRING>>(v1);
    }

    // decompiled from Move bytecode v6
}

