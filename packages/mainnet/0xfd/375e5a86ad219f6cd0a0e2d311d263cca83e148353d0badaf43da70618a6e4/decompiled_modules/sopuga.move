module 0xfd375e5a86ad219f6cd0a0e2d311d263cca83e148353d0badaf43da70618a6e4::sopuga {
    struct SOPUGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOPUGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<SOPUGA>(arg0, 9, 0x1::string::utf8(b"SOPUGA"), 0x1::string::utf8(b"Sopugav"), 0x1::string::utf8(b"Sopugav on Sui"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SOPUGA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SOPUGA>>(0x2::coin_registry::finalize<SOPUGA>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

