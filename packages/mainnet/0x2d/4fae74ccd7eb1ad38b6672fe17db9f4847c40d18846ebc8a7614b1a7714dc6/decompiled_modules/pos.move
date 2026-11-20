module 0x2d4fae74ccd7eb1ad38b6672fe17db9f4847c40d18846ebc8a7614b1a7714dc6::pos {
    struct POS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<POS>(arg0, 9, 0x1::string::utf8(b"POS"), 0x1::string::utf8(b"Poa on sui"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/1ee19fe7fe1c925a587259ca5f79ccd5921d2e8040f26e5a284ecb296553e0c5.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<POS>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<POS>>(0x2::coin_registry::finalize<POS>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<POS>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

