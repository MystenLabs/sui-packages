module 0xa437a22989684a82604ebe9f05766c92e0fcd9ac2b594a38740a9774c9fbb14d::cult {
    struct CULT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CULT>(arg0, 6, b"CULT", b"SUICULT", b"Secret societies and  global influences...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suicult_c010ebf6f2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CULT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CULT>>(v1);
    }

    // decompiled from Move bytecode v6
}

