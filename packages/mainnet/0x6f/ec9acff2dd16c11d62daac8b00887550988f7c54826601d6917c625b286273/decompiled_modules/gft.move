module 0x6fec9acff2dd16c11d62daac8b00887550988f7c54826601d6917c625b286273::gft {
    struct GFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<GFT>(arg0, 9, 0x1::string::utf8(b"GFT"), 0x1::string::utf8(b"GIFT"), 0x1::string::utf8(b"Gift for you"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/03dbd9bcd254af93ca795b9987ea30c8dd09d30b284ddf6a93c5b053e5585d6d.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GFT>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<GFT>>(0x2::coin_registry::finalize<GFT>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<GFT>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

