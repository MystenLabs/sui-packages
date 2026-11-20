module 0xf70d0e5c261276b5beb08c3335cdea62f7c538f1052f3d22237f259713218d08::sx {
    struct SX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<SX>(arg0, 9, 0x1::string::utf8(b"SX"), 0x1::string::utf8(b"sxsu"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/0cefa5648cf201c7053a068e8239aa5653875798d2f5b62a2b71c8b4f342d459.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SX>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SX>>(0x2::coin_registry::finalize<SX>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<SX>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

