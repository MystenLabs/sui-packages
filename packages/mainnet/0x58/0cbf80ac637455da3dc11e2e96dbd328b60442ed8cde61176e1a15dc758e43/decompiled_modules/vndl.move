module 0x580cbf80ac637455da3dc11e2e96dbd328b60442ed8cde61176e1a15dc758e43::vndl {
    struct VNDL has drop {
        dummy_field: bool,
    }

    fun init(arg0: VNDL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<VNDL>(arg0, 9, 0x1::string::utf8(b"VNDL"), 0x1::string::utf8(b"Vandals sui"), 0x1::string::utf8(b"Come and war"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/c74989137bca4bef8997295b6a50392b988434972ff1f2d34d77bf958cb06a06.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<VNDL>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<VNDL>>(0x2::coin_registry::finalize<VNDL>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<VNDL>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

