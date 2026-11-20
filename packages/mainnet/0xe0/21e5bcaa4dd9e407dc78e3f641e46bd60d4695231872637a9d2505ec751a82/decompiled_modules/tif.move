module 0xe021e5bcaa4dd9e407dc78e3f641e46bd60d4695231872637a9d2505ec751a82::tif {
    struct TIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<TIF>(arg0, 9, 0x1::string::utf8(b"TIF"), 0x1::string::utf8(b"This Is Fine"), 0x1::string::utf8(b"fun"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/52c3968a58394228ec6ccb075b06a5ee1193cd8e5d3b0d1cdae28afc25af2a35.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<TIF>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TIF>>(0x2::coin_registry::finalize<TIF>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<TIF>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

