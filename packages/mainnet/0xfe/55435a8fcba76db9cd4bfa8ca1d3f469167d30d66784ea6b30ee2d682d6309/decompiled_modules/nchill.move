module 0xfe55435a8fcba76db9cd4bfa8ca1d3f469167d30d66784ea6b30ee2d682d6309::nchill {
    struct NCHILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NCHILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NCHILL>(arg0, 6, b"NCHILL", b"Not a Chill Guy", b"Not a chill guy on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/U557_F_o_400x400_1_d9d9313841.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NCHILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NCHILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

