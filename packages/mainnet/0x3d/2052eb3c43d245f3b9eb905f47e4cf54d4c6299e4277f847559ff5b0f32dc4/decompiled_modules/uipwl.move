module 0x3d2052eb3c43d245f3b9eb905f47e4cf54d4c6299e4277f847559ff5b0f32dc4::uipwl {
    struct UIPWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: UIPWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<UIPWL>(arg0, 6, 0x1::string::utf8(b"UIPWL"), 0x1::string::utf8(b"Blast UI Presale Allowlist"), 0x1::string::utf8(b"QA presale, allowlist of 3 wallets, opens 08:46 UTC, closes at target. Test SUI"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/67aad4aafd13bf99bae7ff270ea9a21e0faa4913d232ff74ee2dd138dba2d64e.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<UIPWL>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<UIPWL>>(0x2::coin_registry::finalize<UIPWL>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<UIPWL>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

