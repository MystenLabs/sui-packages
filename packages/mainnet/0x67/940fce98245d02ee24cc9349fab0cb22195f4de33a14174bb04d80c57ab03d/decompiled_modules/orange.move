module 0x67940fce98245d02ee24cc9349fab0cb22195f4de33a14174bb04d80c57ab03d::orange {
    struct ORANGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORANGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORANGE>(arg0, 6, b"ORANGE", b"Orange", b"Just orange.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008847_4598a0855b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORANGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORANGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

