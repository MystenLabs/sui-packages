module 0xa3dc1f5c5a03bba7f7561d54e4a93975f0f4ad7022f7d2bcd9f80a4e6a437b89::ft3 {
    struct FT3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FT3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FT3>(arg0, 6, 0x1::string::utf8(b"FT3"), 0x1::string::utf8(b"FartpadT2"), 0x1::string::utf8(b"Ft3"), 0x1::string::utf8(b"https://imagedelivery.net/cBNDGgkrsEA-b_ixIp9SkQ/magma.jpeg/public"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FT3>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FT3>>(0x2::coin_registry::finalize<FT3>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

