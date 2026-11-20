module 0x3df1256001c1db8cb49b44f812c5478182f0ef0a6440ac3847363643b232d99f::vdrip {
    struct VDRIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: VDRIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<VDRIP>(arg0, 9, 0x1::string::utf8(b"VDRIP"), 0x1::string::utf8(b"Vice Drip"), 0x1::string::utf8(b"Five stars. One drop. A Miami getaway in meme coin form, built on Sui."), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/391844715a1aab150ec8d2831b25ea3e17466121eaac3c202279b3408a1e432f.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<VDRIP>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<VDRIP>>(0x2::coin_registry::finalize<VDRIP>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<VDRIP>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

