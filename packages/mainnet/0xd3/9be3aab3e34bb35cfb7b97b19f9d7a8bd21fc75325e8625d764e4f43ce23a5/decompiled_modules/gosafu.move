module 0xd39be3aab3e34bb35cfb7b97b19f9d7a8bd21fc75325e8625d764e4f43ce23a5::gosafu {
    struct GOSAFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOSAFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<GOSAFU>(arg0, 9, 0x1::string::utf8(b"GOSAFU"), 0x1::string::utf8(b"Gosafud"), 0x1::string::utf8(b"Gosafud on Sui"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GOSAFU>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<GOSAFU>>(0x2::coin_registry::finalize<GOSAFU>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

