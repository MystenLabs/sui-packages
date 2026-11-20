module 0x95e067b28e6134e63b9195936fe291a9b1a9b8e30b2be68dfc10a49e3ddcf68e::mihaoblast {
    struct MIHAOBLAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIHAOBLAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<MIHAOBLAST>(arg0, 9, 0x1::string::utf8(b"MIHAOBLAST"), 0x1::string::utf8(b"iAmNihaoCatBlast"), 0x1::string::utf8(b"Mihao"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/76c871b106a5c9dc1f109dafb83185348fac48f6fbbd139e3d155df2719fd6ac.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<MIHAOBLAST>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<MIHAOBLAST>>(0x2::coin_registry::finalize<MIHAOBLAST>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<MIHAOBLAST>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

