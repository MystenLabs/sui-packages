module 0xa14b5638387c84cbe81d5596e1e3a6148982da9580128b037ddd909dfc479095::mola {
    struct MOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOLA>(arg0, 6, b"Mola", b"MOLA SUI", b"$Mola", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8js_P_Au_R_400x400_53e8dd6a63.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

