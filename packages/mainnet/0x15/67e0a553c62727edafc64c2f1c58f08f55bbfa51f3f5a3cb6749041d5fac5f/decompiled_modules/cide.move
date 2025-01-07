module 0x1567e0a553c62727edafc64c2f1c58f08f55bbfa51f3f5a3cb6749041d5fac5f::cide {
    struct CIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIDE>(arg0, 6, b"CIDE", b"SUI", b"This coin is for those who risk it enough to consider aping in; yet smart enough to know its not the solution. This coin is for all those who have thought about it and a memorandum to remind you to keep going forward; no matter the odds. No Matter what!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BEBC_1_FBD_15_B7_4038_8_F53_4_E3_EF_3409_E60_752146cc06.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

