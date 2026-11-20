module 0x7f3ea040355e5f8e51aa6eaabae6923dc028fb2d5e1604c6478ffa78bef9b39e::witch {
    struct WITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<WITCH>(arg0, 9, 0x1::string::utf8(b"WITCH"), 0x1::string::utf8(b"Wanda"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/c971952d6d6c90332077c35cc860bf5ae3f487fc53530a628964f4bb84ff69fb.webp"), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<WITCH>>(v1, 0x2::tx_context::sender(arg1));
        if (false) {
            0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<WITCH>>(0x2::coin_registry::finalize<WITCH>(v0, arg1), @0x3e7a);
        } else {
            0x2::coin_registry::finalize_and_delete_metadata_cap<WITCH>(v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

