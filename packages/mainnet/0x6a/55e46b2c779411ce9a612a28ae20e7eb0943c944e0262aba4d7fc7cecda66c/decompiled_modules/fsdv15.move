module 0x6a55e46b2c779411ce9a612a28ae20e7eb0943c944e0262aba4d7fc7cecda66c::fsdv15 {
    struct FSDV15 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSDV15, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<FSDV15>(arg0, 9, 0x1::string::utf8(b"FSDV15"), 0x1::string::utf8(b"Tesla FSD v15"), 0x1::string::utf8(b"The city never sleeps. The car never asks for directions. Tesla FSD v15 is gta in real life"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/d788e61fb8a550a6875dbce14f9fedab232820dd249677b70b262640e6f53cc3.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<FSDV15>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FSDV15>>(0x2::coin_registry::finalize<FSDV15>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<FSDV15>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

