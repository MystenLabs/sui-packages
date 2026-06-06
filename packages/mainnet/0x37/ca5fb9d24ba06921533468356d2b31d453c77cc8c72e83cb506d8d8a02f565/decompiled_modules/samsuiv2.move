module 0x37ca5fb9d24ba06921533468356d2b31d453c77cc8c72e83cb506d8d8a02f565::samsuiv2 {
    struct SAMSUIV2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMSUIV2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SAMSUIV2>(arg0, 9, 0x1::string::utf8(b"samSUI"), 0x1::string::utf8(b"SAM SUI"), 0x1::string::utf8(b"SAM yield-bearing SUI"), 0x1::string::utf8(b""), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMSUIV2>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SAMSUIV2>>(0x2::coin_registry::finalize<SAMSUIV2>(v0, arg1), v2);
    }

    // decompiled from Move bytecode v7
}

