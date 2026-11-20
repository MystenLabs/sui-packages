module 0xeabc9ad49dda80a363341f814735aba3a70c972ab59467bb385e4f83f319ebcd::scat {
    struct SCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<SCAT>(arg0, 9, 0x1::string::utf8(b"SCAT"), 0x1::string::utf8(b"Sui Cat"), 0x1::string::utf8(b"I'm memecoin but king meme"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/af134ab158aa1ae93f258a681a05fe64843c0d005027f6f5fa554126c7f2214d.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SCAT>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SCAT>>(0x2::coin_registry::finalize<SCAT>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<SCAT>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

