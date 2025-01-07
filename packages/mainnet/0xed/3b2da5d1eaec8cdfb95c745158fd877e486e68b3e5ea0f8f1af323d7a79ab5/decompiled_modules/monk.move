module 0xed3b2da5d1eaec8cdfb95c745158fd877e486e68b3e5ea0f8f1af323d7a79ab5::monk {
    struct MONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONK>(arg0, 6, b"MONK", b"MONK SUI", b"$MONK the spooky fish from $SUI ocean comes from a deep, dark and cold ocean zone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/p_WA_Qa_X8d_400x400_725e09b104.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

