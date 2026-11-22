module 0xaab24e59d4dbe3cccd3834611ac40579901b10f6fef04262e7dc88effa185a54::booz {
    struct BOOZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<BOOZ>(arg0, 9, 0x1::string::utf8(b"BOOZ"), 0x1::string::utf8(x"426568726f6f7a20e29c8bf09faa99"), 0x1::string::utf8(b"Love, let me see what you are doing."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/5911c8c810e4f0fcaa95070f5118a927af38006c227629d46824a9e053e802bd.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BOOZ>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BOOZ>>(0x2::coin_registry::finalize<BOOZ>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<BOOZ>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

