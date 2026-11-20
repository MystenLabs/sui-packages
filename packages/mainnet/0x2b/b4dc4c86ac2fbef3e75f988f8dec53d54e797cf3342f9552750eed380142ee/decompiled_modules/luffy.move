module 0x2bb4dc4c86ac2fbef3e75f988f8dec53d54e797cf3342f9552750eed380142ee::luffy {
    struct LUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<LUFFY>(arg0, 9, 0x1::string::utf8(b"LUFFY"), 0x1::string::utf8(b"Luffy"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/ebd7c4e39a56f1d3c08d144089447a7a7e313932c7e6107805c1723b3ea33d61.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<LUFFY>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<LUFFY>>(0x2::coin_registry::finalize<LUFFY>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<LUFFY>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

