module 0x6aaf86c714a09b9d4475984f6f4fbcafc1635c160a01e0959aa27c4655f56bfa::lcat {
    struct LCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LCAT>(arg0, 6, b"LCAT", b"LUCKY CAT", b"Lucky Cat will make millionaire in this Bull Run.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/364d610b_af34_4e1d_b832_72b305a93ed5_0573c907c2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

