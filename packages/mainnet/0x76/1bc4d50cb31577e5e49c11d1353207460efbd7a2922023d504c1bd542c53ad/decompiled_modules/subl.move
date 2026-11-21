module 0x761bc4d50cb31577e5e49c11d1353207460efbd7a2922023d504c1bd542c53ad::subl {
    struct SUBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<SUBL>(arg0, 9, 0x1::string::utf8(b"SUBL"), 0x1::string::utf8(b"Suiblst"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/339fcb09be4ca0c8f91125850f8a92f3978eaf92389eec9df2f09cda517085a7.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SUBL>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SUBL>>(0x2::coin_registry::finalize<SUBL>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<SUBL>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

