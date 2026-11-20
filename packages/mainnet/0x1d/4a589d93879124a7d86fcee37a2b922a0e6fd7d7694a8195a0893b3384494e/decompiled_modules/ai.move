module 0x1d4a589d93879124a7d86fcee37a2b922a0e6fd7d7694a8195a0893b3384494e::ai {
    struct AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<AI>(arg0, 9, 0x1::string::utf8(b"AI"), 0x1::string::utf8(b"ai coin"), 0x1::string::utf8(b"ai coin new coin on sui"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/57df0498a8c64c9b87b2a8146fa55d35eb0f756e8fadbe9a7448b75376a29eda.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<AI>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<AI>>(0x2::coin_registry::finalize<AI>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<AI>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

