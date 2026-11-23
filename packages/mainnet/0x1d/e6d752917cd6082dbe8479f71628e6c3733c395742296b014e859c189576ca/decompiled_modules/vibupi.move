module 0x1de6d752917cd6082dbe8479f71628e6c3733c395742296b014e859c189576ca::vibupi {
    struct VIBUPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIBUPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<VIBUPI>(arg0, 9, 0x1::string::utf8(b"VIBUPI"), 0x1::string::utf8(b"Vibupip"), 0x1::string::utf8(b"Vibupip on Sui"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<VIBUPI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<VIBUPI>>(0x2::coin_registry::finalize<VIBUPI>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

