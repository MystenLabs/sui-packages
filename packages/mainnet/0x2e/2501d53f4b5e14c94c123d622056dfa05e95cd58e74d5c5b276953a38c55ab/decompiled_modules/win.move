module 0x2e2501d53f4b5e14c94c123d622056dfa05e95cd58e74d5c5b276953a38c55ab::win {
    struct WIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIN>(arg0, 6, b"Win", b"Fight", b"President-elect", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae_e_8bd819cf99.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

