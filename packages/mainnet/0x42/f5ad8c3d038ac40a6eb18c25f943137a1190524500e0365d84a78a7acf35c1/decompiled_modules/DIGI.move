module 0x42f5ad8c3d038ac40a6eb18c25f943137a1190524500e0365d84a78a7acf35c1::DIGI {
    struct DIGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DIGI>(arg0, 9, 0x1::string::utf8(b"DIGI"), 0x1::string::utf8(b"Digimon Token"), 0x1::string::utf8(b"A burn-only Digimon-inspired token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DIGI>>(0x2::coin_registry::finalize<DIGI>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIGI>>(v1, @0x0);
    }

    // decompiled from Move bytecode v6
}

