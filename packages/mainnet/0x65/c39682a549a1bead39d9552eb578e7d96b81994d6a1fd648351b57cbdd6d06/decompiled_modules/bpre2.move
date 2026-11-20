module 0x65c39682a549a1bead39d9552eb578e7d96b81994d6a1fd648351b57cbdd6d06::bpre2 {
    struct BPRE2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPRE2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<BPRE2>(arg0, 9, 0x1::string::utf8(b"BPRE2"), 0x1::string::utf8(b"BLAST PRESALE"), 0x1::string::utf8(b"BLAST BOT presale test token. TEST_SUI only, no value."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BPRE2>>(0x2::coin_registry::finalize<BPRE2>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BPRE2>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

