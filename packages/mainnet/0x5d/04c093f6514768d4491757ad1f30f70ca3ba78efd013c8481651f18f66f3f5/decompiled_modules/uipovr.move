module 0x5d04c093f6514768d4491757ad1f30f70ca3ba78efd013c8481651f18f66f3f5::uipovr {
    struct UIPOVR has drop {
        dummy_field: bool,
    }

    fun init(arg0: UIPOVR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<UIPOVR>(arg0, 9, 0x1::string::utf8(b"UIPOVR"), 0x1::string::utf8(b"Blast UI Presale Overflow"), 0x1::string::utf8(b"QA presale, open to anyone, target 2,000, runs 1 day and goes over target. Test"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/67aad4aafd13bf99bae7ff270ea9a21e0faa4913d232ff74ee2dd138dba2d64e.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<UIPOVR>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<UIPOVR>>(0x2::coin_registry::finalize<UIPOVR>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<UIPOVR>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

