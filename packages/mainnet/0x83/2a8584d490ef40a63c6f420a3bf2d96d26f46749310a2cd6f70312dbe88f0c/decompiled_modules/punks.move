module 0x832a8584d490ef40a63c6f420a3bf2d96d26f46749310a2cd6f70312dbe88f0c::punks {
    struct PUNKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUNKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<PUNKS>(arg0, 9, 0x1::string::utf8(b"PUNKS"), 0x1::string::utf8(b"Sui Punk"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/9b45206c467ac96b1a7499a925d11aff5ad148a8524b859499780c399e317eaf.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<PUNKS>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PUNKS>>(0x2::coin_registry::finalize<PUNKS>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<PUNKS>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

