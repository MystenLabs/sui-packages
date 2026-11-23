module 0xa637e0ef962b1622b00cc57f188a71508f9714489491371f4ec36779b9fe610e::kireni {
    struct KIRENI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIRENI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<KIRENI>(arg0, 9, 0x1::string::utf8(b"KIRENI"), 0x1::string::utf8(b"Kirenir"), 0x1::string::utf8(b"Kirenir on Sui"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<KIRENI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<KIRENI>>(0x2::coin_registry::finalize<KIRENI>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

