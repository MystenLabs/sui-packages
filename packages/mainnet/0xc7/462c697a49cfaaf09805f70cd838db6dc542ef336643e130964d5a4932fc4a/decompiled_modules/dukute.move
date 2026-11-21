module 0xc7462c697a49cfaaf09805f70cd838db6dc542ef336643e130964d5a4932fc4a::dukute {
    struct DUKUTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUKUTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<DUKUTE>(arg0, 9, 0x1::string::utf8(b"DUKUTE"), 0x1::string::utf8(b"Dukutek"), 0x1::string::utf8(b"Dukutek on Sui"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<DUKUTE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DUKUTE>>(0x2::coin_registry::finalize<DUKUTE>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

