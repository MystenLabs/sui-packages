module 0xc5397468e5a8cad7b976af57acbf9695f520c8fe5be3952141a0545f01bfdffa::bpre {
    struct BPRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<BPRE>(arg0, 9, 0x1::string::utf8(b"BPRE"), 0x1::string::utf8(b"BLAST PRESALE"), 0x1::string::utf8(b"BLAST BOT presale test token. TEST_SUI only, no value."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BPRE>>(0x2::coin_registry::finalize<BPRE>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BPRE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

