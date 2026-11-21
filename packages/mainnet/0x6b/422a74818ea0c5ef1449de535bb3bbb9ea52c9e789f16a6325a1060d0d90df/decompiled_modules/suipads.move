module 0x6b422a74818ea0c5ef1449de535bb3bbb9ea52c9e789f16a6325a1060d0d90df::suipads {
    struct SUIPADS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPADS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<SUIPADS>(arg0, 9, 0x1::string::utf8(b"SUIPADS"), 0x1::string::utf8(b"SuiPads.Fun"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/f3c270bb0504694791bda4ce4a391771c359e057ec0016bd060953762a6e6229.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SUIPADS>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SUIPADS>>(0x2::coin_registry::finalize<SUIPADS>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<SUIPADS>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

