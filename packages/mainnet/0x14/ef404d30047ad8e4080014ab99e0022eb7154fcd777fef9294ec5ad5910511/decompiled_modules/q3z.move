module 0x14ef404d30047ad8e4080014ab99e0022eb7154fcd777fef9294ec5ad5910511::q3z {
    struct Q3Z has drop {
        dummy_field: bool,
    }

    fun init(arg0: Q3Z, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<Q3Z>(arg0, 9, 0x1::string::utf8(b"Q3Z"), 0x1::string::utf8(b"Q3z16"), 0x1::string::utf8(b"Passionate about AI creativity, video production, and exploring innovative digit"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/f6816af9ba46c04f2dbedaace55c77c653256ae565ca678228c3d87a939b3f39.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<Q3Z>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<Q3Z>>(0x2::coin_registry::finalize<Q3Z>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<Q3Z>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

