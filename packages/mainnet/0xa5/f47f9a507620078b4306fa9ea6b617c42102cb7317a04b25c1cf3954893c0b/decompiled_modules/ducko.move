module 0xa5f47f9a507620078b4306fa9ea6b617c42102cb7317a04b25c1cf3954893c0b::ducko {
    struct DUCKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKO>(arg0, 6, b"Ducko", b"Ducko Duck", b"just a small duck in a big world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DUCKO_02cac5830b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

