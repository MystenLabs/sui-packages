module 0x10abf9d4203e45e364413c63bc394f2498a3e41049b0e3c068a80eef94cc0bed::hope {
    struct HOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<HOPE>(arg0, 9, 0x1::string::utf8(b"HOPE"), 0x1::string::utf8(b"hope"), 0x1::string::utf8(b"onchain"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/87964f2b04af484f88a3c5f150c5108df9134b0c19792fc0e3ce9706718d1315.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<HOPE>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<HOPE>>(0x2::coin_registry::finalize<HOPE>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<HOPE>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

