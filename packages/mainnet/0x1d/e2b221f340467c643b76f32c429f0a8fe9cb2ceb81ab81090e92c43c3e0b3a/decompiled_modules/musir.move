module 0x1de2b221f340467c643b76f32c429f0a8fe9cb2ceb81ab81090e92c43c3e0b3a::musir {
    struct MUSIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<MUSIR>(arg0, 9, 0x1::string::utf8(b"MUSIR"), 0x1::string::utf8(b"Musir"), 0x1::string::utf8(b"Musir on Sui"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<MUSIR>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<MUSIR>>(0x2::coin_registry::finalize<MUSIR>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

