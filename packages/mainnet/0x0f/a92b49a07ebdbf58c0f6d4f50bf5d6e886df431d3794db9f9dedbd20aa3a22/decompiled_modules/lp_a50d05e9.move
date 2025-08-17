module 0xfa92b49a07ebdbf58c0f6d4f50bf5d6e886df431d3794db9f9dedbd20aa3a22::lp_a50d05e9 {
    struct LP_A50D05E9 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LP_A50D05E9, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LP_A50D05E9>(arg0, 9, b"LP-A50D05E9", b"STEAMM LP LP-A50D05E9", b"STEAMM Liquidity Provider Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LP_A50D05E9>>(v0, @0x54d8f987d3d74ef971bc63538b70d0ce4591772d8118b37f03a5373b84a77ec5);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LP_A50D05E9>>(v1, @0x54d8f987d3d74ef971bc63538b70d0ce4591772d8118b37f03a5373b84a77ec5);
    }

    // decompiled from Move bytecode v6
}

