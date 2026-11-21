module 0xaf1a9177d7f53423992a01f03a66f47d6e88b9a5767ca4a869cae9bc3a812d7c::gigachad {
    struct GIGACHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGACHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<GIGACHAD>(arg0, 9, 0x1::string::utf8(b"GIGACHAD"), 0x1::string::utf8(b"GIGA CHAD"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/cea27ad392435f7c2ec1969c55c508f50fffc811f3b912fbd8dbfdd6d17adc45.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GIGACHAD>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<GIGACHAD>>(0x2::coin_registry::finalize<GIGACHAD>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<GIGACHAD>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

