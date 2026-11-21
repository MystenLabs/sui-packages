module 0x5975cef4e432646ebbaadfd249ee0485df2ceece9e9fc490d27b8cd8eada2a19::som {
    struct SOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<SOM>(arg0, 9, 0x1::string::utf8(b"SOM"), 0x1::string::utf8(b"SOMA"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/7fd1b0df313a0204e1672b8403fa867b909c9802eb5e2ad4e1b7ffd732c26198.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SOM>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SOM>>(0x2::coin_registry::finalize<SOM>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<SOM>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

