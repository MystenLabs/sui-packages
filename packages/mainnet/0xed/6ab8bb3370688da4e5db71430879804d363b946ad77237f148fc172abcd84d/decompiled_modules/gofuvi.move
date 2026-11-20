module 0xed6ab8bb3370688da4e5db71430879804d363b946ad77237f148fc172abcd84d::gofuvi {
    struct GOFUVI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOFUVI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<GOFUVI>(arg0, 9, 0x1::string::utf8(b"GOFUVI"), 0x1::string::utf8(b"Gofuvil"), 0x1::string::utf8(b"Gofuvil on Sui"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GOFUVI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<GOFUVI>>(0x2::coin_registry::finalize<GOFUVI>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

