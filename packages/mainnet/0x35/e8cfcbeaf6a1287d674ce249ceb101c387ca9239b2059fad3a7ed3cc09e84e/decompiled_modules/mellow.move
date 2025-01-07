module 0x35e8cfcbeaf6a1287d674ce249ceb101c387ca9239b2059fad3a7ed3cc09e84e::mellow {
    struct MELLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELLOW>(arg0, 6, b"MELLOW", b"Mellow Man", b"Mellow Man is a laid-back and carefree character who is a friend of Pepe, Brett, and the rest of the Boys Club gang https://t.me/MellowManCommunity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N_Fm_Z7_Ir_400x400_32bddf0753.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELLOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MELLOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

