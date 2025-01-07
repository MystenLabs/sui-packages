module 0xc75d03d78478eabf7f6476dd4c251b56504b78c01198c84f4cb55f44d4377450::corra {
    struct CORRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORRA>(arg0, 6, b"CORRA", b"Disney Born Elephant", x"24434f5252410a0a4a6f696e205447", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/corra_4a374b815f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CORRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

