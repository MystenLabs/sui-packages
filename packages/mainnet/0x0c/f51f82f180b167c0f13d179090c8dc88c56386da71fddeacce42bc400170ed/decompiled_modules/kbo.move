module 0xcf51f82f180b167c0f13d179090c8dc88c56386da71fddeacce42bc400170ed::kbo {
    struct KBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<KBO>(arg0, 9, 0x1::string::utf8(b"KBO"), 0x1::string::utf8(b"kobato"), 0x1::string::utf8(b"Creating AI-powered videos and exploring creative digital experiences."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/4402a432c8024e85912338f7414b15f0852065979fc75f1f7e6317a9ba35673e.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<KBO>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<KBO>>(0x2::coin_registry::finalize<KBO>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<KBO>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

