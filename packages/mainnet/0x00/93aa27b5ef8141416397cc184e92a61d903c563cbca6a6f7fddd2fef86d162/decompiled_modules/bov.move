module 0x93aa27b5ef8141416397cc184e92a61d903c563cbca6a6f7fddd2fef86d162::bov {
    struct BOV has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOV>(arg0, 6, b"BOV", b"BEAVER ON VACATION", b"Enjoying sun and hot chicks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4355_298e16cf7e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOV>>(v1);
    }

    // decompiled from Move bytecode v6
}

