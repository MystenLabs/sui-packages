module 0xea6a76e822545917061c8dce1013b10580725ae366bf37241eb8a0d1790947d3::ghh {
    struct GHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GHH>(arg0, 6, 0x1::string::utf8(b"Ghh"), 0x1::string::utf8(b"Fgb"), 0x1::string::utf8(b"Jkji"), 0x1::string::utf8(b"https://imagedelivery.net/cBNDGgkrsEA-b_ixIp9SkQ/magma.jpeg/public"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHH>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<GHH>>(0x2::coin_registry::finalize<GHH>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

