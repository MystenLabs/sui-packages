module 0x2b3a40e704052ced6ad90c43454f0a7e1091d18cb7579079ed20ef083b3741b8::nopiz {
    struct NOPIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOPIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<NOPIZ>(arg0, 9, 0x1::string::utf8(b"NOPIZ"), 0x1::string::utf8(b"Nopiz"), 0x1::string::utf8(b"Nopiz on Sui"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NOPIZ>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<NOPIZ>>(0x2::coin_registry::finalize<NOPIZ>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

